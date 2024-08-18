# Utiliza una imagen base de Python
FROM python:3.9-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de requerimientos y la aplicación en el contenedor
COPY requirements.txt ./
COPY app.py ./
COPY remove_background.py ./

# Descargar los directorios necesarios desde Docker Hub
RUN docker pull christopherpallo2000/grupo6anuncios:latest

# Extraer archivos desde la imagen
COPY --from=christopherpallo2000/grupo6anuncios:latest /app/ad-gen ./ad-gen
COPY --from=christopherpallo2000/grupo6anuncios:latest /app/fonts ./fonts
COPY --from=christopherpallo2000/grupo6anuncios:latest /app/textures ./textures

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto que usará Streamlit
EXPOSE 8501

# Comando para ejecutar la aplicación cuando el contenedor se inicie
CMD ["streamlit", "run", "app.py"]
