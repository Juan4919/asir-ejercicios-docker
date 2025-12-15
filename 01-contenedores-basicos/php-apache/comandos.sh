#!/bin/bash

echo "=== Ejercicio PHP con Apache ==="

# Parte 1: PHP básico
echo ""
echo "PARTE 1: Contenedor PHP básico"
echo "-------------------------------"

docker run -d \
  --name php-basico \
  -p 8081:80 \
  php:8-apache

echo "✓ Contenedor levantado en puerto 8081"
echo "Comandos ejecutados dentro del contenedor:"
echo "  docker exec php-basico bash -c \"echo '<?php phpinfo(); ?>' > /var/www/html/info.php\""

docker exec php-basico bash -c "echo '<?php phpinfo(); ?>' > /var/www/html/info.php"

echo ""
echo "Accede a: http://localhost:8081/info.php"
echo ""

# Parte 2: PHP con bind mount
echo "PARTE 2: PHP con bind mount"
echo "----------------------------"

# Crear carpeta de proyecto
mkdir -p proyecto-php
cd proyecto-php

# Crear archivos PHP
cat > index.php << 'EOF'
<?php
echo "<h1>Proyecto PHP Local</h1>";
echo "<p>PHP Version: " . phpversion() . "</p>";
echo "<p>Edita este archivo y refresca para ver cambios</p>";
?>
EOF

cat > saludar.php << 'EOF'
<?php
$nombre = $_GET['nombre'] ?? 'Invitado';
echo "<h2>Hola, $nombre!</h2>";
echo "<p><a href='index.php'>Volver</a></p>";
?>
EOF

# Levantar con bind mount
docker run -d \
  --name php-proyecto \
  -p 8082:80 \
  -v "$(pwd):/var/www/html" \
  php:8-apache

echo "✓ Contenedor con bind mount en puerto 8082"
echo ""
echo "Accede a: http://localhost:8082"
echo "Edita los archivos en: $(pwd)"
echo ""
echo "Comandos útiles:"
echo "  docker logs php-proyecto"
echo "  docker stop php-proyecto"
echo "  docker rm php-proyecto"
