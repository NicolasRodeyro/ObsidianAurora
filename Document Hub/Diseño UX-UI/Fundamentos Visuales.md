---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T21:05:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-08T21:05:00
---
# Fundamentos Visuales

Capítulo 4 del [[Manual de UX-UI Aurora]]: iconografía, espaciado, grilla, radios, elevación y movimiento. Tokens en `Design/tokens/tokens.css`.

## 1. Iconografía

**Set base: [Lucide](https://lucide.dev)** (fork mantenido de Feather, licencia ISC, +1500 íconos, paquetes compatibles con React y React Native) — estilo de línea consistente con la estética liviana de la marca.

| Regla | Valor |
| --- | --- |
| Grilla | 24×24 px, área viva 20×20 |
| Trazo | 2 px, terminaciones redondeadas |
| Tamaños de uso | 16 (inline), 20 (controles), 24 (navegación, default), 32+ (estados vacíos) |
| Color | Hereda el color del texto acompañante; semánticos usan `*-icon` |

**Reglas de uso:**
1. **Ícono + texto, siempre**, en acciones y estados críticos. Ícono solo, únicamente en patrones universales (cerrar ✕, volver ←) y siempre con `aria-label`.
2. Un concepto = un ícono en todo el producto (mapa canónico en el design system de Figma): `pill` medicación · `calendar-clock` rutinas · `heart-pulse` biometría · `map-pin` ubicación · `bell` alertas · `book-heart` recuerdos · `cpu`/`speaker` dispositivo · `phone` llamada.
3. Los íconos no se rellenan (outline only); la versión filled queda reservada al estado activo de la navegación.

## 2. Espaciado — grilla 8pt

Escala: `4, 8, 12, 16, 24, 32, 40, 48, 64, 80` (tokens `--space-1…10`). Regla general: **padding interno de cards 16, gap entre cards 16, márgenes de pantalla 16 (mobile) / 24 (tablet+)**. Elementos relacionados a 8, secciones separadas a 32+.

**Áreas táctiles**: mínimo **44×44 px** para todo control interactivo (cuidadores con apuro y pulgares grandes; WCAG 2.5.8 pide ≥24, Apple HIG 44). En el display del dispositivo no hay touch en MVP (interacción por voz + botón físico SOS).

## 3. Grilla y breakpoints

| Breakpoint | Ancho | Layout de Aurora Care |
| --- | --- | --- |
| `mobile` | 390 px (diseño base) | 1 columna, márgenes 16, **bottom tab bar** de 5 ítems |
| `tablet` | 768 px | Contenido a 2 columnas donde aplique, márgenes 24 |
| `wide` | 1024+ px (referencia de pantalla amplia) | Sidebar opcional + contenido máx. 1040 px centrado |

Mobile-first: el cuidador secundario usa casi exclusivamente el teléfono ([[Proto-personas]]); la configuración pesada (onboarding, biografía) puede beneficiarse de pantallas amplias, pero debe ser 100% posible en mobile.

## 4. Radios

| Token | Valor | Uso |
| --- | --- | --- |
| `radius-sm` | 8 | Inputs, chips, badges |
| `radius-md` | 12 | Botones, cards internas |
| `radius-lg` | 16 | Cards principales, modales |
| `radius-xl` | 24 | Contenedores hero, display del dispositivo |
| `radius-full` | 999 | Pills, avatares, FAB, botón SOS |

Redondeado generoso = lenguaje amable del branding (el dispositivo físico es un gabinete de esquinas suaves). Nunca esquinas vivas.

## 5. Elevación

Tres niveles, sombras teñidas de `neutral-850` (nunca negro puro):

| Token | Sombra | Uso |
| --- | --- | --- |
| `shadow-1` | 0 1 2 / 6% | Cards en reposo |
| `shadow-2` | 0 2 8 / 10% | Cards interactivas hover, dropdowns, bottom bar |
| `shadow-3` | 0 8 24 / 14% | Modales, toasts, banner de alerta crítica |

En tema oscuro la elevación se expresa por **color de superficie** (`neutral-850 → 750 → 700`), no por sombra.

## 6. Motion

| Token | Valor | Uso |
| --- | --- | --- |
| `motion-instant` | 80 ms | Feedback táctil (press) |
| `motion-fast` | 160 ms | Hover, toggles, chips |
| `motion-base` | 240 ms | Transiciones de pantalla, modales, acordeones |
| `motion-slow` | 400 ms | Estados vacíos, celebraciones, gradiente aurora |
| `motion-easing` | `cubic-bezier(0.2, 0, 0, 1)` | Salida desacelerada, estándar en todo |

**Principios:**
1. **Funcional, no decorativo**: el movimiento comunica causa-efecto (de dónde vino el modal, qué card se actualizó). Nada se anima "porque sí".
2. **Respetar reducción de movimiento del sistema**: el token ya está definido y la app debe mapearlo a la API de accesibilidad correspondiente — todas las animaciones colapsan a instantáneas.
3. **Las alertas críticas no parpadean**: una alerta SOS aparece con un slide firme y **queda estática**; el parpadeo continuo aumenta la ansiedad y puede disparar fotosensibilidad (WCAG 2.3.1). El pulso lento (1 ciclo/2 s) queda solo para el anillo LED del dispositivo.
4. En el display del dispositivo, las transiciones son **lentas y suaves** (400 ms+): los cambios bruscos de pantalla confunden al paciente.

## 7. Estados interactivos (todas las superficies de Care)

| Estado | Tratamiento |
| --- | --- |
| Hover (solo puntero) | Fondo 4-8% del color de acción / `shadow-2` en cards |
| Pressed | Escala 0.98 + fondo 12% |
| Focus visible | **Anillo 2 px `--focus-ring` + offset 2 px** — nunca se elimina el outline |
| Disabled | 40% de opacidad + cursor default; nunca ocultar la acción primaria de una pantalla |
| Loading | Skeleton con shimmer suave (no spinners salvo acciones puntuales) |

## Documentos relacionados
- [[Color]] · [[Tipografía]] · [[Accesibilidad]]
