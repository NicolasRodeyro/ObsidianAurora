---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-21
---
# Índice Aurora (Mapa de Contenido)

Punto de entrada navegable a la documentación del proyecto **Aurora**. Para el contexto técnico y de acceso a Jira ver `CLAUDE.md` en la raíz del repo.

## Gestión del proyecto
- [[Project Charter]] — alcance, presupuesto, riesgos, stakeholders, WBS.
- [[Horarios y Roles de los Miembros]] — capacidad del equipo.
- [[Documento Presentacion Sprint 0]] — cierre del Sprint 0.
- [[Historial de revisión]] — versiones del documento «Proyecto Aurora 2026» (carátula única).
- [[Desarrollo del Proyecto — Sprints 0, 1 y 2]] — equipo, stack, numeración de sprints y mapa del desarrollo (Instancia 3).
- Informes de sprint (Instancia 3): [[Informe Sprint 0]] · [[Informe Sprint 1]] · [[Informe Sprint 2]] · [[Informe Sprint 3]] · [[Informe Sprint 4]] · [[Informe Sprint 5]] · [[Informe Sprint 6]] (parcial). La numeración sigue la documentación; la equivalencia con Jira está en [[Desarrollo del Proyecto — Sprints 0, 1 y 2]].
- [[Registro de Riesgos]] — riesgos del proyecto (R1 a R22) con su estado y evolución por sprint.
- [[Estado consolidado y tendencias]] · [[Trabajo pendiente y próximos pasos]] · [[Anexos del desarrollo del proyecto]] — cierre de la Instancia 3 al 17/10/2026.
- [[Presentación del Proyecto]] — pitch y diferenciación.
- [[Jornada de Presentación]] — paper, póster y video de la jornada del 06/10/2026 (link a la carpeta de Drive).
- `INSTANCIA 4/video-aurora.html` — render animado del video de presentación (1920×1080, 2:54), listo para grabar.

## Análisis y requerimientos
- [[Estudio Inicial Aurora]] — problema y oportunidad.
- [[Glosario del Dominio]] — términos del dominio (Instancia 2).
- [[Investigacion sobre neurologia]] — base clínica (Alzheimer / demencia).
- [[Requerimientos]] — **98 RF + 52 RNF** en 10 módulos (fuente autoritativa).
- [[Funcionalidades del Sistema en el Hogar]] — componentes por módulo.
- [[Brainstorm de Nombres]] — naming.

## Producto y backlog
- [[Product Backlog Inicial]] — épicas e historias iniciales.
- [[User Story Map]] — mapa de historias.
- [[Plan de Testing]] — estrategia, métricas críticas y línea base de pruebas.
- [[Gestion de la Configuracion]] — repositorios, ramas, commits y CI/CD.
- [[Working Agreement]] — acuerdos de trabajo del equipo.
- [[Trazabilidad RF-Épicas]] — matriz RF ↔ módulo ↔ épica.
- [[Tablero Jira]] — snapshot del board AURA.
- Artefactos de trazabilidad por historia → carpeta de cada sprint en `INSTANCIA 3 — Sprints 1 a N/` (generados con la skill `/artefacto-trazabilidad`).
- Feature de recuerdos (línea de tiempo, personas de la vida del paciente, recuerdo del día): historias US-D5 a US-D7 en [[Handoff y Backlog de Diseño]] §3 · ADR-014 a ADR-016 en [[Arquitectura y Stack Tecnológico]] §3 · artefactos de trazabilidad en `INSTANCIA 3 — Sprints 1 a N/Sprint 6/AURA-195/`, `AURA-197/`, `AURA-201/` y `AURA-202/`.

## Arquitectura y diseño
- [[Boceto de Arquitectura]] — esquema temprano.
- [[Arquitectura y Stack Tecnológico]] — modelo C4 + ADRs + stack (ADR-001 a ADR-012; ADR-013 reservado para LiveKit; ADR-014 a ADR-016: feature de recuerdos).
- [[Investigación — Almacenamiento de Datos y Ley 25.326]] — cumplimiento legal del almacenamiento, escenarios de hosting y costos (base del futuro ADR-010).
- [[Diseño del Prototipo]] — bocetos iniciales (histórico).

## Diseño UX/UI
Manual completo en `Diseño UX-UI/`; artefactos ejecutables en `Design/` (tokens, previews HTML, prototipo navegable).
- [[Manual de UX-UI Aurora]] — **índice del manual** + principios de diseño.
- Fundamentos: [[Identidad de Marca]] · [[Color]] · [[Tipografía]] · [[Fundamentos Visuales]]
- UX: [[Proto-personas]] · [[Journeys y Escenarios]] · [[Arquitectura de Información — Aurora Care]] · [[User Flows]] · [[VUI — Diseño Conversacional]] · [[Accesibilidad]]
- [[Handoff y Backlog de Diseño]] — estado, bloqueo de Figma, cómo retomar.

## Mapa Módulo ↔ Épica
Cada módulo de [[Requerimientos]] tiene una épica de producto en Jira. Detalle en [[Trazabilidad RF-Épicas]].

| Módulo | Épica | Componente |
| --- | --- | --- |
| 1. Interacción con el Paciente | AURA-14 | Aurora Home |
| 2. Monitoreo Biométrico | AURA-19 | Aurora Band |
| 3. Detección y Eventos | AURA-22 | Aurora Core |
| 4. Alertas y Comunicación | AURA-16 | Aurora Core/Care |
| 5. Motor de IA | AURA-15 | Aurora Core |
| 6. Orquestación y Automatización | AURA-21 | Aurora Core |
| 7. Cuidador | AURA-18 | Aurora Care |
| 8. Seguridad, Privacidad y Datos | AURA-20 | Transversal |
| 9. Administración de Rutinas y Medicación | AURA-17 | Aurora Care/Core |
