# Rúbrica de la práctica 1 de SAD

Utiliza esta rúbrica para revisar `practica.md` antes de presentar la entrega.
**Total: 10 puntos.** Se valora aplicar los conceptos a AulaFP, no escribir más.

| Criterio | Máximo | Qué se espera |
|---|---:|---|
| Política de contraseñas | 2,5 | Las cinco decisiones están concretadas y justificadas: longitud acorde con las recomendaciones explicadas en los apuntes y con el uso o no de MFA, prevención de contraseñas comunes o comprometidas, reutilización, cambios cuando hay motivo y actuación ante compromiso. |
| Valoración de biometría | 2 | Propones un uso concreto, explicas una ventaja y una limitación, comparas una alternativa no biométrica y justificas tu recomendación con las comprobaciones previas necesarias. No se premia decidir implantarla. |
| Protección perimetral | 3 | Distingues servicios públicos, puestos y ficheros internos; las comunicaciones son coherentes y limitan el acceso si comprometen la web. Las dos medidas complementarias tienen responsable y forma de comprobación, y responden a las necesidades del caso. |
| Respuesta inicial ante el incidente | 2,5 | Ordenas aviso, valoración, contención y preservación sin retrasar una contención urgente. Registras las intervenciones, distingues las que alteran información, reservas tareas a especialistas y reconoces las fases forenses sin afirmar una causa no confirmada. |

## Cómo se asignan los puntos

En cada criterio se valoran las partes indicadas en el enunciado. Una respuesta
completa, correcta y justificada obtiene el máximo; una respuesta parcialmente
correcta obtiene los puntos de los aspectos acreditados; una respuesta ausente
o incorrecta no acredita esos aspectos. La mera presencia de una palabra o una
tabla rellena no demuestra que el razonamiento sea correcto.

Inventario, propiedades, riesgos y permisos son la base del trabajo: deben estar
completos y ser coherentes con tus decisiones. No tienen una puntuación
independiente ni generan una segunda nota por el mismo contenido.

## Comprueba antes de entregar

- `ud1/practica.md` incluye los cinco apartados y las tablas de la plantilla.
- El inventario recoge los activos del caso, agrupando los equivalentes, y cubre
  información, equipos, servicios, personas y dependencias.
- Has analizado tres activos y tres riesgos ordenados, incluyendo riesgo físico
  o ambiental y riesgo lógico.
- La tabla de permisos incluye los cuatro perfiles. Usas `Bajo`, `Medio`, `Alto`
  y `Lectura`, `Modificación`, `Sin acceso` donde corresponde.
- Hay dos medidas complementarias y entre cinco y siete actuaciones iniciales.
- Distingues datos conocidos, hipótesis e información por comprobar.
- No has modificado `enunciado.md` ni `rubrica.md`.
- Has publicado la etiqueta `practica-sad-01-v1` en tu repositorio privado.
  Si es una segunda o tercera presentación, la versión correspondiente, sin
  mover ni borrar las anteriores.
- El historial Git se revisará como información de trazabilidad de la entrega;
  no tiene puntuación independiente.

El historial no sustituye la lectura de `practica.md` ni se puntúa por el número
de commits. Sirve para identificar qué versión se presentó y qué cambios se
hicieron.

La revisión puede apoyarse en comprobaciones automáticas de formato y
cumplimentación. **La valoración del contenido y la nota definitiva las revisa
el docente**. Un problema de formato se señala para subsanarlo; no convierte
automáticamente en incorrecto todo el trabajo.
