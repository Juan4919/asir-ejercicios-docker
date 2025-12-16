# WordPress con MySQL y volúmenes persistentes

Instalación de WordPress con base de datos MySQL usando volúmenes Docker para persistencia de datos.

## Qué hace

- Crea una red Docker para conectar los contenedores
- Levanta MySQL 8.0 con volumen para la base de datos
- Levanta WordPress con volumen para los archivos
- Los datos persisten aunque elimines los contenedores

## Cómo usar
```bash
chmod +x comandos.sh
./comandos.sh
```

Acceder a: http://localhost:8080

## Estructura
```
wordpress-net (red)
├── wordpress-db (MySQL)
│   └── wordpress-db-data (volumen)
└── wordpress-app (WordPress)
    └── wordpress-files (volumen)
```

## Probar persistencia
```bash
# 1. Instala WordPress en http://localhost:8080

# 2. Elimina los contenedores
docker stop wordpress-app wordpress-db
docker rm wordpress-app wordpress-db

# 3. Vuelve a levantar
./comandos.sh

# 4. Al acceder de nuevo los datos siguen ahí
```

## Comandos útiles
```bash
# Ver volúmenes
docker volume ls

# Ver detalles de un volumen
docker volume inspect wordpress-db-data

# Eliminar volúmenes
docker volume rm wordpress-db-data wordpress-files

# Ver logs
docker logs wordpress-app
docker logs wordpress-db
```
