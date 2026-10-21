# Corrección 4 — Un único alcance y un único MVP

> **Criterio de la profe:** mantener la **línea de corte del User Story Mapping** como referencia principal y asegurarse de que Plan de Proyecto, WBS, arquitectura, backlog y cronograma expresen el mismo MVP.
>
> **Estrategia:** el MVP se define **una sola vez** (sección 1) y todos los documentos remiten a esa definición. Después se corrige cada documento que hoy la contradice (sección 2).
>
> **Criterio adoptado (12/10/2026):** la línea de corte del User Story Mapping es la referencia, y se **actualiza con lo que Jira marca `mvp` y ya está implementado** (sección 4). Así el User Story Mapping describe lo que realmente se construyó.

---

## 1. Definición única del MVP (para incluir en el User Story Mapping y citarla desde los demás documentos)

La referencia es la matriz del User Story Mapping. Esta tabla la traduce a capacidades y se coloca **una sola vez**, justo debajo de la matriz, con el título **"Alcance del MVP vigente"**.

| Capacidad | MVP | Futuras versiones |
| ----- | :---: | :---: |
| Cuenta única del hogar (DOT), perfil del paciente y cuidadores con cuenta personal | ✅ | |
| Baja del perfil del paciente; permisos distintos por cuidador | | ✅ |
| Rutinas diarias (horario, frecuencia, prioridad) y carga de medicación indicada externamente | ✅ | |
| Pausas y reactivaciones automáticas de rutinas | | ✅ |
| Recordatorios por voz desde Aurora Home y registro de la respuesta del paciente | ✅ | |
| Carga de recuerdos, vínculos y datos biográficos validados por el cuidador | ✅ | |
| Ejercicios cognitivos simples y relatos de reminiscencia por voz | ✅ | |
| Ajuste automático de la dificultad de los ejercicios con una regla simple basada en la participación y el ánimo (AURA-77, finalizada) | ✅ | |
| Adaptación de la dificultad mediante un modelo de IA entrenado | | ✅ |
| Recuperación autónoma de recuerdos (RAG sin validación previa) | | ✅ |
| Estado actual del paciente y de los dispositivos; historial de cumplimiento y omisiones | ✅ | |
| Alerta al cuidador (notificación push) ante omisiones críticas de medicación o rutinas | ✅ | |
| Funcionamiento degradado sin internet en Aurora Home (**no figura en la matriz actual del User Story Mapping**: figura en el WBS 4.5 y en el ADR-008; agregarlo a la columna "Tareas del MVP") | ✅ | |
| Monitoreo biométrico, de movimiento y detección de caídas (Aurora Band) | | ✅ |
| Alta, edición y consulta de zonas seguras del paciente en el backend (AURA-86, finalizada; **sin pantalla en Aurora Care ni detección de salida**) | ✅ (parcial) | |
| Detección de agitación, deambulación y salida de zona segura (geofencing) | | ✅ |
| Llamadas telefónicas automáticas de emergencia y escalamiento por otros canales | | ✅ |
| Reportes exportables para uso médico (PDF, Excel) | | ✅ |
| Varios dispositivos por hogar / varios pacientes | | ❌ Fuera del alcance (ver archivo 03, corrección 6) |

---

## 2. Qué corregir en cada documento

| # | Documento y sección | Contradicción actual | Corrección |
| --- | ----- | ----- | ----- |
| 2.1 | **Estudio Inicial → Objetivo** | Presenta el módulo biométrico como parte de la solución integrada | Ya detallado en el archivo 01 (sección 4). |
| 2.2 | **Estudio Inicial → Propuesta → Alcance del sistema** | Mezcla en un solo párrafo funciones del MVP y de la visión (pulsera, eventos de riesgo, llamadas) | Reemplazar el último párrafo por: *"**Alcance del MVP:** gestión de la cuenta del hogar, del paciente y de los cuidadores; rutinas y medicación; recordatorios por voz con registro de respuestas; actividades cognitivas y de reminiscencia; alertas al cuidador ante omisiones críticas; historial de cumplimiento. **Futuras versiones:** monitoreo biométrico y de ubicación, detección de caídas y de agitación, zonas seguras, llamadas automáticas y reportes exportables. La línea de corte es la del User Story Mapping."* |
| 2.3 | **Estudio Inicial → Requerimientos Funcionales** (14 grupos) | Los 14 grupos se presentan al mismo nivel | Agregar a cada título el alcance: grupos 1 a 7, 12 (parcial), 13 (parcial) y 14 (acotado) → **MVP**; grupos 8 y 9 → **Futuras versiones**; grupo 11 → **MVP** (registrar, modificar y consultar zonas seguras) y **Futuras versiones** (detectar y notificar la salida); grupo 10 → **MVP** (alertas por omisión) y **Futuras versiones** (llamada automática y escalamiento). Dentro del grupo 2 marcar "Dar de baja el perfil" como **futura**; en el 12, "Generar y exportar resúmenes" como **futura**. |
| 2.4 | **Plan de Proyecto → 4.1 Descripción** | "Tres componentes principales: Aurora Home, **Aurora Band**, Aurora Care" | Reemplazar la lista por: *"1. Aurora Home (interfaz de voz). 2. Aurora Care (plataforma del cuidador). 3. Aurora Core (backend, orquestación e IA). La integración con un dispositivo corporal comercial (Aurora Band) queda como evolución futura."* Quitar de ese párrafo "análisis predictivo" y "caídas y deambulación". |
| 2.5 | **Plan de Proyecto → 4.2 Entregables** | Entregable 2 es el módulo Aurora Band. El 4 incluye "inferencia de caídas y deambulación (geofencing)" y "anonimización". El 1 dice "STT local" | **Entregable 2:** reemplazar por *"Integración con wearable comercial (Aurora Band), postergada: queda fuera del MVP por restricción presupuestaria (decisión del 29/08/2026)"*. **Entregable 4:** quitar "inferencia de caídas y deambulación (geofencing)". **Entregable 1:** reemplazar "lógica local para STT/TTS" por "pipeline de voz con proveedor en la nube y respaldo local" (ver archivo 06). |
| 2.6 | **Plan de Proyecto → 5. WBS** | Incluye el paquete 5 completo de Aurora Band, "filtrado de eventos biométricos" y "Gemini / Claude" | Reemplazar por la WBS corregida (sección 5). |
| 2.7 | **Plan de Proyecto → Cronograma y Sprint 3 y 4** | No menciona Aurora Band, pero el objetivo del Sprint 4 "flujos críticos" no aclara cuáles | Reemplazar el hito de la fila *Sprint 4* por **"Integrar los flujos críticos del MVP (recordatorio → respuesta → alerta al cuidador)"** y agregar una columna *Estado al 12/10/2026* con `[A COMPLETAR]`. Agregar la nota de numeración que ya figura en el Informe de Sprints (el campo "Sprint" de Jira no coincide con la numeración de la documentación). |
| 2.8 | **Plan de Proyecto → Reglas de Oro** | Habla de "Aurora Band" y "Aurora Care" como encargados | Cambiar "Aurora Care o Aurora Band" por "Aurora Care o Aurora Home". |
| 2.9 | **Product Backlog Inicial → Épica 3** | US 3.1 y 3.2 son de Aurora Band y geofencing, que están fuera del MVP | Reemplazar por las US de la sección 3. |
| 2.10 | **Product Backlog Inicial → encabezado** | No marca el alcance | Agregar: *"Las historias de esta versión son las del MVP. Las de futuras versiones están en la sección final y no se desarrollan."* |
| 2.11 | **Arquitectura → 2.2 Contenedores** | Incluye "Aurora Band Gateway" como contenedor | Marcarlo como *"No desplegado en el MVP"* (ver archivo 06). |
| 2.12 | **Plan de Testing → casos** | Casos de zona segura, pulsera y biometría como núcleo | Marcarlos "futuras versiones" (ver archivo 08). |
| 2.13 | **Glosario** | Define términos del MVP y de la visión sin distinguirlos | Agregar entre paréntesis "(futuras versiones)" a: *Datos biométricos*, *Deambulación errática*, *Geofencing*, *Zona segura*, *Comunicación de emergencia*. |
| 2.14 | **Resumen de Sprints** (sección "Desarrollo del Proyecto Aurora") | Tabla de stack lista Aurora Band como componente | Agregar la nota *"(fuera del MVP desde el 29/08/2026)"*. |

---

## 3. Texto para reemplazar: Product Backlog, Épica 3

### Épica 3: Seguimiento del estado y alertas al cuidador (Aurora Care y Core)

*Agrupa la visualización del estado del paciente, el historial de cumplimiento y las alertas por omisión. Reemplaza a la antigua épica "Monitoreo Físico y Telemetría (Aurora Band)", que pasa a futuras versiones.*

#### US 3.1 - Estado del paciente y de los dispositivos

* **Historia:** Como cuidador, quiero ver en Aurora Care el estado actual del paciente, las últimas interacciones y si Aurora Home está conectado, para saber que el sistema está funcionando aunque no esté en casa.
* **Criterios de Aceptación:**
  * La pantalla de inicio muestra el estado de Aurora Home (conectado, desconectado, última comunicación).
  * Si Aurora Home no se comunica durante el margen configurado, el cuidador ve una advertencia.
  * Solo se muestra información de las cuentas DOT en las que el cuidador está asociado.
* **Prioridad:** Alta.

#### US 3.2 - Alerta por omisión crítica de medicación o rutina

* **Historia:** Como cuidador, quiero recibir una notificación push inmediata si el paciente no confirma una medicación o rutina crítica en el margen configurado, para poder asistirlo o avisar a otra persona.
* **Criterios de Aceptación:**
  * La notificación llega a Aurora Care en menos de 30 segundos desde que Aurora Core registra la omisión.
  * Toda omisión crítica simulada en las pruebas genera una alerta (0 falsos negativos).
  * La notificación no expone datos sensibles en el texto visible (RNF-35).
  * El cuidador puede marcar la alerta como atendida o como falsa alerta.
* **Prioridad:** Alta.

#### US 3.3 - Historial de cumplimiento

* **Historia:** Como cuidador, quiero consultar el historial de cumplimiento y omisiones de medicación y rutinas, para entender la evolución del paciente y llevarla a la consulta médica.
* **Criterios de Aceptación:**
  * El historial se ordena por fecha y distingue cumplido, rechazado, pospuesto y omitido.
  * Los eventos no se eliminan físicamente; solo se registra su visibilidad (regla de negocio 9).
* **Prioridad:** Alta.

### Sección nueva al final del Backlog: Historias de futuras versiones (no se desarrollan en el MVP)

* **US F.1 - Transmisión biométrica continua** (la antigua US 3.1): extraer por API la frecuencia cardíaca y las coordenadas GPS de un wearable comercial.
* **US F.2 - Alerta temprana de deambulación y anomalías** (la antigua US 3.2): notificación push al salir de la zona segura configurada o ante estrés severo. **Requiere validación de umbrales por un profesional** (ver archivo 02).

---

## 4. Actualización de la línea de corte del User Story Mapping (decidido el 12/10/2026)

**Criterio acordado:** la línea de corte del User Story Mapping es la referencia, pero se actualiza con lo que **Jira marca como parte del MVP y que ya está implementado**. Así el documento describe lo que realmente se construyó y no contradice a Jira ni al código.

| Funcionalidad | Jira (estado al 12/10/2026) | Evidencia en el código | Decisión |
| ----- | ----- | ----- | ----- |
| **Dificultad adaptativa** | AURA-77, `mvp`, **Finalizada** | `AuroraCore/apps/ai/difficulty.py`: regla determinista (participación + ánimo, ventana de 5 sesiones) | **Entra al MVP** como regla simple. La adaptación "mediante un modelo de IA" sigue como futura |
| **Zonas seguras (alta, edición y consulta)** | AURA-86, `mvp`, **Finalizada** | API REST `patients/safe-zones` en Core. En Aurora Care **no encontré una pantalla** para gestionarlas | **Entra al MVP parcial** (solo el backend). La **detección de salida y la notificación** siguen como futuras |
| **Consulta de la memoria del paciente (RAG con memorias validadas por el cuidador)** | AURA-105 y AURA-171, **Finalizadas**; AURA-104 en revisión | Endpoint de consulta de contexto en Core; Home lo usa como responder de conversación | **Ya es MVP** (la memoria la valida el cuidador, regla de negocio 6). El **RAG autónomo, sin validación previa**, sigue como futuro |
| **n8n** | AURA-145, **Finalizada** (autoalojado en el VPS) | Dispara las interacciones diarias | **Componente del MVP (acotado)**. La épica AURA-21, "Orquestación y Automatización" general, sigue como `vision` |
| **Drop-in (audio remoto autorizado)** | AURA-134 **En revisión**; AURA-174 finalizada; AURA-173 (error) abierto | Contrato y endpoints en Core y Care; regla de negocio 15 | **Candidata al MVP**: entra cuando AURA-134 se cierre. Mientras tanto se lista como "en revisión" |

### Texto de la matriz del User Story Mapping (celdas que cambian)

| Celda | Texto nuevo |
| ----- | ----- |
| **Tareas del MVP → Gestión de Cuenta y Perfiles** (agregar al final) | "Registrar las zonas seguras del paciente (solo configuración)." |
| **Tareas del MVP → Terapia Cognitiva y Reminiscencia** (agregar al final) | "Ajustar la dificultad de los ejercicios con una regla simple según la participación y el ánimo del paciente." |
| **Futuras versiones → Terapia Cognitiva y Reminiscencia** (reemplaza la frase de la dificultad) | "Adaptar la dificultad de los ejercicios mediante un modelo de IA entrenado." |
| **Futuras versiones → Monitoreo, Historial y Alertas** (reemplaza la frase del geofencing) | "Detectar la salida del paciente de las zonas seguras y notificar al cuidador (geofencing)." |

### Historia nueva para el Backlog (la dificultad adaptativa ya es MVP)

#### US 2.3 - Dificultad adaptativa de las actividades

* **Historia:** Como paciente, quiero que los ejercicios se ajusten a cómo me va, para no frustrarme ni aburrirme.
* **Criterios de Aceptación:**
  * El sistema propone un nivel (bajo, medio o alto) a partir de las últimas 5 sesiones, considerando la participación y el ánimo.
  * Si no hay datos suficientes, no cambia el nivel y lo registra como "datos insuficientes".
  * La decisión queda registrada una vez por día (sin duplicados) y es auditable (RNF-24).
  * La regla no modifica el catálogo de actividades.
* **Prioridad:** Media.

---

## 5. Texto para reemplazar: "5. Estructura WBS - Work Breakdown Structure"

Cambios respecto de la WBS actual: se **quita el paquete 5 (Aurora Band)** y se lo pasa a una sección de futuras versiones; se corrigen los ítems 2.2 y 2.3 (proveedor de IA; sin eventos biométricos); el 3.4 deja de incluir reportes; el 4.3 refleja que la voz usa un proveedor en la nube con respaldo local.

1. **Gestión del Proyecto y Documentación Académica**
   1. Instancia 1: Estudio Inicial y Plan de Proyecto
   2. Instancia 2: Working Agreement, Arquitectura y Product Backlog
   3. Instancia 3: Informes de Sprint y Trazabilidad (Sprints 1 a N)
   4. Instancias 4 y 5: Paper, póster, video y documentación final
2. **Ingeniería de Datos e Inteligencia Artificial (Aurora Core y Worker IA)**
   1. Diseñar el esquema de base de datos (Supabase / PostgreSQL)
   2. Configuración de la integración con el proveedor de modelos de lenguaje (configurable por entorno)
   3. Lógica de negocio: rutinas, medicación, recordatorios y registro de respuestas
   4. Ingeniería de prompts y memoria del paciente para terapias cognitivas y reminiscencia
   5. Lógica de alertas por omisión crítica y clasificación de eventos del MVP
3. **Interfaces de Usuario (Aurora Care)**
   1. Diseño UX/UI de la aplicación (Figma)
   2. Desarrollo del frontend React Native + Expo
   3. Notificaciones push nativas
   4. Pantallas de estado del paciente, dispositivos e historial de cumplimiento
4. **Hardware e Interfaz de Voz (Aurora Home)**
   1. Ensamblado y configuración del sistema operativo en la Raspberry Pi 5
   2. Integración de periféricos (módulo de audio, micrófonos, indicadores LED)
   3. Pipeline de voz: transcripción (STT) y síntesis (TTS) con proveedor en la nube y respaldo local
   4. Lógica de interacción vocal y de ejecución de actividades
   5. Modo offline y cola de eventos pendientes
5. **Aseguramiento de la Calidad (Testing) y DevOps**
   1. Configuración de entornos (desarrollo, staging, producción)
   2. Pipeline de integración y despliegue continuo (CI/CD)
   3. Pruebas unitarias, de integración y E2E, incluida la evaluación de la IA
6. **Lanzamiento y Aspectos Legales**
   1. Términos y Condiciones y Política de Privacidad de datos de salud
   2. Gestión de consentimiento y derechos sobre los datos
   3. Pruebas piloto con usuarios reales

**Futuras versiones (fuera del MVP, no se desarrollan en este proyecto)**

7. **Integración de dispositivo biométrico (Aurora Band)**: conexión y consumo de la API del wearable, normalización de signos vitales y gateway de datos hacia Aurora Core.
8. **Detección de eventos de riesgo**: caídas, deambulación, agitación y zonas seguras (geofencing), con umbrales validados por profesionales.
9. **Comunicación de emergencia**: llamadas automáticas y escalamiento por otros canales.
10. **Reportes**: resúmenes exportables para uso médico.
