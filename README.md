Library BiblioLearn

Descripción
La aplicación BiblioLearn es una plataforma para gestionar usuarios y libros. Permite registrar usuarios, añadir, actualizar, obtener y borrar libros. La aplicación está dividida en dos partes principales:

Backend: Desarrollado en Node.js con Express para manejar las solicitudes HTTP y conectarse a una base de datos SQL.

Frontend: Una aplicación Flutter que permite a los usuarios interactuar con la API del backend.

Funcionalidades:
Backend
Registro de usuarios: Permite registrar nuevos usuarios en el sistema.
Gestión de libros:
Insertar un nuevo libro.
Obtener todos los libros.
Actualizar detalles de un libro.
Borrar un libro.

Frontend
Registro de usuarios: Formulario para registrar nuevos usuarios.
Gestión de libros:
Añadir un libro.
Obtener y mostrar todos los libros.

Tecnologías utilizadas
Backend
Node.js: Entorno de ejecución para JavaScript en el servidor.
Express: Framework para Node.js que facilita la creación de APIs.
mssql: Paquete para conectarse y ejecutar consultas en bases de datos SQL Server.
cors: Middleware para permitir solicitudes de diferentes orígenes.
body-parser: Middleware para analizar cuerpos de solicitudes HTTP.

Frontend
Flutter: Framework para construir aplicaciones nativas de manera rápida.
http: Paquete para hacer solicitudes HTTP a la API del backend.
dart
: Librería para convertir datos JSON a objetos Dart y viceversa.
