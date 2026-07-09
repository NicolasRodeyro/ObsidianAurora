# Wiring del prototipo Figma — Aurora Care

Tabla de conexiones para cablear el prototipo en Figma una vez que las pantallas estén en el archivo (bloqueado hoy por el rate limit del MCP; ver [[Handoff y Backlog de Diseño]]). Los números de pantalla corresponden a los frames de `Design/previews/`. El prototipo HTML equivalente ya funciona: `Design/prototype/aurora-care.html`.

**Configuración del prototipo Figma**: device *iPhone 14/15 (390)* · frame inicial **01 Login** · animación por defecto *Smart animate 240 ms, easing ease-out* (token `--motion-base`) · overlays con fondo `#0B1026` al 50%.

## Flujo principal (demo de la defensa)

| # | Pantalla origen | Hotspot | Destino | Transición |
|---|---|---|---|---|
| 1 | 01 Login | botón «Ingresar» | 08 Inicio | Push ← |
| 2 | 01 Login | «Crear la cuenta del hogar» | 02 Crear cuenta | Push ← |
| 3 | 02 Crear cuenta | «Crear cuenta» | 03 Wizard 1 (vincular) | Push ← |
| 4 | 03 Wizard 1 | «Vincular» | 04 Wizard 2 (perfil) | Push ← |
| 5 | 04 Wizard 2 | «Continuar» | 05 Wizard 3 (rutinas) | Push ← |
| 6 | 05 Wizard 3 | «Continuar» / «Omitir» | 06 Wizard 4 (recuerdo) | Push ← |
| 7 | 06 Wizard 4 | «Guardar y continuar» / «Omitir» | 07 Wizard 5 (cuidadores + prueba) | Push ← |
| 8 | 07 Wizard 5 | «Ir al inicio» | 08 Inicio | Dissolve |
| 9 | 08 Inicio | card «Hoy le toca» | 10 Rutinas agenda | Push ← |
| 10 | 08 Inicio | FAB «Hablar con Ana» | 20 Drop-in | **Overlay** (bottom sheet) |
| 11 | 08 Inicio | tab Actividad | 17 Alertas | Instant |
| 12 | 10 Rutinas | fila «Enalapril» | 11 Editor de rutina | Push ← |
| 13 | 11 Editor | «Guardar» | 10 Rutinas (+ toast) | Push → |
| 14 | 10 Rutinas | segmento «Medicación» | 12 Medicación | Instant |
| 15 | 12 Medicación | fila «Enalapril» | 13 Historial cumplimiento | Push ← |

## Flujo de alerta (simulación de emergencia)

| # | Origen | Hotspot | Destino | Transición |
|---|---|---|---|---|
| 16 | 09 Inicio con alerta | banner «Ver alerta» | 18 Detalle de alerta | Push ← |
| 17 | 18 Detalle | «Drop-in» | 20 Drop-in | Overlay |
| 18 | 20 Drop-in | «Terminar» | 18 Detalle (estado atendida) | Close overlay |
| 19 | 18 Detalle | «Marcar como atendida…» | 17 Alertas (resuelta) | Push → |
| 20 | 17 Alertas | alerta activa | 18 Detalle | Push ← |

## Flujo de terapias

| # | Origen | Hotspot | Destino | Transición |
|---|---|---|---|---|
| 21 | 29 Terapias | «Hacerla juntos» | 31 Player sesión (paso 1) | Push ← |
| 22 | 29 Terapias | card «Trivia de su época» | 30 Detalle trivia | Push ← |
| 23 | 30 Detalle trivia | «Iniciar ahora» | 29 Terapias (+ toast «Aurora arrancó») | Push → |
| 24 | 31 Player | «Siguiente paso» ×3 | 31 (pasos 2-4; duplicar frame por paso) | Smart animate |
| 25 | 31 Player | «Cerrar con calma» | 32 Resultados | Dissolve |
| 26 | 31 Player paso 4 | «Terminar sesión» | 32 Resultados | Dissolve |
| 27 | 32 Resultados | «Es correcto» | 14 Recuerdos (badge actualizado) | Push ← |
| 28 | 32 Resultados | «Listo» | 29 Terapias | Push → |
| 29 | 14 Recuerdos | banner «Revisar» | 16 Validación | Push ← |
| 30 | 16 Validación | «Aprobar» | 14 Recuerdos | Push → |

## Navegación global (aplicar en todas las pantallas con tab bar)

| Tab | Destino |
|---|---|
| Inicio | 08 Inicio |
| Rutinas | 10 Rutinas |
| Recuerdos | 14 Recuerdos |
| Actividad | 17 Alertas |
| Ajustes | 21 Ajustes |

Back (←) de toda pantalla de detalle → su lista de origen. Los segmentos Alertas/Terapias/Historial navegan entre 17 / 29 / 19 con transición *Instant*.
