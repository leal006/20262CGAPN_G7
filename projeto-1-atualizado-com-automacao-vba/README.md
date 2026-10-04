# Projeto 1 — Simulador de Repasse do PNAE com automação VBA

## Grupo e repositório
Grupo 7 — Rafael Stempfer Leal, José Antonio Medeiros, Pedro Giorgi, João Vitor Henrique e Pedro de Marco.

Repositório: https://github.com/leal006/20262CGAPN_G7

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
A integração e os testes finais foram realizados no Excel Desktop por **Rafael Stempfer Leal**. Foram verificadas a execução do botão, a gravação das simulações no banco de dados, o preenchimento da coluna Usuário e a validação do campo obrigatório. A versão final contém registros de teste da automação.

## Disclaimers
- **Inteligência Artificial:** foi utilizada assistência de IA no apoio à implementação, revisão do código VBA, organização da documentação e validação da estrutura da entrega.
- **Dados:** os dados de escola utilizados no simulador são fictícios e têm finalidade didática; parâmetros e regras de cálculo seguem o material disponibilizado na disciplina.
- **Participação:** Rafael Stempfer Leal realizou a integração do campo Usuário e os testes finais da automação no Excel Desktop. Os demais integrantes do Grupo 7 participaram da elaboração e revisão do projeto conforme a organização interna do grupo. Esta descrição pode ser detalhada pelo grupo para refletir com precisão a divisão final de tarefas.
