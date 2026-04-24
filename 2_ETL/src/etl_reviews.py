"""
============================================================
📦 ETL - DATASET REVIEWS (RESEÑAS)
============================================================

OBJETIVO:
Procesar el dataset Electronics.json (reviews) aplicando
transformaciones y manejo por chunks para evitar consumo
excesivo de memoria.

------------------------------------------------------------
📊 DATASET
------------------------------------------------------------

- Nombre: Electronics.json
- Registros: ~20,994,353 reseñas
- Granularidad: 1 fila = 1 reseña

------------------------------------------------------------
⚠️ PROBLEMA
------------------------------------------------------------

Dataset masivo (20M+ filas)

NO se puede cargar completo en RAM

------------------------------------------------------------
⚙️ ESTRATEGIA
------------------------------------------------------------

✔ Procesamiento por CHUNKS (lotes)
✔ Tamaño recomendado: 500,000 filas

------------------------------------------------------------
📈 PROCESO ETL
------------------------------------------------------------

Por cada chunk:

1. Leer lote de datos
2. Limpiar columnas:
   - asin
   - reviewerID
   - overall
   - reviewTime
   - vote
   - verified
3. Transformaciones:
   - convertir fechas a formato estándar
   - generar DateKey (YYYYMMDD)
   - limpiar nulos
4. (Opcional) aplicar ML:
   - Score_Polaridad
   - Categoria_Texto
5. Guardar chunk en Parquet

------------------------------------------------------------
💾 SALIDA
------------------------------------------------------------

../data/processed/reviews/reviews_chunk_0.parquet
../data/processed/reviews/reviews_chunk_1.parquet
../data/processed/reviews/reviews_chunk_2.parquet
...
------------------------------------------------------------
🧠 UNIFICACIÓN FINAL
------------------------------------------------------------

Los chunks pueden combinarse posteriormente en:

reviews_limpio.parquet

------------------------------------------------------------
🎯 USO FINAL
------------------------------------------------------------

Este dataset alimenta:

✔ Fact_Resenas
✔ Dim_Usuario
✔ Dim_Tiempo
✔ Dim_Sentimiento (ML)

------------------------------------------------------------
⚠️ REGLA CRÍTICA
------------------------------------------------------------

SIEMPRE usar chunks en este script
"""