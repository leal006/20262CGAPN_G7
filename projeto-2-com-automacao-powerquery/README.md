# Projeto 2 — Painel do Censo Escolar 2024 com Power Query

## Objetivo
Construir um painel automatizado do Censo Escolar 2024 que utilize a base nacional completa e aplique, dentro do Power Query, o filtro de **UF + Município** escolhido pelo grupo antes das demais transformações. O arquivo final está salvo com o recorte **SP / Rio Claro**.

## Arquivos
- `painel-censo-escolar-2024.xlsx`: planilha final com filtro de município, consulta Power Query, tabela tratada, tabelas dinâmicas, gráficos dinâmicos, segmentação de dados e dashboard.
- `Consulta_DadosTratados.pq`: código M da consulta principal `DadosTratados`.

## O que mudou em relação à versão anterior
Na versão anterior, o trabalho utilizava um recorte de São Paulo preparado para a atividade em sala. Nesta versão, a consulta parte da **base nacional completa do Censo Escolar 2024** e reduz os dados ao município selecionado dentro do Power Query, antes das tabelas dinâmicas e do dashboard.

A consulta também incorpora as tabelas auxiliares de **Dependência, Localização, Localização Diferenciada e Situação**.

## Tratamento no Power Query
- Filtro por `SG_UF` + `NO_MUNICIPIO` com **Inner Join** antes dos merges de dimensão.
- **Left Join** para Dependência, Localização, Localização Diferenciada e Situação.
- Criação da coluna `TAMANHO_ESCOLA` a partir das faixas de matrícula.
- Criação dos indicadores de infraestrutura `AGUA`, `ENERGIA`, `ESGOTO` e `LIXO`, seguindo a prioridade da primeira coluna binária marcada com valor 1.
- Consulta principal configurada sem atualização em segundo plano para que **Atualizar Tudo** respeite a conclusão do Power Query antes da atualização dos objetos dinâmicos.

## Dashboard
O dashboard final reúne **9 gráficos dinâmicos**, cobrindo:
- Dependência administrativa;
- Porte da escola;
- Água;
- Energia;
- Esgoto;
- Lixo;
- Sexo;
- Raça/Cor;
- Etapa de ensino.

Também foram incluídas duas segmentações de dados para análise interativa:
- **Localização**;
- **Dependência**.

As segmentações foram conectadas às tabelas dinâmicas do painel e testadas no Excel Desktop. As tabelas dinâmicas foram reorganizadas para evitar sobreposição durante a aplicação dos filtros.

## Como usar
1. Mantenha o arquivo nacional `Censo_2024_Excel.xlsx` em um local acessível no computador.
2. Na aba `Filtro_Municipio`, informe em `B5` o caminho completo desse arquivo. A célula nomeada `CensoCaminho` aponta para esse endereço.
3. Informe a UF em `B2` e o Município em `B3`. As células estão nomeadas como `UF` e `Município`, e a tabela `FiltroMunicipio` utiliza esses valores para o filtro da consulta.
4. Clique em **Dados > Atualizar Tudo**.
5. Aguarde a conclusão da atualização e confira o dashboard, as tabelas dinâmicas, os gráficos dinâmicos e a segmentação de dados.

## Testes realizados
Os testes finais foram realizados por **João Vitor Henrique** no Excel Desktop. O município selecionado foi alterado de **São Paulo (SP)** para **Rio Claro (SP)** e, após executar **Atualizar Tudo**, foi confirmado que os dados, tabelas dinâmicas, gráficos e dashboard foram atualizados automaticamente para o município selecionado. Também foram testadas as segmentações de **Localização** e **Dependência**, verificando a atualização dos gráficos sem sobreposição das tabelas dinâmicas.

No estado final de Rio Claro, o dashboard apresenta:
- 143 escolas no recorte;
- 122 escolas ativas;
- 43.081 matrículas da Educação Básica;
- 101 escolas públicas.

## Disclaimers
- **Inteligência Artificial:** foi utilizada assistência de IA no apoio à construção e revisão da consulta M, organização do painel e documentação.
- **Dados:** a fonte é o arquivo `Censo_2024_Excel.xlsx` disponibilizado na atividade. O painel utiliza dados do Censo Escolar 2024 e não representa necessariamente a situação atual das escolas.
- **Participação:**
  - **Rafael Stempfer Leal:** integrou a consulta do Power Query à base nacional do Censo Escolar 2024 e configurou o filtro por UF e Município.
  - **José Antonio Medeiros:** preparou as tabelas auxiliares utilizadas no projeto, auxiliou na organização dos dados no Power Query e escreveu os disclaimers do Projeto 2.
  - **Pedro Giorgi:** organizou as tabelas dinâmicas e a estrutura das informações utilizadas no dashboard.
  - **João Vitor Henrique:** realizou os testes finais de atualização automática no Excel Desktop e organizou o README do Projeto 2.
  - **Pedro de Marco:** montou os gráficos dinâmicos e ajudou na organização visual do dashboard.
