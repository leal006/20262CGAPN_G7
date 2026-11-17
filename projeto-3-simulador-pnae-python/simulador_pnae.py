### Projeto 3 — Simulador didático de repasse do PNAE ###

# ======================== PARÂMETROS ========================
# Fonte: https://www.gov.br/fnde/pt-br/acesso-a-informacao/acoes-e-programas/programas/pnae
DIAS_LETIVOS = 200
PER_CAPITA_CRECHE = 1.57
PER_CAPITA_PRE_ESCOLA = 0.82
PER_CAPITA_FUNDAMENTAL = 0.57

# observado em 2021 nas escolas municipais de ensino fundamental de
# Morro da Fumaça (SC), em estudo publicado em 19/09/2025.
# Fonte: Costa et al. (2025), Cadernos de Saúde Pública, tabela 1.
# https://pmc.ncbi.nlm.nih.gov/articles/PMC12448751/
CUSTO_ALIMENTOS_REFEICAO = 4.50


# ========================== FUNÇÕES ==========================
def ler_numero(pergunta):
    while True:
        resposta = input(pergunta).strip()
        try:
            valor = int(resposta)
            if valor < 0:
                print("Valor inválido: digite um inteiro igual ou maior que zero.")
            else:
                return valor
        except ValueError:
            print("Valor inválido: digite um número inteiro.")


def calcular_repasse(creche, pre_escola, fundamental):
    repasse_creche = creche * DIAS_LETIVOS * PER_CAPITA_CRECHE
    repasse_pre_escola = pre_escola * DIAS_LETIVOS * PER_CAPITA_PRE_ESCOLA
    repasse_fundamental = fundamental * DIAS_LETIVOS * PER_CAPITA_FUNDAMENTAL
    return repasse_creche + repasse_pre_escola + repasse_fundamental


def classificar_porte(total_alunos):
    if total_alunos <= 200:
        return "Pequena"
    elif total_alunos <= 400:
        return "Média"
    else:
        return "Grande"


def calcular_cobertura(total_alunos, repasse_anual):
    
    custo_anual = total_alunos * DIAS_LETIVOS * CUSTO_ALIMENTOS_REFEICAO

    if custo_anual == 0:
        return 0.0, 0.0, 0.0, "sem_matriculas"

    cobertura_pct = repasse_anual / custo_anual * 100
    if repasse_anual >= custo_anual:
        diferenca = 0.0
        situacao = "coberto"
    else:
        diferenca = custo_anual - repasse_anual
        situacao = "complementar"
    return custo_anual, cobertura_pct, diferenca, situacao


def formatar_reais(valor):
    numero = f"{valor:,.2f}".replace(",", "_").replace(".", ",").replace("_", ".")
    return f"R$ {numero}"


# ====================== PROGRAMA PRINCIPAL =====================
def main():
    print("=" * 65)
    print("SIMULADOR DE REPASSE DO PNAE — PROJETO 3")
    print("=" * 65)
    print("Informe as matrículas de uma escola pública.")
    print("Se a escola não oferece alguma etapa, digite 0.")
    print()

    escola = input("Nome da escola: ").strip()
    if not escola:
        escola = "Escola não informada"

    creche = ler_numero("Matrículas de creche: ")
    pre_escola = ler_numero("Matrículas de pré-escola: ")
    fundamental = ler_numero("Matrículas de ensino fundamental: ")

    total_alunos = creche + pre_escola + fundamental
    porte = classificar_porte(total_alunos)
    repasse_anual = calcular_repasse(creche, pre_escola, fundamental)
    custo_anual, cobertura_pct, diferenca, situacao = calcular_cobertura(
        total_alunos, repasse_anual
    )

    print()
    print("=" * 65)
    print("RESULTADO DA SIMULAÇÃO")
    print("=" * 65)
    print("Escola:", escola)
    print("Dias letivos:", DIAS_LETIVOS)
    print("Creche:", creche)
    print("Pré-escola:", pre_escola)
    print("Ensino fundamental:", fundamental)
    print("Total de matrículas consideradas:", total_alunos)
    print("Porte (critério didático):", porte)
    print("Repasse federal anual estimado:", formatar_reais(repasse_anual))
    print("Custo de alimentos por refeição:", formatar_reais(CUSTO_ALIMENTOS_REFEICAO))
    print("Custo anual estimado dos alimentos:", formatar_reais(custo_anual))
    print(f"Cobertura do repasse federal: {cobertura_pct:.2f}%".replace(".", ","))
    print("Diferença a ser coberta por outras fontes:", formatar_reais(diferenca))

    if situacao == "coberto":
        print("Situação: o repasse cobre o custo estimado dos alimentos.")
    elif situacao == "sem_matriculas":
        print("Situação: sem matrículas; não há custo de alimentos a estimar.")
    else:
        print("Situação: é necessária complementação de outras fontes.")

    print()
    


if __name__ == "__main__":
    main()