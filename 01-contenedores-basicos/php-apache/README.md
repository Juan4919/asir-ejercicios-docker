# PHP con Apache

Ejercicio para practicar PHP en contenedores Docker.

## Parte 1: PHP básico

Levantar un contenedor con PHP y crear archivos dentro del contenedor.
```bash
# Levantar contenedor
docker run -d --name mi-php -p 8080:80 php:8-apache

# Entrar al contenedor
docker exec -it mi-php bash

# Crear archivo PHP
echo '<?php phpinfo(); ?>' > /var/www/html/info.php

# Salir
exit
```

Acceder a: http://localhost:8080/info.php

## Parte 2: PHP con bind mount

Montar una carpeta local en el contenedor para editar código en tiempo real.
```bash
# Crear carpeta
mkdir mi-proyecto
cd mi-proyecto

# Crear archivo PHP
echo '<?php echo "Hola PHP"; ?>' > index.php

# Levantar con bind mount
docker run -d \
  --name mi-php \
  -p 8080:80 \
  -v "$(pwd):/var/www/html" \
  php:8-apache
```

Ahora editas los archivos en `mi-proyecto/` y los cambios se ven al refrescar el navegador.

## Comandos útiles
```bash
docker exec -it mi-php bash    # Entrar al contenedor
docker logs mi-php             # Ver logs
docker stop mi-php             # Parar
docker rm mi-php               # Eliminar
```
