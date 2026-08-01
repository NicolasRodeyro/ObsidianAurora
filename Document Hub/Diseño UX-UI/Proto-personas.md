---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T21:20:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
  - Customer research
Last updated time: 2026-07-08T21:20:00
---
# Proto-personas

Capítulo 5 del [[Manual de UX-UI Aurora]].

> [!note] Método
> Son **proto-personas**: hipótesis construidas desde el [[Estudio Inicial Aurora.pdf|Estudio Inicial]] (necesidades, problemas, participantes), la [[Investigacion sobre neurologia]] y las restricciones del [[Project Charter]] (perfil clínico GDS/FAST ≤5, hogar unifamiliar, cuenta única del hogar). **Deben validarse** con las entrevistas a especialistas (mitigación del riesgo R1) y las pruebas piloto (grupo de 10 usuarios). Los nombres coinciden con los usados en los mockups («Ana» aparece en el display del branding).

Aurora tiene una particularidad de diseño: **quien usa la app no es quien recibe el cuidado, y quien recibe el cuidado no usa pantallas.** Cada superficie tiene su persona.

---

## P1 · Ana — la paciente 🌅
*«Yo siempre me arreglé sola. No necesito que me vigilen.»*

| | |
| --- | --- |
| **Edad / contexto** | 76 años, viuda, vive sola en su casa de siempre en Córdoba. Jubilada docente. |
| **Cuadro** | Alzheimer en etapa leve-moderada (GDS 4). Conserva conversación, lectura y rutinas con apoyo. Olvida medicación, fechas y a veces si comió; episodios de desorientación vespertina. |
| **Relación con la tecnología** | Usa el teléfono solo para llamadas. **No va a aprender interfaces nuevas** (RNF: interacción sin aprendizaje previo). La radio y la tele le resultan naturales: dispositivos que *hablan*. |
| **Superficie que usa** | Aurora Home, exclusivamente **por voz** + display glanceable + botón SOS físico. Jamás la app. |

**Necesita** (del Estudio Inicial): orientación básica (día, hora, lugar, qué toca hacer) · recordatorios de medicación, comida, hidratación e higiene · comunicación inmediata ante emergencia · actividades cognitivas breves adaptadas · estímulos ligados a sus recuerdos y afectos.

**Le molesta / le teme**: que la traten como nena · sentirse vigilada · los aparatos que "hay que configurar" · fallar en ejercicios y frustrarse (la frustración acelera el abandono).

**Implicaciones de diseño**
1. Interacción **proactiva**: Aurora inicia; Ana no tiene que recordar comandos (RF-01). Sin wake-words obligatorias para los flujos asistenciales.
2. Mensajes ≤40 palabras, una idea por turno, pausas largas ([[VUI — Diseño Conversacional]]).
3. Tono adulto y cálido; jamás condescendiente (RNF-02, principio 4 del manual).
4. El display muestra **siempre** fecha, hora y contexto — es su ancla de orientación (memoria prospectiva, [[Investigacion sobre neurologia]]).
5. Ejercicios de ≤15 min, con salida airosa: si Ana no quiere o se equivoca, Aurora cierra sin marcar el error.
6. El SOS es un **botón físico rojo**, grande, inconfundible — no un flujo de voz.

---

## P2 · María — la cuidadora primaria 🧭
*«Quiero saber que mamá está bien sin tener que llamarla ocho veces por día.»*

| | |
| --- | --- |
| **Edad / contexto** | 52 años, hija de Ana. Trabaja jornada completa; pasa por lo de su madre casi todos los días. Casada, dos hijos adolescentes. |
| **Rol en Aurora** | **Administradora de la cuenta del hogar**: hizo el onboarding, configura rutinas y medicación, carga recuerdos, responde alertas. Su dispositivo es el principal registrado. |
| **Relación con la tecnología** | WhatsApp, home banking, apps de uso diario. Competente pero sin paciencia para interfaces confusas: la app se usa **entre tareas, con estrés de fondo**. |
| **Superficie que usa** | Aurora Care en el teléfono a diario; una vista ampliada en tablet/pantalla grande sería útil para configuraciones largas (biografía, rutinas), pero no es requisito para completar tareas. |

**Necesita**: reducir supervisión física constante · estado del paciente de un vistazo · alertas confiables (pocas y accionables — la fatiga por falsas alarmas es un problema documentado del Estudio Inicial) · historial ordenado para el neurólogo · repartir la carga con su hermano · **saber cómo ayudar**: no es terapeuta, y quiere hacer algo más que vigilar — las sesiones guiadas (J5, F8) le dan un rol activo con instrucciones concretas.

**Le molesta / le teme**: notificaciones ruidosas que no distinguen lo grave de lo trivial · sentir culpa cuando no llega a atender algo · formularios largos · no entender *por qué* el sistema alertó.

**Implicaciones de diseño**
1. **Dashboard = respuesta a "¿está bien mamá?" en <5 segundos**: estado, última actividad, próximas rutinas, dispositivos.
2. Jerarquía estricta de notificaciones por severidad (Baja/Media/Alta/Crítica) con canales configurables (RF-45): lo bajo se acumula en resumen, lo crítico suena distinto.
3. Toda alerta trae **contexto + acciones**: qué pasó, cuándo, qué hacer (llamar / drop-in / marcar atendida) — RN14: el cuidador decide, el sistema informa.
4. Carga de datos en pasos cortos y guardado automático; biografía con prompts («¿Cómo se conocieron Ana y su marido?») en vez de un textarea vacío.
5. Lenguaje sin culpa en todo el sistema (principio 2).

---

## P3 · Diego — el cuidador a distancia 📱
*«Vivo a 700 km. Necesito poder hacer algo más que preguntar cómo anda.»*

| | |
| --- | --- |
| **Edad / contexto** | 47 años, hijo de Ana, vive en Buenos Aires. Visita una vez por mes. |
| **Rol en Aurora** | Cuidador registrado en la cuenta del hogar con **su dispositivo asociado** (sin cuenta propia — regla del alcance MVP). Recibe alertas, consulta estado, hace drop-in, carga recuerdos a validar. |
| **Relación con la tecnología** | Alta. Mobile-only: no va a depender de una vista ampliada para consultar el sistema. |
| **Superficie que usa** | Aurora Care en el teléfono, en momentos muertos (viajes, esperas) y ante alertas. |

**Necesita**: visibilidad para no depender del resumen de María · participar en el cuidado desde lejos (drop-in de voz, cargar fotos/recuerdos) · recibir solo lo importante — es respaldo de escalado, no primera línea.

**Le molesta**: enterarse tarde · duplicar avisos con María (¿quién atiende esta alerta?) · sentirse espectador.

**Implicaciones de diseño**
1. **Confirmación de atención visible para todos** (RF-72): cuando María marca una alerta como atendida, Diego lo ve al instante — evita dobles llamadas y ansiedad.
2. El escalado de alertas (RF-41) sigue el orden de contactos configurado: si María no responde en N minutos, le llega a Diego con ese contexto («María no respondió aún»).
3. Drop-in **unidireccional** a un toque (RN15), con aviso previo a Ana por el parlante para no sobresaltarla.
4. Carga de recuerdos con validación (RN6): Diego propone, María (admin) aprueba — el flujo debe ser liviano para no desincentivar el aporte.
5. Mobile-first al 100%: ninguna función de consulta puede requerir pantalla amplia.

---

## P4 · Silvina — coordinadora institucional 🏥 *(visión, fuera del MVP)*
*«Superviso 40 residentes. Necesito el mapa, no cuarenta apps.»*

38 años, coordinadora de un geriátrico privado (modelo B2B del [[Project Charter]]). Necesitaría un **dashboard multi-paciente** con triage de alertas, permisos por rol y reportes exportables para las familias y los médicos. Queda documentada para que las decisiones del MVP no cierren la puerta: la arquitectura de información de Care debe poder escalar de «un paciente» a «lista de pacientes» sin rediseño estructural. Detalle en [[Handoff y Backlog de Diseño]].

**Actor externo relacionado**: el **profesional de la salud** (neuróloga de Ana) no opera el sistema (Estudio Inicial, Participantes) pero es *destinatario* de los reportes exportables (RNF Exportación) — el formato de exportación se diseña pensando en ella.

---

## Matriz persona × superficie × prioridad

| | Aurora Home (voz+display) | Aurora Care mobile | Aurora Care vista ampliada | Prioridad de diseño |
| --- | --- | --- | --- | --- |
| **Ana** | ●●● única superficie | — | — | Alta — MVP |
| **María** | (escucha los drop-in) | ●●● diaria | ●● configuración | **Máxima — MVP** |
| **Diego** | — | ●●● ante alertas | — | Alta — MVP |
| **Silvina** | — | ○ | ○ dashboard multi | Visión |

## Documentos relacionados
- [[Journeys y Escenarios]] · [[Arquitectura de Información — Aurora Care]] · [[VUI — Diseño Conversacional]] · [[Accesibilidad]]
