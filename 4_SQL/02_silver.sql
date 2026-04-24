============================================================
⚪ CAPA SILVER - DATOS LIMPIOS Y ESTRUCTURADOS
============================================================

OBJETIVO:
Transformar datos crudos en entidades limpias y utilizables.

ORIGEN:
Parquet generado por ETL (Python)

------------------------------------------------------------
📥 INPUT
------------------------------------------------------------

- ../data/processed/reviews/reviews_limpio.parquet
- ../data/processed/metadata/metadata_limpio.parquet

------------------------------------------------------------
🧱 CREACIÓN DE ESQUEMA
------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS silver;

------------------------------------------------------------
📊 VISTAS BASE (LECTURA PARQUET)
------------------------------------------------------------

CREATE VIEW silver.reviews_limpio AS
SELECT * FROM read_parquet('../data/processed/reviews/*.parquet');

CREATE VIEW silver.metadata_limpio AS
SELECT * FROM read_parquet('../data/processed/metadata/*.parquet');

------------------------------------------------------------
🏗 CREACIÓN DE TABLAS (MODELO LÓGICO)
------------------------------------------------------------

Estas son TABLAS FÍSICAS ya limpias:

-- Producto
CREATE TABLE silver.producto AS
SELECT DISTINCT
    asin AS id_producto,
    brand AS marca,
    title,
    category,
    price
FROM silver.metadata_limpio
WHERE asin IS NOT NULL;

-- Usuario
CREATE TABLE silver.usuario AS
SELECT DISTINCT
    reviewerID AS id_usuario
FROM silver.reviews_limpio;
WHERE reviewerID IS NOT NULL;

-- Tiempo
CREATE TABLE silver.tiempo AS
SELECT DISTINCT
    DateKey,
    reviewDate,
    YEAR(reviewDate) AS anio,
    MONTH(reviewDate) AS mes
    DAY(reviewDate) AS dia
    HOUR(reviewDate) AS hora
    MINUTE(reviewDate) AS minuto
    SECOND(reviewDate) AS segundo
FROM silver.reviews_limpio;
WHERE DateKey IS NOT NULL;


-- Reseñas (base)
CREATE TABLE silver.resena AS
SELECT
    asin AS id_producto,
    reviewerID AS id_usuario,
    DateKey,
    overall AS rating,
    vote,
    verified
    Score_Polaridad,
    Categoria_Texto
FROM silver.reviews_limpio;
WHERE asin IS NOT NULL;


-- Sentimiento (desde ML)
CREATE TABLE silver.sentimiento AS
SELECT DISTINCT
    Categoria_Texto,
    Alerta_Incongruencia
FROM silver.reviews_limpio;

------------------------------------------------------------
📌 NOTAS
------------------------------------------------------------

✔ Aquí ya existen ENTIDADES
✔ Datos limpios y normalizados
✔ Aún NO hay modelo estrella

✔ PK y FK:
- Pueden declararse conceptualmente
- NO obligatorio en DuckDB

------------------------------------------------------------
🚫 NO HACER
------------------------------------------------------------

- NO métricas agregadas
- NO KPIs
- NO joins complejos entre muchas tablas

