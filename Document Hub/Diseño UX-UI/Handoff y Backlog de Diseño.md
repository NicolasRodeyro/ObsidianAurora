---
base: "[[Document Hub.base]]"
Created time: 2026-07-09T11:30:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-09T11:30:00
---
# Handoff y Backlog de Diseño

Capítulo 11 del [[Manual de UX-UI Aurora]]. Este documento permite que **cualquiera del equipo retome el diseño** sin contexto previo: qué está hecho, qué está bloqueado, qué falta y cómo se contribuye.

## 1. Estado del diseño (09/07/2026)

| Artefacto | Estado | Dónde |
| --- | --- | --- |
| Manual UX/UI (11 capítulos) | ✅ Completo | `Document Hub/Diseño UX-UI/` |
| Design tokens + verificación WCAG | ✅ 34/34 pares AA | `Design/tokens/` + `Design/tools/contrast.py` |
| Componentes + 32 pantallas MVP (hi-fi HTML) | ✅ Aprobadas | `Design/previews/` (abrir `index.html`) |
| Display del dispositivo (6 estados) | ✅ | `Design/previews/screens-06-device.html` |
| Wireframes de visión (6) | ✅ lo-fi | `Design/previews/screens-07-vision.html` |
| Prototipo navegable (20 pantallas) | ✅ | `Design/prototype/aurora-care.html` |
| Tabla de wiring para Figma | ✅ | `Design/prototype/WIRING.md` |
| **Design system en Figma** | ⛔ **Bloqueado** | ver §2 |
| Prototipo en Figma | ⏸ Espera pantallas | wiring listo |

## 2. Bloqueo de Figma y cómo destrabarlo

**Situación**: el plan Starter de Figma limita el MCP a **6 llamadas de lectura/mes** (verificado 08/07: agotadas) y en la práctica **también bloquea `generate_figma_design`**, aunque la [doc oficial](https://help.figma.com/hc/en-us/articles/32132100833559) la lista como exenta. No hay vía MCP disponible con Starter.

**Caminos (en orden de preferencia):**
1. **Figma Education** — [figma.com/education](https://www.figma.com/education/) (en trámite por Jeremías). Gratis para estudiantes; con seat Full en plan Professional el límite sube a 200 llamadas/día. Al aprobarse: mover el archivo Aurora a un team Education y retomar el push automatizado (capturas de los previews + componentización con `use_figma`).
2. **Import manual con [html.to.design](https://www.figma.com/community/plugin/1159123024924461424)** (no consume MCP): `cd ObsidianAurora/Design && python3 -m http.server 8763`, y desde el plugin en Figma importar cada URL `http://localhost:8763/previews/<página>.html`. Genera capas editables. Después, cablear el prototipo con `Design/prototype/WIRING.md`.
3. Esperar el reset mensual (~01/08) — inútil en la práctica: solo 6 llamadas.

**Archivo Figma**: [Aurora](https://www.figma.com/design/27gwCErUw8a5VMKYBr0KDb/Aurora) — hoy contiene el moodboard original (7 imágenes + nota de paleta). Estructura de páginas sugerida al poblarlo: `Cover · Foundations · Componentes · MVP Mobile · MVP Desktop · Dispositivo · Visión · Moodboard (archivo)`.

## 3. Historias de usuario a agregar al backlog

El diseño de Terapias introdujo alcance sin RF/US propios (ver nota en [[Arquitectura de Información — Aurora Care]]). Borradores para refinar e ingresar a Jira (épicas sugeridas):

**US-D1 — Sesión guiada de terapia (épica AURA-18 / AURA-14)**
> Como cuidador sin formación terapéutica, quiero que la app me guíe paso a paso durante una sesión de reminiscencia con mi familiar, mientras Aurora Home acompaña con música y fotos, para poder estimularlo sin miedo a hacerle mal.
> **CA:** pasos con qué decir/qué evitar y qué hace Aurora en cada uno · botón «Cerrar con calma» siempre visible · máx. 1 intervención de voz de Aurora por paso (guion G10) · registro de duración/participación/ánimo · plantillas de pasos validadas por especialista (mitigación R1).

**US-D2 — Biblioteca de actividades terapéuticas (AURA-18)**
> Como cuidador, quiero ver un catálogo de actividades (trivia, lógica simple, juego de memoria, reminiscencia) con su modalidad («la hace Aurora» / «guiada por vos»), para elegir o programar la estimulación diaria.
> **CA:** filtros por tipo · sugerencia del día según respuesta previa · programable como rutina · métricas semanales de participación.

**US-D3 — Descubrimientos con validación (AURA-15)**
> Como cuidador principal, quiero revisar y aprobar la información nueva que Aurora capta del paciente durante las actividades, para que su memoria solo incorpore datos verificados.
> **CA:** todo hallazgo queda `pendiente` hasta validación (RN6) · Aurora no lo menciona hasta aprobarse · cola compartida con los aportes de cuidadores · trazabilidad de quién aprobó.

**US-D4 — Dificultad adaptativa (AURA-15)**
> Como sistema, quiero ajustar la dificultad de juegos y trivias según el desempeño registrado (RF-52), sin exponer nunca errores ni puntajes al paciente.

## 4. Backlog de diseño — visión (wireframes V1-V6 → hi-fi)

| Ítem | Wireframe | Qué falta decidir/diseñar |
| --- | --- | --- |
| Zonas seguras | V1 | ¿Múltiples zonas? ¿Horarios de vigencia? Interacción del radio en mobile; permisos de ubicación |
| Alerta con mapa | V2 | Proveedor de mapas; estados sin señal GPS; acción «voy en camino» multi-cuidador |
| Llamada automática | V3 | Guion TTS de la llamada (validar con especialista); confirmación DTMF; reintentos |
| Dashboard biométrico | V4 | Definir con el wearable real (post R2); bandas «normales» personalizadas; sin diagnóstico (RNF-21) |
| Reporte médico | V5 | Formato con la neuróloga (actor externo); anonimización para compartir |
| B2B multi-paciente | V6 | Roles/permisos, triage, turnos — rediseño del nivel superior de la IA (nota de escalabilidad) |

**Deuda de diseño (MVP):** derivar versiones del logo (isotipo solo, monocromo, sobre claro — [[Identidad de Marca]] §2.2) · dark mode completo de Care (tokens listos, pantallas no) · estados vacío/error/offline de cada pantalla (definidos en [[Arquitectura de Información — Aurora Care|IA]] §4, diseñados solo los patrones) · set definitivo de íconos Lucide (hoy: sprite propio de referencia) · ilustraciones de estados vacíos · pass de microcopy completo con el filtro de tono ([[Identidad de Marca]] §3) · pantallas de error de Auth0.

## 5. Cómo contribuir al design system

1. **Un color/tamaño nuevo nace en `tokens.json`**, nunca en una pantalla. Agregarlo con su par de verificación en `verificacion.pares` y correr `python3 Design/tools/contrast.py` — si falla, no se usa.
2. **Nomenclatura**: primitivos `familia-peso` (`violet-600`), alias semánticos `uso-variante` (`danger-solid-bg`). Los alias son los únicos que tocan las pantallas.
3. **Componentes**: la referencia viva es `Design/previews/app.css` + `components.html`. Nuevo componente = clase en `app.css` + ejemplo en `components.html` + (cuando haya Figma) componente con variantes.
4. **Pantalla nueva**: usar tokens y clases existentes; textos reales con el tono del manual (nunca lorem ipsum); diseñar los 5 estados (ideal/vacío/cargando/error/offline); verificar contra el checklist de [[Accesibilidad]] §4.
5. **El frontend Next.js consume `tokens.css` tal cual** — los nombres de variables CSS son el contrato entre diseño y código.

## 6. Validaciones pendientes (antes de congelar el diseño)

- [ ] **Especialistas** (R1): plantillas de sesión guiada, guiones VUI G1-G10, contenidos de estimulación cognitiva, formato del reporte médico.
- [ ] **Usability test cuidadores** (5-8 personas, plan en [[Accesibilidad]] §5): dashboard en 5 s, crear rutina, resolver alerta simulada.
- [ ] **Piloto con pacientes** (acompañado y con consentimiento): respuesta a recordatorios, tolerancia a la voz, botón SOS.
- [ ] **Revisión visual del Figma** cuando se pueble (el MCP no pudo verificar: revisar contra los previews HTML, que son la fuente de verdad visual).

## Documentos relacionados
- [[Manual de UX-UI Aurora]] (índice) · [[Arquitectura de Información — Aurora Care]] · [[User Flows]] · [[Accesibilidad]]
