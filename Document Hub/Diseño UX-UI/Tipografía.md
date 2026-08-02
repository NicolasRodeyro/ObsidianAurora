---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T21:00:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-08T21:00:00
---
# Tipografía

Capítulo 3 del [[Manual de UX-UI Aurora]]. Tokens en `Design/tokens/tokens.css` (`--font-*`, `--text-*`).

## 1. Familias

Tres familias, una por rol. Todas de licencia libre (SIL OFL) y disponibles en Google Fonts — compatible con la restricción de presupuesto del [[Project Charter]] (licencias $0).

| Rol | Familia | Por qué |
| --- | --- | --- |
| **Títulos y marca** | [Figtree](https://fonts.google.com/specimen/Figtree) | Geométrica humanista, cálida y redondeada — hereda el carácter amable del wordmark sin necesitar una fuente display propia. Variable (300-900). |
| **Cuerpo y UI** | [Inter](https://fonts.google.com/specimen/Inter) | Estándar de facto para interfaces: x-height alta, excelente en tamaños chicos, **números tabulares** (clave para horarios de medicación y datos biométricos), variable. |
| **Display del dispositivo** | [Atkinson Hyperlegible Next](https://fonts.google.com/specimen/Atkinson+Hyperlegible+Next) | Diseñada por el [Braille Institute](https://www.brailleinstitute.org/freefont/) para maximizar legibilidad con baja visión: formas de caracteres exageradamente diferenciadas (I/l/1, O/0). Ideal para lectura a 2-3 m por adultos mayores. |

**Fallbacks**: `Figtree → Inter → system-ui` · `Inter → system-ui` · `Atkinson Hyperlegible Next → Atkinson Hyperlegible → Inter`.

## 2. Escala

Base 16 px, escala contenida (pocos tamaños, bien usados). Idioma es-AR.

### Aurora Care (app del cuidador)

| Token | Tamaño / línea | Peso | Uso |
| --- | --- | --- | --- |
| `text-4xl` | 36 / 1.2 | Figtree 700 | Hero de marketing/onboarding |
| `text-3xl` | 30 / 1.2 | Figtree 700 | Título de pantalla |
| `text-2xl` | 24 / 1.2 | Figtree 600 | Título de sección |
| `text-xl` | 20 / 1.3 | Figtree 600 | Título de card |
| `text-lg` | 18 / 1.5 | Inter 400/600 | Cuerpo destacado, valor de dato |
| `text-md` | **16 / 1.5** | Inter 400 | **Cuerpo base — mínimo para contenido** |
| `text-sm` | 14 / 1.4 | Inter 500 | Labels, botones secundarios, tabs |
| `text-xs` | 12 / 1.4 | Inter 500 | Timestamps, metadatos. **Nunca información crítica.** |

### Display de Aurora Home

Visible a 2-3 metros por una persona mayor: los tamaños son ~2× los de la app.

| Token | Tamaño | Peso | Uso |
| --- | --- | --- | --- |
| `text-device-clock` | 72 px | Atkinson 700 | Hora en reposo |
| `text-device-title` | 48 px | Atkinson 700 | Saludo, título del recordatorio («Hola, Ana») |
| `text-device-body` | **32 px** | Atkinson 400 | **Mínimo absoluto del display** — fecha, cuerpo del mensaje |

## 3. Reglas

1. **16 px es el piso** para todo contenido en Care; 14 px solo para labels/controles; 12 px solo metadatos.
2. **Números tabulares** (`font-variant-numeric: tabular-nums`) en horarios, dosis, signos vitales y cualquier columna de datos — evita que los valores "bailen" al actualizarse.
3. **Line-height**: 1.5 para cuerpo (WCAG 1.4.8 lo recomienda como mínimo), 1.2 solo en títulos.
4. **Largo de línea**: 45-75 caracteres en textos corridos; en el display del dispositivo, máximo 2 líneas por mensaje.
5. **Peso antes que tamaño** para jerarquizar dentro de un mismo bloque (600 vs 400); tamaño para saltos de nivel.
6. **Sin mayúsculas sostenidas** en frases (solo en el wordmark y labels muy cortos tipo "SOS") — las versalinas dificultan la lectura a personas con deterioro cognitivo.
7. **Sin cursivas** para contenido funcional — legibilidad ante todo; la itálica solo en citas de la documentación.
8. El **texto del display** se escribe pensado para ser *leído en voz alta* por TTS a la vez que se muestra: una idea por pantalla, sin abreviaturas («martes 8 de julio», no «mar 08/07»).

## 4. Carga técnica

- App (React Native + Expo): fuentes `Figtree` e `Inter` empaquetadas con `expo-font`; carga controlada antes de mostrar la UI inicial.
- Device (Raspberry Pi, render local): archivos `woff2/ttf` de Atkinson Hyperlegible Next empaquetados con la imagen del SO — el display no depende de red.
- Previews HTML: Google Fonts CDN (solo para diseño).

## Documentos relacionados
- [[Color]] · [[Fundamentos Visuales]] · [[Accesibilidad]] · [[VUI — Diseño Conversacional]]
