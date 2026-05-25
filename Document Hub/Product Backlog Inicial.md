Las Historias de Usuario están estructuradas bajo el formato estándar ágil y agrupadas por Épicas arquitectónicas. Los criterios de aceptación representan los Requisitos No Funcionales (RNF) y las reglas de negocio.

---

#### Épica 1: Gestión del Entorno de Cuidado (Aurora Care & Core)

_Agrupa la configuración inicial del ecosistema y la carga de datos por parte del familiar._

**US 1.1 - Registro de Perfiles**

- **Historia:** Como cuidador principal, quiero registrar los datos médicos de un único paciente y los datos de contacto de otros cuidadores familiares, para centralizar la red de apoyo.

- **Criterios de Aceptación:**
  - El sistema debe permitir un solo perfil de paciente por instancia/hogar.

  - Los datos personales (nombre, DNI) deben almacenarse encriptados en la base de datos (Cumplimiento de Ley 25.326).

  - **Prioridad:** Alta (Crítica para el MVP).


**US 1.2 - Configuración de Rutinas y Biografía**

- **Historia:** Como cuidador, quiero ingresar los horarios de medicación, rutinas diarias y datos biográficos clave del paciente (gustos, nombres de familiares), para que el asistente de voz tenga contexto al interactuar con él.
    
- **Criterios de Aceptación:**
    
    - La interfaz debe permitir configurar alertas recurrentes (diarias, semanales).

    - El texto de la biografía debe sincronizarse exitosamente con la base de datos vectorial o caché de _Aurora Core_ para el uso del RAG.

- **Prioridad:** Alta.

#### Épica 2: Interacción Cognitiva y Asistencia por Voz (Aurora Home)

_Agrupa la lógica conversacional, el hardware en el borde (Edge) y el consumo del LLM._

**US 2.1 - Ejecución de Recordatorios Orales**

- **Historia:** Como paciente, quiero escuchar un recordatorio claro y amigable emitido por el parlante en el horario establecido por mi cuidador, para no olvidar mi medicación o mis hábitos diarios.

- **Criterios de Aceptación:**

    - El sistema de Texto-a-Voz (TTS) en la Raspberry Pi debe generar el audio en menos de 2 segundos.

    - Si el paciente responde "Ya la tomé", el sistema debe registrar el cumplimiento en _Aurora Care_.

- **Prioridad:** Alta

**US 2.2 - Ejercicios Cognitivos Guiados**

- **Historia:** Como paciente, quiero poder hablar con el asistente para realizar juegos de memoria cortos basados en mi historia de vida, para estimular mis funciones cognitivas sin frustrarme.

- **Criterios de Aceptación:**

    - Las respuestas del LLM deben limitarse a un máximo de 40 palabras por turno para no saturar auditivamente al paciente.

    - Si el paciente no responde tras 10 segundos, el micrófono debe cerrarse automáticamente para evitar la captura de ruido ambiente continuo.

- **Prioridad:** Media (Núcleo de valor, pero ejecutable tras las rutinas).

#### Épica 3: Monitoreo Físico y Telemetría (Aurora Band)

_Agrupa la integración del wearable comercial y los algoritmos de alertas._

**US 3.1 - Transmisión Biométrica Continua**

- **Historia:** Como _Aurora Core_, quiero extraer mediante API el ritmo cardíaco y las coordenadas GPS registradas por el wearable del paciente de forma periódica, para alimentar el motor de análisis de anomalías.

- **Criterios de Aceptación:**

    - El sistema debe realizar un _polling_ (consulta) o recibir un _webhook_ del wearable al menos cada 5 minutos.

    - Si la API del fabricante no responde, el sistema debe registrar un log de error sin bloquear el resto del ecosistema.

- **Prioridad:** Alta.

**US 3.2 - Alerta Temprana de Deambulación y Anomalías**

- **Historia:** Como cuidador, quiero recibir una notificación Push inmediata en mi celular si el paciente sale de la zona segura configurada o si sus signos vitales muestran estrés severo, para poder asistirlo de emergencia.

- **Criterios de Aceptación:**

    - La notificación Push debe llegar a la aplicación _Aurora Care_ en un tiempo menor a 30 segundos desde que _Aurora Core_ detecta la salida del Geofence.

    - La alerta debe incluir un acceso directo al mapa con las últimas coordenadas GPS conocidas.

- **Prioridad:** Alta.