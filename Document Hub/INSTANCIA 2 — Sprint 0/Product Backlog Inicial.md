---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-16
---

# Product Backlog Inicial - Aurora

## Introducción

Este documento contiene el Product Backlog inicial de Aurora (Instancia 2): épicas e historias de usuario con sus criterios de aceptación, prioridad y estimación. Las épicas 1 a 3 son las del backlog original; las épicas 4 a 9 completan los módulos del MVP y se relacionan con las épicas de Jira y con los requerimientos del Estudio Inicial.

Estimación: cada historia indica su tamaño en puntos de historia (escala 1, 2, 3, 5 y 8), a criterio del equipo y sin una técnica formal. Como referencia, 3 puntos equivalen a una pantalla con lógica propia, como el Login de Aurora Care (AURA-54). Las historias 1.1 y 1.2 suman las estimaciones que figuran en Jira para sus módulos; las demás son una propuesta pendiente de confirmación por el equipo.

## Audiencia

Está dirigido al Product Owner, que lo prioriza, al equipo de desarrollo, que lo usa para planificar los sprints, y a los docentes, para evaluar el alcance y el criterio de valor.

Las Historias de Usuario están estructuradas bajo el formato estándar ágil y agrupadas por Épicas arquitectónicas. Los criterios de aceptación representan los Requisitos No Funcionales (RNF) y las reglas de negocio.

## Épica 1: Gestión del Entorno de Cuidado (Aurora Care & Core)

*Agrupa la configuración inicial del ecosistema y la carga de datos por parte del familiar.*

### US 1.1 - Registro de Perfiles

- **Historia:** Como cuidador principal, quiero crear o configurar la cuenta DOT del hogar, registrar los datos de un único paciente y asociar otros cuidadores con cuentas personales, para centralizar la red de apoyo y controlar el acceso a Aurora Care.
- **Criterios de Aceptación:**
  - Los datos personales (nombre, DNI) deben almacenarse encriptados en la base de datos (Cumplimiento de Ley 25.326).
  - El sistema debe permitir un solo perfil de paciente por cuenta DOT/hogar.
  - Cada cuidador debe acceder a Aurora Care con una cuenta personal.
  - Un cuidador solo puede ingresar a cuentas DOT en las que esté asociado.
  - La cuenta DOT debe permitir más de un cuidador asociado.
- **Prioridad:** Alta (Crítica para el MVP).
- **Estimación:** 5 puntos de historia (Login de Aurora Care, 3, y módulo Paciente, 2: AURA-54 y AURA-55).

### US 1.2 - Configuración de Rutinas y Biografía

- **Historia:** Como cuidador, quiero ingresar los horarios de medicación, rutinas diarias y datos biográficos clave del paciente (gustos, nombres de familiares), para que el asistente de voz tenga contexto al interactuar con él.
- **Criterios de Aceptación:**
  - La interfaz debe permitir configurar alertas recurrentes (diarias, semanales).
  - El texto de la biografía debe sincronizarse exitosamente con la base de datos vectorial o caché de *Aurora Core* para el uso del RAG.
- **Prioridad:** Alta.
- **Estimación:** 4 puntos de historia (módulos Recordatorios y Recetario, 2 cada uno: AURA-57 y AURA-58).

## Épica 2: Interacción Cognitiva y Asistencia por Voz (Aurora Home)

*Agrupa la lógica conversacional, el hardware en el borde (Edge) y el consumo del LLM.*

### US 2.1 - Ejecución de Recordatorios Orales

- **Historia:** Como paciente, quiero escuchar un recordatorio claro y amigable emitido por el parlante en el horario establecido por mi cuidador, para no olvidar mi medicación o mis hábitos diarios.
- **Criterios de Aceptación:**
  - El sistema de Texto-a-Voz (TTS) en la Raspberry Pi debe generar el audio en menos de 2 segundos.
  - Si el paciente responde "Ya la tomé", el sistema debe registrar el cumplimiento en *Aurora Care*.
- **Prioridad:** Alta.
- **Estimación:** 5 puntos de historia (propuesta).

### US 2.2 - Ejercicios Cognitivos Guiados

- **Historia:** Como paciente, quiero poder hablar con el asistente para realizar juegos de memoria cortos basados en mi historia de vida, para estimular mis funciones cognitivas sin frustrarme.
- **Criterios de Aceptación:**
  - Las respuestas del LLM deben limitarse a un máximo de 40 palabras por turno para no saturar auditivamente al paciente.
  - Si el paciente no responde tras 10 segundos, el micrófono debe cerrarse automáticamente para evitar la captura de ruido ambiente continuo.
- **Prioridad:** Media (Núcleo de valor, pero ejecutable tras las rutinas).
- **Estimación:** 5 puntos de historia (propuesta).

## Épica 3: Monitoreo Físico y Telemetría (Aurora Band) — futuras versiones, fuera del MVP

*Agrupa la integración del wearable comercial y los algoritmos de alertas. Fuera del MVP desde la decisión del 29/08/2026: se conserva como visión de futuras versiones y sus historias no se desarrollan en este ciclo.*

### US 3.1 - Transmisión Biométrica Continua

- **Historia:** Como *Aurora Core*, quiero extraer mediante API el ritmo cardíaco y las coordenadas GPS registradas por el wearable del paciente de forma periódica, para alimentar el motor de análisis de anomalías.
- **Criterios de Aceptación:**
  - El sistema debe realizar un *polling* (consulta) o recibir un *webhook* del wearable al menos cada 5 minutos.
  - Si la API del fabricante no responde, el sistema debe registrar un log de error sin bloquear el resto del ecosistema.
- **Prioridad:** Alta (futuras versiones, fuera del MVP).
- **Estimación:** no estimada: fuera del MVP.

### US 3.2 - Alerta Temprana de Deambulación y Anomalías

- **Historia:** Como cuidador, quiero recibir una notificación Push inmediata en mi celular si el paciente sale de la zona segura configurada o si sus signos vitales muestran estrés severo, para poder asistirlo de emergencia.
- **Criterios de Aceptación:**
  - La notificación Push debe llegar a la aplicación *Aurora Care* en un tiempo menor a 30 segundos desde que *Aurora Core* detecta la salida del Geofence.
  - La alerta debe incluir un acceso directo al mapa con las últimas coordenadas GPS conocidas.
- **Prioridad:** Alta (futuras versiones, fuera del MVP).
- **Estimación:** no estimada: fuera del MVP.

## Épica 4: Alertas y Comunicación con el Cuidador (Aurora Core y Aurora Care)

Agrupa el aviso al cuidador cuando una medicación o una rutina importante no se cumple, y la gestión de esa alerta. Épica de Jira AURA-16; módulo 4 de los requerimientos (RF-36 a RF-46). El escalamiento por falta de respuesta y las llamadas automáticas son de futuras versiones.

### US 4.1 - Alerta por omisión de medicación o rutina crítica

- **Historia:** Como cuidador, quiero recibir una notificación push en mi celular cuando el paciente no confirma una medicación o una rutina importante dentro del margen configurado, para poder asistirlo a tiempo.
- **Criterios de Aceptación:**
  - La omisión se registra con fecha, tipo, gravedad y paciente.
  - La notificación llega al dispositivo en un tiempo p95 de hasta 30 segundos desde que Aurora Core registra la omisión (ver Plan de Testing, 4.2).
  - El texto visible de la notificación no contiene datos personales (RF-98).
  - Un mismo evento no genera alertas duplicadas.
  - Si hay más de un cuidador asociado, todos los configurados reciben el aviso.
- **Prioridad:** Alta (Crítica para el MVP).
- **Estimación:** 5 puntos de historia (propuesta).
- **Jira:** AURA-106.

### US 4.2 - Atención y cierre de la alerta

- **Historia:** Como cuidador, quiero marcar una alerta como atendida o como falsa alerta, para que el sistema registre qué ocurrió y no vuelva a avisarme por lo mismo.
- **Criterios de Aceptación:**
  - Queda registrado quién atendió la alerta y cuándo.
  - El cierre de la alerta muestra los datos reales y no datos de demostración.
  - La marca «falsa alerta» alimenta la métrica de falsos positivos (Plan de Proyecto, 3.1).
- **Prioridad:** Alta.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-96.

### US 4.3 - Vista de alertas en tiempo real

- **Historia:** Como cuidador, quiero ver las alertas del hogar ordenadas por gravedad y actualizadas sin recargar la pantalla, para saber qué requiere atención primero.
- **Criterios de Aceptación:**
  - La lista muestra gravedad, hora y estado de cada alerta.
  - El detalle de la alerta ofrece las acciones disponibles.
  - Si falla la carga, la pantalla lo informa y no muestra «todo en orden».
- **Prioridad:** Alta.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-107.

## Épica 5: Motor de IA y Memoria del Paciente (Aurora Core y Worker IA)

Agrupa la memoria validada del paciente y las respuestas del asistente, con los límites de seguridad clínica. Épica de Jira AURA-15; módulo 5 de los requerimientos (RF-47 a RF-54).

### US 5.1 - Memoria contextual del paciente

- **Historia:** Como cuidador, quiero cargar y validar recuerdos, vínculos familiares y datos biográficos del paciente, para que el asistente converse con información real y no inventada.
- **Criterios de Aceptación:**
  - Solo los recuerdos validados por el cuidador alimentan las respuestas del asistente.
  - Cada recuerdo puede llevar una foto.
  - La memoria se guarda en la base de datos del sistema, con búsqueda por similitud (pgvector).
- **Prioridad:** Alta.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-104.

### US 5.2 - Respuesta del asistente con el contexto del paciente

- **Historia:** Como paciente, quiero que el asistente me responda con datos de mi vida (nombres de familiares, gustos, rutinas), para sentirme acompañado.
- **Criterios de Aceptación:**
  - Responde con información de la memoria validada y no inventa datos personales.
  - No da consejo ni diagnóstico médico; ante síntomas o dudas de medicación remite al cuidador.
  - Las respuestas tienen hasta 40 palabras por turno.
  - Ante una falla del proveedor de IA, el asistente usa un mensaje de respaldo (ver Plan de Testing, 4.6).
- **Prioridad:** Alta (Crítica para el MVP).
- **Estimación:** 5 puntos de historia (propuesta).
- **Jira:** AURA-105.

### US 5.3 - Dificultad adaptativa de las actividades

- **Historia:** Como cuidador, quiero que Aurora ajuste la dificultad de las actividades según la participación y el ánimo del paciente, para que no se frustre ni se aburra.
- **Criterios de Aceptación:**
  - La regla se basa en las últimas 5 sesiones del paciente.
  - El cuidador puede ver el ajuste aplicado.
  - La regla es de software; los criterios clínicos se validan con la psicopedagoga (Estudio Inicial, matriz de reglas, S5).
- **Prioridad:** Media.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-77.

## Épica 6: Administración de Rutinas y Medicación (Aurora Care y Aurora Core)

Agrupa la carga de la medicación, el registro de su cumplimiento y las sesiones diarias de actividades. Épica de Jira AURA-17; módulo 9 de los requerimientos (RF-82 a RF-91). La configuración de rutinas está en la US 1.2.

### US 6.1 - Medicación y recetario del paciente

- **Historia:** Como cuidador, quiero cargar y mantener la medicación indicada por el profesional (fármaco, dosis y horarios), para que Aurora la recuerde a horario.
- **Criterios de Aceptación:**
  - La medicación solo la carga o la valida un cuidador; el asistente no puede crearla ni modificarla.
  - Los horarios generan recordatorios automáticos.
  - Cada alta o cambio de medicación queda registrado.
- **Prioridad:** Alta (Crítica para el MVP).
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-88 y AURA-80.

### US 6.2 - Registro de cumplimiento

- **Historia:** Como cuidador, quiero ver si el paciente cumplió, rechazó o pospuso cada rutina y cada medicación, para llevar un historial confiable.
- **Criterios de Aceptación:**
  - Cada respuesta del paciente queda registrada con fecha y hora.
  - El historial se puede consultar por día.
  - Un recordatorio sin respuesta se registra como omisión.
- **Prioridad:** Alta.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-89.

### US 6.3 - Sesiones diarias de actividades

- **Historia:** Como paciente, quiero recibir cada día una sesión breve de actividades preparada para mí, para sostener mi rutina de estimulación.
- **Criterios de Aceptación:**
  - Aurora Core genera la sesión diaria a partir del plan de terapia del paciente.
  - Aurora Home ejecuta la sesión y reporta cuándo empieza y cuándo termina.
  - Sin conexión se usa el último plan descargado.
- **Prioridad:** Media.
- **Estimación:** 5 puntos de historia (propuesta).
- **Jira:** AURA-149 y AURA-172.

## Épica 7: Panel del Cuidador (Aurora Care)

Agrupa las vistas con las que el cuidador sigue el estado del paciente y del dispositivo. Épica de Jira AURA-18; módulo 7 de los requerimientos (RF-60 a RF-75).

### US 7.1 - Estado actual del hogar

- **Historia:** Como cuidador, quiero ver de un vistazo el estado del paciente y de Aurora Home, para saber si todo está en orden.
- **Criterios de Aceptación:**
  - Muestra los próximos recordatorios, el último cumplimiento y las alertas abiertas.
  - Indica si Aurora Home no está reportando.
  - Si falla la carga, lo informa en lugar de mostrar «todo en orden».
- **Prioridad:** Alta.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-85 y AURA-108.

### US 7.2 - Métricas e historial del paciente

- **Historia:** Como cuidador, quiero consultar estadísticas del cumplimiento y de la participación del paciente, para llevar información ordenada a la consulta médica.
- **Criterios de Aceptación:**
  - Las métricas se calculan de forma determinista sobre el historial.
  - Los resúmenes generados por IA se identifican como tales.
  - Las etiquetas y los datos se muestran en español.
- **Prioridad:** Media.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-167 y AURA-168.

## Épica 8: Seguridad, Privacidad y Cumplimiento (Ley 25.326)

Agrupa el consentimiento, la protección de los datos y el control de acceso. Épica de Jira AURA-20; módulo 8 de los requerimientos (RF-76 a RF-81 y RF-92 a RF-98).

### US 8.1 - Consentimiento informado y revocable

- **Historia:** Como cuidador, quiero registrar el consentimiento informado antes de usar Aurora y poder revocarlo, para que el tratamiento de los datos sea legítimo.
- **Criterios de Aceptación:**
  - Sin consentimiento no se activa el servicio.
  - Se guarda el tipo de consentimiento, la versión del texto, el alcance y la fecha.
  - Se usan tres consentimientos separados: datos de salud, transferencia internacional y datos del cuidador.
  - La revocación suspende el tratamiento de los datos en 24 horas.
- **Prioridad:** Alta (Crítica para el MVP).
- **Estimación:** 5 puntos de historia (propuesta).
- **Jira:** AURA-109, AURA-169 y AURA-170.

### US 8.2 - Cifrado de datos identificatorios

- **Historia:** Como titular de los datos, quiero que mi nombre, mi DNI y mis contactos se guarden cifrados, para que no queden expuestos ante una filtración.
- **Criterios de Aceptación:**
  - El cifrado se hace en la aplicación (Fernet, ADR-010).
  - La búsqueda por nombre se hace por hash.
  - La clave de cifrado es obligatoria en producción.
- **Prioridad:** Alta.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-93 y AURA-121.

### US 8.3 - Control de acceso por hogar

- **Historia:** Como cuidador, quiero acceder solo a los hogares a los que fui asociado, para proteger la privacidad de los pacientes.
- **Criterios de Aceptación:**
  - Una cuenta revocada recibe 403.
  - Una escritura sobre un hogar no asociado recibe 403.
  - La autenticación valida el JWT emitido por Supabase Auth.
- **Prioridad:** Alta.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-82 y AURA-120.

### US 8.4 - Derechos del titular y depuración de datos

- **Historia:** Como titular de los datos, quiero pedir el acceso, la rectificación o la supresión de mis datos, para ejercer mis derechos.
- **Criterios de Aceptación:**
  - El acceso se resuelve en 10 días corridos; la rectificación o la supresión, en 5 días hábiles.
  - Cada solicitud queda registrada con tipo, estado y responsable.
  - Los datos que superan su plazo de retención se depuran automáticamente (RF-94 y RF-96).
- **Prioridad:** Media. Pendiente de implementación.
- **Estimación:** 5 puntos de historia (propuesta).

## Épica 9: Orquestación y Automatización (MVP acotado)

Agrupa la automatización de las interacciones diarias. Épica de Jira AURA-21; módulo 6 de los requerimientos (RF-55 a RF-59). En el MVP el alcance es acotado; los flujos de automatización más complejos son de futuras versiones.

### US 9.1 - Disparo programado de interacciones diarias

- **Historia:** Como cuidador, quiero que Aurora inicie sola las interacciones del día en los horarios configurados, para no tener que activarlas a mano.
- **Criterios de Aceptación:**
  - El orquestador (n8n) dispara las interacciones diarias en los horarios configurados.
  - Si el servicio de orquestación falla, Aurora Home sigue ejecutando los recordatorios ya programados.
- **Prioridad:** Media.
- **Estimación:** 3 puntos de historia (propuesta).
- **Jira:** AURA-145.

## Documentos relacionados
- [[Requerimientos]]
- [[Trazabilidad RF-Épicas]]
- [[Tablero Jira]]
- [[Índice Aurora]]
