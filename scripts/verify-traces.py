"""
Verificador de "🎬 La película en vivo".

Corre en Python REAL el codigo de cada demo de content/peliculas.json y compara
la salida del programa con la concatenacion de todos los "out" de sus pasos.

Si no coinciden, la pelicula miente: hay que corregir steps_json, nunca el
codigo. Ninguna pelicula entra al seed sin pasar esta prueba.

Uso:
    python scripts/verify-traces.py
"""

import json
import subprocess
import sys
from pathlib import Path

# La consola de Windows llega en cp1252 y los emojis del reporte la revientan
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

RAIZ = Path(__file__).resolve().parent.parent
FUENTE = RAIZ / "content" / "peliculas.json"


def correr(codigo, entrada):
    """
    Ejecuta un programa Python y devuelve lo que imprime.

    Parametros:
        codigo (str): el programa
        entrada (str): lo que el usuario escribe (para los input())

    Retorna:
        str: la salida real, tal cual
    """
    proceso = subprocess.run(
        [sys.executable, "-c", codigo],
        input=entrada,
        capture_output=True,
        text=True,
        encoding="utf-8",
        timeout=10,
    )

    if proceso.returncode != 0:
        raise RuntimeError(proceso.stderr.strip())

    return proceso.stdout


def visible(texto):
    """Muestra los saltos de linea para poder comparar a ojo."""
    return texto.replace("\n", "\\n")


# Inicio
datos = json.loads(FUENTE.read_text(encoding="utf-8"))
peliculas = datos["peliculas"]

fallos = 0

for peli in peliculas:
    etiqueta = f"cap {peli['chapter']} · {peli['title']}"

    esperado = "".join(paso.get("out", "") for paso in peli["steps"])

    try:
        real = correr(peli["code"], peli.get("verify_stdin", ""))
    except Exception as e:  # noqa: BLE001 - queremos ver cualquier fallo
        print(f"❌ {etiqueta}")
        print(f"   el programa no corrio: {e}")
        fallos += 1
        continue

    if real != esperado:
        print(f"❌ {etiqueta}")
        print(f"   real     : {visible(real)}")
        print(f"   pelicula : {visible(esperado)}")
        fallos += 1
        continue

    # Cada paso tiene que traer una celda por columna, o la tabla se desarma
    columnas = len(peli["columns"])
    for i, paso in enumerate(peli["steps"], start=1):
        if len(paso["cells"]) != columnas:
            print(f"❌ {etiqueta}")
            print(
                f"   paso {i}: {len(paso['cells'])} celdas "
                f"y la tabla tiene {columnas} columnas"
            )
            fallos += 1
            break
    else:
        print(f"✅ {etiqueta}  ({len(peli['steps'])} pasos)")

print()
if fallos:
    print(f"{fallos} de {len(peliculas)} peliculas NO cuadran con Python")
    sys.exit(1)

print(f"{len(peliculas)}/{len(peliculas)} peliculas verificadas contra Python real")
# Fin
