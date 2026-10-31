# Práctica 1. Análisis inicial de seguridad de AulaFP

## El encargo

AulaFP quiere proteger su información y sus servicios sin complicar
innecesariamente el trabajo diario. Analiza su situación y presenta una propuesta
inicial de seguridad.

Trabaja con el [caso AulaFP](https://www.apuntesinformaticafp.com/actividades/sad/caso_aulafp.html)
y los ejemplos de [Fundamentos, riesgos y respuesta inicial](https://www.apuntesinformaticafp.com/cursos/fundamentos_seguridad.html).
La dedicación orientativa es de **entre una y dos horas**. No necesitas instalar
herramientas, configurar sistemas ni investigar recursos adicionales.

## 1. Inventario y propiedades de seguridad

Identifica los activos descritos en AulaFP: información, equipos, servicios,
personas y dependencias de soporte. Completa la tabla de inventario de la
plantilla. Agrupa elementos equivalentes: los doce equipos pueden ocupar una
fila. Recoge los activos del caso, no te limites a un ejemplo de cada tipo.
Una dependencia puede ser otro activo o un servicio de soporte.

Después elige **tres activos** y completa la tabla de propiedades. Describe una
pérdida concreta de confidencialidad, integridad y disponibilidad para cada uno.
Indica qué propiedad priorizarías y por qué, sin dar definiciones teóricas.
Si una pérdida no resulta aplicable, explícalo brevemente.

**Referencia:** «Activos, información y propiedades de seguridad», actividades
de AulaFP sobre inventario y propiedades de tres activos.

## 2. Matriz de riesgos

Plantea **tres riesgos**, ordenados de mayor a menor prioridad, relacionados con
los activos de tu inventario. Incluye al menos un riesgo físico o ambiental y
uno lógico. Para cada uno identifica una debilidad concreta, el suceso que podría
causar daño y su consecuencia para AulaFP.

Usa **Bajo, Medio o Alto** para probabilidad e impacto, con una justificación
breve en la tabla siguiente. Relaciona cada riesgo con una medida proporcionada
y explica qué riesgo residual quedaría. Añade una frase que justifique el orden.

**Referencia:** «Vulnerabilidades, amenazas y análisis de riesgos», actividad de
la tabla de tres riesgos; «Seguridad física, ambiental y lógica», actividades
de escenarios y medidas para la sala de servidores.

## 3. Identidad y control de acceso

### Política de contraseñas

Concreta las cinco decisiones de la plantilla y justifícalas brevemente para
AulaFP. Si la longitud depende de utilizar MFA, indica esa condición. No se
piden contraseñas reales ni configuraciones.

### Permisos por perfil

Completa los permisos de los cuatro perfiles para los cinco grupos de recursos
indicados. Usa **Lectura, Modificación o Sin acceso**. Aquí «Modificación» incluye
lectura y escritura. Puedes añadir una condición breve en «Notas» si necesitas
distinguir tareas o documentos dentro de una categoría.

Aplica el mínimo privilegio y distingue administrar técnicamente un servidor de
tener autorización habitual para consultar sus documentos.

### Biometría

Valora un posible uso concreto en AulaFP: finalidad, una ventaja, una limitación
o riesgo, una alternativa no biométrica y tu recomendación. Indica qué
necesitarías comprobar antes. Puedes recomendarla, descartarla o condicionar
su uso: se valora la justificación, no que decidas implantarla.

**Referencia:** «Identidad y control de acceso», actividades de política de
contraseñas, tabla de permisos y valoración de biometría.

## 4. Protección perimetral

Utiliza el esquema de red del caso, sin necesidad de redibujarlo. Propón las
zonas y comunicaciones necesarias para distinguir servicios públicos, puestos
y ficheros internos. Debe quedar claro cómo se accede a web y correo desde
Internet y cómo se limita el acceso a los ficheros.

Explica brevemente por qué comprometer la web no debería dar acceso directo a
los ficheros. Completa la propuesta con **dos medidas complementarias**, cada
una con responsable y forma de comprobar su funcionamiento.

No se piden direcciones IP, comandos, reglas de cortafuegos ni una VPN configurada.
Las zonas y medidas son tu propuesta, no hechos ya comprobados en AulaFP.

**Referencia:** «Protección perimetral y respuesta inicial ante incidentes»,
actividad de zonas para servicios públicos e internos; «Seguridad física,
ambiental y lógica», actividad de medidas complementarias.

## 5. Respuesta inicial ante un incidente

En AulaFP aparecen **indicios de acceso no autorizado al servidor de ficheros**.
Todavía no se conocen la causa ni el alcance. Es un supuesto escrito: no actúes
sobre sistemas reales.

Organiza la respuesta en **entre cinco y siete actuaciones ordenadas**:
aviso, valoración inicial del alcance, contención y preservación de evidencias.
Indica con quién coordinarías cada actuación y qué información registrarías.

Señala qué actuaciones podrían alterar información y cómo las documentarías;
indica qué tareas dejarías a especialistas. Resume las fases de recogida y
preservación, análisis y documentación de resultados. Documentar acompaña todo
el proceso, no se deja únicamente para el final.

No retrases una contención urgente solo para recopilar evidencias ni afirmes
una causa que el supuesto no demuestra.

**Referencia:** «Protección perimetral y respuesta inicial ante incidentes»,
actividades de respuesta ante acceso no autorizado y conservación de información.

## Cómo presentar el trabajo

En `ud01/` encontrarás `enunciado.md` y [rubrica.md](rubrica.md). Consúltalos antes
de empezar. Crea en **ese mismo directorio** `practica.md` con la plantilla que
aparece a continuación. No renombres ni edites los dos documentos del docente.

- Conserva los encabezados y las cabeceras de las tablas de la plantilla.
  Añade las filas que necesites y sustituye los espacios vacíos por tus respuestas.
- Utiliza tablas, listas y frases breves. No necesitas portada, introducción,
  conclusiones, bibliografía ni capturas.
- No copies definiciones: aplica los conceptos a AulaFP.
- Si falta información, indica **«por comprobar»**; si utilizas una hipótesis,
  identifícala. Que una medida no esté documentada no demuestra que no exista.
- Revisa que activos, riesgos, permisos y medidas sean coherentes entre sí.

Registra `ud01/practica.md` en Git y publica la rama en tu repositorio privado.
Sobre el commit que presentas crea y publica la etiqueta **`practica-sad-01-v1`**.
Es esa versión la que se corrige. Sigue el procedimiento de la
[práctica 0-B](https://www.apuntesinformaticafp.com/actividades/preparacion/repositorio-practicas.html).
Para una segunda o tercera versión usa `practica-sad-01-v2` o
`practica-sad-01-v3`, sin borrar ni mover las anteriores. No necesitas enviar
otro aviso por práctica: la etiqueta publicada señala la presentación.

## Plantilla para tu archivo practica.md

Copia el contenido del siguiente bloque en `ud01/practica.md`. Las filas vacías
son espacios para completar, no ejemplos de solución.

```markdown
# Práctica 1. Análisis inicial de seguridad de AulaFP

## 1. Inventario y propiedades de seguridad

### Inventario

| Activo | Tipo | Función o valor para AulaFP | Dependencia principal |
|---|---|---|---|
| | | | |

### Propiedades de tres activos

| Activo | Pérdida de confidencialidad | Pérdida de integridad | Pérdida de disponibilidad | Propiedad prioritaria y motivo |
|---|---|---|---|---|
| | | | | |
| | | | | |
| | | | | |

## 2. Matriz de riesgos

| Riesgo | Activo | Vulnerabilidad | Amenaza | Consecuencia | Probabilidad | Impacto | Medida propuesta | Riesgo residual |
|---|---|---|---|---|---|---|---|---|
| R1 | | | | | | | | |
| R2 | | | | | | | | |
| R3 | | | | | | | | |

| Riesgo | Tipo de riesgo | Justificación de probabilidad | Justificación de impacto |
|---|---|---|---|
| R1 | | | |
| R2 | | | |
| R3 | | | |

Prioridad: [una frase que justifique el orden de los tres riesgos].

## 3. Identidad y control de acceso

### Política de contraseñas

| Decisión | Propuesta para AulaFP | Justificación |
|---|---|---|
| Longitud mínima | | |
| Comunes o comprometidas | | |
| Reutilización | | |
| Cuándo cambiar | | |
| Actuación ante compromiso | | |

### Permisos por perfil

| Perfil | Contactos y consultas | Propuestas, contratos y facturas | Informes y formación | Documentación laboral y nóminas | Configuraciones y registros | Notas |
|---|---|---|---|---|---|---|
| Dirección | | | | | | |
| Administración | | | | | | |
| Técnicos | | | | | | |
| Atención al cliente | | | | | | |

### Biometría

| Aspecto | Respuesta para AulaFP |
|---|---|
| Uso concreto | |
| Ventaja | |
| Limitación o riesgo | |
| Alternativa no biométrica | |
| Recomendación y comprobaciones previas | |

## 4. Protección perimetral

### Zonas y comunicaciones

| Zona propuesta | Equipos o servicios | Comunicaciones permitidas |
|---|---|---|
| | | |

### Separación de web y ficheros

[Explicación breve de cómo se limita el acceso si comprometen la web].

### Medidas complementarias

| Medida | Qué protege o limita | Responsable | Comprobación |
|---|---|---|---|
| | | | |
| | | | |

## 5. Respuesta inicial ante un incidente

### Actuaciones ordenadas

| Orden | Actuación | Aviso o coordinación | Información que registrar o preservar |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

### Actuaciones que alteran información

[Indica cuáles y cómo documentarías la intervención].

### Tareas para especialistas

[Indica qué tareas dejarías a personal especializado].

### Fases del análisis forense

[Resume las fases y la documentación a lo largo del proceso].
```
