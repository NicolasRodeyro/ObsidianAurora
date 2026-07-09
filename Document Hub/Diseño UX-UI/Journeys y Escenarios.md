---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T21:30:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
  - Customer research
Last updated time: 2026-07-08T21:30:00
---
# Journeys y Escenarios

Capítulo 6 del [[Manual de UX-UI Aurora]]. Personas: [[Proto-personas|Ana, María y Diego]]. Los pasos numerados se corresponden con los [[User Flows]].

---

## J1 · Onboarding del hogar (María) — MVP

El momento más delicado del producto: María llega con el dispositivo recién comprado, esperanza y escepticismo a la vez. Si la configuración la frustra, el sistema muere en el cajón.

| Etapa | Qué hace María | Touchpoint | Siente | Oportunidad de diseño |
| --- | --- | --- | --- | --- |
| 1. Unboxing | Enchufa Aurora Home; el display saluda y muestra un código | Dispositivo | Curiosidad, ansiedad | El dispositivo guía por voz desde el primer minuto: «Hola. Para empezar, descargá Aurora Care…» |
| 2. Cuenta del hogar | Descarga la app, crea la **cuenta única del hogar** y vincula el dispositivo con el código | App (auth) | Foco | Un solo formulario corto; el vínculo por código de 6 dígitos, no QR obligatorio (puede no tener segunda cámara a mano) |
| 3. Perfil de Ana | Carga datos básicos + nivel de la enfermedad | App (wizard) | Cuidado, pudor | Explicar *para qué* se usa cada dato («el nivel ajusta la dificultad de los ejercicios») — genera confianza y cumple consentimiento informado (Ley 25.326) |
| 4. Rutinas mínimas | Carga 2-3 rutinas esenciales (medicación de la mañana, almuerzo) | App (wizard) | Alivio | Plantillas predefinidas editables; se puede saltar y completar después — el wizard nunca bloquea |
| 5. Primer recuerdo | Graba/escribe un recuerdo significativo | App (wizard) | Emoción | Prompt guiado; este paso convierte "configurar un aparato" en "presentarle mi mamá a Aurora" |
| 6. Cuidadores | Invita a Diego (link → registra su dispositivo) | App | Colaboración | Invitación por WhatsApp/link; Diego queda asociado a su dispositivo (modelo de cuenta única) |
| 7. Prueba en vivo | Aurora saluda a Ana con su nombre y el primer recordatorio de prueba | Dispositivo + app | **Momento wow** | Cierre del wizard: «Escuchá» — botón que dispara el saludo real. Confirmación emocional de que funciona |

**Métrica de éxito**: onboarding completo (pasos 1-4) en <15 minutos; el resto es diferible.

---

## J2 · Un día típico (Ana + María en paralelo) — MVP

| Hora | Lado Ana (Home) | Lado María (Care) |
| --- | --- | --- |
| 08:00 | «Buen día, Ana. Hoy es miércoles 9 de julio. Después del desayuno toca la pastilla de la presión.» | — |
| 08:20 | Ana: «Ya la tomé.» → confirmación registrada (RF-08) | Badge verde en el timeline: *Medicación 08:00 ✓* |
| 10:30 | Aurora propone ejercicio de memoria con fotos familiares (≤15 min) | — |
| 12:45 | Recordatorio de almuerzo + hidratación | — |
| 14:00 | Recordatorio de medicación. **Sin respuesta.** Reintento suave a los 10 min (margen configurado, RN7) | — |
| 14:15 | Sin confirmación → omisión registrada | **Notificación Media**: «Ana no confirmó la toma de las 14:00» + acciones |
| 14:17 | María hace **drop-in**: «Ma, ¿tomaste la pastilla?» — Ana confirma por voz | Marca la alerta como atendida; Diego ve el cierre |
| 18:30 | Reminiscencia vespertina: música de su juventud + charla sobre su casamiento (contra el atardecer difícil) | — |
| 21:30 | «Que descanses, Ana.» Display pasa a modo noche (hora tenue) | Resumen del día en la app: cumplimiento, actividades, sin pendientes |

**Insight de diseño**: el 90% del valor diario de Care es *pasivo* (ver que todo está bien). El dashboard optimiza para el vistazo de 5 segundos, no para la sesión larga.

---

## J3 · Alerta por omisión crítica → escalado (María ausente, Diego) — MVP

Escenario: medicación **prioritaria** de las 14:00 sin confirmar; María está en una reunión sin ver el teléfono.

| Min | Sistema | María | Diego |
| --- | --- | --- | --- |
| 0 | Omisión → alerta **Alta** (medicación prioritaria) | Push + sonido distintivo | — |
| 0-10 | Espera de respuesta (ventana configurada) | No responde | — |
| 10 | **Escalado** (RF-41) al siguiente contacto | — | Push con contexto: «Alerta sin atender por María» |
| 11 | — | — | Abre detalle: qué, cuándo, reintentos hechos. Hace drop-in |
| 13 | Ana confirma por voz → sistema registra cumplimiento tardío | Ve el cierre al salir de la reunión | Marca atendida con nota «hablé con mamá» |
| — | Alerta cerrada: generada → enviada → atendida → cerrada (RF-44), todo trazado (RN12) | Timeline actualizado | Timeline actualizado |

**Reglas de experiencia**: cada nivel de severidad tiene sonido/canal propio · el estado de atención es **compartido en tiempo real** (evita dobles llamadas) · el detalle de alerta siempre responde: *qué pasó, cuándo, qué hizo ya el sistema, qué puedo hacer yo*.

---

## J4 · Drop-in (Diego) — MVP

1. Diego toca **Hablar con mamá** en el dashboard.
2. La app recuerda la naturaleza del canal: audio **unidireccional** hacia el parlante (RN15).
3. Aurora Home anuncia con tono suave: «Ana, Diego te va a decir algo» — 3 s de gracia para no sobresaltar.
4. Diego habla (máx. 60 s); el display muestra «Mensaje de Diego 🔊».
5. Fin: Aurora pregunta a Ana si quiere responder algo → si dice que sí, transcribe la respuesta y se la envía a Diego como texto/audio en la app.

**Decisión de diseño**: aunque el canal es unidireccional (alcance MVP), el paso 5 cierra el loop emocional usando el pipeline STT existente — sin videollamada ni canal full-duplex.

---

## J5 · Sesión guiada de reminiscencia (María + Ana + Aurora) — MVP

Sábado a la tarde, sin apuro. María quiere hacer algo significativo con su madre pero no sabe "hacer terapia".

| Paso | María (app como coach) | Aurora Home | Ana | Diseño |
| --- | --- | --- | --- | --- |
| Elegir | Actividad → Terapias → «Reminiscencia: el casamiento» (sugerida) | — | — | La app sugiere según recuerdos con mejor respuesta previa |
| Preparar | Lee la pantalla previa: 10-15 min, sin TV de fondo, no corregir | Deja lista la música y la foto | — | Consejos = plantilla validable con especialistas (R1) |
| Apertura | «Preguntale por la primera vez que escuchó este tango» | Reproduce «Por una cabeza» bajito; foto en el display | Sonríe, empieza a contar | Aurora arranca y se corre: 1 intervención por paso (G10) |
| Exploración | Preguntas disparadoras de a una | Suma un dato del recuerdo si María lo pide | Cuenta detalles nuevos del vestido | La app registra participación sin interrumpir |
| Cierre | «Agradecele que te lo haya contado» | Baja la música, despide con calidez | Tranquila, contenta | Botón «Cerrar con calma» siempre visible |
| Después | Ve el resumen + 1 descubrimiento para validar («el vestido era de su madre») | — | — | El descubrimiento entra al circuito RN6 (F9) |

**Momento clave**: María descubre que puede hacer esto sola una vez por semana — el producto convirtió culpa («no sé cómo ayudarla») en capacidad.

## J6 · Fuga de zona segura *(visión — wireframes)*

Ana sale de la zona segura a las 16:40. Secuencia objetivo: detección por geofencing (RF-27) → alerta **Crítica** con mapa y última ubicación (US 3.2: push <30 s, acceso directo al mapa) → acciones: llamar a Ana, drop-in, marcar en camino → si nadie responde en la ventana crítica, **llamada automática** (RF-42). Pantallas en [[Handoff y Backlog de Diseño]].

---

## Momentos de la verdad (síntesis)

1. **Primer saludo de Aurora a Ana** (J1.7) — convierte la compra en confianza.
2. **Primera alerta real bien resuelta** (J3) — demuestra que el sistema avisa cuando importa y solo cuando importa.
3. **El vistazo diario de 5 segundos** (J2) — el hábito que retiene a María.
4. **El recuerdo que emociona** (J2 18:30) — el diferencial de Aurora frente a un pastillero inteligente.
5. **La primera sesión guiada que sale bien** (J5) — María pasa de espectadora a co-terapeuta; el producto le devuelve agencia.

## Documentos relacionados
- [[Proto-personas]] · [[User Flows]] · [[VUI — Diseño Conversacional]] · [[Arquitectura de Información — Aurora Care]]
