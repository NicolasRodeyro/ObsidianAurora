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
- [ ] **Celular del paciente (piloto, acompañado y con consentimiento)**: escala tipográfica propia (20/24/28 px, tope 1,3×), pausa de «Descansamos un rato» a los ~15 minutos y si el sonido suave y la vibración sobresaltan o ayudan. Los valores son derivados, no probados ([[Tipografía]]).
- [ ] **Psicopedagoga — contenido de los juegos**: bancos de palabras, secuencias y dinero; preguntas y distractores de «Elegí la respuesta»; categorías de «Palabras que van juntas»; asignación del juego de la letra que falta; mapeo actividad → juego. Todo contenido nuevo figura «PENDIENTE DE REVISIÓN» hasta entonces.
- [ ] **Psicopedagoga — nombres, frases y secciones de la lista de juegos** (P12): «Con tus fotos y recuerdos», «Con palabras», «Con números, dinero y fechas», «Para ordenar y pensar»; el nombre y la frase de cada juego; el texto del aviso de juego bloqueado (P14).
- [ ] **Psicopedagoga — qué juegos se sugieren al empezar** (frame 43): hoy «Sugeridos para empezar» tilda reminiscencia, rompecabezas, parejas de fotos y calendario (sin respuesta «correcta» ni texto libre). Es una propuesta del equipo de desarrollo. También si el cuidador puede habilitar un juego cuyo contenido figura «en revisión».
- [ ] **Requisito funcional propio para «habilitar juegos del celular»**: la Arquitectura de Información ya reconoce que la sesión guiada «extiende el alcance original» y que el celular del paciente no tiene RF/US propios; elegir qué juegos tiene el paciente tampoco. Proponer RF (cuidador administrador elige; el paciente no ve lo no elegido) y su historia de usuario.
- [ ] **Requisito funcional para «recordatorios en el celular del paciente»**: RF-07/08/56 y US 2.1 sólo contemplan el recordatorio por voz en Aurora Home. Proponer RF/US propios (aviso local, «Ya lo hice», qué se ve en la pantalla bloqueada).
- [ ] **Psicopedagoga y salud — mostrar lo vencido del día** (P23): el celular ofrece «Se pasó la hora» con «Sí, ya lo hice» (confirmación tardía) para lo de hoy que nadie respondió. Decisión del equipo del 03/11/2026, que revisa la regla de no mostrar lo no hecho. Falta validar que, en pastillas, verlo no empuje a una toma tardía (riesgo de doble dosis) y si conviene un tope de horas por tipo.
- [ ] **Consentimiento y ANMAT de los avisos** (frames P20, P21, P23 y P27): datos de medicación en el celular del paciente no están cubiertos por los tres consentimientos de `Correcciones - 12-10-2026/09`; por eso los enciende un administrador y empiezan apagados. Falta decidir quién consiente (situaciones A/B/C) y validar con asesor si un aviso con confirmación acerca el producto a una «finalidad médica» (Disposición 64/2025). Evitar «tratamiento» y «adherencia» en el texto visible.
- [ ] **Qué pasa si no responde**: hoy nada. En el Inicio tampoco se muestra como atrasado o perdido (regla 18). «Todavía no» sólo vuelve a avisar a los 10 minutos y no registra nada: no hay un «No lo hice». No hay barrido que marque una toma vencida como omitida ni aviso al cuidador por omisión (tampoco lo dispara Aurora Home solo). Es una decisión de producto (AURA-180, cadencia de reconfirmación).
- [ ] **Pedir ayuda pasó de la barra a «Llamar»** (P25, regla 13): antes era un botón rojo anclado al pie de todas las pantallas (1 toque + confirmación); ahora son Llamar → «Necesito ayuda» + confirmación. Se hizo a pedido del equipo para que cada pantalla diga una sola cosa a una persona con pérdida de memoria. Validar con cuidadores y en el piloto que no se pierde tiempo en una emergencia; si pesa, El lugar de la barra ya se llama «Ayuda» (no «Llamar»); además es rojo sólido con borde fijo en la barra (desde el 03/11/2026).
- [ ] **El chip de ubicación mide lo que vio el celular, no Core** (P24, regla 19): los umbrales (verde < 5 min, amarillo < 15 min, rojo después) y los 2 minutos de «Conectando…» son provisorios. Cuenta lo ocurrido desde que se abrió la app; con la app cerrada por horas, el chip se pone en verde de nuevo recién cuando llega la primera lectura. Falta decidir con el equipo si el cuidador debe ver este mismo estado en Care.
- [ ] **Ajustes del paciente y la regla 7** (P26, regla 20): el celular ahora tiene una pantalla con controles (permisos, desactivar ubicación, claro/oscuro). Confirmar con la psicopedagoga que no desorienta; el modo oscuro puede ocultarse si molesta.
- [ ] **«Cómo le fue en el celular» pasó de Terapias a Métricas** (frames 42 y 45): sigue el selector de 7/30 días y sólo aparece con un celular vinculado. Falta decidir si el cuidador necesita un corte por semana o un gráfico de tendencia; hoy son barras relativas al juego más jugado y no hay regla de nivel (pendiente de la psicopedagoga).
- [ ] **«Cómo le gusta que le digan»** (frame P23): Core guarda un solo campo `name`, así que el saludo «¡Hola, María Fernanda!» se arma suponiendo que el apellido es lo último (con tres palabras es ambiguo: «Juan Pérez García» saluda «Juan Pérez»). Lo correcto es un campo propio en el perfil del paciente que cargue el cuidador; pendiente de decidir con el equipo.
- [ ] **Silencio nocturno y exactitud en Android**: los avisos no respetan todavía las horas de silencio del hogar, y en Android 12+ sin el permiso de alarma exacta pueden atrasarse unos minutos. Agregar ese permiso exige un build nativo nuevo.
- [ ] **Regla de dificultad adaptativa** (hoy «A VALIDAR»): mientras no se valide, el nivel de los juegos lo elige el cuidador y Aurora no lo cambia sola.
- [ ] **Línea base de los juegos del celular**: sesiones completadas vs. abandonadas por juego (meta del plan: ≥ 70 % terminadas). Todavía no se midió; el resumen por paciente de Terapias → Celular (frame 42) da los primeros datos.
- [ ] **Fuente Atkinson** para el celular del paciente: figura en el tema pero todavía no se empaqueta con `expo-font`.
- [ ] **Revisión visual del Figma** cuando se pueble (el MCP no pudo verificar: revisar contra los previews HTML, que son la fuente de verdad visual).

## Documentos relacionados
- [[Manual de UX-UI Aurora]] (índice) · [[Arquitectura de Información — Aurora Care]] · [[User Flows]] · [[Accesibilidad]]
