# Projeto 3 — Simulador de Repasse do PNAE em Python

**Disciplina:** Análise de Dados para Pesquisas em Políticas Públicas (CGAPN)  
**Professora:** Érica Siqueira · **Período:** 2º semestre de 2026  
**Grupo:** 7

## Objetivo

Este programa simula o repasse federal anual do Programa Nacional de Alimentação Escolar (PNAE) para uma escola, considerando as matrículas de creche, pré-escola e ensino fundamental e 200 dias letivos. Também compara o repasse estimado a uma referência pesquisada para o **custo dos alimentos de uma refeição**, calcula a porcentagem coberta pela União e identifica a diferença que precisaria ser financiada por outras fontes. Os valores são **estimativas didáticas**, e não o repasse efetivamente recebido pela escola.

## Como usar

1. Baixe `simulador_pnae.py` e abra um terminal na pasta do arquivo.
2. Execute:

   ```bash
   python simulador_pnae.py
   ```
4. Digite o nome da escola e as matrículas de **creche**, **pré-escola** e **ensino fundamental**, sempre como números inteiros iguais ou maiores que zero. Para etapas não oferecidas pela escola, digite **0**.
5. Leia o total de matrículas, o porte, o repasse anual, o custo anual estimado dos alimentos, a cobertura percentual e a diferença a complementar.

O programa utiliza as constantes `DIAS_LETIVOS`, `PER_CAPITA_CRECHE`, `PER_CAPITA_PRE_ESCOLA`, `PER_CAPITA_FUNDAMENTAL` e `CUSTO_ALIMENTOS_REFEICAO` no início do arquivo.

## Prints do resultado

**Execução com escola real — Censo Escolar 2024:**

Registro da execução com a escola real: consultar `prints/saida_escola_real.txt`. **A captura de tela correspondente será acrescentada pelo grupo antes da entrega no eClass.**

**Teste de validação do Projeto 1:**

Registro do teste de validação: consultar `prints/saida_validacao_projeto1.txt`. **A captura de tela correspondente será acrescentada pelo grupo antes da entrega no eClass.**

As saídas de texto correspondentes também estão preservadas em `prints/saida_escola_real.txt` e `prints/saida_validacao_projeto1.txt` para conferência.

## Escola simulada

| Informação | Dado verificado no arquivo do Censo 2024 |
|---|---|
| Escola | CECILIA CORREA CASTELANI PROFA EMEF |
| Código INEP | **35217116** |
| Município | **Osasco** |
| UF | **SP** |
| Dependência administrativa | **Municipal** (`TP_DEPENDENCIA = 3`) |
| Situação de funcionamento | **Em atividade** (`TP_SITUACAO_FUNCIONAMENTO = 1`) |
| Matrículas em creche | **0** |
| Matrículas em pré-escola | **0** |
| Matrículas no ensino fundamental | **304** (`QT_MAT_FUND = 304`) |
| Matrículas na educação básica | **304** (`QT_MAT_BAS = 304`) |

### Como encontramos os dados no Censo

Foi utilizado o arquivo disponibilizado na disciplina **`Censo_2024_Excel.rar`**, que contém a planilha **`Censo_2024_Excel.xlsx`**. No conjunto de escolas, foram identificadas as colunas `NO_ENTIDADE` (nome), `CO_ENTIDADE` (código INEP), `NO_MUNICIPIO` (município), `SG_UF` (sigla da UF), `TP_DEPENDENCIA` (dependência), `TP_SITUACAO_FUNCIONAMENTO` (funcionamento), `QT_MAT_INF` (matrículas da educação infantil), `QT_MAT_FUND` (matrículas do ensino fundamental) e `QT_MAT_BAS` (total da educação básica).

O procedimento foi:

1. Filtrar `SG_UF = SP` e `NO_MUNICIPIO = Osasco`.
2. Localizar a linha com `CO_ENTIDADE = 35217116`.
3. Confirmar que `TP_DEPENDENCIA = 3` (municipal) e `TP_SITUACAO_FUNCIONAMENTO = 1` (em atividade).
4. Ler `QT_MAT_INF = 0`, `QT_MAT_FUND = 304` e `QT_MAT_BAS = 304`.
5. Informar **0** para creche e pré-escola, pois a escola não apresenta matrículas de educação infantil, e **304** para o ensino fundamental.

A planilha fornecida agrega educação infantil em `QT_MAT_INF`; ela não possui, nessa versão tratada, colunas separadas para creche e pré-escola. A escolha de uma escola com `QT_MAT_INF = 0` evita inferir uma divisão não observada. Para outros estabelecimentos com matrículas em educação infantil, seria necessário consultar o recorte detalhado de matrículas do Censo antes de preencher essas duas etapas.

**Fonte oficial do conjunto de dados:** [INEP — Microdados do Censo Escolar (edição 2024)](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar). A seleção acima foi verificada na planilha consolidada entregue para a atividade.

## Custo dos alimentos por refeição

**Valor adotado: R$ 4,50 por refeição (somente alimentos).**

**Fonte pesquisada:** Costa, G. M. e colaboradores. *Custo-efetividade de lanches e refeições na alimentação escolar de um município do Sul do Brasil*. **Cadernos de Saúde Pública**, v. 41, n. 9, publicado em **19 de setembro de 2025**. O estudo analisou cardápios servidos em **2021** a estudantes do **ensino fundamental** da rede municipal de **Morro da Fumaça (Santa Catarina)**. Na **Tabela 1**, a mediana do custo direto dos alimentos usados nas **refeições** foi de **R$ 4,50**, diferente do custo dos lanches. Os custos foram calculados com quantidades e preços dos ingredientes das preparações, não como custo completo de equipe e estrutura.

**Link:** https://pmc.ncbi.nlm.nih.gov/articles/PMC12448751/

**Justificativa:** o valor provém de pesquisa com preços de ingredientes efetivamente adquiridos para alimentação escolar e considera a mesma etapa de ensino da escola escolhida (fundamental). Por isso, é uma referência transparente para o exercício de estimar a cobertura do repasse federal.

## Resultados e reflexão

### Teste do simulador do Projeto 1

Com **60 matrículas de creche**, **80 de pré-escola**, **50 de ensino fundamental** e **200 dias letivos**, o repasse federal anual calculado é **R$ 37.660,00**, e a escola é classificada como **Pequena**. Isso reproduz o resultado exigido na orientação do Projeto 3. As matrículas desse teste são fictícias.

### Escola real do Censo 2024

| Indicador | Valor |
|---|---:|
| Matrículas consideradas | **304** |
| Porte pelo critério didático | **Média** |
| Repasse federal anual estimado | **R$ 34.656,00** |
| Referência de alimentos por refeição | **R$ 4,50** |
| Custo anual dos alimentos: 304 × 200 × R$ 4,50 | **R$ 273.600,00** |
| **Cobertura federal estimada** | **12,67%** |
| **Diferença a ser coberta por outras fontes** | **R$ 238.944,00** |

**Fórmulas empregadas:**

- Repasse federal: `(creche × 1,57 + pré-escola × 0,82 + fundamental × 0,57) × 200`;
- Custo anual dos alimentos: `(creche + pré-escola + fundamental) × 200 × 4,50`;
- Cobertura percentual: `repasse federal ÷ custo anual × 100`;
- Diferença a complementar: `máximo(0, custo anual − repasse federal)`.

### Reflexão sobre financiamento

Na simulação, o repasse federal equivale a **12,67%** do custo estimado dos ingredientes de uma refeição principal diária para os 304 alunos da escola. Os **87,33%** restantes seriam a parcela a ser financiada por outras fontes *dentro desse cenário simplificado*. O resultado **não prova que a escola ou a prefeitura tenham déficit de R$ 238.944,00**: o custo usado é histórico e de outro município, e o modelo não observa despesas nem transferências efetivas de Osasco.

A nota técnica do **Todos Pela Educação (2023)** destaca que a atualização dos valores per capita e o financiamento do programa são relevantes para preservar seu poder de compra. A análise do **Observatório da Alimentação Escolar (21/10/2025)** discutiu como a perda de poder aquisitivo, até aquele momento, poderia dificultar o cumprimento das diretrizes de alimentação saudável. A reportagem do **Brasil de Fato (16/10/2025)** salientou que a capacidade de complementar recursos federais é desigual entre municípios. **Em fevereiro de 2026 houve reajuste dos repasses federais**, refletido nos valores que este simulador utiliza; assim, os diagnósticos das leituras de 2025 devem ser entendidos no contexto em que foram publicados.

Se um ente responsável não conseguir custear a diferença entre os recursos federais e os alimentos necessários, poderá haver dificuldade para manter a **regularidade, a variedade ou a qualidade** da alimentação oferecida. A resposta adequada exige planejamento de compras, acompanhamento nutricional e complementação orçamentária suficiente; o simulador, por si só, não substitui uma auditoria de gastos nem a avaliação do cardápio escolar.

**Simplificações adotadas:** matrículas de **2024** combinadas com per capita federal de **2026**; somente três etapas (creche, pré-escola e fundamental); **200 dias letivos**; **uma refeição por aluno por dia**; custos diretos dos alimentos, sem pessoal, gás, infraestrutura ou equipamentos; valor único por refeição, mesmo entre etapas; classificação de porte **didática, não oficial do PNAE**.

### Leituras de apoio solicitadas

1. Todos Pela Educação. *Cenários para a recomposição orçamentária e o fortalecimento do PNAE*. Março de 2023. https://todospelaeducacao.org.br/wordpress/wp-content/uploads/2023/03/nota-pnae-reajuste-nos-valores-do-programa-nacional-de-alimentacao-escolar.pdf
2. Observatório da Alimentação Escolar. *Apesar de ousadas novas metas, ausência de reajuste ameaça a alimentação escolar*. 21 de outubro de 2025. https://alimentacaoescolar.org.br/noticias/2025/10/21/apesar-de-ousadas-novas-metas-ausencia-de-reajuste-ameaca-a-alimentacao-escolar/
3. Brasil de Fato. *Alimentação escolar: Brasil ainda enfrenta desafio do financiamento, diz estudo*. 16 de outubro de 2025. https://www.brasildefato.com.br/podcast/bem-viver/2025/10/16/alimentacao-escolar-brasil-ainda-enfrenta-desafio-do-financiamento-diz-estudo/

## Organização do programa

| Parte/função | O que faz | Correspondência ao Projeto 1 em Excel |
|---|---|---|
| Constantes do início do arquivo | Define dias letivos, valores per capita e custo de referência dos alimentos | Aba de parâmetros do PNAE |
| `ler_numero` | Solicita e valida matrículas inteiras não negativas | Entradas de matrícula na planilha |
| `calcular_repasse` | Calcula o repasse por etapa e soma | `PROCV` dos valores por modalidade e `SOMARPRODUTO` |
| `classificar_porte` | Classifica em Pequena (até 200), Média (201 a 400) ou Grande (acima de 400) | `PROCV` aproximado / tabela didática de porte |
| `calcular_cobertura` | Calcula custo dos alimentos, cobertura (%) e diferença; usa `if` para zerar a diferença quando o repasse cobre o custo | Nova análise, inexistente no Projeto 1 |
| `formatar_reais` | Exibe os montantes com formatação monetária brasileira | Formatação de células como moeda |
| `main` | Lê as matrículas e mostra os resultados no terminal | Uso do simulador e leitura dos resultados na planilha |

Para repetir os testes de cálculo, execute `python testes/testar_simulador.py`.

## Uso de Inteligência Artificial

**Ferramenta utilizada:** ChatGPT (OpenAI).

**Para que foi usada:** apoio à análise do enunciado, consulta e organização de fontes públicas, adaptação do simulador do grupo para as três modalidades exigidas, implementação da cobertura federal, escrita inicial da documentação e preparação de testes. O grupo precisa ler, conferir e assumir responsabilidade por todo o material antes do envio.

## Fonte de Dados

**Fontes oficiais:**

- **INEP — Censo Escolar 2024**, microdados e dicionário de dados: https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar
- **FNDE — Resolução CD/FNDE nº 1, de 18 de fevereiro de 2026**, para os per capita de creche (**R$ 1,57**), pré-escola (**R$ 0,82**) e fundamental (**R$ 0,57**): https://www.gov.br/fnde/pt-br/acesso-a-informacao/acoes-e-programas/programas/pnae

**O que os dados representam:** os registros do Censo Escolar identificam escolas e informam a situação de funcionamento, dependência administrativa e números de matrículas declarados em **2024**. A aplicação dos valores diários federais de **2026** e de 200 dias resulta em uma **estimativa de repasse**, não em transferências verificadas no sistema de pagamentos do FNDE.

**Estrutura utilizada:** `NO_ENTIDADE` (nome); `CO_ENTIDADE` (código INEP); `NO_MUNICIPIO` (município); `SG_UF` (UF); `TP_DEPENDENCIA` (rede); `TP_SITUACAO_FUNCIONAMENTO` (situação); `QT_MAT_INF` (educação infantil, agregado); `QT_MAT_FUND` (fundamental); `QT_MAT_BAS` (educação básica total). A base foi consultada na planilha da disciplina `Censo_2024_Excel.xlsx`.

**Custo dos alimentos:** R$ 4,50 por refeição principal, estudo de **2021** publicado em **19/09/2025**, em município de SC; https://pmc.ncbi.nlm.nih.gov/articles/PMC12448751/. Não é cotação de Osasco.

## Participação do Grupo

**O que aprendemos com este projeto:** Esse trabalho nos deu a possibilidade de comparar os repasses federais por etapa de ensino com uma referência documentada de custo de ingredientes; também exercita entrada e validação de dados, funções, operações aritméticas, estruturas condicionais e documentação reprodutível em Python. Esse é o aprendizado técnico associado ao trabalho; o grupo deve conferir a redação com os integrantes antes da entrega.

**Divisão de responsabilidades informada para o grupo (confirmar a realização efetiva antes da entrega):**

- **Rafael Leal:** desenvolvimento do simulador em Python.
- **José Antonio:** pesquisa e seleção da escola no Censo Escolar 2024.
- **João Henrique:** pesquisa do custo dos alimentos e levantamento das fontes.
- **Pedro de Marco:** testes, conferência dos cálculos e preparação dos prints.
- **Pedro Giorgi:** documentação no README, reflexão e organização no GitHub.


