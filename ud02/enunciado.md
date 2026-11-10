# Práctica 2. Protección y comprobación activa de AulaFP

## El encargo

AulaFP ya conoce sus activos y ha priorizado riesgos. Ahora necesita **aplicar
y comprobar protecciones activas**: proteger la información almacenada y las
comunicaciones, controlar el software y los servicios que escucha, preparar la
detección y verificar que puede recuperar los datos cuando algo falle.

Trabaja con el [caso AulaFP](https://www.apuntesinformaticafp.com/actividades/sad/caso_aulafp.html)
y los ejemplos de [Criptografía, endurecimiento y seguridad activa](https://www.apuntesinformaticafp.com/cursos/seguridad_activa.html).
La dedicación orientativa es de **entre tres y cuatro horas**. Si ya realizaste
las actividades «Para hacer» de las clases, tardarás menos: esta práctica las
aplica al caso, no las repite desde cero. Puedes reutilizar resultados de clase;
solo vuelve a ejecutar una prueba si no conservas su resultado o necesitas
comprobarlo.

## Dónde trabaja: tu laboratorio

Las partes 1, 2, 3 y 5 se practican con comandos de Linux y **datos ficticios**.
Elige un entorno de acuerdo con estas dos opciones:

* **Codespaces (recomendado).** Crea un Codespace en tu repositorio de
  prácticas siguiendo la [práctica 0-C](https://www.apuntesinformaticafp.com/actividades/preparacion/codespaces.html).
  Antes, integra en tu copia privada las novedades de `upstream` con el
  procedimiento de la práctica 0-B y publícalas en `origin`; así tendrás la
  configuración del entorno SAD en la raíz del repositorio. Al crear el
  Codespace se ejecutan pruebas locales del laboratorio. Si no aparecen,
  lánzalas en su terminal: `bash .devcontainer/comprueba-entorno.sh`.
* **Tu equipo.** Si ya tienes un entorno Linux (nativo o WSL), ejecuta esa misma
  comprobación. macOS no incluye `ss`, así que no sirve de forma directa para
  esta práctica; usa Codespaces.

El repositorio contiene [guiones de ejemplo para UD2](ejemplos/README.md).
Puedes leerlos, ejecutarlos y modificar copias para aprender qué hace cada
operación; crean sus resultados bajo `ud02/lab/` y no sobrescriben ejecuciones
anteriores.

**Reglas del laboratorio:**

- Crea tus archivos de prueba en una carpeta nueva `ud02/lab/` y trabaja dentro.
  Los artefactos del laboratorio (claves, firmas, respaldos) **no se publican en
  el repositorio**: están en `.gitignore` y su evidencia se recoge en
  `ud02/practica.md`.
- Genera claves **desechables** con `umask 077` (como en las clases). No uses
  datos ni cuentas reales.
- La parte de amenazas e IDS se resuelve mediante el supuesto y los registros
  ficticios de la parte 4; no necesitas descargar ni ejecutar muestras.
- Las pruebas del laboratorio son locales y usan datos ficticios; no actúan
  sobre servicios reales de AulaFP ni de terceros.
- No actúes sobre los servicios de tu equipo anfitrión ni supongas que todo lo
  que ves está expuesto a Internet: los criterios se aplican a un servidor que
  representa a AulaFP, no a tu máquina real.

## 1. Proteger y verificar la información

Necesitas un **contrato ficticio** de AulaFP. Si ya preparaste uno en clase,
reutilízalo; si no, crea un archivo de texto con unas pocas líneas (`umask 077`
antes de empezar). Conserva **limpio el original** como referencia: es tu
documento de partida para todas las comparaciones.

Configura la protección en reposo con el cifrado simétrico de la clase y
justifica las decisiones de gestión de claves:

- Cifra el contrato y recupéralo en otro archivo. Compara el SHA-256 del
  original y del recuperado.
- Modifica una **copia** del original (por ejemplo, cambia una cifra) y calcula
  su SHA-256.
- Firmar es otra operación: firma el original con un par de claves desechables
  y verifica la firma. Después verifica la firma sobre la copia alterada.

| Prueba | Resultado esperado | Resultado obtenido | Qué demuestra |
|---|---|---|---|
| SHA-256 original vs. recuperado tras descifrar | | | |
| SHA-256 de una copia modificada | | | |
| Verificación de la firma del original | | | |
| Verificación de la firma sobre la copia alterada | | | |

| Decisión sobre las claves | Tu propuesta y justificación |
|---|---|
| Dónde se guardan y con qué permisos | |
| Quién puede usarlas | |
| Qué harías si se pierden | |
| Qué harías si se comprometen | |

**Referencia:** clases «Cifrado de información y gestión de secretos» y «Firmas,
certificados y confianza en redes públicas», actividades de AulaFP sobre cifrar
y compartir, firma del informe y custodia de claves. Puedes empezar con el
[guion de cifrado y firma](ejemplos/01-proteccion-documento.sh) y revisar cada
paso antes de ejecutarlo.

## 2. Comunicación protegida

Registra los resultados de la prueba TLS local de la clase. Si no los conservas
o no la has realizado, repítela en el laboratorio y anota los tres resultados:

| Prueba TLS local | Resultado esperado | Resultado obtenido | Cómo lo interpretas |
|---|---|---|---|
| Nombre correcto con la CA de laboratorio indicada | | | |
| Otro nombre con el mismo certificado | | | |
| Sin indicar la CA de laboratorio | | | |

En el caso, la web pública y el correo comparten el primer servidor; el servidor
de ficheros es otro equipo y el acceso remoto está por documentar. Propón
protocolos para estos servicios sin presentar tus propuestas como una
configuración ya observada:

| Servicio | Protocolo que aceptarías | Justificación |
|---|---|---|
| Web pública | | |
| Correo | | |
| Administración remota | | |
| Transferencia de ficheros | | |

Explica también, en una o dos frases, **qué queda visible** en una conexión
HTTPS aunque el contenido viaje cifrado, y si esos metadatos bastan para saber
qué documento envió una persona.

**Referencia:** clases «Protocolos seguros y comunicaciones protegidas» y
«Firmas, certificados y confianza en redes públicas», actividades de protocolos
para AulaFP, correo en wifi pública y metadatos visibles. El
[guion TLS local](ejemplos/02-tls-local.sh) automatiza la prueba del nombre y
de la confianza con un servidor ligado solo a `localhost`.

## 3. Software confiable y servicios expuestos

Ejecuta el inventario de escuchas de la clase (`ss -tulpn`) en tu entorno de
laboratorio. Fíjate en la diferencia entre **dirección de escucha** y
**accesibilidad efectiva desde Internet**. Si la opción de procesos no muestra
nombres, indícalo: sigue siendo información útil.

| Escucha observada | Qué significa | La mantendría en un servidor de AulaFP |
|---|---|---|
| | | |
| | | |
| | | |

En la tercera columna usa **Mantener**, **Revisar** o **Quitar**. AulaFP quiere
instalar una herramienta para gestionar sus contratos y conviene no improvisar:
completa la tabla de comprobaciones previas.

La salida de `ss` de tu laboratorio **no describe los servidores de AulaFP**.
Usa estos datos conocidos del caso para analizar su superficie de exposición;
si el caso no confirma una debilidad, anótala como algo que habría que comprobar.

| Activo de AulaFP | Amenaza lógica plausible | Exposición o dependencia relevante | Medida para reducirla |
|---|---|---|---|
| Servidor 1: web pública y correo | | | |
| Servidor 2: ficheros internos | | | |

| Comprobación antes de instalar | Qué harías | Qué datos del proveedor necesitas |
|---|---|---|
| Procedencia | | |
| Autenticidad o integridad | | |
| Versión y soporte | | |
| Estado de actualización | | |

| Fase de la actualización | Qué harías para AulaFP | Cómo la comprobarías |
|---|---|---|
| Seguimiento de avisos | | |
| Prioridad | | |
| Pruebas | | |
| Aplicación | | |
| Verificación | | |
| Vuelta atrás | | |

Añade una línea que resuma qué harías ante una **vulnerabilidad grave en el
servidor de correo** sin improvisar cambios en producción.

**Referencia:** clase «Software confiable, actualizaciones y servicios
expuestos», actividades de comprobar la herramienta y política de actualizaciones.

## 4. Amenazas y detección

En un supuesto ficticio de AulaFP se observan, en desorden, estos hechos:

1. Alguien ejecuta un adjunto engañoso de correo.
2. Se crea una tarea programada para volver a ejecutar el programa al iniciar
   sesión.
3. Se cifra el directorio de contratos.
4. Se publica en una web externa información sobre los servicios de la empresa.

Relaciona los hechos con una fase **cuando corresponda**. Propón medidas para
las fases del ataque e indica si son preventivas, de detección o de contención.
La información pública puede servir para el reconocimiento, pero no demuestra
por sí sola que haya actividad maliciosa.

| Hecho | Interpretación o fase, si procede | Medida propuesta |
|---|---|---|
| | | |
| | | |
| | | |
| | | |

Para cada medida indica su tipo, **qué podría frenar y qué quedaría sin cubrir**.

Un detector avisa de **18 intentos de acceso fallidos al correo en un minuto**
y una persona de AulaFP dice que acaba de cambiar su contraseña y que su
cliente sigue usando la anterior. El registro es inventado: no hay confirmación.

| Análisis de la alerta | Propuesta |
|---|---|
| Hipótesis legítima | |
| Hipótesis maliciosa | |
| Datos que contrastarías antes de cerrar la alerta | |
| Clasificación del resultado en este momento | |

En la clasificación, si el resultado queda **pendiente de confirmación**, dilo:
no se penaliza. Añade por qué alertar no justifica borrar archivos ni
bloquear a toda la organización.

Si la investigación confirmase un incidente, distingue las fases de respuesta:

| Fase | Acción propuesta | Quién debería coordinarla | Precaución o límite |
|---|---|---|---|
| Detección | | | |
| Investigación | | | |
| Contención | | | |
| Eliminación de la causa | | | |

Termina situando un **NIDS** y un **HIDS** para AulaFP:

| Tipo | Qué observaría en AulaFP | Límites |
|---|---|---|
| NIDS | | |
| HIDS | | |

Si AulaFP recibiera un adjunto sospechoso, describe cómo organizarías su análisis
defensivo con personal y herramientas adecuados, y qué conclusiones no sacarías
de una sola prueba. No necesitas descargar ni ejecutar muestras para esta actividad.

**Referencia:** clases «Anatomía de ataques y análisis controlado de amenazas»
y «Detección de amenazas y sistemas de detección de intrusiones», actividades de
ordenar los hechos y de los intentos fallidos de acceso.

## 5. Copias, restauración y recuperación

En `ud02/lab/` crea una carpeta `datos/` con **dos ficheros ficticios**
(contrato y nómina), o reutiliza los que preparaste en clase. Registra la prueba
de copia y restauración: si no la hiciste, copia con `tar`, restaura en **otra
carpeta vacía** sin sobrescribir originales y compara.

| Comprobación | Resultado obtenido | Diferencias documentadas |
|---|---|---|
| Nombres tras restaurar | | |
| Hashes SHA-256 | | |
| Permisos | | |

A continuación, completa la propuesta para AulaFP:

Considera la estrategia 3-2-1: tres ejemplares contando el original, dos tipos
de soporte o almacenamiento y una copia fuera de las instalaciones. El caso no
confirma una segunda oficina ni una migración a la nube; presenta cualquier
ubicación externa como propuesta y señala las condiciones o aprobaciones
pendientes.

| Criterio de la política de copias | Tu propuesta y justificación |
|---|---|
| Qué copiar | |
| Frecuencia | |
| Retención | |
| Ubicaciones | |
| Aplicación del principio 3-2-1 | |
| Protección de las copias | |
| Responsables | |

Indica tus hipótesis de pérdida tolerable y tiempo de recuperación: el caso no
las fija. Después responde qué necesitarías, **además de los archivos**, para
recuperar el servicio en un equipo nuevo, y diseña una **prueba periódica**:

| Paso de la prueba periódica | Criterio de éxito |
|---|---|
| 1 | |
| 2 | |
| 3 | |
| 4 | |

**Referencia:** clase «Copias, restauración y recuperación segura», actividades
de política de copias y de restaurar sin sobrescribir. Puedes usar el
[guion de copia y restauración](ejemplos/03-copia-restauracion.sh) y comprobar
su resultado antes de proponer la política de AulaFP.

## 6. Integración con tu UD1

Abre tu práctica 1 y elige dos riesgos que ya priorizaste:

| Riesgo de tu práctica 1 | Control o medida de UD2 | Cómo comprobarías su funcionamiento | Límite o riesgo residual |
|---|---|---|---|
| R1 | | | |
| R2 | | | |

No repitas tablas anteriores: elige los dos riesgos donde las medidas de esta
UD aporten algo claro. El objetivo es mostrar el enlace con el análisis previo,
no repetirlo.

## Cómo presentar el trabajo

En `ud02/` encontrarás `enunciado.md` y [rubrica.md](rubrica.md). Consúltalos
antes de empezar. Crea en **ese mismo directorio** `practica.md` con la plantilla
que aparece a continuación. No renombres ni edites los dos documentos del
docente.

- Conserva los encabezados y las cabeceras de las tablas de la plantilla.
  Añade las filas que necesites y sustituye los espacios vacíos por tus respuestas.
- Los resultados técnicos se registran con **palabras y valores resumidos**,
  no con capturas de pantalla (p. ej., «coinciden», «fallo esperado»).
- Si un resultado no coincide con lo esperado, **documéntalo igualmente**:
  una diferencia explicada tiene más valor que una tabla idéntica.
- No copies definiciones: aplica los conceptos a AulaFP.
- Si falta información, indica **«por comprobar»**; si utilizas una hipótesis,
  identifícala.
- Revisa que cifrado, firmas, servicios y copias se citan e interpretan de forma
  coherente con tu práctica 1.

Registra `ud02/practica.md` en Git y publica la rama en tu repositorio privado.
Sobre el commit que presentas crea y publica la etiqueta **`practica-sad-02-v1`**.
Es esa versión la que se corrige. Sigue el procedimiento de la
[práctica 0-B](https://www.apuntesinformaticafp.com/actividades/preparacion/repositorio-practicas.html).
Para una segunda o tercera versión usa `practica-sad-02-v2` o
`practica-sad-02-v3`, sin borrar ni mover las anteriores. No necesitas enviar
otro aviso por práctica: la etiqueta publicada señala la presentación.

## Plantilla para tu archivo practica.md

Copia el contenido del siguiente bloque en `ud02/practica.md`. Las filas vacías
son espacios para completar, no ejemplos de solución.

```markdown
# Práctica 2. Protección y comprobación activa de AulaFP

## 1. Proteger y verificar la información

### Pruebas de cifrado y firma

| Prueba | Resultado esperado | Resultado obtenido | Qué demuestra |
|---|---|---|---|
| SHA-256 original vs. recuperado tras descifrar | | | |
| SHA-256 de una copia modificada | | | |
| Verificación de la firma del original | | | |
| Verificación de la firma sobre la copia alterada | | | |

### Decisión sobre las claves

| Decisión sobre las claves | Tu propuesta y justificación |
|---|---|
| Dónde se guardan y con qué permisos | |
| Quién puede usarlas | |
| Qué harías si se pierden | |
| Qué harías si se comprometen | |

## 2. Comunicación protegida

### Pruebas TLS locales

| Prueba TLS local | Resultado esperado | Resultado obtenido | Cómo lo interpretas |
|---|---|---|---|
| Nombre correcto con la CA de laboratorio indicada | | | |
| Otro nombre con el mismo certificado | | | |
| Sin indicar la CA de laboratorio | | | |

### Protocolos para AulaFP

| Servicio | Protocolo que aceptarías | Justificación |
|---|---|---|
| Web pública | | |
| Correo | | |
| Administración remota | | |
| Transferencia de ficheros | | |

### Qué queda visible aunque haya HTTPS

[Explicación breve: metadatos visibles y si bastan para saber qué documento envió].

## 3. Software confiable y servicios expuestos

### Escuchas en tu laboratorio

| Escucha observada | Qué significa | La mantendría en un servidor de AulaFP |
|---|---|---|
| | | |
| | | |
| | | |

### Superficie de exposición en AulaFP

| Activo de AulaFP | Amenaza lógica plausible | Exposición o dependencia relevante | Medida para reducirla |
|---|---|---|---|
| Servidor 1: web pública y correo | | | |
| Servidor 2: ficheros internos | | | |

### Comprobación antes de instalar

| Comprobación antes de instalar | Qué harías | Qué datos del proveedor necesitas |
|---|---|---|
| Procedencia | | |
| Autenticidad o integridad | | |
| Versión y soporte | | |
| Estado de actualización | | |

### Política de actualizaciones

| Fase de la actualización | Qué harías para AulaFP | Cómo la comprobarías |
|---|---|---|
| Seguimiento de avisos | | |
| Prioridad | | |
| Pruebas | | |
| Aplicación | | |
| Verificación | | |
| Vuelta atrás | | |

Ante una vulnerabilidad grave en el servidor de correo:

[Resumen breve sin cambios improvisados en producción].

## 4. Amenazas y detección

### Fases del supuesto

| Hecho | Interpretación o fase, si procede | Medida propuesta |
|---|---|---|
| | | |
| | | |
| | | |
| | | |

[Explica qué podría frenar cada medida y qué queda sin cubrir; además, por qué la información pública no demuestra malicia].

### Análisis de la alerta

| Análisis de la alerta | Propuesta |
|---|---|
| Hipótesis legítima | |
| Hipótesis maliciosa | |
| Datos que contrastarías antes de cerrar la alerta | |
| Clasificación del resultado en este momento | |

Justificación de la clasificación y por qué una alerta no autoriza a borrar o bloquear:

[Explicación breve].

| Fase | Acción propuesta | Quién debería coordinarla | Precaución o límite |
|---|---|---|---|
| Detección | | | |
| Investigación | | | |
| Contención | | | |
| Eliminación de la causa | | | |

### NIDS y HIDS para AulaFP

| Tipo | Qué observaría en AulaFP | Límites |
|---|---|---|
| NIDS | | |
| HIDS | | |

Condiciones para analizar un adjunto sospechoso sin ejecutarlo en este laboratorio:

[Describe aislamiento, datos ficticios, observaciones y límites de las conclusiones].

## 5. Copias, restauración y recuperación

### Prueba de copia y restauración

| Comprobación | Resultado obtenido | Diferencias documentadas |
|---|---|---|
| Nombres tras restaurar | | |
| Hashes SHA-256 | | |
| Permisos | | |

### Política de copias de AulaFP

[Considera 3-2-1 como objetivo. La segunda oficina y la migración a la nube no
están aprobadas en el caso: presenta las ubicaciones externas como propuestas].

| Criterio de la política de copias | Tu propuesta y justificación |
|---|---|
| Qué copiar | |
| Frecuencia | |
| Retención | |
| Ubicaciones | |
| Aplicación del principio 3-2-1 | |
| Protección de las copias | |
| Responsables | |

Hipótesis de pérdida tolerable y tiempo de recuperación:

[Indica tus hipótesis].

### Recuperación y prueba periódica

Qué necesitarías además de los archivos:

[Explicación breve].

| Paso de la prueba periódica | Criterio de éxito |
|---|---|
| 1 | |
| 2 | |
| 3 | |
| 4 | |

## 6. Integración con tu UD1

| Riesgo de tu práctica 1 | Control o medida de UD2 | Cómo comprobarías su funcionamiento | Límite o riesgo residual |
|---|---|---|---|
| R1 | | | |
| R2 | | | |
```
