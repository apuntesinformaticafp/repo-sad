# Rúbrica de la práctica 2 de SAD

Utiliza esta rúbrica para revisar `practica.md` antes de presentarla. Se valora
la aplicación razonada a AulaFP y la interpretación de las pruebas, no la
extensión del texto, el número de comandos ni la coincidencia literal con una
solución.

| Criterio | Logrado | Parcialmente logrado | Pendiente de revisión |
|---|---|---|---|
| Protección criptográfica y gestión de claves | Distingues cifrado, hash y firma; interpretas las comparaciones y verificaciones, incluida la copia alterada; propones custodia, acceso y respuesta ante pérdida o compromiso de claves. | Las operaciones principales son correctas, pero falta interpretar algún resultado, explicar sus límites o concretar la gestión de claves. | Se confunden las funciones de cifrado, hash y firma, no se interpretan los resultados o se propone reutilizar/exponer claves de prueba. |
| Certificados y comunicaciones seguras | Interpretas los resultados TLS de nombre y confianza; eliges protocolos coherentes con cada servicio y explicas qué metadatos siguen visibles. | La elección de protocolos o la interpretación TLS es en general correcta, pero omite alguna validación, límite o justificación. | Se acepta un certificado sin validar su identidad/confianza, se confunden protocolos o se afirma que TLS oculta todo el tráfico. |
| Amenazas lógicas, software y servicios | Identificas amenazas y superficie de exposición a partir de los datos confirmados de AulaFP; interpretas las escuchas del laboratorio sin equipararlas a acceso desde Internet; propones controles de procedencia y actualizaciones verificables. | Las amenazas y medidas son razonables, pero falta distinguir hechos de hipótesis, interpretar alguna escucha o concretar la verificación de software y actualizaciones. | Se atribuyen vulnerabilidades no confirmadas al caso, se considera que un hash aislado demuestra procedencia, se infiere acceso desde Internet sin evidencia o se proponen cambios sin prueba. |
| Amenazas y análisis controlado | Relacionas los hechos con fases cuando corresponde, propones medidas con alcance y límites, y describes un análisis defensivo sin ejecutar muestras ni prometer aislamiento absoluto. | El análisis identifica fases y medidas, pero omite límites, alguna condición de seguridad o qué conclusiones no se pueden generalizar. | Se presenta la información pública como prueba de ataque, se propone ejecutar malware en el Codespace o se describen medidas sin relación con el escenario. |
| Detección y respuesta | Contrastas hipótesis antes de clasificar la alerta, sitúas NIDS/HIDS con sus límites y distingues detección, investigación, contención y eliminación de la causa. | La interpretación es razonable, pero faltan datos a contrastar, límites de los detectores o alguna fase de respuesta. | Se da por confirmado un ataque o un falso positivo sin evidencia, se confunde detectar con eliminar o se propone borrar/bloquear sin valorar el impacto. |
| Copias y recuperación | Verificas la restauración en un destino vacío y relacionas contenido, hashes y permisos; propones una política que considera 3-2-1, declara hipótesis y comprueba la recuperación del servicio. | La copia se restaura, pero faltan verificaciones, aplicación de 3-2-1, protección/ubicación de copias o pasos para recuperar el servicio. | Se considera que tener una copia garantiza la recuperación, se sobrescriben originales o no se comprueba el resultado restaurado. |
| Integración y coherencia con UD1 | Vinculas dos riesgos priorizados en UD1 con controles pertinentes de UD2, una forma de comprobarlos y el riesgo residual; separas hechos, hipótesis y aspectos por comprobar. | La relación con UD1 es reconocible, pero algún control, comprobación, límite o supuesto no queda justificado. | Las propuestas no se conectan con los riesgos de AulaFP o presentan hipótesis como hechos confirmados. |

## Cómo se interpreta la rúbrica

Los criterios describen dimensiones de **una única evidencia integradora**. Los
comandos, tablas y análisis no reciben calificaciones independientes ni se
duplican como notas separadas. Un resultado técnico distinto del esperado no
impide demostrar aprendizaje si está documentado e interpretado correctamente.

La asignación de pesos y puntuación de los criterios se concretará conforme a
la programación vigente antes de la evaluación; esta rúbrica no introduce un
reparto de puntos nuevo.

## Comprueba antes de entregar

- `ud02/practica.md` contiene los apartados y tablas de la plantilla.
- El laboratorio utiliza únicamente archivos ficticios y claves desechables.
- No has añadido al repositorio los archivos de `ud02/lab/`, claves privadas,
  certificados de prueba ni firmas.
- Distingues hechos conocidos, hipótesis y cuestiones por comprobar sobre AulaFP.
- Has relacionado dos riesgos de tu práctica 1 con controles de esta UD.
- No has modificado `enunciado.md` ni `rubrica.md`.
- Has publicado la etiqueta `practica-sad-02-v1` en tu repositorio privado; para
  una segunda o tercera presentación, usa `practica-sad-02-v2` o
  `practica-sad-02-v3`, sin mover ni borrar las anteriores.
- El historial Git identifica la versión presentada; no se puntúa por el número
  de commits.
