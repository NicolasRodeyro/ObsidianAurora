---
name: artefacto-trazabilidad
description: Generar o actualizar el artefacto de trazabilidad de una historia o tarea de desarrollo de Aurora, durante los Sprints 1 a N. Usar cuando se necesite vincular un issue AURA de Jira con requerimientos, ADRs, DER, diagramas, código, PRs y casos/resultados de prueba para la documentación UTN-FRC.
---

# Artefacto de trazabilidad Aurora

Crear un artefacto por historia o tarea de desarrollo. Trabajar sólo sobre Instancia 3; no recrear documentos de Inicio de proyecto ni de Sprint 0.

## Entradas y fuentes

Pedir la clave Jira y el número de sprint si no están indicados. Usar datos de Jira si el conector está disponible; si no, usar `jira/snapshot.json` y declarar su fecha de sincronización. Consultar `references/proyecto-aurora.md` para las rutas y fuentes del proyecto.

Tomar evidencia sólo de fuentes existentes:

1. Issue, épica, criterios de aceptación, estado y enlaces de Jira.
2. `Document Hub/Pre Estudio Inicial/Requerimientos.md` y `Document Hub/Trazabilidad RF-Épicas.md` para el vínculo RF ↔ épica.
3. `Document Hub/INSTANCIA 2 — Sprint 0/Arquitectura y Stack Tecnológico.md` y los documentos del sprint para ADR, DER y diagramas.
4. Repositorios Aurora Core, Aurora Care y Aurora Home para paths, commits, PRs, tests y resultados de ejecución.

No inferir vínculos ni declarar que una prueba pasó sin evidencia. Para cada campo sin evidencia, usar `Pendiente` e indicar qué fuente falta. Marcar `No aplica` sólo con una justificación concreta.

## Procedimiento

1. Crear o actualizar `Document Hub/INSTANCIA 3 — Sprints 1 a N/Sprint <N>/<KEY>/Artefacto de trazabilidad - <KEY>.md`. Si ya existe, preservar su contenido válido y completar o corregir sólo con evidencia nueva.
2. Partir de `assets/plantilla-artefacto-trazabilidad.md`. Completar toda la carátula, historial de revisión, introducción y audiencia. Generar el índice desde los encabezados con el mecanismo de exportación o plugin aprobado del vault; no escribir una tabla de contenido manual.
3. Transcribir la historia y los criterios de aceptación desde Jira. Relacionar RF únicamente mediante la épica o los vínculos explícitos documentados. Si la issue es una tarea técnica sin historia, documentar su alcance técnico y el issue padre.
4. Registrar decisiones: enlazar ADRs existentes que condicionen la solución. Crear o proponer un ADR sólo si hubo una decisión técnica significativa y nueva; no crear un ADR para una implementación rutinaria. Explicar el motivo cuando no aplique.
5. Registrar el modelo de datos: enlazar el DER y señalar entidades/campos/relaciones afectados. Si no cambia el modelo, documentar `No aplica` con la verificación realizada.
6. Incluir únicamente diagramas útiles para la historia: clases/entidades, secuencia, estados (DTE) u otro. Preferir enlaces a diagramas existentes; si falta uno necesario, añadir Mermaid pequeño, derivado de la evidencia, y marcarlo como pendiente de validación cuando corresponda.
7. Citar código y pruebas con repositorio, ruta exacta, símbolo o test y commit/PR si existen. No usar rutas amplias como evidencia.
8. Definir casos de prueba trazables a criterios de aceptación: precondición, pasos, resultado esperado y resultado de ejecución. Registrar comando, fecha y salida/resumen para cada resultado ejecutado. Mantener `Pendiente` cuando no se ejecutó.
9. Completar la matriz final y el checklist. Verificar que cada criterio tenga al menos un caso de prueba y que toda afirmación de implementación o ejecución tenga una referencia.

## Salida y verificación

Entregar un resumen de: documento creado/actualizado, evidencia encontrada, pendientes y decisiones que requieren validación del equipo. No modificar Jira (comentarios, estado o campos) salvo pedido explícito del usuario.

Antes de finalizar, comprobar:

- La historia/tarea, su estado y sus criterios tienen fuente.
- ADR, DER y diagramas están enlazados, justificados como no aplicables o pendientes.
- Código, pruebas y resultados no fueron inventados.
- Cada caso de prueba tiene las cinco columnas exigidas por UTN.
- El documento contiene todos los bloques formales exigidos y los enlaces Obsidian funcionan.
