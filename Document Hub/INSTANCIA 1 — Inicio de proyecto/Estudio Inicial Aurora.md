---
base: "[[Document Hub.base]]"
Category:
  - Análisis
Last updated time: 2026-07-09
---

# Estudio Inicial Aurora

## Objetivo

El objetivo de este proyecto es diseñar y desarrollar un sistema de asistencia tecnológica integral para el hogar, orientado a personas con deterioro cognitivo leve o pérdida de memoria. La solución propone la transición de un esquema de cuidado **reactivo y presencial** hacia un modelo de **acompañamiento proactivo** basado en la automatización de tareas de soporte.

Para ello, se desarrollará una solución tecnológica que integra:

* Una **interfaz de interacción por voz (VUI)** dedicada a la asistencia en rutinas diarias, recordatorios y ejecución de protocolos de estimulación cognitiva.
* Un módulo de **procesamiento de datos biométricos** mediante dispositivos *wearables* con capacidad de medición biométrica, permitiendo el análisis de patrones en tiempo real.

El sistema utiliza algoritmos de inteligencia artificial para personalizar las actividades de estimulación y detectar desviaciones en los patrones de comportamiento o variables biométricas del usuario. El propósito final es incrementar la autonomía del paciente y optimizar la gestión del cuidado por parte del entorno familiar, centralizando la supervisión en una interfaz digital que prioriza las alertas basadas en eventos validados por el sistema.

**Aclaración:** *"El alcance de la tesis se centra en el procesamiento y la lógica de detección del software. El sistema está diseñado para ser agnóstico al modelo de hardware, asumiendo que la confiabilidad del dato biométrico es responsabilidad de la capa de hardware certificada."*

## Contexto y Problema a Validar

Las personas con deterioro cognitivo o pérdida de memoria pueden presentar dificultades para recordar actividades cotidianas, mantener rutinas, orientarse temporalmente, tomar medicación, hidratarse, alimentarse o realizar tareas básicas del día a día. Estas dificultades afectan la autonomía del paciente y aumentan la carga sobre el cuidador. En muchos casos, el cuidador no puede estar presente todo el tiempo, lo que provoca incertidumbre sobre el estado del paciente y sobre el cumplimiento de sus rutinas.

En muchos hogares, el cuidado se organiza de forma manual: recordatorios verbales, anotaciones, mensajes entre familiares y supervisión presencial. Esto genera dependencia de la disponibilidad del cuidador y dificulta conservar un historial ordenado de lo que ocurre día a día.

El problema principal que Aurora busca validar es si un sistema de apoyo domiciliario puede ayudar a la rehabilitación cognitiva, el acompañamiento de rutinas, recordatorios, actividades significativas que pueden favorecer la autonomía y el desempeño cotidiano de personas con demencia o deterioro cognitivo.

## Ámbito de Aplicación

Aurora se aplicará exclusivamente en hogares particulares donde resida una persona con deterioro cognitivo leve o pérdida de memoria. El sistema asiste a un paciente por hogar, acompañado por uno o más cuidadores familiares o responsables.

Condiciones del paciente contempladas:

* Daño cerebral adquirido, que les haya causado alguna discapacidad:
  * ACV (Accidente Cerebrovascular).
  * TCE (Traumatismo Craneoencefálico)
  * Tumores cerebrales.
  * Hipoxia (bloqueo del suministro de oxígeno al tejido cerebral)
* Enfermedades neurodegenerativas:
  * Enfermedad de Alzheimer (la más común)
  * Párkinson.
  * Esclerosis Múltiple.
  * Y otras demencias.

Restricción sobre el estado del paciente: el sistema está orientado a pacientes con un grado de deterioro menor a la etapa 5 de la Escala Global de Deterioro (GDS), donde aún existe capacidad de interacción básica y aprovechamiento del entrenamiento cognitivo.

El sistema no estará destinado, en esta primera etapa, a instituciones geriátricas, hospitales, centros de cuidado ni entornos con múltiples pacientes. Tampoco reemplaza la atención médica profesional, sino que funciona como una herramienta de apoyo al cuidado diario.

## Procesos Involucrados

El proceso inicia cuando el paciente se encuentra realizando sus actividades cotidianas dentro del hogar. El sistema monitorea información proveniente del ambiente del hogar: voz, actividad, ubicación, datos biométricos y la configuración previa realizada por el cuidador. Esta configuración comprende el establecimiento de los parámetros y el contexto específico del paciente, tales como su **nivel de avance de la enfermedad**, sus recuerdos personales para fortalecer la reminiscencia, sus rutinas habituales y cualquier dato clínico relevante que permita al sistema personalizar la asistencia y las interacciones de manera precisa.

A partir de estos datos, el sistema interpreta el estado del paciente y determina si debe intervenir. Si detecta una rutina programada, una necesidad de acompañamiento o un evento de riesgo, ejecuta una acción: emitir un recordatorio, iniciar una interacción, registrar un evento o generar una alerta.

En caso de eventos o alertas críticas, el sistema clasifica la gravedad del evento según el nivel de riesgo detectado para la integridad del paciente. Luego el sistema notifica al cuidador mediante los canales que configuró, escalando el aviso en caso de no obtener respuesta inmediata. Luego, el incidente queda registrado para su posterior consulta, análisis de patrones y seguimiento médico.

### Flujos de procesos

1. El cuidador configura rutinas, medicación, zonas seguras (mediante la delimitación de perímetros virtuales (Geofencing) sobre un mapa en la interfaz de la aplicación móvil) y contactos de emergencia.
2. El paciente permanece en el hogar realizando sus actividades diarias.
3. El sistema monitorea voz, actividad, ubicación y datos biométricos.
4. El sistema interpreta el estado del paciente correlacionando fuentes de voz (NLP: Procesamiento de Lenguaje Natural), ubicación y signos vitales para detectar estabilidad o crisis.
5. El sistema evalúa si existe una rutina, necesidad o evento de riesgo.
6. Si no hay situación relevante—entendida como cualquier anomalía biométrica, el incumplimiento de una rutina programada o la detección de un evento de riesgo (como una caída o salida de la zona segura)—, continúa el monitoreo.
7. Si hay una situación relevante, ejecuta una acción.
8. La acción puede ser un recordatorio, interacción, alerta o registro.
9. Si corresponde, se clasifica la gravedad del evento.
10. El cuidador recibe una notificación o llamada.
11. El evento queda registrado.
12. El cuidador consulta el estado, historial o seguimiento del paciente.

### Participantes

| Participante | Descripción |
| ----- | ----- |
| **Paciente** | Persona con pérdida de memoria o deterioro cognitivo que recibe asistencia en el hogar |
| **Cuidador** | Familiar o responsable que configura rutinas, consulta información y responde ante alertas |
| **Profesional de la Salud** | Actor externo que indica tratamientos o pautas, pero no opera directamente con el sistema. |

### Información que maneja el sistema

El sistema maneja información sensible y operativa relacionada con el paciente y su cuidado diario.

* **Información del paciente:**
  * Datos personales básicos.
  * Perfil del paciente.
  * Preferencias del usuario.
  * Recuerdos personales.
  * Vínculos familiares.
  * Rutinas diarias.
  * Medicación y tratamientos.
* **Información biométrica y de actividad (según disponibilidad pulsera IOT):**
  * Frecuencia cardíaca.
  * Movimiento.
  * Ubicación.
  * Temperatura corporal
  * Actividad electrodérmica.
* **Información operativa:**
  * Eventos detectados.
  * Alertas generadas.
  * Historial de cumplimiento de rutinas.
  * Historial de medicación.
  * Configuración de zonas seguras.
  * Estado de dispositivos conectados.
  * Registro de acciones del cuidador.

### Clasificación de evento

El sistema distingue entre eventos de nivel bajo (desvíos leves o recordatorios no confirmados) hasta nivel crítico (situaciones que comprometen la integridad física del paciente). La gravedad se clasifica en cuatro niveles:

| Nivel de gravedad | Descripción | Ejemplo |
| :---- | :---- | :---- |
| **Baja** | Omisión de recordatorio menor | Actividad cognitiva no realizada |
| **Media** | Incumplimiento de un hecho importante | Medicación no tomada |
| **Alta** | Requiere intervención inmediata | Salida de zona segura configurada |
| **Crítica** | Compromete la integridad física del paciente | Caída detectada o frecuencia cardíaca alta |

### Sistemas involucrados

| Sistema / componente | Función |
| :---- | :---- |
| Dispositivo de interacción en el hogar (DOT) | Permite comunicación por voz con el paciente. |
| Pulsera IoT | Registra biometría, movimiento y ubicación. |
| Motor de IA | Interpreta información y genera respuestas contextualizadas. |
| Base de datos del paciente | Almacena información personal, rutinas, eventos y configuraciones. |
| Módulo RAG / memoria | Recupera recuerdos, preferencias y datos relevantes del paciente. |
| Orquestador de automatización | Coordina flujos automáticos ante eventos y rutinas. |
| Módulo de alertas | Genera, clasifica y comunica alertas. |
| Interfaz del cuidador | Permite visualizar estado, configurar rutinas y consultar historial. |
| Servicios externos | Canales como notificaciones push, servicios de mensajería instantánea. |

## Mapa global de procesos del Entorno

El mapa representa la organización general de los procesos involucrados en el sistema de asistencia y acompañamiento domiciliario para personas con pérdida de memoria (PPM). Se identifican las necesidades y requerimientos provenientes del paciente, cuidador y partes interesadas, gestionados mediante procesos estratégicos, misionales y de apoyo.

Los **procesos estratégicos** orientan la planificación, configuración y control del sistema, incluyendo la gestión del cuidado, la seguridad, la privacidad y el manejo de datos (bajo el marco de la **Ley 25.326 de Protección de Datos Personales**). Los **procesos operativos** representan las funciones centrales que generan valor directo para el paciente y el cuidador: interacción con el paciente, monitoreo biométrico, detección de eventos, alertas y administración de rutinas y medicación. Finalmente, los **procesos de apoyo** sostienen el funcionamiento técnico del sistema mediante inteligencia artificial, automatización, gestión de datos, dispositivos y soporte.

Como resultado, el sistema busca brindar asistencia, seguimiento y mayor seguridad dentro del hogar, permitiendo al cuidador recibir información relevante y actuar ante eventos de riesgo de manera oportuna.

## Impulsos

### Necesidades del Paciente

* Mantener orientación básica sobre día, hora, lugar y actividades previstas.
* Recordar medicación, alimentación, higiene y descanso.
* Registrar eventos relevantes para seguimiento posterior.
* Comunicación inmediata ante emergencias.
* Realizar actividades cognitivas simples, breves y adaptadas a su estado.
* Recibir estímulos vinculados a recuerdos personales, familiares o emocionalmente significativos.

### Necesidades del Cuidador

* Reducir la necesidad de supervisión física constante.
* Recibir información actualizada sobre el estado del paciente.
* Personalizar la interacción según el perfil y recuerdos del paciente.
* Contar con un historial que ayude a comprender la evolución diaria.
* Consultar el cumplimiento u omisión de rutinas y medicación.

### Problemas

* El paciente puede olvidar rutinas básicas, medicación o actividades de higiene.
* El cuidador no siempre puede estar presente físicamente.
* Situaciones de riesgo (caídas, desorientación) pueden no detectarse a tiempo.
* La información sobre eventos diarios suele quedar dispersa o no registrada.
* La supervisión constante genera sobrecarga física y emocional en el cuidador.
* El cuidado tradicional actúa después del problema, no de forma preventiva.
* La falta de seguimiento histórico dificulta comprender la evolución del paciente.
* Las falsas alarmas pueden generar fatiga en el cuidador si no se validan correctamente.

### Oportunidades

* Automatizar recordatorios y alertas para reducir la dependencia del cuidador.
* Incorporar estimulación cognitiva y terapia de reminiscencia en la rutina diaria.
* Registrar eventos y generar trazabilidad histórica del estado del paciente.
* Mejorar la seguridad del paciente sin eliminar su autonomía.
* Adaptar las interacciones del sistema según el estado estimado del paciente.
* Reducir la carga operativa y emocional del cuidador.
* Escalar el sistema en fases futuras con nuevas integraciones o funcionalidades.

## Propuesta

### Objetivo de la propuesta

Desarrollar un sistema inteligente de asistencia domiciliaria para personas con pérdida de memoria, que permita acompañar al paciente en su vida diaria, detectar situaciones de riesgo, emitir recordatorios, registrar eventos y notificar al cuidador cuando sea necesario.

### Alcance del sistema

El sistema estará orientado al acompañamiento domiciliario de **una persona con pérdida de memoria o deterioro cognitivo leve/moderado por hogar**, asistida por uno o varios cuidadores. El paciente debe poseer un grado de deterioro cognitivo menor a la etapa 5 de la escala de deterioro por Alzheimer.

La solución se implementará como una aplicación multiplataforma, pensada principalmente para dispositivos móviles y con posibilidad de adaptación al entorno web. La aplicación permitirá cargar, consultar y administrar información del paciente, rutinas, medicación, cuidadores, dispositivos, eventos, alertas e historial.

El sistema utilizará una **única cuenta asociada al DOT o sistema del hogar**. Esta cuenta funcionará como cuenta principal del entorno domiciliario. Dentro de ella se podrá administrar toda la información del paciente y de los cuidadores.

Los cuidadores no tendrán cuentas individuales. Para diferenciar la participación de cada cuidador, el sistema registrará los dispositivos desde los cuales se utiliza la aplicación, permitiendo asociar cada dispositivo a un cuidador determinado.

El sistema podrá integrarse con una pulsera o reloj inteligente existente en el mercado, siempre que dicho dispositivo pueda conectarse a un teléfono y aportar datos útiles para el monitoreo. No se desarrollará hardware propio.

El sistema permitirá gestionar rutinas, medicación, recordatorios, interacción por voz, actividades cognitivas, terapia de reminiscencia cognitiva, eventos de riesgo, alertas, llamadas automáticas, historial y seguimiento del paciente, para estimular la memoria, reforzar la identidad personal y mejorar el bienestar emocional del paciente.

### Fuera del alcance

* Diagnosticar Alzheimer u otras enfermedades.
* Recomendar tratamientos médicos.
* Modificar automáticamente la medicación.
* Reemplazar al cuidador.
* Desarrollar una pulsera o reloj propio.
* Garantizar compatibilidad con cualquier marca de wearable.
* Gestionar instituciones geriátricas o múltiples pacientes institucionalizados.
* Integrarse obligatoriamente con hospitales o historias clínicas.
* Certificarse formalmente como dispositivo médico.
* Garantizar prevención absoluta de caídas, extravíos o emergencias.
* Gestionar cuentas individuales por cada cuidador.
* Definir perfiles de permisos distintos entre cuidadores.

## Requerimientos Funcionales

### 1. Gestión de la cuenta del hogar (DOT)

* Registrar, modificar y consultar la cuenta única del sistema domiciliario.
* Asociar la cuenta del DOT a un único paciente.
* Gestionar la configuración general del entorno domiciliario.
* Validar acceso a la cuenta del DOT mediante credenciales configuradas.
* Proteger la información personal y biométrica (Ley 25.326).
* Restringir el acceso mediante credenciales válidas y bloquear dispositivos no registrados.

### 2. Gestionar paciente

* Registrar y mantener el perfil del paciente (datos personales, historial biográfico, preferencias).
* Registrar vínculos familiares del paciente.
* Registrar recuerdos significativos del paciente para terapia de reminiscencia cognitiva.
* Dar de baja el perfil del paciente cuando corresponda.

### 3. Gestionar cuidadores

* Registrar cuidadores dentro de la cuenta y asociarlos a dispositivos.
* Gestionar métodos de contacto del cuidador.
* Identificar dispositivo de origen en cada acción relevante.

### 4. Gestionar rutinas, medicación y tratamientos del paciente

* Registrar medicación o tratamientos indicados externamente, horarios, frecuencia, confirmación y omisiones.
* Consultar historial de cumplimiento de medicación.
* Definir rutinas, horarios, frecuencia, prioridad, pausas, reactivación y seguimiento de cumplimiento.

### 5. Gestionar recordatorios

* Generar y emitir recordatorios de medicación, rutinas, alimentación, higiene y descanso.
* Registrar la respuesta del paciente ante cada recordatorio.
* Notificar al cuidador ante omisión de recordatorio prioritario.

### 6. Gestionar interacción con el paciente

* Iniciar interacción vocal proactiva según horario, rutina, inactividad o estado estimado.
* Capturar, interpretar y responder al lenguaje del paciente de forma contextualizada.
* Limitar las respuestas del sistema a los flujos asistenciales definidos.

### 7. Gestionar terapia de reminiscencia y actividades cognitivas

* Registrar, consultar y presentar recuerdos personalizados del paciente.
* Registrar y proponer actividades cognitivas y recreativas adaptadas al perfil.
* Registrar la participación y respuesta del paciente en cada actividad.
* Presentar información simple sobre fecha, hora, lugar, actividades previstas y datos básicos del entorno del paciente.

### 8. Gestionar monitoreo biométrico y de ubicación

* Vincular wearable compatible; registrar biometría disponible (frecuencia cardíaca, movimiento, ubicación, temperatura, actividad electrodérmica).
* Informar pérdida de conexión o batería baja del wearable.
* El sistema debe operar en modo reducido si no hay wearable conectado.

### 9. Gestionar detección de eventos de riesgo

* Detectar una posible caída a partir de datos de movimiento disponibles.
* Detectar deambulación errática o ausencia prolongada de actividad esperada.
* Detectar un posible estado de agitación a partir de voz, comportamiento o biometría.
* Clasificar eventos como informativos, preventivos o críticos según reglas configuradas y datos disponibles.
* Permitir marcar eventos como revisados, atendidos o descartados (sin eliminación física).

### 10. Gestionar alertas y comunicación de emergencia

* Generar y clasificar alertas por gravedad a partir de eventos preventivos o críticos.
* Notificar al cuidador por los canales configurados; escalar si no hay respuesta.
* Ejecutar llamada automática ante evento crítico según reglas configuradas.
* Iniciar comunicación de audio remoto unidireccional desde un dispositivo registrado.
* Evitar exponer datos sensibles en mensajes externos.

### 11. Gestionar zonas seguras

* Registrar, modificar y consultar zonas seguras del hogar.
* Detectar y notificar la salida del paciente de la zona segura según nivel de riesgo configurado.

### 12. Gestionar visualización del historial y reportes

* Visualizar estado actual del paciente, biometría disponible, actividad reciente y dispositivos.
* Consultar historial de eventos, alertas, rutinas, medicación e interacciones.
* Generar y exportar resúmenes de cumplimiento, evolución y eventos.
* Registrar la fecha, hora y dispositivo de origen de las acciones, sin eliminar eventos físicamente, y conservar el historial.

### 13. Gestionar Inteligencia Artificial y memoria contextual

* Recuperar contexto del paciente para personalizar interacciones y respuestas.
* Adaptar la interacción según el estado estimado del paciente.
* Asistir en la clasificación de eventos cuando se requiera contexto adicional.
* Incorporar nueva información a la memoria del paciente previa validación desde el dispositivo registrado.
* Restringir respuestas al contexto asistencial; registrar decisiones relevantes.

### 14. Gestionar orquestación y automatización

* Ejecutar flujos automáticos ante rutinas programadas, eventos detectados o alertas generadas.
* Aplicar reglas configuradas para recordatorios, alertas y escalamiento.
* Evitar ejecución duplicada de acciones ante el mismo evento; reintentar acciones fallidas cuando corresponda.

## Requerimientos No Funcionales

* **Usabilidad del cuidador:** La información debe presentarse de forma clara, priorizada y fácil de interpretar.
* **Accesibilidad para el paciente:** La interfaz de interacción debe ser simple, de bajo esfuerzo cognitivo y sin requerir aprendizaje previo.
* **Disponibilidad de alertas:** Mantener operativas las funciones críticas de alerta mientras existan condiciones mínimas de conectividad y configuración.
* **Compatibilidad multiplataforma:** Diseñar la aplicación para poder ejecutarse en entorno móvil y, eventualmente, web mediante un único desarrollo multiplataforma.
* **Escalabilidad funcional:** Permitir incorporar en el futuro nuevos dispositivos, reglas o canales sin alterar el objetivo principal.
* **Exportación de reportes:** Permitir exportar resúmenes en formato estándar de lectura para uso médico o familiar, estos son: PDF, excel.
* **Eficiencia energética:** minimizar el consumo de batería durante tareas de monitoreo en dispositivos móviles y wearables.

## Reglas de Negocio

1. El sistema se configura para un único paciente por hogar.
2. El entorno de cuidado contiene información del paciente, cuidadores, rutinas, medicación, actividades, eventos, alertas e historial.
3. Toda medicación o tratamiento debe ser cargado o validado por un cuidador o responsable externo al sistema.
4. Aurora no puede recomendar dosis, tratamientos ni cambios médicos.
5. Las actividades cognitivas deben ser breves, simples y adaptadas al perfil registrado del paciente.
6. Los recuerdos personales solo pueden incorporarse o modificarse con validación de un cuidador autorizado.
7. Una omisión de medicación se registra cuando no existe confirmación dentro del margen de un tiempo configurado.
8. Las alertas críticas deben notificarse a los cuidadores configurados.
9. Los eventos no deben eliminarse físicamente, se debe registrar la visibilidad del mismo.
10. El sistema debe poder operar sin dispositivos externos, limitando las funciones dependientes de sensores.
11. La salida de una zona segura, si la funcionalidad está habilitada, genera un evento según la configuración del hogar.
12. Toda acción relevante debe conservar trazabilidad suficiente para seguimiento posterior.
13. Las respuestas automáticas deben mantenerse dentro del contexto asistencial del sistema.
14. El cuidador es responsable de interpretar y actuar ante las alertas emitidas por el sistema.
15. La comunicación de audio remoto solo puede iniciarse desde un dispositivo registrado y autorizado.
