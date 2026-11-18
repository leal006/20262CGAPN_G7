# Projeto 4 — Painel Interativo do Censo Escolar 2024
# Disciplina: Análise de Dados para Pesquisas em Políticas Públicas
# Grupo 7

from pathlib import Path

import pandas as pd
import streamlit as st


# ---------- FUNÇÃO DE PORTE (a mesma lógica da Aula 21) ----------
def classificar_porte(total):
    if total <= 200:
        return "Pequena"
    elif total <= 400:
        return "Média"
    else:
        return "Grande"


# ---------- CARREGAMENTO E ORGANIZAÇÃO DOS DADOS ----------
ARQUIVO_DADOS = Path(__file__).resolve().parent / "escolas_sp_regioes_2024_geo.csv"


@st.cache_data
def carregar_dados(caminho):
    dados = pd.read_csv(caminho)
    dados["porte"] = dados["matriculas"].apply(classificar_porte)
    return dados


st.set_page_config(page_title="Painel do Censo Escolar 2024", page_icon="🏫", layout="wide")

try:
    base = carregar_dados(ARQUIVO_DADOS)
except FileNotFoundError:
    st.error("Não foi possível encontrar o arquivo escolas_sp_regioes_2024_geo.csv. Mantenha-o na mesma pasta de painel.py.")
    st.stop()

st.title("Panorama das Escolas — Censo Escolar 2024")
st.caption("Grupo 7 · Dados do INEP (Censo Escolar 2024) · Recorte de 30 municípios em quatro regiões de São Paulo")
st.markdown("Explore escolas e matrículas por região, município e porte, além de infraestrutura e localização.")


# ---------- FILTROS (ANTES DOS INDICADORES E GRÁFICOS) ----------
st.subheader("Filtros")
col_regiao, col_municipio, col_porte = st.columns(3)

with col_regiao:
    opcoes_regiao = ["Todas"] + sorted(base["regiao"].dropna().unique().tolist())
    regiao = st.selectbox("Região", opcoes_regiao)

# Municípios oferecidos dependem da região escolhida.
base_regiao = base if regiao == "Todas" else base[base["regiao"] == regiao]
with col_municipio:
    opcoes_municipio = ["Todos"] + sorted(base_regiao["municipio"].dropna().unique().tolist())
    municipio = st.selectbox("Município", opcoes_municipio)

base_municipio = base_regiao if municipio == "Todos" else base_regiao[base_regiao["municipio"] == municipio]
with col_porte:
    opcoes_porte = ["Todos"] + [p for p in ["Pequena", "Média", "Grande"] if p in base_municipio["porte"].values]
    porte = st.selectbox("Porte da escola", opcoes_porte)

censo = base_municipio if porte == "Todos" else base_municipio[base_municipio["porte"] == porte]
censo = censo.copy()

if censo.empty:
    st.warning("Não há escolas para essa combinação de filtros. Selecione outra opção.")
    st.stop()


# ---------- INDICADORES (BIG NUMBERS) ----------
st.subheader("Indicadores")
indicador_escolas, indicador_matriculas = st.columns(2)
indicador_escolas.metric("Total de escolas", f"{len(censo):,}".replace(",", "."))
indicador_matriculas.metric("Total de matrículas", f"{int(censo['matriculas'].sum()):,}".replace(",", "."))


# ---------- GRÁFICOS DE CARACTERÍSTICAS ----------
st.subheader("Características das escolas")
grafico_dependencia, grafico_localizacao = st.columns(2)
with grafico_dependencia:
    st.markdown("**Escolas por dependência administrativa**")
    st.bar_chart(censo["dependencia"].value_counts(), x_label="Dependência", y_label="Escolas")
with grafico_localizacao:
    st.markdown("**Escolas por localização**")
    st.bar_chart(censo["localizacao"].value_counts(), x_label="Localização", y_label="Escolas")


# ---------- GRÁFICOS DE INFRAESTRUTURA ----------
st.subheader("Infraestrutura das escolas")
grafico_agua, grafico_esgoto = st.columns(2)
with grafico_agua:
    st.markdown("**Escolas por abastecimento de água**")
    st.bar_chart(censo["agua"].value_counts(), x_label="Abastecimento", y_label="Escolas")
with grafico_esgoto:
    st.markdown("**Escolas por tipo de esgoto**")
    st.bar_chart(censo["esgoto"].value_counts(), x_label="Esgoto", y_label="Escolas")


# ---------- MAPA DAS ESCOLAS ----------
st.subheader("Mapa das escolas")
st.caption("Cada ponto representa uma escola com coordenadas de latitude e longitude na base da atividade.")
st.map(censo[["latitude", "longitude"]])


# ---------- LISTA DE ESCOLAS ----------
st.subheader("Lista de escolas")
st.caption(f"Exibindo {len(censo):,} escola(s) de acordo com os filtros selecionados.".replace(",", "."))
colunas_lista = ["codigo_inep", "regiao", "municipio", "escola", "dependencia", "localizacao", "matriculas", "porte", "agua", "esgoto"]
st.dataframe(
    censo[colunas_lista].sort_values(["municipio", "escola"]).reset_index(drop=True),
    use_container_width=True,
    hide_index=True,
)

st.caption("Fonte: Censo Escolar 2024 (INEP), base recortada disponibilizada na disciplina. Porte é uma classificação didática.")
