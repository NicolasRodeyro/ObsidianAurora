---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-07-09T11:40:00
---
# Índice Aurora (Mapa de Contenido)

Punto de entrada navegable a la documentación del proyecto **Aurora**. Para el contexto técnico y de acceso a Jira ver `CLAUDE.md` en la raíz del repo.

## Gestión del proyecto
- [[Project Charter]] — alcance, presupuesto, riesgos, stakeholders, WBS.
- [[Horarios y Roles de los Miembros]] — capacidad del equipo.
- [[Documento Presentacion Sprint 0]] — cierre del Sprint 0.
- [[Presentación del Proyecto]] — pitch y diferenciación.
- `INSTANCIA 4/video-aurora.html` — render animado del video de presentación (1920×1080, 2:54), listo para grabar.

## Análisis y requerimientos
- [[Estudio Inicial]] — problema y oportunidad.
- [[Investigacion sobre neurologia]] — base clínica (Alzheimer / demencia).
- [[Requerimientos]] — **91 RF + 43 RNF** en 9 módulos (fuente autoritativa).
- [[Funcionalidades del Sistema en el Hogar]] — componentes por módulo.
- [[Brainstorm de Nombres]] — naming.

## Producto y backlog
- [[Product Backlog Inicial]] — épicas e historias iniciales.
- [[Trazabilidad RF-Épicas]] — matriz RF ↔ módulo ↔ épica.
- [[Tablero Jira]] — snapshot del board AURA.
- Artefactos de trazabilidad por historia → carpeta `Trazabilidad/` (generados con la skill `/artefacto-trazabilidad`).

## Arquitectura y diseño
- [[Boceto de Arquitectura]] — esquema temprano.
- [[Arquitectura y Stack Tecnológico]] — modelo C4 + ADRs + stack.
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
