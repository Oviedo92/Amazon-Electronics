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
cd <Amazon-Electronics>

# 2. Crear entorno
python3 -m venv venv
source venv/bin/activate

# 3. Instalar dependencias
pip install -r requirements.txt

# 4. Ejecutar análisis exploratorio
jupyter lab

# 5. Ejecutar pipeline ETL
python src/etl_pipeline.py


*SUGERENCIAS*
Registrar el entorno (CRÍTICO)
Bash
# python -m ipykernel install --user --name=venv --display-name "Python (venv)"
Sin esto, VS Code no detecta el kernel.

Ejecutar JupyterLab
Bash
# jupyter lab

O si falla:
Bash
# python -m jupyter lab

Problemas comunes (rápido)
❌ No aparece kernel
python -m ipykernel install --user --name=venv
❌ Jupyter no abre
python -m jupyter lab

❌ Error leyendo JSON
Asegúrate:
lines=True

