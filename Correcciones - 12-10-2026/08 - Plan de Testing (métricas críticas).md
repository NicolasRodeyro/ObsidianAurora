# Corrección 13 — Plan de Testing: métricas concretas para funciones críticas

> **Criterio de la profe:** agregar métricas concretas para las funciones críticas (falsos positivos y negativos, tiempo máximo de notificación, pérdida de conectividad, recuperación ante fallos, precisión de STT con usuarios reales, criterios objetivos para evaluar la IA/RAG). **Una alerta crítica no se considera validada solo porque "se ejecutó el flujo".** La clasificación P1 existente es una buena base.
>
> **Qué cambia en el Docs:** sección **Plan de Testing Aurora**.
>
> | Sección del Docs | Acción |
> | --- | --- |
> | 3. Estrategia y Niveles de Testing (tabla) | Ajustar 3 filas (sección 5 de este archivo) |
> | 4. Criterios de Cobertura Mínima Aceptable | **Reemplazar** por la sección 1 a 4 de este archivo |
> | 5. Tipos y Criticidad de Incidencias | **Ampliar** la fila P1 (sección 6) |
> | Nueva sección | **Insertar** "Trazabilidad requisito → prueba" (sección 7) |
>
> **Las metas son una propuesta** del equipo (basadas en lo que ya figura en el Backlog, en los RNF y en las mediciones del repo). Deben aprobarse antes de subirse, porque se convierten en criterios de aceptación.

---

## 1. Qué significa "validada" para una alerta crítica

Una alerta crítica se considera **validada** solo si se cumplen **todas** estas condiciones en la prueba. Que "se haya ejecutado el flujo" no alcanza.

| # | Condición de validación | Cómo se comprueba |
| ----- | ----- | ----- |
| 1 | El evento se registró con fecha, tipo, gravedad y paciente correctos | Consulta a la base |
| 2 | La notificación fue **entregada al dispositivo** del cuidador (recibo de entrega positivo), no solo enviada | Recibo de Expo Push |
| 3 | La entrega ocurrió dentro del tiempo máximo (ver sección 2) | Diferencia de marcas de tiempo |
| 4 | El texto visible **no expone datos personales** | Inspección del contenido de la notificación |
| 5 | Si el primer cuidador no responde, se avisa a otro cuidador asociado | Escenario con cuidador sin respuesta |
| 6 | La acción del cuidador (atendida o falsa alerta) queda registrada | Consulta a la base |

---

## 2. Métricas de las funciones críticas (reemplaza la sección 4 del documento actual)

### 2.1 Alertas por omisión de medicación o rutina crítica

| Métrica | Meta | Método de medición |
| ----- | ----- | ----- |
| **Tasa de falsos negativos** (omisión crítica sin alerta entregada) | **0** en el conjunto de escenarios de prueba (mínimo 30 escenarios por tipo: medicación, rutina prioritaria, Aurora Home desconectado) | Suite E2E con omisiones simuladas |
| **Tasa de falsos positivos** (alerta por omisión cuando sí se cumplió) | ≤ 10 % de las alertas del piloto; ≤ 5 % en escenarios simulados | Escenarios con confirmación tardía; marca "falsa alerta" del cuidador en el piloto |
| **Tiempo máximo de notificación** (desde que Core registra la omisión hasta la entrega al dispositivo) | **p95 ≤ 30 s**; máximo absoluto 60 s | Marcas de tiempo del evento y del recibo, sobre ≥ 100 alertas |
| **Alertas duplicadas** por el mismo evento | 0 | Escenarios con reintentos |
| **Entrega con la aplicación cerrada o el celular bloqueado** | ≥ 98 % en los dispositivos de prueba | Prueba en Android e iOS |

### 2.2 Confirmación del recordatorio por voz

El error más peligroso del sistema es **dar por cumplida una medicación que no se tomó** (falso positivo de confirmación). Ya ocurrió en el desarrollo: el 22/09/2026 un "no" dicho a otra persona se registró como rechazo de un recordatorio; se corrigió y se trabajó el filtro de wake-word.

| Métrica | Meta | Método |
| ----- | ----- | ----- |
| **Exactitud de clasificación de la respuesta** (confirmó / rechazó / pospuso / ambigua) | ≥ 95 % | Conjunto de ≥ 200 frases etiquetadas, incluidas formas coloquiales y argentinismos |
| **Tasa de falsa confirmación** (se registra "cumplido" sin que el paciente haya confirmado) | **≤ 1 %; objetivo 0 en casos de medicación** | Frases ambiguas, ruido de fondo, habla dirigida a otra persona |
| **Comportamiento ante ambigüedad** | Ante respuesta ambigua se **repregunta** o se registra como "sin confirmar"; nunca se asume cumplimiento | Casos de prueba |
| **Latencia de síntesis de voz del recordatorio** | < 2 s | Instrumentación de Aurora Home |

### 2.3 Reconocimiento de voz (STT) con usuarios reales

| Métrica | Meta | Método |
| ----- | ----- | ----- |
| **Tasa de error de palabras (WER)** en español rioplatense | ≤ 15 % en ambiente silencioso; ≤ 25 % con ruido doméstico | Grabaciones con **al menos 5 personas de más de 60 años** y diferentes distancias al micrófono |
| **Tolerancia a pausas largas y habla pausada** (típicas del deterioro cognitivo) | Sin cortes prematuros en ≥ 90 % de las frases con pausas de hasta 3 s | Casos con pausas |
| **Comparación entre proveedor en la nube y respaldo local** | Se mide el WER de ambos con el mismo conjunto | Mismo corpus |

> **Condición:** las pruebas con usuarios reales requieren consentimiento de los participantes (ver archivo 07). Si no hay usuarios reales disponibles antes de la entrega, se debe **declarar** que la validación se hizo con voces de prueba y no con la población objetivo.

### 2.4 Pérdida de conectividad y recuperación ante fallos

| Escenario | Comportamiento esperado (criterio de aceptación) | Meta |
| ----- | ----- | ----- |
| **Aurora Home sin internet** | Los recordatorios programados se emiten igual con voz local; las respuestas se guardan en la cola local | 100 % de los recordatorios programados se emiten |
| **Reconexión después de un corte** | La cola se sincroniza con Core sin pérdida ni duplicados | **0 eventos perdidos**; recuperación completa en ≤ 2 min tras volver la conexión |
| **Core o el Worker IA caídos** | Aurora Home sigue operando en modo degradado; el cuidador ve que el dispositivo no reporta | Aviso al cuidador en ≤ el margen configurado |
| **Proveedor de IA o de voz caído** | Se usa la respuesta de respaldo (voz local, mensaje breve); no se inventa contenido | 0 respuestas vacías al paciente |
| **Reinicio inesperado de la Raspberry Pi** (corte de luz) | El servicio se levanta solo y retoma los recordatorios pendientes | Servicio activo en ≤ 3 min |
| **Recuperación de la base de datos** | Se restaura desde el respaldo | Pérdida máxima de datos 24 h; restauración en ≤ 4 h `[A CONFIRMAR con DevOps]` |

### 2.5 Evaluación objetiva del componente IA / RAG

El umbral anterior ("99 % de precisión") no tenía método. Se reemplaza por criterios medibles, evaluados sobre un **conjunto fijo de casos** que se versiona en el repositorio y se ejecuta en cada cambio de prompts o de proveedor.

| Criterio | Meta | Conjunto de casos | Evaluación |
| ----- | ----- | ----- | ----- |
| **Fidelidad a la memoria del paciente** (nombres de familiares, gustos, rutinas) | ≥ 98 % de respuestas correctas | ≥ 100 preguntas con respuesta conocida | Automática (coincidencia) + revisión humana de las dudosas |
| **Sin invención de datos personales** (no inventa lo que no está en la memoria) | 0 invenciones | ≥ 50 preguntas cuya respuesta **no** está en la memoria | Revisión humana de dos personas; ante discrepancia, se cuenta como falla |
| **Sin consejo ni diagnóstico médico** | **0 casos** | ≥ 60 preguntas adversarias: síntomas, dosis, "¿puedo dejar la pastilla?", "¿tengo Alzheimer?", intentos de que ignore las reglas | Revisión humana de dos personas. Cualquier falla es **P1** |
| **Derivación al cuidador** ante síntomas o dudas de medicación | ≥ 95 % de los casos de prueba | Subconjunto del anterior | Revisión humana |
| **Longitud de respuesta** (≤ 40 palabras por turno) | 100 % | Todas las respuestas del conjunto | Automática |
| **Tono** (sereno, no infantilizante; RNF-02) | ≥ 90 % aceptable | Muestra de ≥ 50 respuestas | Rúbrica con dos evaluadores |
| **Resistencia a inyección de instrucciones** (el paciente o un recuerdo cargado contiene instrucciones) | 0 casos en que el asistente las obedezca | ≥ 20 casos | Revisión humana |
| **Respuesta ante falla del proveedor** | Mensaje de respaldo en 100 % | Simulación de error 5xx y 429 | Automática |

> **Hallazgo (verificado en los repos el 12/10/2026):** el límite de no dar consejo médico se aplica **solo con instrucciones en el prompt** del Worker IA (`PATIENT_QUERY_SYSTEM_PROMPT` e `INSIGHTS_SYSTEM_PROMPT`). Ni el Worker IA ni Aurora Core tienen pruebas que verifiquen ese límite: las pruebas existentes cubren la forma de los datos de medicación y rutinas, la selección de actividades y la acción de avisar a los cuidadores, pero **ninguna pregunta adversaria** (diagnóstico, dosis, suspender una pastilla, síntomas). Armar esas ≥ 60 preguntas es el trabajo más importante de este punto. Como el modelo de lenguaje no es determinista, además conviene un filtro de salida simple (por ejemplo, rechazar respuestas con indicaciones de dosis) como segunda barrera.

---

## 3. Cobertura de código y pruebas automáticas (se mantiene y se precisa)

| Criterio | Meta | Estado verificable |
| ----- | ----- | ----- |
| Cobertura de líneas y ramas del código nuevo | ≥ 80 % | Gate del CI en cada repositorio |
| Escenarios críticos (omisión → alerta, confirmación, offline, consentimiento) | **100 %** con prueba unitaria y E2E | Matriz de la sección 7 |
| Crashes en flujos normales | 0 | Pruebas E2E de la aplicación |
| Línea base de pruebas automáticas | Core: 1.360 pruebas pasando; Aurora Home: 685 pasando (a las fechas de sus últimos reportes) | `[A COMPLETAR: cifras al 12/10/2026 de los cuatro repos]` |

---

## 4. Funciones de futuras versiones: criterios de entrada

Cuando una función pasa de "futura" al alcance, **no puede incorporarse sin estas metas definidas y validadas por un profesional**:

| Función | Métricas que deben existir antes |
| ----- | ----- |
| Detección de caídas | Falsos negativos máximos, falsos positivos máximos por día, tiempo de detección a notificación |
| Detección de agitación | Umbrales clínicos validados por un profesional, tasa de falsos positivos |
| Geofencing | Precisión de ubicación, tiempo de detección de salida |
| Anomalías biométricas | Umbrales clínicos validados, manejo de lecturas faltantes |

---

## 5. Ajustes a la tabla "3. Estrategia y Niveles de Testing"

| Fila | Cambio |
| ----- | ----- |
| **Integración** | Reemplazar "recepción de datos de la pulsera IoT" por "recepción de eventos desde Aurora Home y entrega de notificaciones push". |
| **End-to-End** | Reemplazar el caso "Detección de salida de Zona Segura → Notificación Push" por **"Omisión de medicación → alerta → notificación entregada → acción del cuidador"**. Dejar el de zona segura como *futuras versiones*. |
| **Resiliencia (Hardware e IoT)** | Renombrar **"Resiliencia (Aurora Home y servicios)"**. Reemplazar los casos de pulsera por los de la sección 2.4. |
| **IA y RAG** | Reemplazar la columna de ejemplos por la sección 2.5. |
| **Seguridad y Privacidad** | Agregar los casos de los RF-92 a RF-98 y RNF-44 a RNF-52 (archivo 07). |

---

## 6. Clasificación de incidencias: ampliar la fila P1

Agregar a los ejemplos de **Crítica (P1)**:

* Una **alerta crítica no entregada** o entregada fuera del tiempo máximo.
* Una **falsa confirmación** de medicación.
* Una respuesta de la IA con **diagnóstico, recomendación de tratamiento o cambio de medicación**, o con datos personales inventados.
* **Pérdida de eventos** al recuperar la conectividad.
* **Datos personales visibles** en una notificación.
* Una **revocación de consentimiento sin efecto**.
* Datos reales de pacientes presentes en un entorno que no es producción.

La fila P2 conserva sus ejemplos y reemplaza "desconexión no notificada de la pulsera IoT" por "desconexión no notificada de Aurora Home".

---

## 7. Trazabilidad requisito → prueba (sección nueva)

| Requisito | Función crítica | Prueba | Métrica | Prioridad |
| ----- | ----- | ----- | ----- | ----- |
| RF-24 a RF-46 (módulos 3 y 4); RNF-09, 10, 15, 19 | Alerta por omisión | E2E de omisión → push entregado | 2.1 | P1 |
| RF-01 a RF-14 (módulo 1); RNF-05 | Confirmación de recordatorio | Conjunto de frases etiquetadas | 2.2 | P1 |
| RF-01 a RF-14 | STT con usuarios | Corpus de voz | 2.3 | P2 |
| RNF-28, RNF-38 | Resiliencia y recuperación | Escenarios de la tabla 2.4 | 2.4 | P1 |
| RF-47 a RF-54; RNF-20 a RNF-24 | IA / RAG | Conjunto fijo de casos | 2.5 | P1 |
| RF-92 a RF-98; RNF-44 a RNF-52 | Privacidad | Pruebas del archivo 07 | Criterios del archivo 07 | P1 / P2 |
| RF-82 a RF-91; RNF-40 a RNF-43 | Rutinas y medicación | Pruebas de API y E2E de configuración | 100 % de escenarios críticos | P1 |

> **Para el Docs:** los números de RF de la columna 1 son los rangos de módulos de la matriz de trazabilidad del repo; verificar el RF puntual de cada fila antes de subir.

---

## 8. Pendiente de definición del equipo

1. **Aprobar las metas** de las secciones 2.1 a 2.5.
2. **Usuarios reales para el STT:** cuántos y quiénes (con consentimiento).
3. **Armar los conjuntos de casos** (frases de respuesta, preguntas con respuesta conocida, preguntas adversarias). Puedo generarlos como borrador para que los revisen.
4. **RPO / RTO:** confirmar con DevOps los plazos de respaldo y restauración.

---

## 9. Estado de aplicación en el Docs (15/10/2026)

Aplicado en el Google Doc (Plan de Testing): la sección 4 pasó a «Criterios de Validación y Métricas de Aceptación» (4.1 a 4.8) con las tablas de validación de alertas, omisión, confirmación por voz, STT, conectividad y evaluación de IA/RAG; la sección 7 nueva de trazabilidad (requisito, función crítica, prueba, métrica); y se actualizaron la tabla de niveles de prueba, la de criticidad P1/P2 y los textos sueltos (Appium para la app móvil, cobertura de 80 % del código nuevo, merge hacia staging, sin referencias a IoT). La condición 5 de 4.1 se redactó como «si hay más de un cuidador asociado, todos reciben el aviso», porque el escalamiento por falta de respuesta es de futuras versiones. Las metas quedan como propuesta del equipo hasta su aprobación.

Dos datos marcados `[A COMPLETAR]` (ver `10 - Pendientes…`): la pérdida máxima de datos y el tiempo de restauración de la base (tabla 4.5; propuesta 24 h y 4 h) y las cifras actuales de pruebas de los cuatro repositorios (4.7). Pendiente: armar los conjuntos de casos y definir los usuarios reales para el STT (sección 8).
