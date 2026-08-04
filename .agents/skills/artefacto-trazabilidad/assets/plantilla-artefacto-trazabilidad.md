---
base: "[[Document Hub.base]]"
Category:
  - Instancia 3
  - Sprint <N>
  - Trazabilidad
sprint: "Sprint <N>"
jira: "<KEY>"
Last updated time: "<AAAA-MM-DD>"
---

# Artefacto de trazabilidad — <KEY> <título>

## Carátula

| Campo | Valor |
| --- | --- |
| Universidad | Universidad Tecnológica Nacional |
| Regional | Facultad Regional Córdoba |
| Logo | <insertar logo institucional UTN-FRC aprobado> |
| Carrera | Ingeniería en Sistemas de Información |
| Asignatura | Proyecto Final |
| Curso | 2026 |
| Organización / cliente | Aurora — <sponsor o cliente, si aplica> |
| Tema | <tema de la historia o tarea> |
| Docentes | <completar> |
| Año | 2026 |
| Sprint | Sprint <N> |
| Issue | <KEY> — <título> |
| Integrantes | <completar integrantes y legajo> |

## Historial de revisión

| Versión | Fecha | Autor | Descripción |
| --- | --- | --- |
| 0.1 | <AAAA-MM-DD> | <autor> | Creación del artefacto. |

## Índice

<!-- Generar automáticamente desde los encabezados al exportar; no editar manualmente. -->

## Introducción

Este documento registra la trazabilidad de `<KEY>` durante el Sprint `<N>` del proyecto Aurora: requisitos, decisiones de diseño, modelo, código y pruebas.

## Audiencia

Está dirigido al equipo de Aurora y a la cátedra de Proyecto Final. Presupone conocimiento básico de Scrum, Jira y la arquitectura documentada del proyecto.

## 1. Historia o tarea

| Campo | Valor |
| --- | --- |
| Tipo y estado en Jira | <tipo> — <estado> |
| Épica / issue padre | <KEY o no aplica> |
| Enlace | <URL o referencia al snapshot> |
| Fuente consultada | <Jira / `jira/snapshot.json` con fecha> |

### Descripción

<texto verificable de Jira>

### Criterios de aceptación

- [ ] <CA-01>

## 2. Requerimientos relacionados

| RF / RNF | Relación con la historia | Fuente |
| --- | --- | --- |
| <RF-XX> | <relación explícita> | <enlace al requerimiento o matriz> |

## 3. Decisiones de diseño (ADR)

| ADR | Relación con la historia | Estado / evidencia |
| --- | --- | --- |
| <ADR-XXX o No aplica> | <decisión existente o nueva> | <enlace o justificación> |

## 4. Modelo de datos (DER)

| DER / entidad | Cambio o relación | Evidencia |
| --- | --- | --- |
| <documento / entidad o No aplica> | <detalle> | <enlace o justificación> |

## 5. Diagramas de modelado

### <Tipo de diagrama>

<Enlace al diagrama existente o diagrama Mermaid derivado de evidencia. Explicar por qué aplica.>

## 6. Código y cambios relacionados

| Componente | Repositorio | Ruta exacta / símbolo | Commit o PR | Evidencia |
| --- | --- | --- | --- | --- |
| <Aurora Core/Care/Home> | <repo> | `<ruta>` | <hash/URL/Pendiente> | <qué implementa> |

## 7. Casos de prueba y ejecución

| ID | Criterio | Precondición | Pasos | Resultado esperado | Resultado de ejecución |
| --- | --- | --- | --- | --- | --- |
| <CP-KEY-01> | <CA-01> | <condición> | 1. <paso> | <resultado> | Pendiente / Pasó / Falló — <fecha, comando y evidencia> |

## 8. Matriz de trazabilidad

| Historia / tarea | RF / RNF | ADR | DER | Diagramas | Código | Casos de prueba |
| --- | --- | --- | --- | --- | --- | --- |
| <KEY> | <RF> | <ADR> | <DER> | <tipos> | <rutas/PR> | <IDs> |

## 9. Checklist de completitud UTN

- [ ] Historia/tarea y criterios con fuente.
- [ ] ADR vinculado, justificado como no aplicable o pendiente.
- [ ] DER actualizado, justificado como no aplicable o pendiente.
- [ ] Diagramas relevantes vinculados o pendientes.
- [ ] Código y cambios con ruta exacta y evidencia.
- [ ] Casos de prueba con precondición, pasos, resultado esperado y ejecución.
- [ ] Cada criterio de aceptación tiene al menos un caso de prueba.
