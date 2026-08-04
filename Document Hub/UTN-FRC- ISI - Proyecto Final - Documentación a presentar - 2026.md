# Guía de documentación a presentar

**Universidad Tecnológica Nacional**  
**Facultad Regional Córdoba**  
**Carrera:** Ingeniería en Sistemas de Información  
**Cátedra:** Proyecto Final  
**Año:** 2026  

---

## Introducción

Esta guía es orientativa e indica qué documentos debe producir el equipo durante el año.

Cada equipo acordará con su JTP cómo hacer las entregas y la profundidad de cada una.

El enfoque es incremental. La documentación crece con el sistema, se versiona en el repositorio y refleja su estado real.

Está organizada por instancias temporales. Cada artefacto indica para qué existe y quién lo consume.

## Formato estándar

Todos los documentos entregables deben incluir:

- **Carátula:** Universidad, regional, logo, carrera, asignatura, curso, organización o cliente —si aplica—, tema, docentes, año e integrantes con legajo.
- **Historial de revisión:** Número de versión, fecha, autor y descripción del cambio.
- **Tabla de contenido:** Generada automáticamente desde los encabezados del documento.
- **Introducción:** Contexto del documento: qué es, a qué proyecto pertenece y qué cubre.
- **Audiencia:** A quién está dirigido y qué conocimiento previo se asume.

---

# Instancia 1 — Inicio de proyecto

## Estudio inicial

**Para qué:** Valida que el equipo tiene entendimiento del problema antes de comprometerse con una solución.

**Para quién:** Docente, para aprobar el inicio. Cliente o sponsor, para confirmar el diagnóstico.

- Objetivo del proyecto, ámbito de aplicación e impulsos:
  - Necesidades.
  - Problemas.
  - Oportunidades.
- Procesos involucrados:
  - Descripción.
  - Flujo.
  - Participantes.
  - Información que manejan.
  - Sistemas existentes.
- Mapa global de procesos del entorno.
- Propuesta:
  - Objetivo.
  - Alcance del producto: qué incluye y qué queda fuera.
  - Valor esperado.

## Plan de proyecto

**Para qué:** Define cómo el equipo va a organizar el trabajo. Se actualiza cuando cambia la realidad.

**Para quién:** Docente, para evaluar viabilidad. Equipo, como referencia durante el año.

- Declaración de alcance, equipo de trabajo y roles.
- Propuesta metodológica:
  - Forma de coordinación.
  - Técnica de estimación.
  - Métricas de seguimiento.
- WBS y cronograma alineado al calendario académico.
- Plan de riesgos:
  - Identificación.
  - Probabilidad.
  - Impacto.
  - Estrategias de mitigación.
- Presupuesto de desarrollo y costo operativo mensual futuro del sistema en producción.
- Flujo de fondos básico y estrategia de monetización —aplica a desarrollo de producto—.

---

# Instancia 2 — Sprint 0

## Working Agreement

**Para qué:** Establece cómo trabaja el equipo: normas, compromisos y forma de resolver conflictos.

**Para quién:** El equipo completo. Se revisa al inicio de cada sprint.

- Roles Scrum, normas de trabajo y canales de comunicación.
- Estrategia de versionado y revisión de código.
- Criterios de Ready y Definition of Done.
- Política de uso de inteligencia artificial:
  - Herramientas autorizadas.
  - Tratamiento de información sensible.
  - Requisito de revisión humana.

## Gestión de la configuración

**Para qué:** Define dónde vive cada artefacto y cómo evoluciona. Cualquier integrante debe poder encontrar lo que necesita sin preguntar.

**Para quién:** Equipo, durante el año. Docente, para ubicar artefactos a revisar.

- Estructura de repositorio y convención de nombres para documentos y código fuente.
- Ciclo de vida de los artefactos:
  - Quién los crea.
  - Quién los actualiza.
  - Cuándo se actualizan.
- Herramientas utilizadas:
  - Repositorio.
  - Gestión de backlog.
  - Comunicación.
  - CI/CD.
- Política de ramas y proceso de revisión de pull requests.

## Arquitectura y stack tecnológico

**Para qué:** Registra las decisiones técnicas fundacionales con su razonamiento.

**Para quién:** Equipo, durante el desarrollo. Futuros mantenedores del sistema.

- Arquitectura de solución mediante el modelo C4:
  - Context —Nivel 1—.
  - Container —Nivel 2—.
  - Deployment.
- Architecture Decision Records —ADRs—: uno por cada decisión técnica significativa.
  - Cobertura mínima:
    - Lenguaje y framework.
    - Base de datos.
    - Patrón arquitectónico.
    - Autenticación.
    - Despliegue.
    - Diseño de API.
  - Cada ADR debe incluir:
    - Contexto.
    - Alternativas consideradas.
    - Criterios de comparación.
    - Decisión tomada.
    - Consecuencias, incluyendo trade-offs negativos.
- Pautas de codificación:
  - Convenciones.
  - Estructura de archivos.
  - Linting.
- Proceso de despliegue y gestión de ambientes:
  - Desarrollo.
  - Staging.
  - Producción.

## Plan de testing

**Para qué:** Define la estrategia de verificación antes de escribir código. Evita que el testing sea una actividad de último momento.

**Para quién:** Equipo, durante el desarrollo. Docente, para evaluar la cobertura real.

- Niveles de testing:
  - Unitario.
  - Integración.
  - End-to-end.
  - Herramientas utilizadas por nivel.
- Criterios de cobertura mínima aceptable.
- Tipos y criticidad de incidencias.
- Cuándo se ejecutan los tests y quién revisa los resultados.

## User Story Mapping y backlog inicial

**Para qué:** Visualiza el recorrido del usuario y organiza el trabajo con criterio de valor.

**Para quién:** Equipo, para planificar sprints. Product Owner, para gestionar el backlog.

- User Story Map:
  - Actividades del usuario.
  - Tareas por actividad.
  - Corte de MVP.
- Product Backlog inicial:
  - Épicas.
  - Historias de usuario priorizadas.
  - Criterios de aceptación.
  - Estimación.
- Glosario del dominio:
  - Términos clave del negocio.
  - Definición acordada por el equipo.

---

# Instancia 3 — Sprints 1 a N

## Informe de sprint

**Para qué:** Registra qué planificó el equipo, qué logró, qué aprendió y cómo va a mejorar.

**Para quién:** Equipo, para mejorar. Docente, para evaluar el proceso, no solo el producto.

- Objetivo del sprint: el valor a entregar, no una lista de tareas.
- Sprint Backlog con estimación.
- Capacidad del equipo asumida.
- Resultado de la Sprint Review:
  - Qué se demostró.
  - Feedback recibido.
- Métricas con su correspondiente análisis de tendencia. No se deben presentar únicamente los números.
- Retrospectiva con formato estructurado:
  - Insights.
  - Action items.
  - Responsable.
  - Fecha.
  - Estado de los action items del sprint anterior:
    - Qué se implementó.
    - Qué no se implementó.
- Product Backlog repriorizado.
- Registro de riesgos actualizado.

## Artefactos de trazabilidad

**Para qué:** Conectan cada historia del backlog con las decisiones de diseño, el código y las pruebas.

**Para quién:** Equipo, durante el desarrollo. Docente, para evaluar la calidad técnica.

- Diagramas de modelado relevantes, según corresponda:
  - Clases.
  - Secuencia.
  - Estados —DTE—.
  - Otros diagramas aplicables.
- ADR correspondiente, si la historia implicó una decisión técnica nueva.
- DER actualizado, si la historia modificó el modelo de datos.
- Casos de prueba:
  - Precondición.
  - Pasos.
  - Resultado esperado.
  - Resultados de ejecución.

---

# Instancia 4 — Jornada de presentación

## Paper, poster y video

**Para qué:** Comunica el proyecto a la comunidad académica. El paper argumenta, el poster comunica visualmente y el video demuestra.

**Para quién:** Comunidad académica, docentes, jurado y visitantes.

- Elaboración de documentación bajo las normas previstas en el instrumento que regula la presentación.

---

# Instancia 5 — Fin de proyecto

## Documentación del proceso que contiene al sistema

**Para qué:** Describe el proceso de negocio actualizado tras la implementación del sistema.

**Para quién:** Cliente, usuarios del sistema y futuros mantenedores.

- Descripción del proceso actualizado post-implementación con el sistema integrado.
- Diagrama de flujo del proceso.
- Roles y responsabilidades en el nuevo contexto.

## Instructivos de uso

**Para qué:** Permite operar el sistema sin asistencia del equipo.

**Para quién:** Usuarios finales del sistema.

- Descripción de cada función con capturas de pantalla.
- Flujos de las tareas principales.
- Preguntas frecuentes.
- Resolución de problemas comunes.

## Manual de instalación y operación

**Para qué:** Permite instalar, desplegar, configurar y operar el sistema en producción sin intervención del equipo.

**Para quién:** Administradores, DevOps y futuros mantenedores.

- Requisitos de hardware y software.
- Procedimiento de instalación o despliegue paso a paso.
- Configuración de variables de entorno y secretos.
- Recomendaciones sobre:
  - Gestión de backups.
  - Restauración.
  - Monitoreo.

## Análisis de impacto ambiental

**Para qué:** Evalúa cómo afecta la implementación de la solución actual en el medio ambiente.

**Para quién:** Docente y comunidad académica.

- Estimación del consumo energético y huella de carbono aproximada.
- Alternativas de diseño evaluadas por impacto ambiental.
- Prácticas adoptadas para reducir el impacto ambiental.
- Beneficios obtenidos a partir de la implementación de la solución actual.

## Retrospectiva de proyecto

**Para qué:** Reflexión honesta sobre el proceso completo.

**Para quién:** El equipo, docentes y futuros estudiantes de la cátedra.

- Top 3 de decisiones que resultaron bien y por qué.
- Top 3 de cosas que el equipo haría diferente.
- Recomendaciones para futuros equipos con proyectos similares.