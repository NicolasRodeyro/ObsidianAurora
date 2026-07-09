---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T20:55:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-08T20:55:00
---
# Color

Capítulo 2 del [[Manual de UX-UI Aurora]]. Fuente de verdad programática: `Design/tokens/tokens.json` (v1.0.0) → `Design/tokens/tokens.css`. Verificación automática: `python3 Design/tools/contrast.py`.

## 1. Filosofía: un sistema, tres temas

La paleta original del branding (moodboard de Figma, `Design/assets/branding/paleta-sistema-aurora.png`) es **nocturna**: identidad de marca y dispositivo. Para la app del cuidador la extendimos a un **tema claro por defecto**, por tres razones:

1. **Contexto de uso**: Aurora Care se consulta de día, entre tareas, muchas veces al aire libre o en ambientes iluminados; un tema claro rinde mejor en esas condiciones.
2. **Audiencia**: cuidadores de 40-70 años; sobre fondo claro el texto oscuro tolera mejor tamaños pequeños y astigmatismo (halación del texto claro sobre oscuro).
3. **Carácter**: la app es una herramienta de salud — sobria y confiable; la noche queda para la marca y el dispositivo.

| Tema | Dónde | Base |
| --- | --- | --- |
| **Claro** (default) | Aurora Care | Fondo `neutral-50`, superficies blancas |
| **Oscuro** | Identidad, marketing, dark mode de Care | Aurora Night `#0B1026` + Deep Indigo `#171E42` |
| **Device** | Display de Aurora Home | `neutral-900`, texto blanco grande, acento lima |

## 2. Primitivos

Los valores marcados **[B]** provienen del branding original; el resto son rampas derivadas para cumplir WCAG 2.2 AA (ver §5).

### Violeta — marca y acción
| Token | Hex | Nota |
| --- | --- | --- |
| `violet-50` | `#F4F0FF` | fondos sutiles |
| `violet-100` | `#E7DEFF` | |
| `violet-200` | `#CFBBFF` | |
| `violet-300` | `#A884FF` | **[B] Aurora Violet** — marca en fondos oscuros |
| `violet-400` | `#9773FD` | **[B]** inicio del degradé de marca; focus ring |
| `violet-500` | `#7C5CEE` | botón primario en dark |
| `violet-600` | `#6E4FE0` | **[B]** fin del degradé; **acción primaria y links en tema claro** |
| `violet-700` | `#5638BE` | hover de acción primaria |
| `violet-800` | `#3F2792` | |
| `violet-900` | `#2A1A64` | |

### Lima — acento (Glow Lime)
| Token | Hex | Nota |
| --- | --- | --- |
| `lime-50…200` | `#FBFDE9` `#F5FACB` `#EDF59D` | fondos sutiles |
| `lime-300` | `#E5F06F` | **[B] Glow Lime** — CTA/acento, siempre con texto `neutral-850` |
| `lime-400…600` | `#D3E24D` `#B4C531` `#8FA021` | |
| `lime-700…900` | `#5F6C14` `#48520E` `#2E3407` | texto lima sobre claro |

### Neutros — del blanco a la noche
| Token | Hex | Nota |
| --- | --- | --- |
| `neutral-0` | `#FFFFFF` | **[B]** superficies en claro |
| `neutral-50` | `#F5F7FC` | fondo base en claro |
| `neutral-100` | `#E9EDF7` | **[B] N100** |
| `neutral-200` | `#D2D9EA` | bordes decorativos |
| `neutral-300` | `#B8C0D9` | **[B] N300** — bordes fuertes |
| `neutral-400` | `#848DB0` | borde de inputs (≥3:1 sobre blanco) |
| `neutral-500` | `#697298` | **[B] N500** — texto muted |
| `neutral-600` | `#4D5679` | texto secundario en claro |
| `neutral-700` | `#232B52` | **[B] N700** — superficies elevadas en dark |
| `neutral-750` | `#171E42` | **[B] Deep Indigo** — texto primario en claro / superficie en dark |
| `neutral-800` | `#0F1530` | **[B] N800** |
| `neutral-850` | `#0B1026` | **[B] Aurora Night** — fondo base en dark |
| `neutral-900` | `#070B1A` | **[B] N900** — fondo del display |

### Semánticos
Cada familia tiene: `50/100` (fondos), `300` (**[B]** el valor pastel original — solo sobre fondos oscuros o como decoración), `600` (íconos sobre claro), `700` (texto sobre claro).

| Familia | 100 (fondo) | 300 [B] | 600 (ícono) | 700 (texto) |
| --- | --- | --- | --- | --- |
| **Éxito** (green) | `#D6F3E4` | `#7FD6A8` | `#1F8A57` | `#136343` |
| **Info** (blue) | `#DCE9FF` | `#8EB8FF` | `#2E62D9` | `#2450AE` |
| **Advertencia** (amber) | `#FFEBC5` | `#FFD27A` | `#A96A00` | `#8A5600` |
| **Emergencia/SOS** (red) | `#FAD7D7` | `#F29B9B` | `#C93535`* | `#A62828` |

\* El rojo agrega `red-500 #E84B4B` **[B]**: es el color físico del botón SOS del dispositivo y de las superficies de emergencia en dark. En tema claro, los botones de emergencia usan `red-600` (5.19:1 con texto blanco).

### Decorativos (secundarios del branding)
`pink #F5A6D3` · `peach #FFD6A8` · `mint #BDEFD4` · `sky #BFD7FF` · `lilac #D9C5FF` — **[B]** todos. Solo para ilustración, gráficos de datos (con etiqueta, nunca como única codificación) y el gradiente aurora. **No** llevan texto encima salvo `neutral-850`.

### Gradientes
- **Degradé de marca**: `violet-400 → violet-600` (135°). Botón primario destacado, headers de onboarding.
- **Gradiente aurora**: `violet-300 → pink → peach → mint → sky` (90°). Firma visual: covers, splash, momentos de celebración. Nunca como fondo de texto ni de componentes funcionales.

## 3. Alias semánticos por tema

La UI **nunca** usa primitivos directamente: consume alias (`--bg-base`, `--text-primary`, `--action-primary-bg`…). Mapa completo en `tokens.css`. Reglas duras:

1. **Violeta = marca y acción.** Todo lo clickeable primario es violeta. Nada decorativo es violeta.
2. **Lima = acento y "activo/en vivo".** Estados en curso (asistente escuchando, rutina en progreso, CTA destacado). Siempre con texto oscuro.
3. **Rojo = solo emergencia y acciones destructivas.** Nunca para errores de validación menores (eso es advertencia). El SOS tiene tratamiento propio y reservado.
4. **Estado ≠ solo color.** Todo estado semántico lleva ícono + texto (ver [[Accesibilidad]]).
5. **Un token, un significado** — si un color nuevo hace falta, se agrega a `tokens.json`, se verifica contraste y recién ahí se usa.

## 4. El color en el dispositivo (anillo LED)

El anillo LED de Aurora Home usa el mismo lenguaje (detalle de estados en [[VUI — Diseño Conversacional]]):

| LED | Color base | Significado |
| --- | --- | --- |
| Respiración suave violeta | `violet-300` | Escuchando |
| Barrido aurora | gradiente | Hablando / saludando |
| Pulso lima | `lime-300` | Recordatorio activo esperando confirmación |
| Pulso rojo | `red-500` | SOS / emergencia |
| Ámbar fijo tenue | `amber-300` | Sin conexión (modo degradado) |
| Apagado | — | Reposo |

## 5. Contraste verificado (WCAG 2.2)

Salida de `Design/tools/contrast.py` sobre `tokens.json` v1.0.0 — **34/34 pares cumplen**. Niveles: AA = 4.5:1 texto normal · AA-large = 3:1 texto ≥24 px (o ≥18.7 px bold) · UI = 3:1 componentes (WCAG 1.4.11) · AAA = 7:1.

| Uso | fg | bg | Ratio | Req. |
| --- | --- | --- | --- | --- |
| claro: texto primario / fondo base | `neutral-750` | `neutral-50` | 15.06 | AAA ✓ |
| claro: texto primario / superficie | `neutral-750` | `neutral-0` | 16.14 | AAA ✓ |
| claro: texto secundario / superficie | `neutral-600` | `neutral-0` | 7.18 | AA ✓ |
| claro: texto muted / superficie | `neutral-500` | `neutral-0` | 4.71 | AA ✓ |
| claro: links / superficie | `violet-600` | `neutral-0` | 5.44 | AA ✓ |
| claro: botón primario | `neutral-0` | `violet-600` | 5.44 | AA ✓ |
| claro: botón secundario / fondo | `violet-600` | `neutral-50` | 5.08 | AA ✓ |
| claro: acento lima | `neutral-850` | `lime-300` | 15.25 | AA ✓ |
| claro: badge éxito | `green-700` | `green-100` | 6.15 | AA ✓ |
| claro: badge info | `blue-700` | `blue-100` | 6.05 | AA ✓ |
| claro: badge advertencia | `amber-700` | `amber-100` | 5.26 | AA ✓ |
| claro: badge peligro | `red-700` | `red-100` | 5.33 | AA ✓ |
| claro: botón SOS | `neutral-0` | `red-600` | 5.19 | AA ✓ |
| claro: ícono éxito / superficie | `green-600` | `neutral-0` | 4.35 | UI ✓ |
| claro: ícono info / superficie | `blue-600` | `neutral-0` | 5.43 | UI ✓ |
| claro: ícono advertencia / superficie | `amber-600` | `neutral-0` | 4.42 | UI ✓ |
| claro: borde de inputs / superficie | `neutral-400` | `neutral-0` | 3.27 | UI ✓ |
| claro: focus ring / superficie | `violet-400` | `neutral-0` | 3.39 | UI ✓ |
| oscuro: texto primario / fondo | `neutral-0` | `neutral-850` | 18.81 | AAA ✓ |
| oscuro: texto secundario / superficie | `neutral-300` | `neutral-750` | 8.90 | AA ✓ |
| oscuro: texto muted / superficie | `neutral-400` | `neutral-750` | 4.93 | AA-large ✓ |
| oscuro: texto brand / fondo | `violet-300` | `neutral-850` | 6.64 | AA ✓ |
| oscuro: botón primario | `neutral-0` | `violet-500` | 4.54 | AA ✓ |
| oscuro: CTA lima | `neutral-850` | `lime-300` | 15.25 | AA ✓ |
| oscuro: éxito / superficie | `green-300` | `neutral-750` | 9.29 | AA ✓ |
| oscuro: info / superficie | `blue-300` | `neutral-750` | 8.03 | AA ✓ |
| oscuro: advertencia / superficie | `amber-300` | `neutral-750` | 11.34 | AA ✓ |
| oscuro: SOS (botón grande) | `neutral-0` | `red-500` | 3.79 | AA-large ✓ |
| device: texto principal / display | `neutral-0` | `neutral-900` | 19.59 | AAA ✓ |
| device: texto secundario / display | `neutral-300` | `neutral-900` | 10.80 | AAA ✓ |
| device: acento lima / display | `lime-300` | `neutral-900` | 15.88 | AA ✓ |
| device: anillo escucha / display | `violet-300` | `neutral-900` | 6.91 | UI ✓ |
| device: SOS | `neutral-0` | `red-500` | 3.79 | AA-large ✓ |

> [!warning] Restricciones que salen de esta tabla
> - `violet-300` (Aurora Violet) y los semánticos `300` **no alcanzan AA sobre blanco** → en tema claro son solo decorativos; el texto usa las variantes `600/700`.
> - El SOS sobre `red-500` solo cumple como **texto grande** → los botones/indicadores SOS siempre usan tipografía ≥24 px o equivalente bold.
> - Cualquier token nuevo debe agregarse a `verificacion.pares` de `tokens.json` y pasar el script **antes** de usarse.

## Documentos relacionados
- [[Identidad de Marca]] · [[Fundamentos Visuales]] · [[Accesibilidad]]
