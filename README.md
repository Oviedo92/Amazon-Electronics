# Amazon-Electronics
Estos conjuntos de datos contienen atributos sobre los productos vendidos en ModCloth y Amazon que pueden generar sesgos en las recomendaciones (en particular, atributos sobre cómo se comercializan los productos). Los datos también incluyen interacciones entre usuarios y artículos para la recomendación.

	ModCloth	Amazon Electronics
	Reseñas:	99.893	1.292.954
	Elementos:	1.020	9.560
	Usuarios:	44.783	1.157.633


	Metadatos
	calificaciones
	imágenes del producto
	identidades de usuario
	tamaños de artículos, usuarios


# 📊 Amazon Electronics Data Engineering Project

Proyecto de Ingeniería de Datos basado en el dataset público de Amazon Electronics. https://cseweb.ucsd.edu/~jmcauley/datasets/amazon_v2/

Incluye:
- Análisis Exploratorio (EDA)
- ETL optimizado con procesamiento por chunks
- Machine Learning (Análisis de Sentimiento)
- Arquitectura Medallion (Bronze, Silver, Gold)
- Modelo Dimensional (Kimball)
- KPIs listos para visualización

---


## ⚠️ NOTA IMPORTANTE

*Antes de ejecutar cualquier script, leer los archivos `INSTRUCCIONES.txt` ubicados en cada carpeta.*

Estos contienen:
- Configuración del entorno
- Orden correcto de ejecución
- Explicación del flujo ETL
- Manejo de memoria con chunks


## 📁 Estructura del Proyecto

Amazon-Electronics/
│
├── README.md
├── requirements.txt
├── .gitignore
├── informacion_datasets.txt
│
├── 1_Analisis_EDA/
│ ├── notebooks/
│ │ ├── analisis_metadata.ipynb
│ │ ├── analisis_reviews.ipynb
│ │ └── instrucciones.txt
│
├── 2_ETL/
│ ├── etl_metadata.py
│ ├── etl_reviews.py
│ └── instrucciones.txt
│
├── 3_ML/
│ ├── ml_sentiment.py
│ ├── INSTRUCCIONES_ML.txt
│ └── DESCRIPCION_ML.txt
│
├── 4_SQL/
│ ├── 01_bronze.sql
│ ├── 02_silver.sql
│ ├── 03_gold.sql
│ └── 04_kpis.sql
│
├── data/
│ ├── raw/ (NO incluido en el repo)
│ └── processed/ (NO incluido en el repo)
│
└── docs/
├── arquitectura_medallion.txt
└── modelo_kimball.txt
	

---

## ⚙️ Tecnologías utilizadas

- Python (Polars, Pandas) (chunks)
- DuckDB (SQL)
- DBeaver (SQL)
- JupyterLab
- VADER Sentiment (NLP)
- .Parquet (formato columnar)

---

EDA (Jupyter)
↓
ETL (Python + Chunks + Parquet)
↓
Machine Learning (Sentimiento)
↓
DuckDB
├── Bronze (datos crudos)
├── Silver (datos limpios)
└── Gold (modelo estrella + KPIs)
↓
Power BI / API


## 🔄 Flujo del Proyecto

# 1. Clonar repo
 git clone <https://github.com/Oviedo92/Amazon-Electronics>
 cd Amazon-Electronics

 # 2. Crear entorno
 python3 -m venv venv
 source venv/bin/activate

Activar:

Windows

venv\Scripts\activate

Linux / Mac

source venv/bin/activate

# 3. Instalar dependencias
 	pip install -r requirements.txt


# 4. Ejecutar EDA
	jupyter lab

# Abrir:
	analisis_metadata.ipynb
	analisis_reviews.ipynb

# 5. Ejecutar ETL
	python 2_ETL/etl_metadata.py
	python 2_ETL/etl_reviews.py

# ✔ Genera archivos .parquet en data/processed/

# 6. Ejecutar Machine Learning
	python 3_ML/ml_sentiment.py

# ✔ Genera análisis de sentimiento en parquet

# 7. Ejecutar SQL (DuckDB)

# Ejecutar en orden:
	4_SQL/01_bronze.sql
	4_SQL/02_silver.sql
	4_SQL/03_gold.sql
	4_SQL/04_kpis.sql (Views)

# 🧠 Arquitectura
## 🔹 Medallion Architecture
	Bronze: Datos crudos (JSON)
	Silver: Datos limpios (Parquet)
	Gold: Modelo analítico (Dimensional + KPIs)

# 🔹 Modelo Kimball (Gold)
Dimensiones:
	Producto
	Tiempo
	Sentimiento
	Usuario
Tabla de hechos:
	Fact_Resenas
	
# ⚠️ Nota importante
	Este repositorio NO incluye datasets debido a su tamaño (10GB+).
	Debes descargarlos manualmente y ubicarlos en:	data/raw/

# 🎯 Resultados
	Dataset limpio optimizado en Parquet
	Modelo estrella listo para análisis
	KPIs para visualización en Power BI
	Pipeline completo de ingeniería de datos
	
# 📌 Autor

Oviedo Emmanuel - Ingeniería de Sistemas


# *SUGERENCIAS*
 
# Registrar el entorno (CRÍTICO) (Bash)

 python -m ipykernel install --user --name=venv --display-name "Python (venv)"

# NOTA: Sin esto, VS Code no detecta el kernel.

# Ejecutar JupyterLab (Bash)

 	jupyter lab

# O si falla (Bash) :
 python -m jupyter lab

# Problemas comunes (rápido)
# ❌ No aparece kernel (Bash)
 python -m ipykernel install --user --name=venv
# ❌ Jupyter no abre (Bash)
 python -m jupyter lab

# ❌ Error leyendo JSON 
Asegúrate:
 lines=True

