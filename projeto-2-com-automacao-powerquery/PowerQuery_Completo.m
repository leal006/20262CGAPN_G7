section Section1;

shared ArquivoCenso = Excel.Workbook(File.Contents("C:\SUBSTITUA\PASTA\Censo_2024_Excel.xlsx"), null, true);

shared Dependencia = let
    Dados = ArquivoCenso{[Item="Dependencia",Kind="Sheet"]}[Data],
    Cabecalhos = Table.PromoteHeaders(Dados, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(Cabecalhos,{{"TP_DEPENDENCIA", Int64.Type}, {"DEPENDENCIA", type text}})
in Tipos;

shared Localizacao = let
    Dados = ArquivoCenso{[Item="Localizacao",Kind="Sheet"]}[Data],
    Cabecalhos = Table.PromoteHeaders(Dados, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(Cabecalhos,{{"TP_LOCALIZACAO", Int64.Type}, {"LOCALIZACAO", type text}})
in Tipos;

shared LocDiferenciada = let
    Dados = ArquivoCenso{[Item="LocDiferenciada",Kind="Sheet"]}[Data],
    Cabecalhos = Table.PromoteHeaders(Dados, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(Cabecalhos,{{"TP_LOCALIZACAO_DIFERENCIADA", Int64.Type}, {"LOC_DIFERENCIADA", type text}})
in Tipos;

shared Situacao = let
    Dados = ArquivoCenso{[Item="Situacao",Kind="Sheet"]}[Data],
    Cabecalhos = Table.PromoteHeaders(Dados, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(Cabecalhos,{{"TP_SITUACAO_FUNCIONAMENTO", Int64.Type}, {"SITUACAO", type text}})
in Tipos;

shared Tabela6 = let
    Dados = Excel.CurrentWorkbook(){[Name="Tabela6"]}[Content],
    Tipos = Table.TransformColumnTypes(Dados,{{"Estado (SIGLA)", type text}, {"Município ", type text}})
in Tipos;

shared Microdados = let
    Dados = ArquivoCenso{[Item="Microdados",Kind="Sheet"]}[Data],
    Cabecalhos = Table.PromoteHeaders(Dados, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(Cabecalhos,{
        {"CO_UF", Int64.Type}, {"CO_MUNICIPIO", Int64.Type}, {"CO_ENTIDADE", Int64.Type},
        {"SG_UF", type text}, {"NO_MUNICIPIO", type text}, {"TP_DEPENDENCIA", Int64.Type},
        {"TP_LOCALIZACAO", Int64.Type}, {"TP_LOCALIZACAO_DIFERENCIADA", Int64.Type},
        {"TP_SITUACAO_FUNCIONAMENTO", Int64.Type}, {"QT_MAT_BAS", Int64.Type},
        {"IN_AGUA_POTAVEL", Int64.Type}, {"IN_AGUA_REDE_PUBLICA", Int64.Type},
        {"IN_AGUA_POCO_ARTESIANO", Int64.Type}, {"IN_AGUA_CACIMBA", Int64.Type},
        {"IN_AGUA_FONTE_RIO", Int64.Type}, {"IN_AGUA_INEXISTENTE", Int64.Type},
        {"IN_AGUA_CARRO_PIPA", Int64.Type}, {"IN_ENERGIA_REDE_PUBLICA", Int64.Type},
        {"IN_ENERGIA_GERADOR_FOSSIL", Int64.Type}, {"IN_ENERGIA_RENOVAVEL", Int64.Type},
        {"IN_ENERGIA_INEXISTENTE", Int64.Type}, {"IN_ESGOTO_REDE_PUBLICA", Int64.Type},
        {"IN_ESGOTO_FOSSA_SEPTICA", Int64.Type}, {"IN_ESGOTO_FOSSA_COMUM", Int64.Type},
        {"IN_ESGOTO_FOSSA", Int64.Type}, {"IN_ESGOTO_INEXISTENTE", Int64.Type},
        {"IN_LIXO_SERVICO_COLETA", Int64.Type}, {"IN_LIXO_QUEIMA", Int64.Type},
        {"IN_LIXO_ENTERRA", Int64.Type}, {"IN_LIXO_DESTINO_FINAL_PUBLICO", Int64.Type},
        {"IN_LIXO_DESCARTA_OUTRA_AREA", Int64.Type}
    }),
    Filtro = Table.NestedJoin(Tipos, {"SG_UF", "NO_MUNICIPIO"}, Tabela6, {"Estado (SIGLA)", "Município "}, "FiltroMunicipio", JoinKind.Inner),
    SoMunicipio = Table.RemoveColumns(Filtro,{"FiltroMunicipio"}),
    MergeDependencia = Table.NestedJoin(SoMunicipio,{"TP_DEPENDENCIA"},Dependencia,{"TP_DEPENDENCIA"},"Dependencia",JoinKind.LeftOuter),
    ExpandeDependencia = Table.ExpandTableColumn(MergeDependencia,"Dependencia",{"DEPENDENCIA"},{"Dependencia.DEPENDENCIA"}),
    MergeLocalizacao = Table.NestedJoin(ExpandeDependencia,{"TP_LOCALIZACAO"},Localizacao,{"TP_LOCALIZACAO"},"Localizacao",JoinKind.LeftOuter),
    ExpandeLocalizacao = Table.ExpandTableColumn(MergeLocalizacao,"Localizacao",{"LOCALIZACAO"},{"Localizacao.LOCALIZACAO"}),
    MergeLocalizacaoDiferenciada = Table.NestedJoin(ExpandeLocalizacao,{"TP_LOCALIZACAO_DIFERENCIADA"},LocDiferenciada,{"TP_LOCALIZACAO_DIFERENCIADA"},"LocDiferenciada",JoinKind.LeftOuter),
    ExpandeLocalizacaoDiferenciada = Table.ExpandTableColumn(MergeLocalizacaoDiferenciada,"LocDiferenciada",{"LOC_DIFERENCIADA"},{"LocDiferenciada.LOC_DIFERENCIADA"}),
    MergeSituacao = Table.NestedJoin(ExpandeLocalizacaoDiferenciada,{"TP_SITUACAO_FUNCIONAMENTO"},Situacao,{"TP_SITUACAO_FUNCIONAMENTO"},"Situacao",JoinKind.LeftOuter),
    ExpandeSituacao = Table.ExpandTableColumn(MergeSituacao,"Situacao",{"SITUACAO"},{"Situacao.SITUACAO"}),
    Tamanho = Table.AddColumn(ExpandeSituacao,"TAMANHO_ESCOLA", each
        if [QT_MAT_BAS] = null then "Não informado"
        else if [QT_MAT_BAS] <= 50 then "Microescola"
        else if [QT_MAT_BAS] <= 200 then "Pequena"
        else if [QT_MAT_BAS] <= 500 then "Média"
        else if [QT_MAT_BAS] <= 1000 then "Grande"
        else if [QT_MAT_BAS] <= 5000 then "Muito Grande"
        else "Mega escola", type text),
    Agua = Table.AddColumn(Tamanho,"Água", each
        if Record.FieldOrDefault(_,"IN_AGUA_REDE_PUBLICA",null)=1 then "Rede pública"
        else if Record.FieldOrDefault(_,"IN_AGUA_POCO_ARTESIANO",null)=1 then "Poço artesiano"
        else if Record.FieldOrDefault(_,"IN_AGUA_CACIMBA",null)=1 then "Cacimba"
        else if Record.FieldOrDefault(_,"IN_AGUA_FONTE_RIO",null)=1 then "Fonte/Rio"
        else if Record.FieldOrDefault(_,"IN_AGUA_CARRO_PIPA",null)=1 then "Carro-pipa"
        else if Record.FieldOrDefault(_,"IN_AGUA_INEXISTENTE",null)=1 then "Inexistente"
        else "Não informado", type text),
    Energia = Table.AddColumn(Agua,"Energia", each
        if Record.FieldOrDefault(_,"IN_ENERGIA_REDE_PUBLICA",null)=1 then "Rede pública"
        else if Record.FieldOrDefault(_,"IN_ENERGIA_GERADOR_FOSSIL",null)=1 then "Gerador fóssil"
        else if Record.FieldOrDefault(_,"IN_ENERGIA_RENOVAVEL",null)=1 then "Renovável"
        else if Record.FieldOrDefault(_,"IN_ENERGIA_INEXISTENTE",null)=1 then "Inexistente"
        else "Não informado", type text),
    Esgoto = Table.AddColumn(Energia,"Esgoto", each
        if Record.FieldOrDefault(_,"IN_ESGOTO_REDE_PUBLICA",null)=1 then "Rede pública"
        else if Record.FieldOrDefault(_,"IN_ESGOTO_FOSSA_SEPTICA",null)=1 then "Fossa séptica"
        else if Record.FieldOrDefault(_,"IN_ESGOTO_FOSSA_COMUM",null)=1 then "Fossa comum"
        else if Record.FieldOrDefault(_,"IN_ESGOTO_FOSSA",null)=1 then "Fossa"
        else if Record.FieldOrDefault(_,"IN_ESGOTO_INEXISTENTE",null)=1 then "Inexistente"
        else "Não informado", type text),
    Lixo = Table.AddColumn(Esgoto,"Lixo", each
        if Record.FieldOrDefault(_,"IN_LIXO_SERVICO_COLETA",null)=1 then "Serviço de coleta"
        else if Record.FieldOrDefault(_,"IN_LIXO_QUEIMA",null)=1 then "Queima"
        else if Record.FieldOrDefault(_,"IN_LIXO_ENTERRA",null)=1 then "Enterra"
        else if Record.FieldOrDefault(_,"IN_LIXO_DESTINO_FINAL_PUBLICO",null)=1 then "Destino final público"
        else if Record.FieldOrDefault(_,"IN_LIXO_DESCARTA_OUTRA_AREA",null)=1 then "Descarta em outra área"
        else "Não informado", type text)
in Lixo;
