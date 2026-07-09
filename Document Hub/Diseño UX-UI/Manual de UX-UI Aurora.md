---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T20:45:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-08T20:45:00
---
# Manual de UX/UI — Aurora

Este es el punto de entrada al sistema de diseño de Aurora. Reúne la identidad de marca, los fundamentos visuales, la investigación de usuarios, los flujos y las guidelines que gobiernan **todas las superficies** del producto: la app del cuidador ([[Arquitectura de Información — Aurora Care|Aurora Care]]), el display y los LEDs del dispositivo ([[VUI — Diseño Conversacional|Aurora Home]]) y la comunicación de marca.

> [!info] Cómo usar este manual
> Cada capítulo es un documento independiente de esta carpeta. Las **decisiones** viven acá (con su justificación); los **artefactos ejecutables** viven en `Design/` (tokens, previews HTML, prototipo) y en el archivo de Figma. Si un valor difiere entre el manual y `Design/tokens/tokens.json`, manda el `tokens.json` — es la fuente de verdad programática.

## Capítulos

### Fundamentos
1. [[Identidad de Marca]] — concepto, logo, tagline, tono de voz.
2. [[Color]] — paleta, tokens, temas claro/oscuro/device, contraste verificado.
3. [[Tipografía]] — familias, escala, reglas de legibilidad.
4. [[Fundamentos Visuales]] — iconografía, espaciado, grilla, radios, elevación, motion.

### Investigación y estrategia UX
5. [[Proto-personas]] — cuidadora primaria, cuidador a distancia, paciente, institucional.
6. [[Journeys y Escenarios]] — onboarding, día típico, alerta crítica, drop-in.
7. [[Arquitectura de Información — Aurora Care]] — sitemap, navegación, contenido por pantalla.
8. [[User Flows]] — flujos MVP y de visión en Mermaid.
9. [[VUI — Diseño Conversacional]] — principios, guiones, estados del LED y del display.
10. [[Accesibilidad]] — WCAG 2.2 AA + pautas para deterioro cognitivo y cuidadores bajo estrés.

### Ejecución
11. [[Handoff y Backlog de Diseño]] — estado del design system, visión pendiente, cómo retomar.

## Entregables y dónde viven

| Artefacto | Ubicación | Estado |
| --- | --- | --- |
| Manual (este documento + capítulos) | `Document Hub/Diseño UX-UI/` | En construcción |
| Design tokens (fuente de verdad) | `Design/tokens/tokens.json` + `tokens.css` | ✅ v1.0.0, contraste verificado |
| Verificador de contraste WCAG | `Design/tokens/../tools/contrast.py` | ✅ 34/34 pares cumplen |
| Referencias del branding original | `Design/assets/branding/` | ✅ rescatadas del moodboard |
| Previews HTML (foundations, componentes, pantallas) | `Design/previews/` | En construcción |
| Prototipo HTML navegable | `Design/prototype/` | Pendiente |
| Design system + pantallas en Figma | [Archivo Aurora](https://www.figma.com/design/27gwCErUw8a5VMKYBr0KDb/Aurora) | Pendiente (hoy: moodboard) |

## Principios de diseño

Estos seis principios ordenan cualquier decisión de diseño en Aurora. Ante un conflicto, gana el de número menor.

1. **Lo crítico primero.** Una alerta de emergencia importa más que cualquier otra cosa en pantalla. La jerarquía visual refleja la jerarquía de riesgo (RNF-30, RNF-33): SOS > alertas preventivas > estado > configuración.
2. **Calma, no alarma.** El producto acompaña una enfermedad dura. La interfaz informa sin dramatizar: colores serenos, lenguaje directo, cero culpa ("Ana no confirmó la toma de las 14:00" — nunca "¡Ana olvidó su medicación!").
3. **Una acción principal por pantalla.** Tanto el cuidador estresado como el paciente con deterioro cognitivo se benefician de lo mismo: saber exactamente qué hacer ahora. Cada pantalla tiene un CTA dominante; lo demás es secundario.
4. **Nunca infantilizar.** El paciente es un adulto (RNF-02). La voz, el display y la app le hablan a adultos: tono cálido pero respetuoso, sin diminutivos, sin emojis decorativos en la comunicación con el paciente.
5. **Visible de un vistazo.** El cuidador revisa la app entre tareas; el paciente ve el display a 2-3 metros. Estados legibles en segundos: color + ícono + texto, nunca solo color.
6. **Confianza mediante consistencia.** Mismos patrones en todas las superficies: el violeta siempre es marca/acción, el lima siempre es acento/positivo-activo, el rojo solo emergencias. Un token, un significado.

## Alcance de esta versión

- **MVP en alta fidelidad** — según la línea de corte del [[Product Backlog Inicial]] y el User Story Map: cuenta y perfiles, rutinas y medicación, biografía/recuerdos, terapia cognitiva (superficie de configuración), monitoreo de estado, historial y alertas por omisión.
- **Visión en wireframes** — pulsera/biometría, geofencing y mapa, escalado de alertas con llamada, reportes médicos, multi-cuidador con permisos. Detalle para retomar en [[Handoff y Backlog de Diseño]].

## Documentos relacionados
- [[Requerimientos]] — 91 RF / 43 RNF que este diseño materializa.
- [[Investigacion sobre neurologia]] — base clínica de las decisiones de VUI y estimulación cognitiva.
- [[Project Charter]] — alcance, restricciones y perfil clínico (FAST ≤5).
- [[Arquitectura y Stack Tecnológico]] — Aurora Care es una PWA Next.js; los tokens CSS se consumen directo.
