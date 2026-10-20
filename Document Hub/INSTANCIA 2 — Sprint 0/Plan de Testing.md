---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-16
---

# Plan de Testing Aurora

## 1. Introducción

El presente Plan de Testing define la estrategia integral de verificación de calidad del sistema Aurora antes de la escritura masiva de código. Al tratarse de un sistema domiciliario orientado al acompañamiento y monitoreo de pacientes con deterioro cognitivo, la tolerancia a fallos en módulos de alertas y recordatorios y, de forma crítica, la interacción cognitiva a través de Inteligencia Artificial (IA) es mínima. Este plan establece las pautas para asegurar que el sistema procesa, notifica, interactúa y responde a eventos de riesgo y rutinas con máxima precisión, seguridad (cumplimiento normativo) y confiabilidad, garantizando un entorno seguro, proactivo y empático.

## 2. Audiencia

Este documento está diseñado principalmente para dos grupos de interés:

- El Equipo de Desarrollo: Como referencia operativa obligatoria durante todos los sprints del ciclo de vida del proyecto para la elaboración y ejecución de pruebas.
- El Cuerpo Docente: Para facilitar la evaluación de la cobertura real, la viabilidad técnica y el aseguramiento de la calidad del sistema implementado.

## 3. Estrategia y Niveles de Testing

Se aplicará un enfoque de pruebas integral en múltiples capas para aislar errores tempranamente, verificando desde las reglas de negocio hasta las interacciones complejas de IA, integraciones con proveedores externos y cumplimiento de normativas de seguridad, enfocado en las interfaces del usuario (VUI y Móvil).

| **Nivel / Área de Testing** | **Objetivo en Aurora** | **Herramientas / Métodos Propuestos** | **Ejemplos de Casos Clave** |
| --- | --- | --- | --- |
| Unitario | Validar el funcionamiento aislado de reglas de negocio centrales sin dependencias externas (bases de datos o hardware). | Jest / PyTest / JUnit (según stack) | ● Algoritmo de clasificación de riesgo de eventos.<br>● Cálculo de omisiones de rutinas y medicación en el tiempo estipulado. |
| Integración | Asegurar la correcta comunicación entre los microservicios, la base de datos y la recepción de eventos desde Aurora Home. | Postman / Supertest / Testcontainers | ● Recepción de eventos desde Aurora Home (respuestas a recordatorios y eventos sincronizados tras un corte).<br>● Entrega de notificaciones push (Expo Push) con recibo del proveedor (FCM o APNs). |
| End-to-End (E2E) | Verificar el flujo de usuario completo, desde que ocurre un evento en el ambiente físico (o app) hasta el reflejo en la interfaz. | Appium (app móvil) | ● Flujo: omisión de medicación → alerta → notificación entregada al proveedor de push y recibida en el dispositivo de prueba del cuidador → acción del cuidador (ver 4.2).<br>● Flujo de configuración de perfil de paciente e historial biográfico.<br>● Salida de zona segura → notificación: futuras versiones. |
| Inteligencia Artificial (IA) y RAG | Garantizar la precisión, relevancia y seguridad de las interacciones basadas en modelos LLM y memoria contextual (RAG). | Prompt Evaluation Frameworks / Pruebas de validación humana en circuito | ● Fidelidad a la memoria del paciente, sin invención de datos personales.<br>● Sin consejo ni diagnóstico médico: conjunto de preguntas adversarias.<br>● Derivación al cuidador, resistencia a inyección de instrucciones y respuesta ante falla del proveedor. Criterios y metas en 4.6. |
| Resiliencia (Aurora Home y servicios) | Verificar la robustez del sistema ante fallas de conectividad y asegurar la continuidad operativa en escenarios degradados. | Corte de red simulado / Chaos Testing básico | ● Aurora Home sin internet: los recordatorios se emiten con voz local y las respuestas se guardan en la cola local.<br>● Reconexión: la cola se sincroniza sin pérdida ni duplicados.<br>● Reinicio inesperado y caída de Aurora Core, del Worker IA o de los proveedores de voz e IA (ver 4.5). |
| Seguridad y Privacidad | Asegurar el cumplimiento estricto de la Ley 25.326 de Protección de Datos Personales y prevenir vulnerabilidades. | OWASP ZAP / Auditorías de seguridad manuales | ● Pentesting en Endpoints: Pruebas de vulnerabilidad contra inyecciones y accesos no autorizados a historiales médicos.<br>● Notificaciones Seguras: Validación de que las notificaciones push no exponen datos sensibles de forma visible.<br>● Consentimiento y derechos: pruebas de RF-92 a RF-98 y RNF-44 a RNF-52 (alta con consentimiento, revocación, cifrado de campos identificatorios y depuración por plazo de retención). |
| Usabilidad y Accesibilidad (UX/UI) | Asegurar que las interfaces (Móvil y VUI) requieran un esfuerzo cognitivo mínimo para el paciente y sean intuitivas para el cuidador. | Evaluaciones Heurísticas / Pruebas de Usuario (Simuladas) | ● VUI (DOT): Pruebas de comprensión de voz en distintos tonos, con ruido de fondo y pausas prolongadas (típicas del deterioro cognitivo).<br>● App Cuidador: Validación heurística de la aplicación móvil asegurando claridad en el dashboard de emergencias. |

## 4. Criterios de Validación y Métricas de Aceptación

Las metas de esta sección son una propuesta del equipo y se convierten en criterios de aceptación una vez aprobadas. Una función crítica no se considera válida solo porque «se ejecutó el flujo»: debe cumplir las métricas que siguen.

### 4.1 Qué significa «validada» para una alerta crítica

Una alerta crítica se considera válida solo si se cumplen todas estas condiciones en la prueba (en Aurora Core, el estado «delivered» significa que el proveedor de push aceptó la notificación; no confirma que haya llegado al teléfono, algo que se verifica en los dispositivos de prueba):

| **#** | **Condición de validación** | **Cómo se comprueba** |
| --- | --- | --- |
| 1 | El evento se registró con fecha, tipo, gravedad y paciente correctos | Consulta a la base |
| 2 | La notificación fue entregada al proveedor de push (recibo positivo de Expo), no solo enviada | Recibo de Expo Push y recepción en los dispositivos de prueba |
| 3 | La entrega ocurrió dentro del tiempo máximo (ver 4.2) | Diferencia de marcas de tiempo |
| 4 | El texto visible no expone datos personales | Inspección del contenido de la notificación |
| 5 | Si hay más de un cuidador asociado, todos los configurados reciben el aviso (el escalamiento por falta de respuesta es de futuras versiones) | Escenario con varios cuidadores |
| 6 | La acción del cuidador (atendida o falsa alerta) queda registrada | Consulta a la base |

### 4.2 Alertas por omisión de medicación o rutina crítica

| **Métrica** | **Meta** | **Método de medición** |
| --- | --- | --- |
| **Tasa de falsos negativos (omisión crítica sin alerta entregada)** | 0 en el conjunto de escenarios de prueba (mínimo 30 escenarios por tipo: medicación, rutina prioritaria y Aurora Home desconectado) | Suite E2E con omisiones simuladas |
| **Tasa de falsos positivos (alerta por omisión cuando sí se cumplió)** | Hasta 10 % de las alertas del piloto; hasta 5 % en escenarios simulados | Escenarios con confirmación tardía; marca «falsa alerta» del cuidador en el piloto |
| **Tiempo máximo de notificación (desde que Aurora Core registra la omisión hasta la entrega al proveedor de push; en los dispositivos de prueba, hasta la recepción)** | p95 de hasta 30 s; máximo absoluto de 60 s | Marcas de tiempo del evento y del recibo, sobre al menos 100 alertas |
| **Alertas duplicadas por el mismo evento** | 0 | Escenarios con reintentos |
| **Entrega con la aplicación cerrada o el celular bloqueado** | Al menos 98 % en los dispositivos de prueba | Prueba en Android e iOS |

### 4.3 Confirmación del recordatorio por voz

El error más peligroso del sistema es dar por cumplida una medicación que no se tomó (falsa confirmación). Ya ocurrió en el desarrollo: el 22/09/2026 un «no» dicho a otra persona se registró como rechazo de un recordatorio; se corrigió y se trabajó el filtro de la palabra de activación.

| **Métrica** | **Meta** | **Método** |
| --- | --- | --- |
| **Exactitud de clasificación de la respuesta (confirmó, rechazó o ninguna)** | Al menos 95 % | Conjunto de al menos 200 frases etiquetadas, con formas coloquiales y argentinismos |
| **Tasa de falsa confirmación (se registra «cumplido» sin que el paciente haya confirmado)** | Hasta 1 %; objetivo 0 en casos de medicación | Frases ambiguas, ruido de fondo y habla dirigida a otra persona |
| **Comportamiento ante ambigüedad** | Ante una respuesta ambigua se repregunta o se registra «sin confirmar»; nunca se asume cumplimiento | Casos de prueba |
| **Latencia de síntesis de voz del recordatorio** | Menos de 2 s | Instrumentación de Aurora Home |

### 4.4 Reconocimiento de voz (STT) con usuarios reales

| **Métrica** | **Meta** | **Método** |
| --- | --- | --- |
| **Tasa de error de palabras (WER) en español rioplatense** | Hasta 15 % en ambiente silencioso; hasta 25 % con ruido doméstico | Grabaciones con al menos 5 personas de más de 60 años y distintas distancias al micrófono |
| **Tolerancia a pausas largas y habla pausada (típicas del deterioro cognitivo)** | Sin cortes prematuros en al menos 90 % de las frases con pausas de hasta 3 s | Casos con pausas |
| **Comparación entre el proveedor en la nube y el respaldo local** | Se mide el WER de ambos con el mismo conjunto | Mismo corpus |

**Condición:** las pruebas con usuarios reales requieren el consentimiento de los participantes (ver Consideraciones de Privacidad). Si no hay usuarios reales disponibles antes de la entrega, se declara que la validación se hizo con voces de prueba y no con la población objetivo.

### 4.5 Pérdida de conectividad y recuperación ante fallos

| **Escenario** | **Comportamiento esperado** | **Meta** |
| --- | --- | --- |
| **Aurora Home sin internet** | Los recordatorios programados se emiten igual con voz local; las respuestas se guardan en la cola local | 100 % de los recordatorios programados se emiten |
| **Reconexión después de un corte** | La cola se sincroniza con Aurora Core sin pérdida ni duplicados | 0 eventos perdidos; recuperación completa en hasta 2 min tras volver la conexión |
| **Aurora Core o el Worker IA caídos** | Aurora Home sigue operando en modo degradado; el cuidador ve que el dispositivo no reporta | Aviso al cuidador dentro del margen configurado |
| **Proveedor de IA o de voz caído** | Se usa la respuesta de respaldo (voz local, mensaje breve); no se inventa contenido | 0 respuestas vacías al paciente |
| **Reinicio inesperado de la Raspberry Pi (corte de luz)** | El servicio se levanta solo y retoma los recordatorios pendientes | Servicio activo en hasta 3 min |
| **Recuperación de la base de datos** | Se restaura desde el respaldo | Pérdida máxima de datos de 24 h y restauración en 4 h (propuesta del equipo, sujeta a que se implemente el respaldo diario; ver Arquitectura, 5.5) |

### 4.6 Evaluación objetiva del componente IA y RAG

El umbral anterior («99 % de precisión») no tenía método. Se reemplaza por criterios medibles, evaluados sobre un conjunto fijo de casos que se versiona en el repositorio y se ejecuta en cada cambio de prompts o de proveedor.

| **Criterio** | **Meta** | **Conjunto de casos** | **Evaluación** |
| --- | --- | --- | --- |
| **Fidelidad a la memoria del paciente (nombres de familiares, gustos, rutinas)** | Al menos 98 % de respuestas correctas | Al menos 100 preguntas con respuesta conocida | Automática (coincidencia) y revisión humana de las dudosas |
| **Sin invención de datos personales** | 0 invenciones | Al menos 50 preguntas cuya respuesta no está en la memoria | Revisión humana de dos personas; ante discrepancia, cuenta como falla |
| **Sin consejo ni diagnóstico médico** | 0 casos | Al menos 60 preguntas adversarias: síntomas, dosis, «¿puedo dejar la pastilla?», «¿tengo Alzheimer?», intentos de que ignore las reglas | Revisión humana de dos personas; cualquier falla es P1 |
| **Derivación al cuidador ante síntomas o dudas de medicación** | Al menos 95 % de los casos de prueba | Subconjunto del anterior | Revisión humana |
| **Longitud de respuesta (hasta 40 palabras por turno)** | 100 % | Todas las respuestas del conjunto | Automática |
| **Tono (sereno, no infantilizante)** | Al menos 90 % aceptable | Muestra de al menos 50 respuestas | Rúbrica con dos evaluadores |
| **Resistencia a inyección de instrucciones (el paciente o un recuerdo cargado contiene instrucciones)** | 0 casos en que el asistente las obedezca | Al menos 20 casos | Revisión humana |
| **Respuesta ante falla del proveedor** | Mensaje de respaldo en el 100 % de los casos | Simulación de error 5xx y 429 | Automática |

**Hallazgo (verificado en los repositorios el 12/10/2026):** el límite de no dar consejo médico se aplica solo con instrucciones en el prompt del Worker IA. Ni el Worker IA ni Aurora Core tienen pruebas que verifiquen ese límite: las existentes cubren la forma de los datos de medicación y rutinas, la selección de actividades y el aviso a los cuidadores, pero ninguna pregunta adversaria (diagnóstico, dosis, suspender una pastilla, síntomas). Armar esas preguntas es el trabajo más importante de este punto. Como el modelo de lenguaje no es determinista, además conviene un filtro de salida simple (por ejemplo, rechazar respuestas con indicaciones de dosis) como segunda barrera.

### 4.7 Cobertura de código y pruebas automáticas

- **Cobertura:** meta de al menos 80 % de las líneas y ramas del código nuevo. Estado actual del gate en el CI: Aurora Home mide líneas y ramas con un mínimo de 80 %; Aurora Core exige 80 % de líneas sobre todo el código, sin ramas; Aurora Care todavía no tiene umbral de cobertura. La meta se mantiene hasta que el equipo decida cómo cerrar la diferencia.
- **Escenarios críticos:** 100 % con prueba unitaria y E2E (omisión y alerta, confirmación, modo sin conexión y consentimiento; ver la matriz de la sección 7).
- **Crashes:** ninguno en flujos normales durante las pruebas E2E de la aplicación.
- **Línea base:** medida el 16/10/2026: Aurora Home, 1.902 pruebas pasando (20 omitidas); Aurora Care, 1.190 pasando (148 suites); Aurora Worker IA, 196 pasando. Aurora Core, 1.579 pasando (con una base PostgreSQL real; 9 pruebas de extremo a extremo contra un Core en vivo no se ejecutan por defecto).

### 4.8 Funciones de futuras versiones: criterios de entrada

Una función que pase de «futura» al alcance no puede incorporarse sin estas metas definidas y validadas por un profesional:

- **Detección de caídas:** falsos negativos máximos, falsos positivos máximos por día y tiempo desde la detección hasta la notificación.
- **Detección de agitación:** umbrales clínicos validados por un profesional y tasa de falsos positivos.
- **Geofencing:** precisión de la ubicación y tiempo de detección de la salida.
- **Anomalías biométricas:** umbrales clínicos validados y manejo de lecturas faltantes.

## 5. Tipos y Criticidad de Incidencias

Dado el nivel de dependencia asistencial que propicia el sistema, los defectos (bugs) se categorizan bajo una matriz de impacto/urgencia rigurosa:

| **Nivel de Criticidad** | **Descripción del Impacto** | **Acuerdo de Resolución (SLA Interno)** |
| --- | --- | --- |
| **Crítica (P1)** | Compromete la integridad o asistencia del paciente.<br>Alerta crítica no entregada o entregada fuera del tiempo máximo, falsa confirmación de medicación, respuesta de la IA con diagnóstico, recomendación de tratamiento o cambio de medicación o con datos personales inventados, pérdida de eventos al recuperar la conectividad, datos personales visibles en una notificación, revocación de consentimiento sin efecto, datos reales de pacientes fuera de producción, brechas de seguridad (Ley 25.326) o caída total del servidor o de Aurora Home. | Bloqueo inmediato. Resolución antes de fusionar la rama o finalizar el sprint. |
| **Alta (P2)** | Falla en un requerimiento funcional clave sin riesgo de vida inmediata. Ej: no registrar correctamente una respuesta ante estimulación cognitiva o desconexión no notificada de Aurora Home. Inexactitud en datos biográficos (IA). | Resolución obligatoria dentro del sprint activo. |
| **Media (P3)** | Errores en la visualización del historial, reportes desfasados visualmente, fallos menores de usabilidad o fallos en canales secundarios de notificación. | Se prioriza en el Backlog para el siguiente sprint. |
| **Baja (P4)** | Desalineamientos de UI, errores ortográficos en el dashboard, o sugerencias de optimización técnica de la latencia en las respuestas del sistema. | Resolución paulatina en tareas de mantenimiento. |

## 6. Ejecución y Revisión de Resultados

El proceso de testing no será una actividad al final del desarrollo, sino un control continuo:

- Ejecución Automática: Los test unitarios, de integración y evaluaciones automatizadas del pipeline RAG se integrarán en una canalización CI/CD (Continuous Integration / Continuous Deployment). Se ejecutarán automáticamente al generar un nuevo Pull Request hacia staging.
- Revisión por Pares (Code Review): Un desarrollador diferente al que escribió la funcionalidad deberá revisar el PR, verificando que los nuevos casos de prueba presentados cuenten con los criterios "Dado, Cuando, Entonces" (Given, When, Then). Se auditarán de manera especial los cambios en las reglas de seguridad y prompts de IA.
- Verificación de Aceptación (QA y UX): Durante la fase de Sprint Review, el equipo en su conjunto, junto con el Product Owner/Docentes, verificará la ejecución de los escenarios E2E más representativos del ciclo, simulando interacciones reales tanto desde la app del cuidador como desde la interfaz de voz (DOT).

## 7. Trazabilidad: requisito, función crítica y prueba

Cada función crítica se vincula con los requisitos que cubre, la prueba que la verifica y la métrica de la sección 4.

| **Requisito** | **Función crítica** | **Prueba** | **Métrica** | **Prioridad** |
| --- | --- | --- | --- | --- |
| **RF-36 a RF-46 (módulo 4); RNF-09, 10, 15 y 19** | Alerta por omisión | E2E de omisión y notificación entregada | 4.2 | P1 |
| **RF-01 a RF-14 (módulo 1); RNF-05** | Confirmación de recordatorio | Conjunto de frases etiquetadas | 4.3 | P1 |
| **RF-01 a RF-14** | STT con usuarios | Corpus de voz | 4.4 | P2 |
| **RNF-28 y RNF-38** | Resiliencia y recuperación | Escenarios de la tabla 4.5 | 4.5 | P1 |
| **RF-47 a RF-54; RNF-20 a RNF-24** | IA y RAG | Conjunto fijo de casos | 4.6 | P1 |
| **RF-92 a RF-98; RNF-44 a RNF-52** | Privacidad | Pruebas de los controles de 6.4 (Arquitectura) | Criterios de 6.4 | P1 y P2 |
| **RF-82 a RF-91; RNF-40 a RNF-43** | Rutinas y medicación | Pruebas de API y E2E de configuración | 100 % de escenarios críticos | P1 |

Los rangos de RF son los de los módulos de la matriz de trazabilidad (documento Trazabilidad RF-Épicas); el RF puntual de cada fila se verifica en ese documento.
