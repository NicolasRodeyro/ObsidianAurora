---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T20:50:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-08T20:50:00
---
# Identidad de Marca

Capítulo 1 del [[Manual de UX-UI Aurora]].

## 1. Concepto

**Aurora** toma su nombre del fenómeno natural: una luz suave que aparece en plena oscuridad y permite orientarse sin encandilar. Esa es la promesa de marca condensada en el tagline:

> ## «Luz que acompaña»

La metáfora funciona en tres planos:

| Plano | Lectura |
| --- | --- |
| **Para el paciente** | Una presencia serena que orienta cuando la memoria falla — está, ilumina, no invade. |
| **Para el cuidador** | Visibilidad en la oscuridad: saber cómo está su familiar sin estar encima, y dormir más tranquilo. |
| **Para el producto** | El sistema actúa de noche y de día en segundo plano, y "se enciende" solo cuando hace falta. |

De acá salen las decisiones estéticas: fondos nocturnos profundos (Aurora Night `#0B1026`), el degradé aurora multicolor como firma visual, y una luz de acento (Glow Lime `#E5F06F`) que señala lo importante.

## 2. Logo

Referencias originales del moodboard en `Design/assets/branding/`:
- `logo-vertical-tagline.png` — isologo + wordmark + tagline sobre fondo nocturno con aurora.
- `logo-horizontal-dark.png` — versión horizontal sobre fondo oscuro.

### 2.1 Construcción
El **isotipo** es un domo (media cúpula) que contiene una aurora estilizada en degradé (violeta → rosa → durazno → menta → cielo) sobre un paisaje nocturno con estrellas. Remite a la vez a un amanecer, a un hogar que protege y a la pantalla curva del dispositivo Aurora Home.

El **wordmark** «AURORA» va en mayúsculas, sans geométrica de trazo uniforme, con tracking amplio (~8-12%). El tagline «Luz que acompaña» va debajo en peso regular, caja baja.

### 2.2 Versiones

| Versión | Uso | Estado |
| --- | --- | --- |
| Vertical (isotipo + wordmark + tagline) | Portadas, splash, packaging | ✅ existe (moodboard) |
| Horizontal (isotipo + wordmark) | Headers de app y documentos | ✅ existe (moodboard) |
| Isotipo solo | Favicon, ícono de app, avatar del asistente | ⚠️ derivar (ver [[Handoff y Backlog de Diseño]]) |
| Monocromo claro / oscuro | Fondos donde el degradé no funciona, impresión | ⚠️ derivar |
| Versión sobre fondo claro | Documentación, tema claro de Aurora Care | ⚠️ derivar |

### 2.3 Reglas de uso
- **Área de respeto**: mínimo la altura de la «A» del wordmark en todo el perímetro.
- **Tamaño mínimo**: wordmark legible — 24 px de alto para la versión horizontal digital; isotipo solo, 16 px.
- **Fondo preferido**: Aurora Night `#0B1026` o Deep Indigo `#171E42`. Sobre claro, usar la versión para fondo claro (pendiente) — nunca el degradé directo sobre blanco sin contorno.
- **Usos incorrectos**: no rotar, no estirar, no recolorear el degradé, no aplicar sombras duras, no colocar sobre fotos con ruido visual sin un scrim oscuro.

## 3. Tono de voz de marca

La voz de Aurora es **cálida, clara y serena**. Habla como una persona de confianza, no como un sistema ni como una enfermera condescendiente. Aplica a la app, al asistente de voz, a las notificaciones y a todo material externo.

| Principio | Sí ✓ | No ✗ |
| --- | --- | --- |
| **Claro antes que técnico** | «El dispositivo se quedó sin conexión» | «Error de conectividad WSS con Aurora Core» |
| **Sereno, no alarmista** | «Ana salió de la zona segura hace 5 min» | «🚨 ¡¡ALERTA!! ¡PACIENTE FUERA DE ZONA!» |
| **Sin culpa** | «No hay confirmación de la toma de las 14:00» | «Ana olvidó otra vez su medicación» |
| **Adulto, nunca infantil** (RNF-02) | «Buen día, Ana. Hoy es martes 8 de julio» | «¡Holis! ¿Cómo está mi abuelita hoy? 😊» |
| **Accionable** | «Llamala o marcá la alerta como atendida» | «Se registró un evento tipo 3» |
| **Breve** (RNF-01) | Frases de una idea. Máx. 40 palabras por turno de voz. | Párrafos con subordinadas encadenadas. |

**Vocabulario fijo** (consistencia en todas las superficies): *paciente* → en la UI siempre se usa su **nombre** («Ana»), nunca "el paciente" · *cuidador/a* · *rutina* (no "tarea") · *recuerdo* (no "dato biográfico") · *alerta* (no "notificación" cuando hay riesgo) · *zona segura* (no "geocerca") · *dispositivo* o *Aurora Home* (no "el parlante").

## 4. La marca en cada superficie

| Superficie | Expresión |
| --- | --- |
| **Aurora Care (app)** | Tema claro y funcional; la marca aparece en el header (logo horizontal), el degradé solo en momentos clave (onboarding, login, vacíos). El día a día es sobrio: la protagonista es la información del paciente. |
| **Aurora Home (display)** | Tema nocturno permanente ([[Color]], tema `device`). El anillo LED usa los colores de marca como lenguaje de estado ([[VUI — Diseño Conversacional]]). |
| **Documentación / tesis** | Portadas oscuras con degradé aurora; interior claro y legible. |

## Documentos relacionados
- [[Color]] · [[Tipografía]] · [[VUI — Diseño Conversacional]]
- [[Brainstorm de Nombres]] — origen del naming.
