---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-16
---

# Gestión de la Configuración Aurora

## Introducción

Este documento define dónde vive cada artefacto del proyecto Aurora y cómo evoluciona (Instancia 2). Describe la estructura de los repositorios y la convención de nombres, el ciclo de vida de los artefactos, las herramientas utilizadas (repositorio, gestión de backlog, comunicación y CI/CD) y la política de ramas y de revisión de pull requests.

## Audiencia

Está dirigido al equipo, como referencia durante el año, y a los docentes, para ubicar los artefactos a revisar. Se asume un conocimiento básico de Git y de GitHub.

## 1. Estructura de repositorio y convención de nombres para documentos y código fuente

Para garantizar el orden del proyecto, se utiliza un enfoque monorrepo (o repositorios separados bajo una misma organización de GitHub) con la siguiente estructura y reglas de nomenclatura basadas en kebab-case para carpetas/archivos técnicos, y PascalCase para documentación formal.

![Estructura del repositorio](images/Estructura%20del%20repositorio.png)

- Convención de nombres para código: Carpetas y archivos en minúsculas separados por guiones (ej: aurora).
- Convención de nombres para documentación: Prefijo numérico de dos dígitos para indicar orden de lectura, seguido del nombre del entregable en CamelCase o PascalCase sin espacios (ej: 01_EstudioInicial_Aurora.pdf).

## 2. Ciclo de vida de los artefactos: quién los crea, quién los actualiza y cuándo

| **Artefacto** | **Creador Inicial** | **Responsable de Actualizar** | **¿Cuándo se actualiza?** |
| --- | --- | --- | --- |
| Estudio Inicial (Objetivos, Procesos, Impulsos y Propuesta) | Todo el Equipo | Quien tenga asignado el ticket en Jira | Al cierre de cada Sprint, únicamente si la cátedra solicita correcciones o si se redefine el alcance del problema a validar. |
| Plan de Proyecto (Metodología, WBS, Cronograma, Riesgos y Costos) | Todo el Equipo | Scrum Master | De manera mensual, para ajustar el cronograma ante desvíos reales respecto al calendario académico o mitigar nuevos riesgos técnicos detectados. |
| User Story Mapping y Backlog Inicial (Actividades, Tareas por actividad, Corte de MVP y Glosario) | Todo el Equipo | Product Owner | Al finalizar cada Sprint Planning o durante las sesiones de refinamiento del Backlog (Grooming), para detallar criterios de aceptación de las historias prioritarias. |
| Working Agreement (Normas, Compromisos, Roles Scrum y Canales) | Todo el Equipo | Todo el Equipo (Consenso general) | Obligatoriamente al inicio de cada Sprint durante la reunión de Sprint Planning, evaluando si las normas de convivencia y el uso de herramientas necesitan ajustes. |
| Gestión de la Configuración (Estructura de repositorio, Herramientas y Política de ramas) | Todo el Equipo | Integrador Técnico / DevOps del equipo | Al cierre de cada hito de entrega o si el equipo decide incorporar una nueva herramienta al ecosistema de desarrollo (ej: cambios en automatizaciones de n8n o esquemas de Supabase). |

## 3. Herramientas utilizadas: repositorio, gestión de backlog, comunicación, CI/CD

El ecosistema de herramientas seleccionado para soportar el desarrollo ágil de Aurora se compone de:

- Repositorio de Código y Documentación: GitHub. Centraliza todo el historial de versiones del software y los entregables de la materia.
- Gestión de Backlog: Jira Software. Utilizado para crear los sprints, priorizar historias de usuario del MVP, asignar tareas y medir la velocidad del equipo mediante tableros Scrum.
- Comunicación: Discord (para weeklys) y WhatsApp (para coordinación interna rápida).

## 4. Política de ramas y proceso de revisión de pull requests

Se adopta el flujo feature → staging → main, el mismo del Working Agreement (sección 4.1), para asegurar la estabilidad del proyecto final:

- **Rama de producción (main):** contiene el código estable, listo para ser evaluado por la cátedra. Está protegida; solo recibe PR desde staging (o desde hotfix/). Los PR hacia main los aprueba el Product Owner (Haik Kilic); si es el autor del cambio, lo aprueba otro integrante.
- **Rama de integración (staging):** es la base de todo el desarrollo. Está protegida y solo recibe PR. En Aurora Core se despliega automáticamente al entorno de staging.
- **Ramas de características (feature/):** cada tarea o historia de usuario se desarrolla en una rama propia que nace de staging. Su nomenclatura sigue el formato feature/AURA-[Número_Tarea_Jira]-[Descripción_Breve] (ejemplo: feature/AURA-05-registro-paciente). Se elimina al mergear.
- **Correcciones urgentes (hotfix/):** nacen de main; se integran en main y luego en staging para que el arreglo no se pierda.
- **Rama base:** toda rama de trabajo se crea desde staging (confirmar la rama base antes de crearla). Un PR apilado sobre otra rama de trabajo se mergea en esa rama; hay que verificar que el cambio llegó a staging.
Proceso de Revisión de Pull Requests (PR):

- El desarrollador finaliza la tarea en su rama feature/ y abre un Pull Request hacia staging.
- **Regla de Aprobación:** el PR requiere obligatoriamente la revisión y el aprobado de al menos un miembro del equipo ajeno a la creación de ese código (revisión por pares), y los tests automáticos (CI) deben pasar.
- Una vez aprobado y verificado que no genera conflictos, se realiza el Merge hacia staging y la rama de origen se elimina del repositorio remoto para mantener la limpieza del proyecto.
- Para publicar una versión, se abre un PR de staging hacia main, aprobado por el Product Owner, que dispara el despliegue a producción.

Estado de adopción por repositorio:

- **Aurora Core y Aurora Care (frontend):** ya trabajan con PR hacia staging.
- **Aurora Home y Aurora Worker IA:** hoy integran directo en main. El equipo decidió el 12/10/2026 adoptar el mismo flujo; queda pendiente crear y proteger la rama staging, cambiar la rama base de los PR y ajustar el CI. Mientras no exista un entorno de staging propio, staging funciona como rama de integración y el despliegue se mantiene al fusionar a main.
