import polars as pl
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import os
import time

# ============================================================
# CONFIGURACIÓN
# ============================================================

INPUT_PATH = "../data/raw/Electronics/Electronics.json"

# Carpeta de salida (se crea automáticamente)
OUTPUT_DIR = "../data/processed/ml"

# Tamaño del chunk (ajustable)
CHUNK_SIZE = 200_000

# Crear carpeta si no existe
os.makedirs(OUTPUT_DIR, exist_ok=True)

print("="*60)
print("🤖 INICIANDO MACHINE LEARNING - ANÁLISIS DE SENTIMIENTO")
print("="*60)

print(f"📂 Archivo de entrada: {INPUT_PATH}")
print(f"📁 Carpeta de salida: {OUTPUT_DIR}")
print(f"📦 Tamaño de chunk: {CHUNK_SIZE}")
print("-"*60)

start_time = time.time()

# ============================================================
# MODELO DE SENTIMIENTO (VADER)
# ============================================================

print("🧠 Cargando modelo VADER...")

analyzer = SentimentIntensityAnalyzer()

print("✅ Modelo cargado correctamente")

# ============================================================
# FUNCIÓN DE POLARIDAD
# ============================================================

def calcular_polaridad(texto):
    """
    Calcula el score de sentimiento usando VADER.
    Retorna valor entre -1 (negativo) y 1 (positivo)
    """
    if texto is None:
        return 0.0
    return analyzer.polarity_scores(texto)['compound']

# ============================================================
# PROCESAMIENTO POR CHUNKS
# ============================================================

print("\n🚀 Iniciando procesamiento por chunks...")

chunk_id = 0
total_filas = 0

# Lectura eficiente tipo streaming
for df in pl.read_ndjson(INPUT_PATH, infer_schema_length=1000).iter_slices(n_rows=CHUNK_SIZE):

    print(f"\n📦 Procesando chunk {chunk_id}...")

    filas_chunk = df.height
    total_filas += filas_chunk

    print(f"  📊 Filas en este chunk: {filas_chunk}")

    # --------------------------------------------------------
    # SELECCIÓN DE COLUMNAS NECESARIAS
    # --------------------------------------------------------
    df = df.select([
        "asin",
        "reviewerID",
        "reviewText",
        "summary",
        "overall"
    ])

    # --------------------------------------------------------
    # UNIFICAR TEXTO (summary + reviewText)
    # --------------------------------------------------------
    df = df.with_columns(
        pl.concat_str([
            pl.col("summary").fill_null(""),
            pl.col("reviewText").fill_null("")
        ], separator=" ").alias("texto_completo")
    )

    # --------------------------------------------------------
    # APLICAR MODELO DE SENTIMIENTO
    # --------------------------------------------------------
    print("  🧠 Analizando sentimiento...")

    df = df.with_columns(
        pl.col("texto_completo")
        .map_elements(calcular_polaridad, return_dtype=pl.Float64)
        .alias("Score_Polaridad")
    )

    # --------------------------------------------------------
    # CLASIFICACIÓN DE SENTIMIENTO
    # --------------------------------------------------------
    df = df.with_columns(
        pl.when(pl.col("Score_Polaridad") > 0.05).then(pl.lit("Positivo"))
        .when(pl.col("Score_Polaridad") < -0.05).then(pl.lit("Negativo"))
        .otherwise(pl.lit("Neutral"))
        .alias("Sentimiento")
    )

    # --------------------------------------------------------
    # SELECCIÓN FINAL (modelo analítico)
    # --------------------------------------------------------
    df_final = df.select([
        "asin",
        "reviewerID",
        "overall",
        "Score_Polaridad",
        "Sentimiento"
    ])

    # --------------------------------------------------------
    # GUARDADO POR CHUNK (CLAVE PARA NO ROMPER RAM)
    # --------------------------------------------------------
    output_file = f"{OUTPUT_DIR}/sentiment_chunk_{chunk_id}.parquet"
    df_final.write_parquet(output_file)

    print(f"  💾 Guardado: {output_file}")
    print(f"  ✅ Chunk {chunk_id} completado")

    chunk_id += 1

# ============================================================
# FINAL
# ============================================================

end_time = time.time()

print("\n" + "="*60)
print("🎉 MACHINE LEARNING FINALIZADO")
print("="*60)

print(f"📦 Total chunks procesados: {chunk_id}")
print(f"📊 Total filas procesadas: {total_filas}")
print(f"📁 Archivos generados en: {OUTPUT_DIR}")
print(f"⏱ Tiempo total: {round(end_time - start_time, 2)} segundos")

print("="*60)