"""Testes do simulador do PNAE. Execute: python3 testes/testar_simulador.py"""
import importlib.util
from pathlib import Path

ARQUIVO = Path(__file__).resolve().parents[1] / "simulador_pnae.py"
spec = importlib.util.spec_from_file_location("simulador_pnae", ARQUIVO)
modulo = importlib.util.module_from_spec(spec)
spec.loader.exec_module(modulo)

assert round(modulo.calcular_repasse(60, 80, 50), 2) == 37660.00
assert modulo.classificar_porte(190) == "Pequena"
assert round(modulo.calcular_repasse(0, 0, 304), 2) == 34656.00
assert modulo.classificar_porte(304) == "Média"
custo, pct, diferenca, situacao = modulo.calcular_cobertura(304, 34656)
assert round(custo, 2) == 273600.00
assert round(pct, 2) == 12.67
assert round(diferenca, 2) == 238944.00
assert situacao == "complementar"
assert modulo.calcular_cobertura(1, 10000)[2:] == (0.0, "coberto")
assert modulo.calcular_cobertura(0, 0) == (0.0, 0.0, 0.0, "sem_matriculas")
print("OK: todos os testes passaram.")
