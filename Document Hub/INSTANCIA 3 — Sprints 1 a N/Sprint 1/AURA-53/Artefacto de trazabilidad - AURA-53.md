---
base: "[[Document Hub.base]]"
Category:
  - Instancia 3
  - Sprint 1
  - Trazabilidad
sprint: "Sprint 1"
jira: "AURA-53"
Last updated time: "2026-08-03"
---

# Artefacto de trazabilidad — AURA-53 Diseño de BD

## Carátula

| Campo | Valor |
| --- | --- |
| Universidad | Universidad Tecnológica Nacional |
| Regional | Facultad Regional Córdoba |
| Logo | Pendiente: no se localizó un logo institucional aprobado en las fuentes consultadas. |
| Carrera | Ingeniería en Sistemas de Información |
| Asignatura | Proyecto Final |
| Curso | 2026 |
| Organización / cliente | Aurora |
| Tema | Diseño de base de datos para Aurora |
| Docentes | Pendiente: sin evidencia en las fuentes consultadas. |
| Año | 2026 |
| Sprint | Sprint 1 (carpeta documental y alcance solicitado). **Observación:** Jira registra el campo Sprint como `SCRUM Sprint 2` (cerrado). |
| Issue | AURA-53 — Diseño de BD |
| Integrantes | Pendiente: no se encontraron legajos. El comentario Jira atribuye la propuesta a Mateo Romero Plaza y Nicolás Rodeyro. |

## Historial de revisión

| Versión | Fecha | Autor | Descripción |
| --- | --- | --- | --- |
| 0.1 | 2026-08-03 | Codex (asistencia documental) | Creación del artefacto a partir de Jira y evidencia versionada existente; pendiente de validación del equipo. |

## Índice

<!-- Generar automáticamente desde los encabezados al exportar; no editar manualmente. -->

## Introducción

Este documento registra la trazabilidad de AURA-53 durante el Sprint 1 documental del proyecto Aurora: requerimientos explícitamente vinculados por su épica, decisiones arquitectónicas aplicables, modelo de datos, cambios versionados y estado de pruebas. No reemplaza ni duplica el DER, la definición de tablas ni las vistas DBML: los referencia como anexos fuente.

## Audiencia

Está dirigido al equipo de Aurora y a la cátedra de Proyecto Final. Presupone conocimiento básico de Scrum, Jira y de la arquitectura documentada del proyecto.

## 1. Historia o tarea

| Campo | Valor |
| --- | --- |
| Tipo y estado final en Jira | Tarea — Finalizada (resolución: Listo). |
| Fecha de cierre | 2026-07-14 19:51:14 -03:00. |
| Épica / issue padre | [AURA-15 — Motor de IA y Memoria del Paciente](https://project-aurora-alz.atlassian.net/browse/AURA-15). |
| Enlace | [AURA-53 — Diseño de BD](https://project-aurora-alz.atlassian.net/browse/AURA-53). |
| Fuente consultada | Jira, consulta realizada el 2026-08-03. |
| Discrepancia a validar | La ubicación del artefacto y el alcance solicitado son Sprint 1; el campo Sprint de Jira informa `SCRUM Sprint 2` cerrado. |

### Descripción

Jira no contiene descripción para AURA-53. Por lo tanto, el alcance técnico se toma únicamente de su título, de su pertenencia a AURA-15 y de los anexos versionados; no se infiere una historia de usuario adicional.

### Criterios de aceptación

Jira no registra criterios de aceptación para AURA-53. No se crean criterios retroactivamente en este artefacto.

### Comentarios relevantes de Jira

El 2026-07-09 Mateo Romero Plaza informó que, junto con Nicolás Rodeyro, se había terminado una propuesta de base de datos en la rama `der-base-datos`, con material completo y separado por schema. El mismo comentario señala que la propuesta estaba sujeta a cambios y no debía considerarse definitiva. También menciona un script SQL y una base creada en Supabase; esos dos elementos **no están presentes en la carpeta actual de AURA-53**, por lo que no se los usa como evidencia de implementación ni de ejecución.

## 2. Requerimientos relacionados

La vinculación siguiente se fundamenta en la relación explícita AURA-15 ↔ RF-47–54 de [[Document Hub/Trazabilidad RF-Épicas]]. AURA-53 no nombra RF/RNF propios y no se agregan relaciones por similitud temática.

| RF / RNF | Relación con la tarea | Fuente |
| --- | --- | --- |
| RF-47 | Vinculado por la épica AURA-15: interpretación de texto transcripto durante interacciones. El modelo documenta sesiones y mensajes de interacción de voz, sin afirmar implementación. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RF-48 | Vinculado por la épica AURA-15: respuestas contextualizadas según perfil, historial y estado estimado. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RF-49 | Vinculado por la épica AURA-15: recuperación de recuerdos, rutinas, preferencias y vínculos familiares. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RF-50 | Vinculado por la épica AURA-15: incorporación de información relevante a la memoria del paciente. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RF-51 | Vinculado por la épica AURA-15: detección de estado cognitivo o emocional estimado. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RF-52 | Vinculado por la épica AURA-15: adaptación de actividades cognitivas según desempeño previo. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RF-53 | Vinculado por la épica AURA-15: adaptación de respuestas según estado emocional o cognitivo. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RF-54 | Vinculado por la épica AURA-15: asistencia para clasificación de eventos con contexto adicional. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |
| RNF | Pendiente / sin vínculo explícito: no existe una relación AURA-53 ↔ RNF ni una relación RNF ↔ AURA-15 en la matriz consultada. | [[Document Hub/Trazabilidad RF-Épicas]]; [[Document Hub/Pre Estudio Inicial/Requerimientos]] |

## 3. Decisiones de diseño (ADR)

| ADR | Relación con la tarea | Estado / evidencia |
| --- | --- | --- |
| ADR-003 — Base de Datos (Relacional y Vectorial) | Aplica directamente: adopta Supabase con PostgreSQL 16 y pgvector; el modelo incluye datos relacionales y `ai.memory_embeddings`. | Aceptado. [[Document Hub/INSTANCIA 2 — Sprint 0/Arquitectura y Stack Tecnológico]] § ADR-003. |
| ADR-005 — Autenticación y Autorización | Aplica a la decisión del anexo de modelar cuidadores con identidad externa OAuth y asociación a cuentas DOT. El ADR vigente define Auth0 como proveedor. | Aceptado. [[Document Hub/INSTANCIA 2 — Sprint 0/Arquitectura y Stack Tecnológico]] § ADR-005. |
| Nuevo ADR — modelo de tenencia hogar/paciente | **Propuesta pendiente de validación.** La decisión `una cuenta DOT por hogar y un único paciente por cuenta` condiciona la tenencia, integridad y evolución del modelo. ADR-003 define la plataforma y ADR-005 la autenticación, pero no fija esta regla de negocio/modelo. Si el equipo confirma que trasciende el MVP, corresponde abrir un ADR específico de modelo de tenencia. | No crear aún: la fuente de AURA-53 declara la propuesta sujeta a cambios y no hay decisión formal del equipo para aprobar un nuevo ADR. [[Definicion y decisiones de tablas BD]]; [[DER - Base de Datos Aurora]]. |
| Resto de las decisiones de tablas | Consolidación de diseño lógico: roles `primary/support`, biometría consolidada, orígenes de eventos explícitos, actividades unificadas, embeddings versionables, UUID generados por Python, auditoría con IDs mixtos e integridad de drop-in. | No requieren ADR nuevo por separado con la evidencia actual: son detalles de implementación/modelado derivados o compatibles con ADR-003/ADR-005. Requieren revisión al materializar migraciones. [[Definicion y decisiones de tablas BD]]. |

## 4. Modelo de datos (DER)

| DER / entidad | Cambio o relación | Evidencia |
| --- | --- | --- |
| DER completo de Aurora | Anexo principal de AURA-53. Representa el modelo físico y las relaciones entre los dominios `core`, `routines`, `voice`, `biometrics`, `events`, `alerts`, `ai`, `caregiver`, `orchestration` y `compliance`. | [[DER - Base de Datos Aurora]] |
| Núcleo para AURA-15 | El DER incluye, entre otras, `ai.patient_memories`, `ai.memory_embeddings`, `ai.cognitive_state_records`, `ai.ai_decisions` y `ai.llm_interaction_logs`, relacionadas con paciente y, cuando corresponde, sesiones de voz. | [[DER - Base de Datos Aurora]] |
| Decisiones y definiciones de tablas | Anexo explicativo del significado de las tablas y de las decisiones de modelo; no se reproduce aquí. | [[Definicion y decisiones de tablas BD]] |
| DDL/migraciones ejecutables | Pendiente: no hay script SQL, migración ni modelo de aplicación dentro de la carpeta actual de AURA-53. El commit de consolidación eliminó el script SQL previo de Sprint 1. | Commit `4a3a442f2e7179907dad2baca92b2fad2cd74473`; árbol actual de AURA-53. |

## 5. Diagramas de modelado

### DER y vistas DBML existentes

Se utilizan los anexos existentes; no se generan diagramas duplicados. El DER en Mermaid es la representación completa y el paquete DBML ofrece una vista general y siete vistas por dominio.

| Anexo | Uso en la trazabilidad |
| --- | --- |
| [[DER - Base de Datos Aurora]] | DER completo y notas de integridad. |
| [[DER_Aurora_8_Vistas_DBML/README]] | Índice y criterio de uso del paquete DBML. |
| [[DER_Aurora_8_Vistas_DBML/01_Vista_General.dbml]] | Vista ejecutiva resumida. |
| [[DER_Aurora_8_Vistas_DBML/02_Core_y_Cuidadores.dbml]] | Cuenta DOT, pacientes, cuidadores, contactos, consentimientos y preferencias. |
| [[DER_Aurora_8_Vistas_DBML/03_Rutinas_y_Medicacion.dbml]] | Rutinas, medicación y cumplimiento. |
| [[DER_Aurora_8_Vistas_DBML/04_Voz_e_Interaccion.dbml]] | Sesiones de voz, mensajes, recordatorios, actividades y drop-in. |
| [[DER_Aurora_8_Vistas_DBML/05_Biometria_y_Eventos.dbml]] | Dispositivos, lecturas, criterios, geocercas y eventos. |
| [[DER_Aurora_8_Vistas_DBML/06_Alertas_y_Escalamiento.dbml]] | Alertas, reglas, escalamiento, notificaciones y confirmaciones. |
| [[DER_Aurora_8_Vistas_DBML/07_Inteligencia_Artificial.dbml]] | Memorias, embeddings, estado cognitivo, decisiones y logs de LLM. |
| [[DER_Aurora_8_Vistas_DBML/08_Orquestacion_y_Compliance.dbml]] | Flujos, auditoría, retención, accesos y claves. |
| [[DER_Aurora_8_Vistas_DBML/DER_Aurora.dbml]] y [[DER_Aurora_8_Vistas_DBML/DER_Aurora.pdf]] | Modelo DBML físico completo y su exportación PDF. |

No se agrega un diagrama de secuencia o estados: no hay una historia, criterio de aceptación ni comportamiento ejecutable de AURA-53 que los sustente.

## 6. Código y cambios relacionados

| Componente | Repositorio | Ruta exacta / símbolo | Commit o PR | Evidencia |
| --- | --- | --- | --- | --- |
| Documentación del modelo | ObsidianAurora | `Document Hub/INSTANCIA 3 — Sprints 1 a N/Sprint 1/AURA-53/DER - Base de Datos Aurora.md` | `4a3a442f2e7179907dad2baca92b2fad2cd74473` — 2026-07-18 | El commit crea el DER consolidado. |
| Vistas del modelo | ObsidianAurora | `Document Hub/INSTANCIA 3 — Sprints 1 a N/Sprint 1/AURA-53/DER_Aurora_8_Vistas_DBML/` | `4a3a442f2e7179907dad2baca92b2fad2cd74473` — 2026-07-18 | El commit crea `DER_Aurora.dbml`, PDF, README y ocho vistas DBML. |
| Decisiones de tablas | ObsidianAurora | `Document Hub/INSTANCIA 3 — Sprints 1 a N/Sprint 1/AURA-53/Definicion y decisiones de tablas BD.md` | `4a3a442f2e7179907dad2baca92b2fad2cd74473` — 2026-07-18 | El commit crea el anexo de decisiones y definición de tablas. |
| Código de aplicación | Aurora Core / Aurora Care / Aurora Home | No aplica a la evidencia localizada: no se identificaron rutas ni commits relacionados por `AURA-53`, `Diseño de BD` o `der-base-datos`. | Pendiente de validación en los repositorios remotos. | AURA-53 documenta diseño; no hay implementación versionada vinculada en las fuentes locales consultadas. |
| Pull request | ObsidianAurora | No se localizó referencia de PR en las refs locales ni en el material de AURA-53. | Pendiente. | La rama local `der-base-datos` contiene el commit y está contenida en `main`; la asociación a un PR requiere evidencia del repositorio remoto. |

## 7. Casos de prueba y ejecución

Jira no provee criterios de aceptación, por lo que no es posible declarar casos de aceptación ejecutables ni resultados aprobados. Los siguientes son **casos técnicos candidatos**, derivados de decisiones explícitas del modelo; no sustituyen criterios Jira y permanecen pendientes hasta contar con DDL/migraciones y criterios aprobados.

| ID | Criterio | Precondición | Pasos | Resultado esperado | Resultado de ejecución |
| --- | --- | --- | --- | --- | --- |
| CP-AURA-53-01 | Sin CA Jira. Traza la decisión de una cuenta DOT con un único paciente. | DDL o migración versionada que implemente `core.home_accounts` y `core.patients`; instancia de prueba. | 1. Crear una cuenta DOT. 2. Asociar un paciente. 3. Intentar asociar un segundo paciente a la misma cuenta. | La restricción de unicidad sobre `core.patients.home_account_id` impide el segundo vínculo. | Pendiente: no existe DDL/migración ni evidencia de ejecución en AURA-53. |
| CP-AURA-53-02 | Sin CA Jira. Traza la decisión de integridad de `voice.drop_in_sessions`. | DDL o migración versionada que implemente las claves foráneas compuestas; cuenta, paciente y cuidadores de prueba. | 1. Asociar un paciente a una cuenta DOT. 2. Asociar un cuidador diferente a otra cuenta. 3. Intentar crear un `drop_in_session` entre ambos. | La integridad referencial rechaza la sesión si paciente y cuidador no pertenecen a la misma cuenta DOT. | Pendiente: no existe DDL/migración ni evidencia de ejecución en AURA-53. |
| CP-AURA-53-03 | Sin CA Jira. Traza la decisión de embeddings versionables. | DDL o migración versionada de `ai.memory_embeddings`; memoria de paciente de prueba. | 1. Registrar más de un chunk para una memoria. 2. Registrar una nueva versión/modelo de embedding. 3. Consultar los registros. | Se conservan chunks y versiones de modelo según las restricciones que el equipo formalice en DDL. | Pendiente: la decisión existe en el anexo, pero no hay DDL, restricción concreta ni resultado de ejecución. |

Como referencia metodológica, el [[Document Hub/INSTANCIA 2 — Sprint 0/Plan de Testing]] prevé pruebas unitarias e integración, pero no acredita ejecución para AURA-53.

## 8. Matriz de trazabilidad

| Historia / tarea | RF / RNF | ADR | DER | Diagramas | Código | Casos de prueba |
| --- | --- | --- | --- | --- | --- | --- |
| AURA-53 — Diseño de BD | RF-47 a RF-54, vía épica AURA-15. RNF: sin vínculo explícito. | ADR-003 y ADR-005 aplicables; propuesta de ADR de tenencia pendiente de validación. | [[DER - Base de Datos Aurora]]; [[Definicion y decisiones de tablas BD]] | [[DER_Aurora_8_Vistas_DBML/README]] y vistas DBML 01–08; DER Mermaid. | Commit `4a3a442f2e7179907dad2baca92b2fad2cd74473`; sin código de aplicación ni PR evidenciado. | CP-AURA-53-01 a CP-AURA-53-03 — pendientes, no ejecutados. |

## 9. Checklist de completitud UTN

- [x] Historia/tarea, estado final, fecha de cierre y ausencia de criterios documentados con fuente Jira.
- [x] RF vinculados sólo mediante la épica AURA-15 y la matriz explícita; RNF marcado sin vínculo explícito.
- [x] ADR-003 y ADR-005 vinculados; nueva decisión de tenencia evaluada y marcada pendiente de validación.
- [x] DER y anexos de decisiones enlazados sin duplicarlos.
- [x] Diagramas existentes vinculados; no se agregaron diagramas no sustentados.
- [x] Cambio documentado con ruta exacta y commit; código de aplicación y PR justificados como sin evidencia local / pendientes.
- [x] Casos técnicos candidatos incluyen precondición, pasos, resultado esperado y estado de ejecución.
- [x] No se declara ningún resultado de prueba como aprobado: Jira no tiene criterios de aceptación y no hay evidencia de ejecución.

## 10. Pendientes y validaciones requeridas

1. Resolver la discrepancia entre Sprint 1 (carpeta y alcance solicitado) y `SCRUM Sprint 2` (campo de Jira).
2. Definir y cargar criterios de aceptación de AURA-53 en Jira o acordar formalmente que la tarea documental no los requiere; no se modificó Jira desde este artefacto.
3. Confirmar si la regla de una cuenta DOT por hogar con un único paciente es una decisión de alcance duradera. Si lo es, crear y aprobar un ADR específico de modelo de tenencia.
4. Versionar o localizar el DDL/migraciones y, si corresponde, el script SQL mencionado en el comentario Jira; el script no está en la carpeta actual y el commit `4a3a442` eliminó su versión previa del Sprint 1.
5. Ejecutar y registrar las validaciones de integridad una vez disponible el DDL/migraciones, incluyendo fecha, comando/salida y responsable.
6. Verificar en el repositorio remoto si el commit `4a3a442` tuvo PR asociado y, de existir, agregar URL, revisión y resultados de CI.
