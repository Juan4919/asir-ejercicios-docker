#!/bin/bash

echo "=== WordPress con MySQL y volúmenes persistentes ==="
echo ""

# Crear red
echo "Creando red Docker..."
docker network create wordpress-net 2>/dev/null || echo "Red ya existe"

# Crear volúmenes
echo "Creando volúmenes..."
docker volume create wordpress-db-data
docker volume create wordpress-files

# Limpiar contenedores anteriores
echo "Limpiando contenedores anteriores..."
docker stop wordpress-app wordpress-db 2>/dev/null
docker rm wordpress-app wordpress-db 2>/dev/null

# Levantar MySQL
echo "Levantando MySQL..."
docker run -d \
  --name wordpress-db \
  --network wordpress-net \
  -e MYSQL_ROOT_PASSWORD=abc123 \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wpuser \
  -e MYSQL_PASSWORD=abc123 \
  -v wordpress-db-data:/var/lib/mysql \
  mysql:8.0

echo "Esperando a que MySQL esté listo..."
sleep 20

# Levantar WordPress
echo "Levantando WordPress..."
docker run -d \
  --name wordpress-app \
  --network wordpress-net \
  -p 8080:80 \
  -e WORDPRESS_DB_HOST=wordpress-db:3306 \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=abc123 \
  -e WORDPRESS_DB_NAME=wordpress \
  -v wordpress-files:/var/www/html \
  wordpress:latest

echo ""
echo "============================================"
echo "WordPress listo"
echo "============================================"
echo ""
echo "Accede a: http://localhost:8080"
echo ""
echo "Comandos útiles:"
echo "  docker ps                    # Ver contenedores"
echo "  docker logs wordpress-app    # Ver logs WordPress"
echo "  docker logs wordpress-db     # Ver logs MySQL"
echo "  docker volume ls             # Ver volúmenes"
echo ""
echo "Para probar persistencia:"
echo "  docker stop wordpress-app wordpress-db"
echo "  docker rm wordpress-app wordpress-db"
echo "  ./comandos.sh  # Volver a levantar y los datos persisten"
