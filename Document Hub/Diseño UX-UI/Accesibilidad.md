---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T22:10:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-08T22:10:00
---
# Accesibilidad

Capítulo 10 del [[Manual de UX-UI Aurora]]. Piso normativo: **[WCAG 2.2](https://www.w3.org/TR/WCAG22/) nivel AA** en Aurora Care y en el display de Aurora Home. Encima del piso: pautas específicas para deterioro cognitivo (paciente) y uso bajo estrés (cuidadores).

## 1. Compromisos WCAG 2.2 AA (y cómo se cumplen)

| Criterio | Compromiso en Aurora |
| --- | --- |
| 1.4.3 / 1.4.11 Contraste | 34/34 pares de tokens verificados por script ([[Color]] §5); tokens nuevos no entran sin pasar `contrast.py` |
| 1.4.4 Resize text | Layout funcional al 200% de zoom; unidades relativas en Care |
| 1.4.10 Reflow | PWA responsive desde 320 px sin scroll horizontal |
| 1.4.12 Text spacing | Line-height ≥1.5 en cuerpo ([[Tipografía]]) |
| 2.1 Teclado | Toda la app operable por teclado (sidebar desktop incluida); orden de foco = orden visual |
| 2.4.7 / 2.4.13 Focus | Anillo de foco 2 px `--focus-ring` + offset, nunca suprimido ([[Fundamentos Visuales]] §7) |
| 2.3.1 Destellos | Nada parpadea >3/s; las alertas críticas son estáticas (el pulso lento vive solo en el LED del dispositivo) |
| 2.5.8 Target size | Controles ≥44×44 px (por encima del mínimo 24×24 de WCAG) |
| 3.2.3 Navegación consistente | Tabs/sidebar idénticos en toda la app; mismos íconos = mismos significados |
| 3.3.1-3.3.4 Errores | Mensajes junto al campo, en lenguaje claro, con cómo corregir; confirmación antes de acciones con consecuencias |
| 4.1.2-4.1.3 Semántica/estados | Componentes con roles ARIA correctos; alertas nuevas anunciadas vía `aria-live` |
| 1.1.1 / 1.4.1 No solo color | Todo estado semántico = color + ícono + texto (regla dura de [[Color]] §3) |

## 2. Accesibilidad cognitiva — el paciente

El display y la voz de Aurora Home se diseñan para una persona con GDS ≤5. Referencia adicional: [W3C Making Content Usable for People with Cognitive Disabilities](https://www.w3.org/TR/coga-usable/).

1. **Cero aprendizaje requerido** (RNF del Estudio Inicial): no hay menúes, gestos ni comandos que memorizar. Aurora inicia las interacciones; el único control físico es el botón SOS rojo.
2. **Lenguaje literal**: sin metáforas, ironía ni frases hechas — se interpretan mal con deterioro cognitivo. «Es la hora de tu pastilla», no «no te olvides de tus remediitos».
3. **Redundancia bimodal**: lo hablado se muestra y lo mostrado se habla ([[VUI — Diseño Conversacional]] §5) — cubre pérdida auditiva y visual parcial, frecuentes en +75.
4. **Orientación permanente**: fecha, hora y próxima actividad siempre en el display — apoyo directo a la memoria prospectiva ([[Investigacion sobre neurologia]]).
5. **Sin presión temporal**: los diálogos no expiran castigar el silencio; el cierre del micrófono a los 10 s termina con despedida amable y la información queda en el display.
6. **Sin registro de fracaso frente al paciente**: los ejercicios no puntúan en voz alta ni muestran errores; las métricas van solo al historial del cuidador.
7. **El dispositivo no debe poder desconfigurarse por el paciente** ([[Investigacion sobre neurologia]], nota final): sin controles táctiles de configuración en el display; todo se administra desde Care.

## 3. Uso bajo estrés — el cuidador

Una alerta crítica se lee corriendo, con el corazón acelerado, quizá de noche.

1. **Pantallas de alerta autosuficientes**: qué pasó + cuándo + qué hizo el sistema + 2-3 acciones máximo, en botones grandes. Nada de información que obligue a navegar para decidir (RN14: el cuidador decide).
2. **Jerarquía de interrupción proporcional a severidad** (Baja acumula en resumen · Media push estándar · Alta sonido distintivo · Crítica sonido insistente + pantalla completa). Proporcionalidad = confianza; confianza = menos fatiga de alarmas (problema documentado en el Estudio Inicial).
3. **Una mano, un pulgar**: acciones críticas alcanzables en la zona inferior de la pantalla en mobile.
4. **Estados compartidos en tiempo real**: «Atendida por María 14:17» — reduce ansiedad y dobles llamadas ([[Proto-personas|Diego]]).
5. **Modo offline honesto**: dato + timestamp de última sincronización, nunca datos viejos presentados como actuales.

## 4. Checklist por pantalla (para la fase de diseño y QA)

- [ ] Contraste de todos los pares presentes verificado (tokens ya validados = gratis si no se inventan colores)
- [ ] Estados: ideal / vacío / cargando / error / offline diseñados
- [ ] Foco visible y orden lógico; operable por teclado
- [ ] Targets ≥44 px; acciones primarias en zona de pulgar (mobile)
- [ ] Estado semántico = color + ícono + texto
- [ ] Texto real (no imágenes de texto); `alt` en imágenes significativas
- [ ] `aria-live` en contenido que se actualiza solo (alertas, estado del paciente)
- [ ] Sin información crítica en `text-xs`
- [ ] Copy pasado por el filtro de tono ([[Identidad de Marca]] §3): claro, sin culpa, accionable

## 5. Validación con usuarios (plan para el piloto)

- **Cuidadores (5-8, 40-70 años)**: tareas — interpretar el dashboard en 5 s, crear una rutina, resolver una alerta simulada de punta a punta. Métrica: éxito sin ayuda + SUS.
- **Pacientes (con acompañamiento profesional y consentimiento, R1/R4 del [[Project Charter]])**: sesiones cortas observadas de interacción con Aurora Home — tasa de respuesta a recordatorios, señales de confusión o rechazo ante la voz.
- Los hallazgos actualizan este manual y las [[Proto-personas]].

## Documentos relacionados
- [[Color]] · [[Tipografía]] · [[Fundamentos Visuales]] · [[VUI — Diseño Conversacional]]
