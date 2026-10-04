let
    // Parametros editáveis: FiltroMunicipio (SG_UF, NO_MUNICIPIO) e CensoCaminho (caminho local do arquivo).
    Filtro = Excel.CurrentWorkbook(){[Name="FiltroMunicipio"]}[Content],
    FiltroTipos = Table.TransformColumnTypes(Filtro, {{"SG_UF", type text}, {"NO_MUNICIPIO", type text}}),
    Caminho = Excel.CurrentWorkbook(){[Name="CensoCaminho"]}[Content]{0}[Column1],
    Pasta = Excel.Workbook(File.Contents(Caminho), null, true),
    MicrodadosBrutos = Table.PromoteHeaders(Pasta{[Item="Microdados",Kind="Sheet"]}[Data], [PromoteAllScalars=true]),
    Dependencia = Table.PromoteHeaders(Pasta{[Item="Dependencia",Kind="Sheet"]}[Data], [PromoteAllScalars=true]),
    Localizacao = Table.PromoteHeaders(Pasta{[Item="Localizacao",Kind="Sheet"]}[Data], [PromoteAllScalars=true]),
    LocDiferenciada = Table.PromoteHeaders(Pasta{[Item="LocDiferenciada",Kind="Sheet"]}[Data], [PromoteAllScalars=true]),
    Situacao = Table.PromoteHeaders(Pasta{[Item="Situacao",Kind="Sheet"]}[Data], [PromoteAllScalars=true]),
    TiposChave = Table.TransformColumnTypes(MicrodadosBrutos, {{"SG_UF", type text}, {"NO_MUNICIPIO", type text}, {"TP_DEPENDENCIA", Int64.Type}, {"TP_LOCALIZACAO", Int64.Type}, {"TP_LOCALIZACAO_DIFERENCIADA", Int64.Type}, {"TP_SITUACAO_FUNCIONAMENTO", Int64.Type}, {"QT_MAT_BAS", Int64.Type}}),
    // Inner Join por UF e Município antes de qualquer merge de dimensão.
    Filtrado = Table.NestedJoin(TiposChave, {"SG_UF","NO_MUNICIPIO"}, FiltroTipos, {"SG_UF","NO_MUNICIPIO"}, "FiltroMunicipio", JoinKind.Inner),
    SemFiltroAninhado = Table.RemoveColumns(Filtrado,{"FiltroMunicipio"}),
    MergeDependencia = Table.NestedJoin(SemFiltroAninhado,{"TP_DEPENDENCIA"},Dependencia,{"TP_DEPENDENCIA"},"DimDependencia",JoinKind.LeftOuter),
    ExpandeDependencia = Table.ExpandTableColumn(MergeDependencia,"DimDependencia",{"DEPENDENCIA"},{"DEPENDENCIA"}),
    MergeLocalizacao = Table.NestedJoin(ExpandeDependencia,{"TP_LOCALIZACAO"},Localizacao,{"TP_LOCALIZACAO"},"DimLocalizacao",JoinKind.LeftOuter),
    ExpandeLocalizacao = Table.ExpandTableColumn(MergeLocalizacao,"DimLocalizacao",{"LOCALIZACAO"},{"LOCALIZACAO"}),
    MergeLocDiferenciada = Table.NestedJoin(ExpandeLocalizacao,{"TP_LOCALIZACAO_DIFERENCIADA"},LocDiferenciada,{"TP_LOCALIZACAO_DIFERENCIADA"},"DimLocDiferenciada",JoinKind.LeftOuter),
    ExpandeLocDiferenciada = Table.ExpandTableColumn(MergeLocDiferenciada,"DimLocDiferenciada",{"LOC_DIFERENCIADA"},{"LOC_DIFERENCIADA"}),
    MergeSituacao = Table.NestedJoin(ExpandeLocDiferenciada,{"TP_SITUACAO_FUNCIONAMENTO"},Situacao,{"TP_SITUACAO_FUNCIONAMENTO"},"DimSituacao",JoinKind.LeftOuter),
    ExpandeSituacao = Table.ExpandTableColumn(MergeSituacao,"DimSituacao",{"SITUACAO"},{"SITUACAO"}),
    // Faixas mantidas conforme classificação usada no arquivo do grupo: 0-50, 51-200, 201-500, 501-1000, >1000.
    Tamanho = Table.AddColumn(ExpandeSituacao,"TAMANHO_ESCOLA", each if [QT_MAT_BAS]=null then "Não informado" else if [QT_MAT_BAS]<=50 then "Microescola" else if [QT_MAT_BAS]<=200 then "Pequena" else if [QT_MAT_BAS]<=500 then "Média" else if [QT_MAT_BAS]<=1000 then "Grande" else "Muito Grande", type text),
    Agua = Table.AddColumn(Tamanho,"AGUA", each if [IN_AGUA_REDE_PUBLICA]=1 then "Rede pública" else if [IN_AGUA_POCO_ARTESIANO]=1 then "Poço artesiano" else if [IN_AGUA_CACIMBA]=1 then "Cacimba" else if [IN_AGUA_FONTE_RIO]=1 then "Fonte/Rio" else if [IN_AGUA_INEXISTENTE]=1 then "Inexistente" else if [IN_AGUA_CARRO_PIPA]=1 then "Carro-pipa" else "Não informado", type text),
    Energia = Table.AddColumn(Agua,"ENERGIA", each if [IN_ENERGIA_REDE_PUBLICA]=1 then "Rede pública" else if [IN_ENERGIA_GERADOR_FOSSIL]=1 then "Gerador fóssil" else if [IN_ENERGIA_RENOVAVEL]=1 then "Renovável" else if [IN_ENERGIA_INEXISTENTE]=1 then "Inexistente" else "Não informado", type text),
    Esgoto = Table.AddColumn(Energia,"ESGOTO", each if [IN_ESGOTO_REDE_PUBLICA]=1 then "Rede pública" else if [IN_ESGOTO_FOSSA_SEPTICA]=1 then "Fossa séptica" else if [IN_ESGOTO_FOSSA_COMUM]=1 then "Fossa comum" else if [IN_ESGOTO_FOSSA]=1 then "Fossa rudimentar" else if [IN_ESGOTO_INEXISTENTE]=1 then "Inexistente" else "Não informado", type text),
    Lixo = Table.AddColumn(Esgoto,"LIXO", each if [IN_LIXO_SERVICO_COLETA]=1 then "Serviço de coleta" else if [IN_LIXO_QUEIMA]=1 then "Queima" else if [IN_LIXO_ENTERRA]=1 then "Enterra" else if [IN_LIXO_DESTINO_FINAL_PUBLICO]=1 then "Destino final público" else if [IN_LIXO_DESCARTA_OUTRA_AREA]=1 then "Descarte em outra área" else "Não informado", type text)
in
    Lixo
