---
base: "[[Document Hub.base]]"
Category:
  - Análisis
Last updated time: 2026-10-16
---

# Estudio Inicial Aurora

## Introducción

Este documento es el Estudio Inicial de Aurora, un sistema de acompañamiento para personas con pérdida de memoria o deterioro cognitivo leve a moderado (nivel FAST igual o inferior a 5) que viven en su hogar. Describe el objetivo y el ámbito de aplicación, los procesos involucrados antes y después de Aurora, los impulsos del proyecto y la propuesta de solución, con su alcance (MVP y futuras versiones). Incluye también los requerimientos, las reglas de negocio y el fundamento del dominio clínico.

## Audiencia

El documento está dirigido al docente, para aprobar el inicio del proyecto, y al sponsor, para confirmar el diagnóstico del problema. Es además la base de trabajo del equipo. No se asume conocimiento técnico ni clínico previo: los términos específicos se definen en el Glosario.

## Objetivo

El objetivo de este proyecto es diseñar y desarrollar un sistema de asistencia tecnológica integral para el hogar, orientado a personas con deterioro cognitivo leve a moderado o pérdida de memoria. La solución propone la transición de un esquema de cuidado **reactivo y presencial** hacia un modelo de **acompañamiento proactivo** basado en la automatización de tareas de soporte.

Para ello, se desarrollará una solución tecnológica que integra:

- Una **interfaz de interacción por voz (VUI)** dedicada a la asistencia en rutinas diarias, recordatorios y ejecución de protocolos de estimulación cognitiva.
- Un módulo de actividades cognitivas y de reminiscencia guiadas por voz, con registro de la participación del paciente para el seguimiento del cuidador.
- Visión de futuras versiones (fuera del MVP): un módulo de procesamiento de datos biométricos mediante dispositivos wearables, que permita el análisis de patrones.

El sistema utiliza algoritmos de inteligencia artificial para personalizar las actividades de estimulación y generar resúmenes del cumplimiento para el cuidador. La detección de desviaciones en los patrones de comportamiento o variables biométricas del usuario queda para futuras versiones. El propósito final es incrementar la autonomía del paciente y optimizar la gestión del cuidado por parte del entorno familiar, centralizando la supervisión en una interfaz digital que prioriza las alertas basadas en eventos validados por el sistema.  
  
**Aclaración:** *"El alcance de la tesis se centra en el procesamiento y la lógica de detección del software. El sistema está diseñado para ser agnóstico al modelo de hardware, asumiendo que la confiabilidad del dato biométrico es responsabilidad de la capa de hardware certificada."*

## Contexto y Problema a Validar

Las personas con deterioro cognitivo o pérdida de memoria pueden presentar dificultades para recordar actividades cotidianas, mantener rutinas, orientarse temporalmente, tomar medicación, hidratarse, alimentarse o realizar tareas básicas del día a día. Estas dificultades afectan la autonomía del paciente y aumentan la carga sobre el cuidador. En muchos casos, el cuidador no puede estar presente todo el tiempo, lo que provoca incertidumbre sobre el estado del paciente y sobre el cumplimiento de sus rutinas.

En muchos hogares, el cuidado se organiza de forma manual: recordatorios verbales, anotaciones, mensajes entre familiares y supervisión presencial. Esto genera dependencia de la disponibilidad del cuidador y dificulta conservar un historial ordenado de lo que ocurre día a día.

El problema principal que Aurora busca validar es si un sistema de apoyo domiciliario puede sostener las rutinas, los recordatorios y las actividades significativas de personas con deterioro cognitivo, y reducir la carga del cuidador. La evidencia disponible sobre terapias no farmacológicas muestra beneficios moderados, por lo que Aurora no promete efectos terapéuticos.

## Ámbito de Aplicación

Aurora se aplicará exclusivamente en hogares particulares donde resida una persona con deterioro cognitivo leve a moderado o pérdida de memoria. El sistema asiste a un paciente por hogar, acompañado por uno o más cuidadores familiares o responsables.

Condiciones del paciente contempladas:

- Daño cerebral adquirido, que les haya causado alguna discapacidad:
  - ACV (Accidente Cerebrovascular).
  - TCE (Traumatismo Craneoencefálico )
  - Tumores cerebrales.
  - Hipoxia (bloqueo del suministro de oxígeno al tejido cerebral)
- Enfermedades neurodegenerativas:
  - Enfermedad de Alzheimer (la más común)
  - Párkinson.
  - Esclerosis Múltiple.
  - Y otras demencias.

Restricción sobre el estado del paciente: el sistema está orientado a pacientes con un nivel igual o inferior a 5 en la escala FAST (Functional Assessment Staging), donde aún existe capacidad de interacción básica y aprovechamiento del entrenamiento cognitivo

El sistema no estará destinado, en esta primera etapa, a instituciones geriátricas, hospitales, centros de cuidado ni entornos con múltiples pacientes. Tampoco reemplaza la atención médica profesional, sino que funciona como una herramienta de apoyo al cuidado diario.

## Procesos Involucrados

El análisis se organiza en dos partes. La **Parte A** describe cómo se resuelve hoy el cuidado domiciliario de una persona con pérdida de memoria, sin ninguna solución de Aurora. La **Parte B** describe el proceso futuro (**TO-BE**) que Aurora propone. Los problemas identificados en la Parte A son los que justifican las decisiones de la Parte B.

### A. Situación actual (AS-IS): el cuidado domiciliario sin Aurora

![AS-IS - Situación actual](images/AS-IS%20-%20Situaci%C3%B3n%20actual.png)

#### Descripción del proceso actual

Hoy el cuidado de una persona con deterioro cognitivo leve o moderado en su hogar se organiza de forma **manual y presencial**. Uno o más familiares, que suelen convivir con el paciente o vivir cerca, asumen el rol de cuidador y se ocupan de:

- Recordar al paciente, de forma verbal, la medicación, las comidas, la hidratación, la higiene y el descanso.
- Supervisar de manera presencial que las rutinas se cumplan y que el paciente no se exponga a situaciones de riesgo (salir solo del hogar, cocinar, caerse).
- Anotar lo que ocurre (si tomó la medicación, cómo estuvo de ánimo, si hubo un episodio) en cuadernos, calendarios o mensajes.
- Coordinarse con otros familiares para cubrir los horarios en que el cuidador principal no está.
- Llevar la información al profesional de la salud en las consultas periódicas, normalmente de memoria o con anotaciones sueltas.

El cuidado es **reactivo**: se interviene cuando el cuidador advierte un problema, no antes. Cuando el cuidador no está presente, no hay un mecanismo que recuerde las rutinas ni que avise de un incidente.

#### Flujo del proceso actual

1. El profesional de la salud indica el tratamiento, la medicación y las pautas de rutina (en consulta, por receta o por indicación verbal).
2. El cuidador traduce esas indicaciones a su organización doméstica: pastillero semanal, alarmas en el celular, notas en el calendario o en un cuaderno.
3. El paciente realiza sus actividades diarias en el hogar.
4. Cuando llega la hora de una rutina o de una medicación, el cuidador, si está presente, se lo recuerda verbalmente. Si no está, depende de que el paciente lo recuerde solo o de que otro familiar lo llame.
5. El cuidador verifica **de manera presencial** si el paciente cumplió (por ejemplo, mirando el pastillero).
6. Si el cuidador observa algo anormal (desorientación, agitación, una caída), decide por su cuenta cómo actuar y a quién avisar, normalmente por llamada o por mensajería instantánea.
7. Lo ocurrido se registra, si se registra, en notas personales o en mensajes dispersos.
8. En la siguiente consulta, el cuidador le relata al profesional lo que recuerda del período.

#### Participantes

Los actores que intervienen en el proceso actual son:

| **Participante** | **Rol en el proceso actual** |
| --- | --- |
| **Paciente** | Persona con deterioro cognitivo leve o moderado. Realiza sus actividades diarias y depende de recordatorios y supervisión de terceros. |
| **Cuidador principal** | Familiar o responsable que organiza la rutina, recuerda la medicación, supervisa y decide ante incidentes. |
| **Familiares / cuidadores de apoyo** | Cubren turnos, reciben avisos del cuidador principal y colaboran en la supervisión. |
| **Profesional de la salud** | Actor externo. Diagnóstica, indica el tratamiento y las pautas, y realiza el seguimiento en consulta. No interviene en el día a día. |

#### Información que se utiliza hoy y dónde vive

La información que sostiene el cuidado hoy está distribuida en varios lugares y sin un formato común:

| **Información** | **Dónde está hoy** | **Limitación** |
| --- | --- | --- |
| **Medicación y horarios** | Receta médica, pastillero, alarmas del celular | Cada cuidador la interpreta y la carga por su cuenta; no hay una versión única. |
| **Rutinas diarias (comidas, higiene, descanso)** | Memoria del cuidador, notas, calendario | No se registra si se cumplieron. |
| **Recuerdos, gustos y vínculos del paciente** | Conocimiento del cuidador | Se pierde si cambia la persona que cuida; no se usa de forma estructurada para estimular la memoria. |
| **Cumplimiento y eventos del día** | Anotaciones sueltas, mensajes entre familiares | Quedan dispersos y sin orden cronológico. |
| **Incidentes (caídas, desorientación, episodios)** | Relato verbal al familiar o al profesional | Sin fecha exacta ni contexto; difíciles de analizar luego. |
| **Evolución del paciente** | Memoria del cuidador y notas de consulta o algún historial médico que posee el médico del paciente. | No hay historial ordenado que permita ver tendencias. |

#### Herramientas existentes que intervienen hoy

Estas son las herramientas que hoy se usan o se podrían usar para apoyar el cuidado, y lo que cada una no resuelve:

| **Herramienta** | **Uso actual** | **Qué no resuelve** |
| --- | --- | --- |
| **Pastilleros semanales** | Organizar la medicación | No avisan ni registran si se tomó. |
| **Alarmas y calendario del celular** | Recordar horarios de medicación y rutinas | Suenan en el celular del cuidador, no hablan con el paciente; no registran respuesta. |
| **Cuadernos o planillas** | Anotar eventos y cumplimiento | Dependen de que alguien las complete; no generan alertas. |
| **WhatsApp / llamadas** | Coordinar entre familiares y avisar incidentes | Información dispersa, sin estructura ni historial. |
| **Asistentes de voz comerciales genéricos** | Alarmas y consultas generales | No están adaptados al paciente: no usan su historia de vida, no registran cumplimiento ni avisan al cuidador. |
| **Botones de asistencia / teleasistencia** | Pedir ayuda en una emergencia | Requieren que el paciente reconozca la emergencia y accione el botón. |
| **Relojes inteligentes con detección de caídas** | Detectar caídas | Dispositivos aislados, sin vínculo con las rutinas ni con el resto del cuidado. |

#### Problemas del proceso actual

De este análisis surgen los problemas que Aurora busca atender:

| **Problema** | **Consecuencia** |
| --- | --- |
| El paciente olvida rutinas, medicación e higiene. | Incumplimiento del tratamiento y deterioro de la autonomía. |
| El cuidador no puede estar presente todo el tiempo. | Incertidumbre constante y sobrecarga física y emocional. |
| No hay verificación del cumplimiento cuando el cuidador está ausente. | Omisiones de medicación que se descubren tarde o nunca. |
| La información queda dispersa o sin registrar. | No se puede reconstruir qué pasó ni ver la evolución. |
| Las situaciones de riesgo no se detectan a tiempo. | Intervención tardía. |
| El cuidado actúa después del problema. | No hay prevención ni estimulación sistemática de la memoria. |
| Cada familiar maneja su propia versión de la información. | Inconsistencias entre cuidadores. |

### B. Situación propuesta (TO-BE): el proceso con Aurora

Esta parte describe **el sistema que se propone construir**, no una situación existente. Lo que corresponde al **MVP** y lo que queda para **futuras versiones** sigue la línea de corte del User Story Mapping.

![TO-BE - Proceso con Aurora](images/TO-BE%20-%20Proceso%20con%20Aurora.png)

#### Descripción del proceso propuesto

Con Aurora, la configuración que hoy vive en la cabeza del cuidador pasa a un sistema: el cuidador carga rutinas, medicación y datos biográficos del paciente en la aplicación **Aurora Care**. **Aurora Home**, el dispositivo de voz del hogar, ejecuta esos recordatorios hablándole al paciente, propone actividades cognitivas y de reminiscencia, y registra sus respuestas. **Aurora Core** centraliza la información y avisa al cuidador cuando una rutina o medicación crítica no se cumple. Todo queda en un historial consultable.

La detección automática de eventos de riesgo (caídas, salida de zona segura, anomalías biométricas) y las llamadas automáticas de emergencia forman parte de la visión del producto y **quedan fuera del MVP actual** (ver Propuesta, Alcance del sistema).

#### Flujo del proceso propuesto

**Dentro del MVP:**

1. El cuidador configura en Aurora Care la cuenta del hogar, el perfil del paciente, las rutinas, la medicación y los recuerdos significativos.
2. Aurora Home emite por voz los recordatorios en el horario configurado.
3. El paciente responde (por ejemplo, "ya la tomé") o no responde.
4. El sistema registra la respuesta o la omisión.
5. Si la omisión corresponde a una medicación o rutina crítica, el sistema genera una alerta y notifica al cuidador mediante notificación push.
6. Aurora Home propone al paciente actividades cognitivas breves y relatos de reminiscencia, y registra su participación.
7. El cuidador consulta en Aurora Care el estado del paciente y de los dispositivos, y el historial de cumplimiento.

**Futuras versiones (fuera del MVP):**

- Monitoreo de ubicación y biometría, detección de caídas y delimitación de zonas seguras (geofencing).
- Clasificación automática de eventos de riesgo y escalamiento por otros canales, incluidas llamadas automáticas.
- Reportes exportables para uso médico.

#### Información que maneja el sistema

- **Información del paciente:** datos personales básicos, perfil, preferencias, recuerdos personales, vínculos familiares, rutinas diarias, medicación y tratamientos. *(MVP)*
- **Información operativa:** respuestas del paciente, participación en actividades, alertas generadas, historial de cumplimiento y de medicación, estado de los dispositivos, registro de acciones del cuidador. *(MVP)*
- **Información biométrica y de ubicación** (frecuencia cardíaca, movimiento, ubicación, temperatura, actividad electrodérmica): *(futuras versiones; requiere un dispositivo wearable comercial)*.

#### Clasificación de eventos

El sistema distingue cuatro niveles de gravedad. La clasificación es una regla de software configurable; los ejemplos clínicos deben ser validados por un profesional.

| **Nivel de gravedad** | **Descripción** | **Ejemplo** | **Alcance** |
| --- | --- | --- | --- |
| **Baja** | Omisión de recordatorio menor | Actividad cognitiva no realizada | MVP |
| **Media** | Incumplimiento de un hecho importante | Medicación no tomada | MVP |
| **Alta** | Requiere intervención inmediata | Salida de zona segura configurada | Futuras versiones |
| **Crítica** | Compromete la integridad física del paciente | Caída detectada o frecuencia cardíaca alta | Futuras versiones |

### Sistemas involucrados

#### Sistemas y herramientas existentes en el entorno actual (AS-IS)

Son los elementos que ya intervienen en el cuidado domiciliario antes de Aurora: pastilleros, alarmas y calendario del celular, cuadernos y planillas, mensajería instantánea y llamadas, asistentes de voz comerciales genéricos, botones de asistencia y relojes inteligentes con detección de caídas (detallados en A.5), además de la historia clínica y las indicaciones del profesional de la salud, que son externas al sistema.

#### Componentes de la solución Aurora (TO-BE), que se desarrollan en este proyecto

Los siguientes componentes no existen hoy en el entorno del problema: son la solución que se construye.

| **Componente** | **Función** | **Alcance** |
| --- | --- | --- |
| **Aurora Home / DOT (dispositivo de interacción en el hogar)** | Permite la comunicación por voz con el paciente, emite recordatorios y ejecuta actividades. | MVP |
| **Aurora Care (interfaz del cuidador)** | Permite configurar rutinas, visualizar estado y consultar historial. | MVP |
| **Aurora Core** | Lógica de negocio, persistencia, orquestación y comunicación entre componentes. | MVP |
| **Base de datos del paciente** | Almacena información personal, rutinas, eventos y configuraciones. | MVP |
| **Módulo de alertas** | Genera y comunica alertas por omisión de medicación o rutina. | MVP |
| **Motor de IA (Worker IA)** | Genera respuestas contextualizadas y resúmenes. | MVP |
| **Memoria del paciente (RAG)** | Recupera recuerdos validados por el cuidador. El módulo RAG autónomo queda para futuras versiones. | MVP (acotado) |
| **Orquestador de automatización** | Coordina flujos automáticos ante eventos y rutinas. | Visión |
| **Aurora Band (pulsera comercial)** | Registra biometría, movimiento y ubicación. | Futuras versiones |

#### Servicios externos de los que depende la solución

Notificaciones push, proveedor de modelos de lenguaje, servicios de voz en la nube y proveedor de base de datos y autenticación. El detalle y el estado de cada decisión está en el documento de Arquitectura y Stack Tecnológico.

## Mapa global de procesos del Entorno

El mapa se presenta en **dos vistas**.

**Vista 1: Dominio actual del cuidado domiciliario (AS-IS).** Representa los procesos que existen hoy, con independencia de Aurora:

- *Proceso estratégico:* decisión del tratamiento y las pautas (profesional de la salud).
- *Procesos operativos:* recordatorio de rutinas y medicación, supervisión presencial, registro manual, comunicación entre familiares y consulta periódica.
- *Procesos de apoyo:* herramientas domésticas (pastillero, celular, cuaderno).
- *Entradas:* necesidades del paciente y del cuidador, indicaciones médicas.
- *Salidas:* paciente asistido e información dispersa.

![AS-IS - Situación actual](images/AS-IS%20-%20Situaci%C3%B3n%20actual.png)

**Vista 2: cómo Aurora modifica o automatiza esos procesos (TO-BE).** Sobre el mismo mapa se señala qué proceso toma Aurora:

| **Proceso actual** | **En Aurora (TO-BE)** |
| --- | --- |
| Recordatorio verbal de rutinas y medicación | Recordatorio por voz desde Aurora Home |
| Verificación presencial del cumplimiento | Registro automático de la respuesta del paciente |
| Anotaciones y mensajes dispersos | Historial centralizado en Aurora Care |
| Aviso del cuidador a otros familiares | Alerta por notificación push ante omisiones críticas |
| Estimulación espontánea de la memoria | Actividades cognitivas y de reminiscencia sistemáticas |
| Relato de memoria en la consulta | Historial de cumplimiento consultable |

Los procesos estratégicos incluyen además la **seguridad, la privacidad y el manejo de datos** bajo el marco de la **Ley 25.326 de Protección de Datos Personales**.

![TO-BE - Proceso con Aurora](images/TO-BE%20-%20Proceso%20con%20Aurora.png)

## Impulsos

### Necesidades del Paciente

- Mantener orientación básica sobre día, hora, lugar y actividades previstas.
- Recordar medicación, alimentación, higiene y descanso.
- Registrar eventos relevantes para seguimiento posterior.
- Comunicación inmediata ante emergencias.
- Realizar actividades cognitivas simples, breves y adaptadas a su estado.
- Recibir estímulos vinculados a recuerdos personales, familiares o emocionalmente significativos.

Necesidades del Cuidador

- Reducir la necesidad de supervisión física constante.
- Recibir información actualizada sobre el estado del paciente.
- Personalizar la interacción según el perfil y recuerdos del paciente.
- Contar con un historial que ayude a comprender la evolución diaria.
- Consultar el cumplimiento u omisión de rutinas y medicación.

### Problemas

- El paciente puede olvidar rutinas básicas, medicación o actividades de higiene.
- El cuidador no siempre puede estar presente físicamente.
- Situaciones de riesgo (caídas, desorientación) pueden no detectarse a tiempo.
- La información sobre eventos diarios suele quedar dispersa o no registrada.
- La supervisión constante genera sobrecarga física y emocional en el cuidador.
- El cuidado tradicional actúa después del problema, no de forma preventiva.
- La falta de seguimiento histórico dificulta comprender la evolución del paciente.
- Las falsas alarmas pueden generar fatiga en el cuidador si no se validan correctamente.

### Oportunidades

- Automatizar recordatorios y alertas para reducir la dependencia del cuidador.
- Incorporar estimulación cognitiva y terapia de reminiscencia en la rutina diaria.
- Registrar eventos y generar trazabilidad histórica del estado del paciente.
- Mejorar la seguridad del paciente sin eliminar su autonomía.
- Adaptar las interacciones del sistema según el estado estimado del paciente.
- Reducir la carga operativa y emocional del cuidador.
- Escalar el sistema en fases futuras con nuevas integraciones o funcionalidades.

## Propuesta

### Objetivo de la propuesta

Desarrollar un sistema inteligente de asistencia domiciliaria para personas con pérdida de memoria, que permita acompañar al paciente en su vida diaria, emitir recordatorios, registrar las respuestas y los eventos, y alertar al cuidador cuando una medicación o una rutina importante no se cumple.

### Valor esperado

Para el paciente y el cuidador, Aurora busca los resultados siguientes, que se miden con los indicadores del Plan de Proyecto (sección 3.1):

- **Continuidad de las rutinas:** el paciente recibe a horario sus recordatorios de medicación y de actividades, aun cuando el cuidador no está presente.
- **Menor carga para el cuidador:** deja de depender de su memoria y de verificar todo de manera presencial, y se entera por Aurora Care cuando algo importante no se cumple.
- **Trazabilidad:** el cuidador y el profesional cuentan con un historial ordenado del cumplimiento, en lugar de notas dispersas.
- **Estimulación y acompañamiento:** el paciente participa de actividades cognitivas y de reminiscencia guiadas por voz, con registro de su participación.
- **Confianza en el sistema:** las alertas son confiables y los datos del paciente se tratan con su consentimiento y de forma protegida.

Para el equipo y la cátedra, el valor está en demostrar, con un MVP medible, que un sistema de apoyo domiciliario puede sostener la rutina de una persona con pérdida de memoria sin reemplazar al cuidador ni al profesional.

### Alcance del sistema

El sistema estará orientado al acompañamiento domiciliario de **una persona con pérdida de memoria o deterioro cognitivo leve/moderado por hogar**, asistida por uno o varios cuidadores. El paciente debe poseer un nivel igual o inferior a 5 en la escala FAST (Functional Assessment Staging)

La solución se implementará como una aplicación multiplataforma, pensada principalmente para dispositivos móviles y con posibilidad de adaptación al entorno web. La aplicación permitirá cargar, consultar y administrar información del paciente, rutinas, medicación, cuidadores, dispositivos, eventos, alertas e historial.

El sistema utilizará una **única cuenta asociada al DOT o sistema del hogar**. Esta cuenta funcionará como cuenta principal del entorno domiciliario y estará asociada a un único paciente.

Los cuidadores tendrán cuentas personales para ingresar a Aurora Care. Cada cuidador podrá acceder a una o más cuentas DOT/hogar siempre que haya sido asociado previamente. Dentro de cada cuenta DOT se administra la información del paciente, sus rutinas, medicación, alertas, cuidadores autorizados y configuración del entorno.

El sistema podrá integrarse con una pulsera o reloj inteligente existente en el mercado, siempre que dicho dispositivo pueda conectarse a un teléfono y aportar datos útiles para el monitoreo. No se desarrollará hardware propio. En el MVP no se integra ningún wearable (decisión del 29/08/2026 por restricción presupuestaria); la integración queda como evolución futura.

Alcance del MVP: el sistema permitirá gestionar la cuenta del hogar, el paciente y los cuidadores; rutinas, medicación y recordatorios por voz con registro de las respuestas del paciente; actividades cognitivas y terapia de reminiscencia; alertas al cuidador ante omisiones críticas de medicación o rutinas; e historial de cumplimiento, para estimular la memoria, reforzar la identidad personal y mejorar el bienestar emocional del paciente.

Futuras versiones: monitoreo biométrico y de ubicación, detección de caídas y de agitación, zonas seguras, llamadas automáticas y reportes exportables. La línea de corte es la del User Story Mapping.

### Fuera del alcance

- Diagnosticar Alzheimer u otras enfermedades.
- Recomendar tratamientos médicos.
- Modificar automáticamente la medicación.
- Reemplazar al cuidador.
- Desarrollar una pulsera o reloj propio.
- Garantizar compatibilidad con cualquier marca de wearable.
- Gestionar instituciones geriátricas o múltiples pacientes institucionalizados.
- Integrarse obligatoriamente con hospitales o historias clínicas.
- Certificarse formalmente como dispositivo médico.
- Garantizar prevención absoluta de caídas, extravíos o emergencias.

## Requerimientos Funcionales

Cada grupo indica su alcance según la línea de corte del User Story Mapping: MVP o Futuras versiones.

### 1. Gestión de la cuenta del hogar (DOT) (MVP)

- Registrar, modificar y consultar la cuenta única del sistema domiciliario.
- Asociar la cuenta del DOT a un único paciente.
- Asociar uno o más cuidadores autorizados a la cuenta DOT.
- Permitir que un cuidador autenticado seleccione una cuenta DOT/hogar asociada.
- Gestionar la configuración general del entorno domiciliario.
- Validar el acceso del cuidador mediante su cuenta personal.
- Proteger la información personal y biometrica.

### 2. Gestionar paciente (MVP)

- Registrar y mantener el perfil del paciente (datos personales, historial biográfico, preferencias).
- Registrar vínculos familiares del paciente.
- Registrar recuerdos significativos del paciente para terapia de reminiscencia cognitiva.
- Dar de baja el perfil del paciente cuando corresponda. (Futuras versiones)

### 3. Gestionar cuidadores (MVP)

- Registrar cuidadores con cuenta personal y asociarlos a una o más cuentas DOT/hogar.
- Gestionar métodos de contacto del cuidador.
- Identificar dispositivo de origen en cada acción relevante.
- Definir el rol del cuidador dentro de cada cuenta DOT: cuidador principal o cuidador de apoyo.
- Gestionar métodos de contacto y preferencias de notificación del cuidador.
- Registrar las acciones relevantes indicando el cuidador autenticado que las realizó.

### 4. Gestionar rutinas, medicación y tratamientos del paciente (MVP)

- Registrar medicación o tratamientos indicados externamente, horarios, frecuencia, confirmación y omisiones.
- Consultar historial de cumplimiento de medicación.
- Definir rutinas, horarios, frecuencia, prioridad, pausas, reactivación y seguimiento de cumplimiento.

### 5. Gestionar recordatorios (MVP)

- Generar y emitir recordatorios de medicación, rutinas, alimentación, higiene y descanso.
- Registrar la respuesta del paciente ante cada recordatorio.
- Notificar al cuidador ante omisión de recordatorio prioritario

### 6. Gestionar interacción con el paciente (MVP)

- Iniciar interacción vocal proactiva según horario, rutina, inactividad o estado estimado.
- Capturar, interpretar y responder al lenguaje del paciente de forma contextualizada.
- Limitar las respuestas del sistema a los flujos asistenciales definidos

### 7. Gestionar terapia de reminiscencia y actividades cognitivas (MVP)

- Registrar y consultar recuerdos significativos del paciente dentro de la memoria del paciente.
- Proponer actividades cognitivas, recreativas o de reminiscencia adaptadas al perfil del paciente.
- Registrar la participación, duración, progreso, resultado y métricas de cada sesión de actividad.
- Para actividades de reminiscencia, utilizar recuerdos ya almacenados en la memoria del paciente, sin duplicar su contenido.

### 8. Gestionar monitoreo biométrico y de ubicación (Futuras versiones)

- Vincular wearable compatible; registrar biometría disponible (frecuencia cardíaca, movimiento, ubicación, temperatura, actividad electrodérmica).
- Informar pérdida de conexión o batería baja del wearable.
- El sistema debe operar en modo reducido si no hay wearable conectado.

### 9. Gestionar detección de eventos de riesgo (Futuras versiones)

- Detectar una posible caída a partir de datos de movimiento disponibles.
- Detectar deambulación errática o ausencia prolongada de actividad esperada.
- Detectar un posible estado de agitación a partir de voz, comportamiento o biometría.
- Clasificar eventos como informativos, preventivos o críticos según reglas configuradas y datos disponibles.
- Permitir marcar eventos como revisados, atendidos o descartados (sin eliminación física)

### 10. Gestionar alertas y comunicación de emergencia (MVP: alertas por omisión; futuras versiones: llamada automática y escalamiento)

- Generar y clasificar alertas por gravedad a partir de eventos preventivos o críticos.
- Notificar al cuidador por los canales configurados; escalar si no hay respuesta (el escalamiento corresponde a futuras versiones).
- Ejecutar llamada automática ante evento crítico según reglas configuradas. (Futuras versiones)
- Evitar exponer datos sensibles en mensajes externos.

### 11. Gestionar zonas seguras (MVP: registrar, modificar y consultar; futuras versiones: detectar y notificar la salida)

- Registrar, modificar y consultar zonas seguras del hogar.
- Detectar y notificar la salida del paciente de la zona segura según nivel de riesgo configurado. (Futuras versiones)

### 12. Gestionar visualización del historial y reportes (MVP: estado e historial; futuras versiones: reportes exportables)

- Visualizar estado actual del paciente, biometría disponible, actividad reciente y dispositivos.
- Consultar historial de eventos, alertas, rutinas, medicación e interacciones.
- Generar y exportar resúmenes de cumplimiento, evolución y eventos. (Futuras versiones)
- Registrar la fecha, hora y dispositivo de origen de las acciones, sin eliminar eventos físicamente , y conservar el historial

### 13. Gestionar Inteligencia artificial y memoria contextual (MVP: memoria validada por el cuidador; futuras versiones: recuperación autónoma y adaptación con modelo de IA)

- Recuperar contexto del paciente para personalizar interacciones y respuestas.
- Adaptar la interacción según el estado estimado del paciente.
- Asistir en la clasificación de eventos cuando se requiera contexto adicional.
- Los recuerdos personales solo pueden incorporarse o modificarse con validación de un cuidador autenticado y autorizado dentro de la cuenta DOT.
- Restringir respuestas al contexto asistencial; registrar decisiones relevantes.

### 14. Gestionar orquestación y automatización (MVP acotado)

- Ejecutar flujos automáticos ante rutinas programadas, eventos detectados o alertas generadas.
- Aplicar reglas configuradas para recordatorios, alertas y escalamiento.
- Evitar ejecución duplicada de acciones ante el mismo evento; reintentar acciones fallidas cuando corresponda.

### 15. Gestionar privacidad, consentimiento y derechos sobre los datos (MVP)

- Registrar el consentimiento informado antes de tratar datos del paciente, con tipo, versión de la política, alcance, fecha de aceptación y quién lo registró (RF-92).
- Permitir revocar el consentimiento en cualquier momento desde Aurora Care, con los efectos definidos en la política de privacidad (RF-93).
- Atender solicitudes del titular o su representante de acceso (exportar), rectificación y supresión, registrando tipo, estado y responsable (RF-94).
- Informar al cuidador, en el consentimiento, qué datos salen del hogar y a qué proveedores (RF-95).
- Depurar automáticamente los datos que superaron su plazo de retención y dejar constancia (RF-96).
- Registrar el acceso a los datos del paciente: quién, qué, cuándo y con qué motivo (RF-97).
- No incluir datos personales en el texto visible de las notificaciones (RF-98).

## Requerimientos No Funcionales

- **Usabilidad del cuidador:** La información debe presentarse de forma clara, priorizada y fácil de interpretar.
- **Accesibilidad para el paciente:** La interfaz de interacción debe ser simple, de bajo esfuerzo cognitivo y sin requerir aprendizaje previo.
- **Disponibilidad de alertas:** Mantener operativas las funciones críticas de alerta mientras existan condiciones mínimas de conectividad y configuración.
- **Compatibilidad multiplataforma:** Diseñar la aplicación para poder ejecutarse en entorno móvil y, eventualmente, web mediante un único desarrollo multiplataforma.
- **Escalabilidad funcional:** Permitir incorporar en el futuro nuevos dispositivos, reglas o canales sin alterar el objetivo principal.
- **Exportación de reportes:** Permitir exportar resúmenes en formato estándar de lectura para uso médico o familiar, estos son:PDF, excel.
- **Eficiencia energética:** minimizar el consumo de batería durante tareas de monitoreo en dispositivos móviles y wearables.
- **Cifrado en reposo (RNF-44):** el 100 % de los campos identificatorios (nombre, DNI y contactos de emergencia) se almacena cifrado; una consulta directa a la base no devuelve texto plano.
- **Cifrado en tránsito (RNF-45):** todas las comunicaciones externas usan TLS 1.2 o superior y los endpoints rechazan HTTP plano.
- **Rotación de claves (RNF-46):** existe un procedimiento documentado y probado para rotar la clave de cifrado sin migraciones masivas.
- **Separación de entornos (RNF-47):** los datos reales de pacientes no se usan en desarrollo ni en staging.
- **Minimización en Aurora Home (RNF-48):** el dispositivo no almacena audio más allá de un buffer circular de 5 minutos.
- **Tiempo de atención de derechos (RNF-49):** las solicitudes de acceso se resuelven en 10 días corridos y las de rectificación, actualización o supresión en 5 días hábiles (Ley 25.326, arts. 14 y 16).
- **Anonimización (RNF-50):** ningún dato de pacientes se usa para entrenar o ajustar modelos sin consentimiento específico y sin eliminar los identificadores; por defecto, no se usa.
- **Proveedores de voz e IA (RNF-51):** no conservan el audio ni el texto; la configuración de cada proveedor se verifica con una lista de control en cada cambio.
- **Credencial del proveedor de voz (RNF-52):** no debe quedar expuesta en los dispositivos; se emiten tokens de corta duración desde Aurora Core o credenciales revocables por dispositivo. Estado actual: no cumple.

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
15. La comunicación de audio remoto solo puede iniciarse desde Aurora Care por un cuidador autenticado y autorizado dentro de la cuenta DOT.
16. Cada hogar tiene una única cuenta DOT activa.
17. Cada cuenta DOT tiene un único paciente activo.
18. Una cuenta DOT puede tener uno o más cuidadores asociados.
19. Un cuidador puede estar asociado a una o más cuentas DOT.
20. El acceso a la información del paciente depende de la asociación entre el cuidador autenticado y la cuenta DOT.
21. Las acciones relevantes deben registrar el cuidador autenticado que las ejecutó.

## Dominio clínico: fundamento, validación y límites del software

### 1. Principio de separación de responsabilidades

Aurora trabaja con una población vulnerable. Por eso el proyecto separa de forma explícita dos tipos de decisión:

- **Decisiones clínicas:** qué terapias son adecuadas, qué tipo de actividades son seguras, para qué estadios de la enfermedad es apropiado el sistema y qué se considera una señal de riesgo. **No las toma el equipo de software.** Provienen de bibliografía publicada o de profesionales de la salud que las validaron.
- **Decisiones de software:** cómo se implementa una regla ya definida (por ejemplo, que un recordatorio se emita a las 9:00, que una omisión genere una alerta, que una respuesta no supere cierta cantidad de palabras). Se documentan, se prueban y son trazables.

Cuando una regla requiere un umbral clínico que no fue validado por un profesional, **la funcionalidad no entra al MVP** y queda marcada como pendiente de validación.

### 2. Validación profesional realizada

La validación del enfoque terapéutico y del perfil de paciente se realizó con los siguientes profesionales:

| **Aspecto validado** | **Quién** | **Qué se validó** | **Fecha** |
| --- | --- | --- | --- |
| **Enfoque terapéutico y actividades** | Lic. Virginia Salvador (psicopedagoga) | El tipo de terapias que Aurora puede realizar y qué clase de juegos o actividades propone. Pautas de diseño: anticipar siempre lo que va a ocurrir y sostener una rutina diaria para apoyar la memoria de corto plazo. | 05/06/2026 |
| **Estadios del paciente a cubrir** | Profesionales del ámbito de la neurología<br>- Martina Schmidtt<br>- Alejo Matus | Qué etapas de la enfermedad puede cubrir el sistema. | Abril 2026 |
| **Investigación de dominio** | Equipo Aurora, con aportes de los profesionales anteriores | Documento Investigación sobre neurología (AURA-6 y AURA-7). | Sprint 0 |

**Aclaración:** la validación realizada fue una consulta de orientación, no una certificación del producto ni un estudio clínico. Aurora no es un dispositivo médico.

### 3. Fundamento bibliográfico

Las afirmaciones con fundamento clínico se respaldan en las siguientes fuentes:

| **Afirmación o regla** | **Fuente** |
| --- | --- |
| La escala GDS clasifica el deterioro cognitivo en 7 estadios. | Reisberg B, Ferris SH, de Leon MJ, Crook T. The Global Deterioration Scale for assessment of primary degenerative dementia. Am J Psychiatry. 1982;139(9):1136-1139. |
| La escala FAST describe la progresión funcional de la enfermedad de Alzheimer. | Reisberg B. Functional Assessment Staging (FAST). Psychopharmacol Bull. 1988;24(4):653-659. |
| La terapia de reminiscencia puede beneficiar la calidad de vida, la comunicación y el estado de ánimo en personas con demencia. Los efectos sobre la cognición son pequeños o inciertos. | Woods B, O'Philbin L, Farrell EM, Spector AE, Orrell M. Reminiscence therapy for dementia. Cochrane Database Syst Rev. 2018;3:CD001120. |
| La estimulación cognitiva se asocia con mejoras en la cognición en demencia leve a moderada. | Woods B, Aguirre E, Spector AE, Orrell M. Cognitive stimulation to improve cognitive functioning in people with dementia. Cochrane Database Syst Rev. 2012;(2):CD005562. |
| La rehabilitación cognitiva se basa en la neuroplasticidad y en objetivos personalizados de la vida cotidiana. | Fuentes citadas en Investigación sobre neurología (PubMed, 2024) |
| Marco legal del tratamiento de datos personales y de salud. | Ley 25.326 de Protección de Datos Personales (Argentina). |

Los hallazgos de las revisiones Cochrane son **moderados**: Aurora no promete efectos terapéuticos. Su objetivo es acompañar, sostener la rutina y reducir la carga del cuidador, que es lo que el producto puede sostener sin validación clínica propia.

### 4. Matriz de reglas: qué decide el software y qué proviene del conocimiento clínico

Cada regla con fundamento clínico se clasifica según quién la define y cómo está respaldada:

| **#** | **Regla o afirmación** | **Tipo de decisión** | **Respaldo** | **Estado** |
| --- | --- | --- | --- | --- |
| **C1** | Perfil de paciente: FAST igual o inferior a 5 (interacción básica conservada). | Clínica | Reisberg 1982 y 1988; consulta con profesionales de neurología | Validado informalmente |
| **C2** | Anticipar lo que va a ocurrir y sostener una rutina diaria. | Clínica | Lic. V. Salvador | Validado |
| **C3** | Tipos de terapia: reminiscencia y estimulación cognitiva. | Clínica | Cochrane 2018 y 2012; Lic. V. Salvador | Validado |
| **C4** | Tipo de actividades y juegos que Aurora puede proponer. | Clínica | Lic. V. Salvador | Validado |
| **C5** | Actividades breves y simples. | Mixta | Lic. V. Salvador; regla de negocio 5 | Validado en criterio; la duración exacta es de software |
| **S1** | Respuestas del asistente de máximo 40 palabras por turno (hablables). | Software | Criterio de diseño (RNF-01 y RNF-03) | [A validar con la Lic. Salvador] |
| **S2** | El micrófono se cierra a los 10 segundos sin respuesta. | Software | Criterio de diseño | [A validar] |
| **S3** | Margen de tiempo para registrar una omisión de medicación. | Software, configurable | Regla de negocio 7; lo fija el cuidador, no el sistema | No requiere validación clínica |
| **S4** | Cuatro niveles de gravedad de eventos. | Software | Estudio Inicial | Los ejemplos clínicos (caída, frecuencia cardíaca alta) son de futuras versiones y requieren validación |
| **S5** | Ajuste de la dificultad de los ejercicios con una regla simple (participación y ánimo, últimas 5 sesiones). Está en el MVP. | Clínica y software | La regla es de software; los criterios de qué es baja participación o mal ánimo y cuándo bajar la dificultad son clínicos | [A validar con la Lic. Salvador] |
| **F1** | Detección de caídas, agitación y frecuencia cardíaca anormal. | Clínica y software | Sin validación | Fuera del MVP. No se implementa hasta contar con umbrales validados por un profesional |
| **F2** | Adaptación de la dificultad mediante un modelo de IA entrenado. | Clínica y software | Sin validación | Fuera del MVP |

### 5. Límites del software (explícitos y trazables)

Aurora **no**:

1. Diagnostica Alzheimer ni otras enfermedades.
2. Recomienda tratamientos médicos ni dosis.
3. Modifica automáticamente la medicación.
4. Reemplaza al cuidador ni al profesional.

Cada límite se hace cumplir y se verifica de la siguiente manera:

| **Límite** | **Regla de negocio** | **Requisito no funcional** | **Mecanismo en el sistema** | **Cómo se verifica** |
| --- | --- | --- | --- | --- |
| **No diagnosticar ni recomendar tratamientos** | RN 4 y RN 13 | RNF-21 | Instrucción explícita en los prompts del Worker IA: "NUNCA indiques iniciar, suspender ni cambiar una medicación, ni des diagnóstico" y "NO des consejo ni diagnóstico médico" | Pruebas de evaluación de IA (ver Plan de Testing). Falta un conjunto de casos adversarios específico [pendiente] |
| **No modificar medicación** | RN 3 | RNF-40 y RNF-43 | La medicación solo la carga o valida un cuidador; el asistente no tiene herramientas de escritura sobre ella | Pruebas de API: el asistente no puede crear ni editar medicación |
| **Ante síntomas, derivar al cuidador** | RN 14 | RNF-21 | El prompt indica responder que no tiene ese registro y sugerir hablar con el cuidador | Casos de prueba con preguntas por síntomas y por dosis |
| **Mantener las respuestas dentro del contexto asistencial** | RN 13 | RNF-20 y RNF-22 | Memoria del paciente validada por el cuidador (RN 6) | Evaluación de respuestas fuera de contexto |

**Hallazgo:** hoy el límite se aplica mediante instrucciones en los prompts del asistente, que reducen pero no eliminan el riesgo. Se prevé agregar un filtro de salida (palabras clave de dosis y diagnóstico) y un conjunto de pruebas adversarias. Se considera un riesgo prioritario del proyecto.
