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


# 1. Clonar repo
 git clone <https://github.com/Oviedo92/Amazon-Electronics>
 cd Amazon-Electronics

# 2. Crear entorno
 python3 -m venv venv
 source venv/bin/activate

# 3. Instalar dependencias
 pip install -r requirements.txt

# 4. Ejecutar análisis exploratorio
 jupyter lab

# 5. Ejecutar pipeline ETL
 python src/etl_pipeline.py

## ⚠️ NOTA IMPORTANTE

*Antes de ejecutar cualquier script, leer los archivos `INSTRUCCIONES.txt` ubicados en cada carpeta.*

Estos contienen:
- Configuración del entorno
- Orden correcto de ejecución
- Explicación del flujo ETL
- Manejo de memoria con chunks

# Estructura proyecto
	Amazon-Electronics/
│
├── README.md
├── requirements.txt
├── .gitignore
├── informacion_datasets.txt
│
├── 1_Analisis_EDA/
│   ├── notebooks/
│   │   ├── analisis_metadata.ipynb
│   │   ├── analisis_reviews.ipynb
│   │   └── instrucciones.txt
│
├── 2_ETL/
│   ├── etl_metadata.py
│   ├── etl_reviews.py
│   ├── instrucciones.txt
│
├── 3_ML/
│   ├── ml_sentiment.py
│   ├── INSTRUCCIONES_ML.txt
│   ├── DESCRIPCION_ML.txt
│
├── 4_SQL/
│   ├── 01_bronze.sql
│   ├── 02_silver.sql
│   ├── 03_gold.sql
│   ├── 04_kpis.sql
│
├── data/
│   ├── raw/          (NO se sube)
│   ├── processed/    (NO se sube)
│
└── docs/
    ├── arquitectura_medallion.txt
    ├── modelo_kimball.txt

	

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

