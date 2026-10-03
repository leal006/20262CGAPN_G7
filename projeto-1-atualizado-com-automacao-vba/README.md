# Projeto 1 — Simulador de Repasse do PNAE com VBA

## Objetivo
Registrar cada cenário de repasse com data/hora, fator de ajuste, racional, resultado calculado e nome de quem executou a simulação.

## Como usar
1. Abra `Simulador-PNAE-Projeto1-Atualizado.xlsm` no Excel Desktop e habilite macros quando o Excel solicitar.
2. No campo **Usuário da Simulação** (C22), informe seu nome. Preencha o racional (C25) e o fator de ajuste (C26).
3. Clique em **Salvar Simulação**. A macro registra os valores nas colunas A:G da aba `Banco_de_Dados` e limpa C22, C25 e C26.
4. Para instalar a versão final da macro: pressione `Alt+F11` (Windows) ou `Option+F11`/menu Desenvolvedor > Visual Basic (Mac); remova o módulo antigo `modSimulador` e importe `modSimulador.bas` em **File > Import File**; salve como `.xlsm`. O botão existente continua associado a `RegistrarSimulacao`.
5. Teste com pelo menos duas simulações preenchidas e uma tentativa com Usuário em branco; confira que a tentativa inválida não cria linha.

## Arquivos
- `Simulador-PNAE-Projeto1-Atualizado.xlsm`: campo Usuário na tela e coluna G no banco; o VBA original ainda precisa ser substituído pelo módulo `.bas` incluído.
- `modSimulador.bas`: versão completa do módulo com leitura, validação, gravação e limpeza do Usuário.

## Dados e regras
Escola e matrículas são fictícias para fins didáticos. Os valores per capita e a regra do repasse estão identificados no simulador como baseados na Resolução CD/FNDE nº 1/2026. A base Censo não é usada no Projeto 1.

## Disclaimers
- **Inteligência Artificial:** apoio de IA na preparação/revisão do código e da documentação. O grupo deve registrar o uso real feito e revisar o código antes da entrega.
- **Dados:** a escola e as matrículas do simulador são fictícias; os parâmetros per capita são os apresentados no próprio arquivo de atividade.
- **Participação:** preencher antes de publicar: `[nome(s) de quem implementou/importou o módulo]`; teste realizado por `[nomes]` em `[data]`, com `[quantidade]` cenários válidos e uma tentativa com Usuário em branco. Não afirmar teste concluído até executá-lo no Excel Desktop.

## Checklist do roteiro
- [x] Campo Usuário criado na tela sem deslocar as células C25/C26.
- [x] Coluna G (`Usuário`) adicionada ao banco de dados.
- [x] Código VBA final incluído em arquivo `.bas` com leitura, validação, gravação e limpeza.
- [ ] Importar/substituir módulo no Excel Desktop e salvar o `.xlsm` final.
- [ ] Testar macro pelo botão com 2–3 cenários, incluindo Usuário vazio.
- [ ] Preencher os nomes reais de participação e os testes efetivamente realizados.
- [x] Publicar a pasta do Projeto 1 no GitHub.
