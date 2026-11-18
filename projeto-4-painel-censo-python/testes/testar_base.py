"""Conferência independente da base. Execute: python3 testes/testar_base.py"""
from pathlib import Path
import pandas as pd

caminho = Path(__file__).resolve().parents[1] / "escolas_sp_regioes_2024_geo.csv"
df = pd.read_csv(caminho)
assert len(df) == 3110
assert df["municipio"].nunique() == 30
assert df["regiao"].nunique() == 4
assert df[["latitude", "longitude"]].notna().all().all()
assert df["codigo_inep"].is_unique
assert df["matriculas"].sum() == 1153026
assert len(df[df["regiao"] == "Vale do Ribeira"]) == 338
assert df.loc[df["regiao"] == "Vale do Ribeira", "matriculas"].sum() == 63777
assert len(df[df["regiao"] == "Região Metropolitana de SP"]) == 1263
print("OK: base original conferida, sem coordenadas ausentes, 3.110 escolas e 30 municípios.")
