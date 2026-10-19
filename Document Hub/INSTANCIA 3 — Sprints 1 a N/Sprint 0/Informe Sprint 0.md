---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-18
---

# Sprint 0 — Fundación (21/04 a 07/06/2026)

**Período:** 21 de abril de 2026 – 07 de junio de 2026 (cierre real).  
**Corresponde en Jira:** "SCRUM Sprint 0" (dos iteraciones).  
**Objetivo (goal):** "Ponernos de acuerdo y configurar todo" → comenzar el proyecto con las bases definidas.

### Resumen del sprint

Sprint de arranque. El equipo alineó **alcance, arquitectura y forma de trabajo**, y dejó lista toda la documentación de gestión y los 5 repositorios. No se escribió código de producto: el valor entregado son las definiciones que gobiernan todo lo posterior — 9 épicas alineadas 1:1 con los 9 módulos funcionales, 91 requerimientos funcionales + 43 no funcionales, la elección del stack tecnológico y 9 ADR (hoy 12). Ya aparece el primer indicio del patrón que marcaría el proyecto: el cierre real se estiró por encima de lo planificado.

### Naturaleza del sprint

Sprint de **fundación**: definición de alcance, arquitectura, documentación de gestión y setup de repositorios. **No hay código de producto**; los entregables son documentos y decisiones.

### Gestión

- **Tickets Finalizados:** 16 (AURA-1, 2, 5, 6, 7, 8, 9, 10, 26, 32, 33, 34, 35, 36, 37, 38).
- El cierre real (07/06) quedó por encima de lo planificado, primer indicio del patrón de sprints que se estiran.

### Desarrollo y entregables

Al no haber código, el "desarrollo" del sprint es la producción de los artefactos que rigen todo lo posterior:

- **Definición de alcance y funcionalidades** (AURA-1, AURA-2, AURA-26).
- **Arquitectura del sistema** (AURA-5, AURA-35): modelo C4 + 9 ADRs; elección de stack.
- **9 épicas de producto alineadas 1:1 con los 9 módulos funcionales** (AURA-8).
- **Documentos de gestión:** Project Charter (AURA-32), Working Agreement (AURA-33), Gestión de la Configuración (AURA-34), Plan de Testing (AURA-36).
- **Requerimientos:** 91 RF + 43 RNF (hoy ampliados a 98 RF y 52 RNF) distribuidos en 9 módulos (fuente autoritativa).
- **User Story Map** (AURA-37) y **Backlog inicial** (AURA-38).
- **Investigación de dominio:** demencia/neurología y contacto con profesional de la salud (AURA-6, AURA-7).
- **Creación de los 5 repositorios** (AURA-9): AuroraCore, AuroraCareBack (hoy unificados en AuroraCore), AuroraCareFront, AuroraHome, ObsidianAurora.
- **Definición de roles y capacidad semanal por integrante** (AURA-10).

### Decisiones clave

- **Stack tecnológico oficial:** Python/Django-DRF (backend) · React Native + Expo + TypeScript (móvil) · Supabase/PostgreSQL + pgvector · Supabase Auth · n8n · Azure Speech con respaldo local (Whisper.cpp y Piper).
- **Modelo de épicas:** 9 épicas de producto (1:1 con módulos) + épicas de gestión.
- **Deprecación** de las épicas AURA-23/24/25 (detección de comportamiento, estados fisiológicos y geolocalización), absorbidas por la épica AURA-22 (Detección de Eventos y Riesgos) por solapamiento.

### Retrospectiva

Las retrospectivas de esta sección salen de la sesión de retro del equipo (técnica de las **4 L's**: *Liked / Learned / Lacked / Longed for*). Como las retros individuales quedaron pendientes, se hizo una sola sesión combinada y acá se **repartieron los aportes por sprint según su contenido**. Los aportes que abarcan varios sprints (o que no son atribuibles a uno solo) se agrupan en «Estado consolidado y tendencias».

**Lo que funcionó bien:** Documentos de gestión (Todos) · Creación de los repositorios (Nico) · Investigaciones útiles (Haik, Mateo).

**Lo que faltó:** definir/seleccionar el reloj-pulsera todavía pendiente (Haik).

*(Aprendizajes y deseos de este sprint no tuvieron aportes específicos; ver los aportes transversales en «Estado consolidado y tendencias».)*
