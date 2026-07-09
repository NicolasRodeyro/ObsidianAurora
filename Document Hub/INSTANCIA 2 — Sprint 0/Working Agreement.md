---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-07-09
---

# Working Agreement

## 1. Introducción

El presente documento constituye el "Working Agreement" para el proyecto Aurora. Su objetivo principal es establecer las reglas de convivencia, normas de trabajo, compromisos y la forma en que el equipo resolverá los conflictos durante el ciclo de desarrollo. Este acuerdo se genera en la Instancia 2 (Sprint 0) y actúa como un marco de referencia que guía nuestras interacciones, estableciendo claramente cómo evoluciona nuestra dinámica de trabajo.

## 2. Audiencia

Este documento está dirigido al equipo completo de desarrollo del proyecto Aurora. Se asume que todos los miembros poseen conocimientos sobre las ceremonias y el marco de trabajo Scrum. Este documento es un artefacto vivo y será revisado obligatoriamente por todo el equipo al inicio de cada sprint.

## 3. Roles Scrum, Normas de Trabajo y Canales de Comunicación

### 3.1 Roles Scrum

El equipo se organiza bajo metodologías ágiles (Scrum). Los roles específicos (Product Owner y Scrum Master) serán distribuidos y rotados internamente según lo acordado por el equipo al inicio de cada ciclo. El equipo completo asume las responsabilidades del Development Team:

* Mateo Romero Plaza
* Haik Martín Kilic Aslan
* Nicolás Rodeyro Contarino
* Jeremías Daniel Maldonado Gómez
* Octavio Escudero

### 3.2 Normas de Trabajo

* Puntualidad: Es mandatorio el respeto por los horarios pactados para todas las ceremonias ágiles (Dailies, Planning, Review y Retrospective).
* Toma de Decisiones y Conflictos: Las decisiones técnicas se toman por consenso grupal. Los desacuerdos se resolverán exponiendo argumentos técnicos claros. En caso de impasse prolongado, el rol de Scrum Master facilitará una votación simple para destrabar la situación.
* Transparencia: Todos los miembros deben comunicar sus bloqueos de manera proactiva e inmediata.

### 3.3 Canales de Comunicación

* Asíncrona y Diaria: Grupo oficial de mensajería rápida (WhatsApp/Slack o similar) para resolución rápida de dudas operativas.
* Gestión de Tareas: Plataforma de tableros Kanban/Scrum (ej. Jira o Trello) para seguimiento riguroso del Product y Sprint Backlog.
* Síncrona y Ceremonias: Llamadas de voz o video (Google Meet o Discord) para reuniones de planificación, revisiones y retrospectivas.

## 4. Estrategia de Versionado y Revisión de Código

### 4.1 Versionado

La estrategia principal de versionado estará basada en ramificaciones controladas (ej. Git Flow o GitHub Flow):

* Una rama main protegida que contendrá código estable para entregas.
* Una rama develop como entorno principal de integración.
* Desarrollo de nuevas funcionalidades mediante ramas específicas con el prefijo feature/.

### 4.2 Revisión de Código

* Todo código debe integrarse a develop exclusivamente a través de Pull Requests (PR).
* Es requisito obligatorio contar con la revisión de al menos un integrante distinto al autor del código.
* El equipo se compromete a realizar revisiones constructivas y priorizar el desbloqueo de compañeros.

## 5. Criterios de Ready y Definition of Done (DoD)

### 5.1 Criterios de "Ready" (Preparado)

Una historia de usuario puede ingresar a un Sprint solo si:

* Está debidamente descrita y su valor de negocio es claro.
* Cuenta con criterios de aceptación definidos y verificables.
* Posee una estimación de esfuerzo acordada por el equipo técnico.

### 5.2 Definition of Done ("Terminado")

Una tarea se considera finalizada y factible de ser evaluada en la Sprint Review si:

* Cumple con todos sus criterios de aceptación específicos.
* El código ha sido subido, cuenta con revisión aprobada y está integrado sin errores en la rama principal o de desarrollo.
* Pasa las pruebas y métricas de calidad mínimas acordadas por el equipo.
* No interfiere negativamente con funcionalidades preexistentes del sistema Aurora.

## 6. Política de Uso de Inteligencia Artificial

Dado el contexto de trabajo, el uso de herramientas de Inteligencia Artificial se encuentra regido por las siguientes normativas estrictas:

* **Herramientas Autorizadas:** Se autoriza el uso de modelos como GitHub Copilot, Gemini o ChatGPT exclusivamente como asistentes para refactorización, boilerplate de código o generación de plantillas documentales.
* **Información Sensible:** Queda terminantemente prohibido compartir, ingresar o procesar datos reales de pacientes, arquitectura crítica de seguridad, datos biométricos sensibles, credenciales (tokens, contraseñas) a través de prompts en plataformas de IA públicas. Esto se enmarca en la obligatoriedad del cumplimiento de la Ley 25.326 de Protección de Datos Personales.
* **Revisión Humana Obligatoria:** Cualquier código generado o sugerido por un modelo de IA debe ser inspeccionado minuciosamente, comprendido al 100% y validado por el desarrollador a cargo. La responsabilidad sobre el funcionamiento y los posibles fallos del código integrado recae de manera absoluta sobre el humano que realiza el commit.
