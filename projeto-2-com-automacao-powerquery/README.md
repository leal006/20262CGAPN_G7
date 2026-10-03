# Projeto 2 — Painel do Censo Escolar com Power Query

## Objetivo
Tratar a base nacional do Censo Escolar 2024 no Power Query, filtrar primeiro pelo UF e município informados, enriquecer os registros com quatro tabelas auxiliares e permitir atualização do painel.

## O que foi atualizado
- A planilha parte do arquivo de Aula 10 e conserva a estrutura de consultas, tabela de filtro e tabela dinâmica que já existiam.
- O código M completo foi incluído na planilha e também em `PowerQuery_Completo.m`. A consulta `Microdados` filtra o município por junção interna antes dos quatro merges Left Outer.
- A classificação usa as faixas praticadas na consulta de Aula 10: até 50, Microescola; até 200, Pequena; até 500, Média; até 1.000, Grande; até 5.000, Muito Grande; acima disso, Mega escola.
- Água, Energia, Esgoto e Lixo usam a primeira coluna binária marcada com 1, na ordem dos campos do Censo.
- Os campos nomeados `UF` e `Municipio` apontam para as duas células da tabela de filtro existente (Planilha1!A2:B2); o padrão inicial permanece SP / Rio Claro.
- A atualização em segundo plano foi desligada na conexão principal e a tabela dinâmica existente está marcada para atualizar ao abrir.

## Como terminar a configuração no Excel Desktop
1. Extraia a pasta `projeto-2-com-automacao-powerquery` do pacote zip. Ela já contém `Censo_2024_Excel.xlsx`; deixe esse arquivo e a planilha acessíveis na pasta local. Se preferir, use a cópia extraída do RAR recebido.
2. Abra `Painel_Censo_Projeto2-Preparado.xlsx` no Excel Desktop. No Editor do Power Query, edite a consulta `ArquivoCenso` e substitua `C:\SUBSTITUA\PASTA\Censo_2024_Excel.xlsx` pelo caminho real do arquivo extraído.
3. Confira os nomes no Gerenciador de Nomes: `UF` aponta para `Planilha1!A2` e `Municipio` para `Planilha1!B2`. Edite esses valores para o município escolhido pelo grupo (o exemplo do material é SP / Rio Claro).
4. Clique em **Dados > Atualizar Tudo**. Verifique que a prévia da consulta `Microdados` contém somente o UF/município selecionado e que os quatro rótulos auxiliares e cinco colunas derivadas aparecem.
5. Atualize a tabela dinâmica. Crie/ajuste gráfico(s) dinâmico(s) e segmentação(ões) na aba de painel conforme os campos escolhidos pelo grupo. Altere UF/município e repita **Atualizar Tudo** para validar a atualização em um clique.

## Limitação desta preparação
O arquivo contém a consulta M completa e o cache/tabela dinâmica que já existiam na planilha de aula. O painel final com gráfico(s) dinâmico(s), segmentação(ões) e teste real de atualização precisa ser concluído/validado no Excel Desktop; esses objetos e a execução do motor Power Query não puderam ser confirmados neste ambiente.

## Dados e disclaimers
- **Inteligência Artificial:** apoio de IA na revisão do código M e da documentação; o grupo deve registrar o uso real e conferir cada transformação.
- **Dados:** microdados e tabelas auxiliares são da base nacional Censo Escolar 2024 recebida para a atividade. O filtro inicial SP / Rio Claro é apenas o exemplo já usado em aula; substituir pelo município efetivamente escolhido.
- **Participação:** preencher antes de publicar: `[integrantes que implementaram as consultas]`; indicar quem montou as dinâmicas/gráficos e quem realizou o teste de troca de município e atualização.

## Checklist do roteiro
- [x] Base nacional fornecida identificada e esquema verificado (215.545 linhas de escolas, 59 colunas e quatro abas auxiliares).
- [x] Consulta M filtrando por UF e Município em Inner Join antes dos merges.
- [x] Quatro merges Left Outer: Dependência, Localização, Localização Diferenciada e Situação.
- [x] Coluna Tamanho da Escola e indicadores Água, Energia, Esgoto e Lixo descritos no M.
- [x] Dois nomes definidos no Excel e consulta principal sem atualização em segundo plano.
- [ ] Atualizar consulta no Excel Desktop com o caminho local da base e validar amostra.
- [ ] Finalizar/validar as tabelas e gráficos dinâmicos, segmentações e dashboard.
- [ ] Testar troca do município e Atualizar Tudo em um clique.
- [ ] Preencher os nomes reais de participação e os testes efetivamente realizados.
- [x] Publicar a pasta do Projeto 2 no GitHub.
