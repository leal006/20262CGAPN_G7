# Projeto 1 — Simulador de Repasse do PNAE com automação VBA

## Grupo 
Grupo 7 — Rafael Stempfer Leal, José Antonio Medeiros, Pedro Giorgi, João Vitor Henrique e Pedro de Marco.

## Objetivo
Automatizar o registro das simulações do PNAE no Excel, incluindo a identificação do usuário responsável por cada simulação. A solução mantém a lógica original do simulador e adiciona o tratamento completo do campo **Usuário** no VBA.

## Arquivos
- `Simulador-PNAE-Projeto1.xlsm`: planilha habilitada para macro com o campo Usuário integrado e a automação funcionando.
- `modRegistrarSimulacao.bas`: código-fonte do módulo VBA usado pela automação.

## O que foi implementado
- Campo **Usuário** na aba `Simulador_Escola`, célula `B22`.
- Leitura do usuário em `RegistrarSimulacao`.
- Validação que impede o registro quando o campo Usuário está vazio.
- Gravação do usuário na coluna `G` da aba `Banco_de_Dados`.
- Limpeza do campo Usuário após o registro, junto com Racional da Taxa e Fator de Ajuste.
- Manutenção das referências originais `C25` (Racional da Taxa) e `C26` (Fator de Ajuste).
- Botão de salvamento executando a macro `RegistrarSimulacao`.

## Como usar
1. Abra `Simulador-PNAE-Projeto1.xlsm` no Excel Desktop.
2. Habilite as macros para o arquivo.
3. Na aba `Simulador_Escola`, informe o nome do usuário em `B22`, o Racional da Taxa em `C25` e o Fator de Ajuste em `C26`.
4. Clique no botão **Salvar Simulação**.
5. Confira o novo registro na aba `Banco_de_Dados`, nas colunas `A:G`.
6. Se o campo Usuário estiver vazio, o registro é bloqueado e uma mensagem de validação é exibida.

## Testes realizados
A integração e os testes finais foram realizados no Excel por **Rafael Stempfer Leal**. Foram verificadas a execução do botão, a gravação das simulações no banco de dados, o preenchimento da coluna Usuário e a validação do campo obrigatório. A versão final contém registros de teste da automação.

## Disclaimers
- **Inteligência Artificial:** foi utilizada assistência de IA no apoio à implementação, revisão do código VBA, organização da documentação e validação da estrutura da entrega.
- **Dados:** os dados utilizados no simulador têm finalidade didática. Os valores e parâmetros do PNAE seguem o material disponibilizado na disciplina e a planilha-base utilizada no projeto.
- **Participação:**
  - **Rafael Stempfer Leal:** implementou o campo Usuário na planilha, integrou o código VBA e realizou os testes finais da macro `RegistrarSimulacao` no Excel Desktop.
  - **José Antonio Medeiros:** organizou a estrutura da planilha e escreveu a documentação do Projeto 1.
  - **Pedro Giorgi:** realizou a conferência do funcionamento do simulador e organizou os arquivos da entrega.
  - **João Vitor Henrique:** escreveu os disclaimers e o texto do README do Projeto 1.
  - **Pedro de Marco:** organizou a pasta do Projeto 1 e estruturou os arquivos no GitHub.

### Testes realizados
A automação foi testada no Excel Desktop com registros de simulações contendo o campo Usuário preenchido e também com o campo Usuário vazio. Foi verificado que, com o campo preenchido, os dados eram salvos corretamente na aba `Banco_de_Dados` e, quando o campo estava vazio, a macro bloqueava o registro e exibia a mensagem de validação.
