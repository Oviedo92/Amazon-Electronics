============================================================
🟤 CAPA BRONZE - DATOS CRUDOS
============================================================

OBJETIVO:
Almacenar los datos originales SIN transformación.

IMPORTANTE:
- NO limpiar datos
- NO transformar columnas
- NO eliminar nulos
- SOLO INGESTA

------------------------------------------------------------
📥 ORIGEN
------------------------------------------------------------

Archivos JSON crudos:

- ../data/raw/Electronics/Electronics.json      → REVIEWS
- ../data/raw/Metadata/meta_Electronics.json    → METADATA

------------------------------------------------------------
🧱 CREACIÓN DE ESQUEMA
------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS bronze;

------------------------------------------------------------
📊 CREACIÓN DE VISTAS (RECOMENDADO EN DUCKDB)
------------------------------------------------------------

DuckDB permite leer JSON directamente:

-- Reviews
CREATE VIEW bronze.reviews_raw AS
SELECT *
FROM read_ndjson('../data/raw/Electronics/Electronics.json');

-- Metadata
CREATE VIEW bronze.metadata_raw AS
SELECT *
FROM read_ndjson('../data/raw/Metadata/meta_Electronics.json');

------------------------------------------------------------
📊 VALIDACIONES
------------------------------------------------------------

-- Ver estructura
DESCRIBE bronze.reviews_raw;

-- Contar registros
SELECT COUNT(*) FROM bronze.reviews_raw;
SELECT COUNT(*) FROM bronze.metadata_raw;


------------------------------------------------------------
📌 NOTAS IMPORTANTES
------------------------------------------------------------

✔ Aquí NO existen tablas físicas
✔ Solo vistas externas
✔ Es la copia fiel del origen

✔ Sirve para:
   - auditoría
   - trazabilidad
   - debugging

------------------------------------------------------------
🚫 NO HACER
------------------------------------------------------------

- NO crear dimensiones
- NO aplicar joins
- NO aplicar filtros complejos
- NO usar datos procesados

