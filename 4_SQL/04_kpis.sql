============================================================
📊 CAPA KPI - MÉTRICAS ANALÍTICAS (NIVEL NEGOCIO)
============================================================

OBJETIVO:
Generar métricas avanzadas listas para:
- Power BI
- API (.NET)
- Toma de decisiones

============================================================
📈 KPI 1: RATING PROMEDIO POR MARCA
============================================================

CREATE VIEW gold.kpi_rating_marca AS
SELECT
    p.marca,
    COUNT(*) AS total_resenas,
    ROUND(AVG(f.rating), 2) AS rating_promedio
FROM gold.fact_resenas f
JOIN gold.dim_producto p ON f.id_producto = p.id_producto
GROUP BY p.marca
ORDER BY rating_promedio DESC;

============================================================
📈 KPI 2: TOP PRODUCTOS (RELEVANCIA REAL)
============================================================

CREATE VIEW gold.kpi_top_productos AS
SELECT
    p.title,
    p.marca,
    COUNT(*) AS total_resenas,
    ROUND(AVG(f.rating), 2) AS rating_promedio,
    SUM(f.vote) AS votos_utiles
FROM gold.fact_resenas f
JOIN gold.dim_producto p ON f.id_producto = p.id_producto
GROUP BY p.title, p.marca
HAVING COUNT(*) > 50
ORDER BY rating_promedio DESC, votos_utiles DESC
LIMIT 20;

============================================================
📈 KPI 3: DISTRIBUCIÓN DE SENTIMIENTO
============================================================

CREATE VIEW gold.kpi_sentimiento_global AS
SELECT
    s.Categoria_Texto,
    COUNT(*) AS total_resenas,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS porcentaje
FROM gold.fact_resenas f
JOIN gold.dim_sentimiento s ON f.SentimentKey = s.SentimentKey
GROUP BY s.Categoria_Texto;

============================================================
📈 KPI 4: INCONGRUENCIA (CALIDAD DE DATOS)
============================================================

CREATE VIEW gold.kpi_incongruencias AS
SELECT
    s.Alerta_Incongruencia,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS porcentaje
FROM gold.fact_resenas f
JOIN gold.dim_sentimiento s ON f.SentimentKey = s.SentimentKey
GROUP BY s.Alerta_Incongruencia
ORDER BY total DESC;

============================================================
📈 KPI 5: EVOLUCIÓN TEMPORAL (TREND)
============================================================

CREATE VIEW gold.kpi_evolucion_rating AS
SELECT
    t.anio,
    t.mes,
    ROUND(AVG(f.rating), 2) AS rating_promedio,
    COUNT(*) AS volumen
FROM gold.fact_resenas f
JOIN gold.dim_tiempo t ON f.DateKey = t.DateKey
GROUP BY t.anio, t.mes
ORDER BY t.anio, t.mes;

============================================================
📈 KPI 6: SENTIMIENTO POR MARCA (CLAVE NEGOCIO)
============================================================

CREATE VIEW gold.kpi_sentimiento_marca AS
SELECT
    p.marca,
    s.Categoria_Texto,
    COUNT(*) AS total
FROM gold.fact_resenas f
JOIN gold.dim_producto p ON f.id_producto = p.id_producto
JOIN gold.dim_sentimiento s ON f.SentimentKey = s.SentimentKey
GROUP BY p.marca, s.Categoria_Texto;

============================================================
📈 KPI 7: PRODUCTOS PROBLEMÁTICOS
============================================================

CREATE VIEW gold.kpi_productos_riesgo AS
SELECT
    p.title,
    p.marca,
    ROUND(AVG(f.rating), 2) AS rating_promedio,
    SUM(CASE WHEN s.Categoria_Texto = 'Negativo' THEN 1 ELSE 0 END) AS negativos,
    COUNT(*) AS total
FROM gold.fact_resenas f
JOIN gold.dim_producto p ON f.id_producto = p.id_producto
JOIN gold.dim_sentimiento s ON f.SentimentKey = s.SentimentKey
GROUP BY p.title, p.marca
HAVING COUNT(*) > 30
ORDER BY negativos DESC, rating_promedio ASC
LIMIT 20;

============================================================
📈 KPI 8: USUARIOS MÁS ACTIVOS
============================================================

CREATE VIEW gold.kpi_usuarios_activos AS
SELECT
    u.id_usuario,
    COUNT(*) AS total_resenas,
    ROUND(AVG(f.rating), 2) AS rating_promedio
FROM gold.fact_resenas f
JOIN gold.dim_usuario u ON f.id_usuario = u.id_usuario
GROUP BY u.id_usuario
ORDER BY total_resenas DESC
LIMIT 50;

============================================================
📈 KPI 9: VERIFICACIÓN DE COMPRA
============================================================

CREATE VIEW gold.kpi_verificados AS
SELECT
    verified,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS porcentaje
FROM gold.fact_resenas
GROUP BY verified;

============================================================
📈 KPI 10: IMPACTO DE VOTOS EN RATING
============================================================

CREATE VIEW gold.kpi_votos_vs_rating AS
SELECT
    ROUND(AVG(vote), 2) AS votos_promedio,
    ROUND(AVG(rating), 2) AS rating_promedio
FROM gold.fact_resenas;

============================================================