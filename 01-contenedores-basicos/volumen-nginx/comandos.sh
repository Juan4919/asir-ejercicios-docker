#!/bin/bash

# Crear carpeta HTML
mkdir -p html
cp index.html html/

# Levantar nginx
docker run -d --name mi-nginx -p 8080:80 -v "$(pwd)/html:/usr/share/nginx/html:ro" nginx:latest

echo "Listo. Abre http://localhost:8080"
