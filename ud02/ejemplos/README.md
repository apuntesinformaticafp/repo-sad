# Ejemplos ejecutables de SAD UD02

Estos guiones complementan las explicaciones de los apuntes. Se ejecutan desde
la raíz de tu repositorio privado y usan solo herramientas locales y archivos
ficticios. No requieren `sudo` ni contactan servicios externos.

```console
bash ud02/ejemplos/01-proteccion-documento.sh
bash ud02/ejemplos/02-tls-local.sh
bash ud02/ejemplos/03-copia-restauracion.sh
```

Cada ejecución crea una carpeta nueva dentro de `ud02/lab/`, que está excluida
de Git. Si ya existe una carpeta con el mismo nombre base, el guion crea otra
con un sufijo aleatorio: no sobrescribe resultados anteriores. Los guiones y
esta documentación sí forman parte del repositorio público.

## 01 · Cifrado, hash y firma

`01-proteccion-documento.sh` crea un contrato ficticio, cifra y recupera una
copia con AES-256-CBC y PBKDF2, compara resúmenes SHA-256 y firma el original con
una clave desechable. Solicita la contraseña de cifrado de forma interactiva;
no la pongas en la línea de comandos. También comprueba que la firma no valida
una copia alterada.

La clave privada de firma queda sin contraseña para simplificar el ejercicio.
Es desechable, se guarda con permisos restringidos bajo `ud02/lab/` y no debe
publicarse ni reutilizarse.

## 02 · TLS local

`02-tls-local.sh` genera un certificado autofirmado de corta duración para
`local.test`, inicia un servicio que escucha **solo en `127.0.0.1`** y prueba la
conexión con el nombre correcto, con otro nombre y sin confiar explícitamente
en el certificado. El propio guion detiene el servicio al terminar.

El certificado se confía solo en estas pruebas de OpenSSL: el guion no lo
instala en el sistema o el navegador ni contacta con `local.test` fuera de
localhost.

## 03 · Copia y restauración

`03-copia-restauracion.sh` crea un contrato y una nómina ficticios, limita sus
permisos, genera un archivo `tar` y lo restaura en un directorio vacío. Compara
contenido y permisos sin sobrescribir los originales.

## Limpieza

Los guiones no borran sus resultados: puedes inspeccionarlos y registrar en
`ud02/practica.md` lo que demuestran. Al terminar el curso, elimina únicamente
las carpetas de laboratorio que hayas creado y ya no necesites. No guardes ahí
datos reales, contraseñas ni claves que vayas a reutilizar.
