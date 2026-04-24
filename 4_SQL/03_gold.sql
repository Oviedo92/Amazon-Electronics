============================================================
🟡 CAPA GOLD - MODELO DIMENSIONAL (KIMBALL)
============================================================

OBJETIVO:
Construir modelo estrella listo para BI.

------------------------------------------------------------
🧱 CREACIÓN DE ESQUEMA
------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS gold;

------------------------------------------------------------
⭐ DIMENSIONES
------------------------------------------------------------

-- Dim Producto
CREATE TABLE gold.dim_producto AS
SELECT
    id_producto,
    marca,
    title,
    category,
    price
FROM silver.producto;

-- Dim Usuario
CREATE TABLE gold.dim_usuario AS
SELECT
    id_usuario
FROM silver.usuario;

-- Dim Tiempo
CREATE TABLE gold.dim_tiempo AS
SELECT
    DateKey,
    fecha,
    anio,
    mes,
    dia,
    hora,
    minuto,
    segundo
FROM silver.tiempo;

-- Dim Sentimiento
CREATE TABLE gold.dim_sentimiento AS
SELECT
    ROW_NUMBER() OVER () AS SentimentKey,
    Categoria_Texto,
    Alerta_Incongruencia
FROM silver.sentimiento;

------------------------------------------------------------
🔥 TABLA DE HECHOS
------------------------------------------------------------

GRANULARIDAD:
👉 1 fila = 1 reseña

CREATE TABLE gold.fact_resenas AS
SELECT
    r.id_producto,
    r.id_usuario,
    r.DateKey,
    s.SentimentKey,
    r.rating,
    r.vote,
    r.verified
FROM silver.resena r
LEFT JOIN gold.dim_sentimiento s
ON r.rating IS NOT NULL;

------------------------------------------------------------
📌 NOTAS
------------------------------------------------------------

✔ Aquí SÍ hay modelo estrella
✔ Aquí SÍ hay joins
✔ Aquí SÍ hay granularidad definida

✔ Esto es lo que consume:
- Power BI
- API

============================================================