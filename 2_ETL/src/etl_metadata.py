"""
============================================================
📦 ETL - DATASET METADATA (PRODUCTOS)
============================================================

OBJETIVO:
Procesar el dataset meta_Electronics.json para generar una
tabla limpia de productos en formato Parquet.

------------------------------------------------------------
📊 DATASET
------------------------------------------------------------

- Nombre: meta_Electronics.json
- Registros: ~786,868 productos
- Granularidad: 1 fila = 1 producto

------------------------------------------------------------
⚙️ PROCESO ETL
------------------------------------------------------------

1. Lectura del JSON (modo lines=True)
2. Selección de columnas relevantes:
   - asin
   - title
   - brand
   - category
   - price
3. Eliminación de columnas pesadas:
   - feature
   - imageURL
   - also_buy / also_view
4. Limpieza de datos:
   - eliminar nulos en asin
   - estandarizar strings
5. Exportación a formato Parquet

------------------------------------------------------------
💾 SALIDA
------------------------------------------------------------

../data/processed/metadata/metadata_limpio.parquet

------------------------------------------------------------
🧠 NOTA TÉCNICA
------------------------------------------------------------

- Este dataset NO requiere chunks obligatoriamente
- Se puede cargar completo en memoria
- Aun así, se puede usar chunks si se desea consistencia

------------------------------------------------------------
🎯 USO FINAL
------------------------------------------------------------

Este dataset se usará para construir:

✔ Dim_Producto (modelo dimensional)
"""