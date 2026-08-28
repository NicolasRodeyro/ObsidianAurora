---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
historia: "AURA-59"
epica: "AURA-18"
Last updated time: "2026-08-23T00:00:00"
---
# Artefacto de Trazabilidad — AURA-59 Vistas Paciente UI

> [!draft] **Scaffolding** generado automáticamente. La **identidad** (historia, épica, RF, estado, enlace, código) está rellena con datos reales de Jira y del repo. Las secciones de análisis (ADR, DER, diagramas, criterios detallados, casos de prueba) quedan como `[!todo]` para completar en equipo. **No inventar** resultados de pruebas ni ADRs.

> **Para qué:** conectar esta historia con sus decisiones de diseño, modelo de datos, código y pruebas.
> **Para quién:** equipo (durante el desarrollo) y docente (evaluación de calidad técnica).

| Campo | Valor |
| --- | --- |
| Historia | **AURA-59** — Vistas Paciente UI |
| Épica | AURA-18 — Panel del Cuidador (Aurora Care) |
| Requerimientos | RF-60–75 (ver [[Requerimientos]] · [[Trazabilidad RF-Épicas]]) |
| Estado en Jira | Finalizada |
| Enlace | https://project-aurora-alz.atlassian.net/browse/AURA-59 |

## 1. Historia de usuario
> [!todo] **Como** {rol} **quiero** {objetivo} **para** {beneficio}.

### Criterios de aceptación
> [!todo] Derivar de la descripción del ticket en Jira (AURA-59).
- [ ] {criterio_1}
- [ ] {criterio_2}

## 2. Decisiones de diseño (ADR)
> [!todo] Enlazar los ADR aplicables de [[Arquitectura y Stack Tecnológico]]. Si hubo decisión técnica nueva sin ADR, crear `ADR-0XX`. Si no, indicar "Sin ADR nuevo".

## 3. Modelo de datos (DER)
> [!todo] Si esta historia modifica el modelo de datos, reflejar las entidades afectadas (`erDiagram`). Si no, indicar "Sin cambios en el DER". Ver [[DER - Base de Datos Aurora]].

## 4. Diagramas de modelado
> [!todo] Incluir solo los que apliquen (clases / secuencia / estados) y borrar el resto.

## 5. Código relacionado
| Tipo | Ubicación / referencia |
| --- | --- |
| Frontend | Repo `AuroraCareFront` (React Native + Expo) |
| Commit / PR | _(pendiente: enlazar pantalla/commit específico)_ |

> [!todo] Completar con paths y commits/PRs faltantes.

## 6. Casos de prueba
| ID | Precondición | Pasos | Resultado esperado | Resultado de ejecución |
| --- | --- | --- | --- | --- |
| CP-AURA-59-01 | {precondición} | {pasos} | {esperado} | Pendiente |

> [!todo] Cada criterio de aceptación debería tener al menos un caso. No registrar "Pasó/Falló" sin ejecución real.

## 7. Matriz de trazabilidad
| Historia | RF | ADR | DER | Diagramas | Código | Casos de prueba |
| --- | --- | --- | --- | --- | --- | --- |
| AURA-59 | RF-60–75 | {—} | {sí/—} | {—} | {ver §5} | {CP-…} |

## Checklist de completitud (cátedra)
- [ ] Historia y criterios de aceptación
- [ ] ADR correspondiente (si hubo decisión técnica nueva)
- [ ] DER actualizado (si modificó el modelo de datos)
- [ ] Diagramas de modelado relevantes
- [ ] Casos de prueba con precondición, pasos y resultado esperado
- [ ] Resultados de ejecución de las pruebas
- [ ] Referencias a código (paths/commits/PRs)
