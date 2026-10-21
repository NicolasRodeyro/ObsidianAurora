# Revisión del Docs contra la guía de documentación de la cátedra

> **Fuente de la guía:** `Document Hub/UTN-FRC- ISI - Proyecto Final - Documentación a presentar - 2026.docx.pdf`.
> **Qué se revisó:** el Google Doc "Proyecto Aurora 2026" (pestaña 1, al 15/10/2026, después de aplicar las correcciones 01 a 09) y las carpetas `INSTANCIA 1` a `INSTANCIA 5` de `Document Hub/`. La Instancia 3 (informes de sprint y trazabilidad) queda para después.
> **Leyenda:** ✅ cumple · 🟡 cumple en parte · 🔴 falta.

---

## 0. Formato estándar (aplica a todos los documentos)

La guía pide que **todo documento entregable** tenga carátula, historial de revisión, tabla de contenido, introducción y audiencia.

| Requisito | Estado | Detalle |
| --- | --- | --- |
| Carátula (universidad, regional, carrera, asignatura, curso, tema, docentes, año, integrantes con legajo) | ✅ | Una carátula para todo el Doc, con legajos, curso 5K3 y docentes. Falta confirmar con el JTP si alcanza una sola carátula o si cada documento lleva la suya |
| **Historial de revisión** (versión, fecha, autor, cambio) | 🔴 | No existe en el Doc. Solo hay "Versión 1.0 / 05/05/2026" en la ficha del Plan de Proyecto |
| Tabla de contenido automática | ✅ | "Índice" al inicio (hay que actualizarlo con Ctrl+clic → Actualizar) |
| **Introducción y audiencia** | 🟡 | Tienen ambas: Working Agreement, Arquitectura y Plan de Testing. **Faltan** en Estudio Inicial, Plan de Proyecto, Gestión de la Configuración, User Story Mapping y Backlog |

---

## 1. Instancia 1: Inicio de proyecto

### Estudio Inicial

| Contenido pedido | Estado | Detalle |
| --- | --- | --- |
| Objetivo, ámbito de aplicación e impulsos | ✅ | Secciones Objetivo, Contexto, Ámbito e Impulsos |
| Procesos involucrados: descripción, **flujo**, participantes, información y sistemas existentes | 🟡 | El texto está (AS-IS y TO-BE separados). **Falta insertar los diagramas de flujo** (`figuras/` AS-IS y TO-BE): hoy no hay ninguna imagen en esa sección |
| Mapa global de procesos | ✅ | Con dos imágenes. Revisar que coincidan con el texto nuevo (solo componentes del MVP) |
| Propuesta: objetivo, alcance (incluye y excluye) y valor esperado | ✅ | Alcance del MVP y futuras versiones consistente con el USM |

### Plan de Proyecto

| Contenido pedido | Estado | Detalle |
| --- | --- | --- |
| Alcance, equipo y roles | ✅ | |
| Propuesta metodológica: coordinación, técnica de estimación, **métricas de seguimiento** | 🟡 | Están Scrum de 3 semanas y estimación por capacidad en horas. **No hay métricas de seguimiento** (velocidad, cumplimiento del sprint, burndown, defectos) |
| WBS y cronograma alineado al calendario académico | 🟡 | Están. La columna "Estado al 12/10/2026" tiene 7 `[A COMPLETAR]` |
| Plan de riesgos | ✅ | Con los riesgos nuevos de falsos positivos y negativos |
| Presupuesto de desarrollo y costo operativo mensual | 🟡 | Real vs. estimado cargado. Falta infraestructura (`[A COMPLETAR]`) |
| Flujo de fondos y monetización | ✅ | Con B2B y B2G como visión futura |

---

## 2. Instancia 2: Sprint 0

| Documento | Contenido pedido | Estado | Detalle |
| --- | --- | --- | --- |
| Working Agreement | Roles, versionado y revisión, DoR/DoD, política de IA | ✅ | Revisión al inicio de cada sprint ya figura |
| Gestión de la Configuración | Estructura y nombres, ciclo de vida, herramientas, política de ramas y PR | ✅ | Revisar la figura de la estructura del repositorio (puede estar desactualizada) |
| Arquitectura | C4 nivel 1, 2 y despliegue | 🟡 | Texto vigente. **Reemplazar las tres imágenes** por las de `figuras/`. En 2.1 (Contexto) no se detecta ninguna imagen: verificar que el diagrama esté |
| Arquitectura | ADR con cobertura mínima: lenguaje/framework, BD, patrón, autenticación, despliegue y **diseño de API** | 🔴 | Hay ADR de todo salvo **diseño de API**. El ADR-009 es de IoT y está sin implementar |
| Arquitectura | Cada ADR con **alternativas consideradas con criterios de comparación**, decisión y consecuencias con trade-offs | 🔴 | Solo ADR-010 y ADR-011 tienen "Alternativas". Los ADR-001 a 009 tienen contexto, drivers, decisión y consecuencias, pero **sin alternativas ni comparación** |
| Arquitectura | Pautas de codificación; despliegue y ambientes | ✅ | |
| Plan de Testing | Niveles y herramientas, cobertura, incidencias, cuándo y quién revisa | ✅ | Reforzado con métricas (secciones 4 y 7) |
| User Story Mapping | Actividades, tareas y corte de MVP | ✅ | |
| Product Backlog inicial | Épicas e historias **priorizadas, con criterios de aceptación y estimación** | 🔴 | Solo hay **3 de las 9 épicas** de producto (y la Épica 3 es de futuras versiones). **No hay estimación** en ninguna historia. Faltan las épicas de alertas, motor de IA, panel del cuidador, seguridad y rutinas y medicación, que son el corazón del MVP |
| Glosario | Términos clave con definición acordada | ✅ | Actualizado. Se puede sumar "Consentimiento" y "Retención" |

---

## 3. Instancia 4: Jornada de presentación (6/10/2026)

La guía pide **paper, póster y video**, "bajo las normas previstas en el instrumento que regula la presentación" (ese reglamento no está en el repo).

| Entregable | Estado | Detalle |
| --- | --- | --- |
| Video | 🟡 | `INSTANCIA 4 — Jornada de presentación/video-aurora.html` (render animado). Menciona la autenticación con Auth0 como historia del Sprint 1, que es correcto como relato. Falta el archivo de video final si se exportó |
| Paper | 🔴 | No hay ningún paper ni en el repo ni en las carpetas locales. En el cronograma figura "Documentación, paper, video y demo" |
| Póster | 🔴 | Idem |
| Material complementario | ℹ️ | Existe la landing de la jornada (`Desarrollo/Landing`, con QR) y presentaciones en `Speechs/`. Conviene referenciarlas |

**Pendiente:** saber si el paper y el póster existen (fuera del repo) y subirlos a la carpeta de la Instancia 4, y revisar que digan lo mismo que el Doc (MVP único, Azure, Supabase, sin Aurora Band).

---

## 4. Instancia 5: Fin de proyecto (cierre de ejecución 05/10, entrega final 05/11)

La carpeta `INSTANCIA 5 — Fin de proyecto/` está vacía (solo `.gitkeep`). **Faltan los cinco documentos.**

| Documento | Qué pide la guía | Material disponible hoy | Qué falta |
| --- | --- | --- | --- |
| **Documentación del proceso actualizado** | Proceso post-implementación, diagrama de flujo, roles y responsabilidades | Sección TO-BE del Estudio Inicial y las figuras TO-BE | Redactarlo desde el sistema real, con diagrama de flujo y roles (paciente, cuidador principal, cuidador de apoyo, equipo) |
| **Instructivos de uso** | Cada función con capturas y flujos de tareas; preguntas frecuentes y problemas comunes | 13 archivos de `Design/previews` (32 pantallas MVP), README de Care, flujos de Home | Capturas de la app real; instructivo de Aurora Home para el paciente; FAQ |
| **Manual de instalación y operación** | Requisitos, instalación paso a paso, variables y secretos, backups, restauración y monitoreo | `AuroraCore/deploy/` (compose con Traefik, `deploy.sh`), `.env.example` de los cuatro repos, `AuroraHome/Docs/04` y `13` (offline, operación y OTA), `deploy/systemd`, READMEs de Worker IA y Care | **`AuroraCore/deploy/README.md` está desactualizado** (habla de Nginx y puertos; hoy es Traefik). Backups, restauración y monitoreo sin definir (RPO/RTO `[A COMPLETAR]`) |
| **Análisis de impacto ambiental** | Consumo energético y huella de carbono aproximada, alternativas de diseño evaluadas por impacto ambiental, beneficios | Nada | Todo. Datos: fuente de 27 W y consumo real de la Raspberry Pi 5 (idealmente medido), VPS y servicios en la nube, voz local vs. nube, descarte de la pulsera (menos hardware nuevo) |
| **Retrospectiva de proyecto** | Top 3 decisiones que salieron bien, top 3 que harían distinto, recomendaciones a futuros equipos | Retrospectivas de los Sprints 0 a 2, decisiones documentadas (descope de Aurora Band, cambio a Azure, Supabase) | La reflexión del equipo; puedo armar un borrador con las decisiones ya registradas |

---

## 5. Prioridad sugerida

**A. Rápido y en el Doc (sin depender de nadie):**
1. Historial de revisión.
2. Introducción y audiencia en los documentos que faltan.
3. Métricas de seguimiento en el Plan de Proyecto.
4. Insertar AS-IS y TO-BE y reemplazar los tres C4 (a mano).

**B. Arquitectura:**
5. ADR de diseño de API (se arma desde `AuroraCore/api-openapi.yaml`).
6. Alternativas con criterios en los ADR-001 a 009 (borrador mío, revisión del equipo).

**C. Backlog:**
7. Completar las épicas 4 a 9 (desde Jira y `Trazabilidad RF-Épicas`) y agregar estimación.

**D. Instancia 4:** ubicar o preparar el paper y el póster.

**E. Instancia 5:** los cinco documentos. El manual de instalación y la retrospectiva se pueden redactar ya; el impacto ambiental necesita una medición; los instructivos necesitan capturas.

## 6. Datos que necesito del equipo

- ¿Existen el paper y el póster? ¿Dónde están? ¿Hay un reglamento de la jornada con formato?
- Autores y fechas para el historial de revisión (o lo reconstruyo desde el historial de versiones del Doc).
- ¿El JTP acepta una carátula única o pide una por documento?
- ¿Los documentos de la Instancia 5 van como pestañas del mismo Doc o como archivos aparte?
- ¿Alguien puede medir el consumo de la Raspberry con un medidor de enchufe (en reposo y en conversación)?
- Estimaciones de las historias: ¿están en Jira (horas o puntos)?

---

## 7. Respuestas del equipo (15/10/2026)

| Pregunta | Respuesta |
| --- | --- |
| Paper y póster | Están en la carpeta de Drive **PAPER**: https://drive.google.com/drive/folders/1f0UUx19_2XY1bp-2ClbyupcR-_oQchJu (tres PDF `5K3G12_AURORA_1` a `_3`, dos imágenes `_4_CLARO` y `_4_OSCURO`, un video `_5.mp4`). Alcanza con **agregar el link** en el Doc y en la carpeta de la Instancia 4. Las fechas de modificación son de agosto y septiembre, anteriores a las correcciones: hay que revisar que no digan cosas viejas (Aurora Band, Redis, voz local) |
| Carátula | **Una sola para todo el Doc** (lo confirmó el JTP) |
| Documentos de la Instancia 5 | **Todos dentro del mismo Doc**, pero **todavía no se agregan** |
| Medición de la Raspberry | Probablemente no se pueda medir: el análisis ambiental usará valores del fabricante y estimaciones declaradas como tales |
| Estimaciones de historias | Están en Jira, **a ojo** (sin técnica formal). Se documentan así, sin inventar una técnica |

---

## 8. Estado de avance por instancia

### Instancia 1 (hecha en el Doc el 15/10/2026)

- **Estudio Inicial:** se agregaron las secciones *Introducción* y *Audiencia* antes de *Objetivo*.
- **Plan de Proyecto:** se agregaron *Introducción* y *Audiencia* antes del *Acta de Constitución*, y las **métricas de seguimiento** (cumplimiento del sprint, desvío de cierre, carga por integrante, trabajo arrastrado, incidencias por criticidad, calidad del código y mejora del proceso) a continuación de la propuesta metodológica. Las metas son una propuesta del equipo y se aclara que las estimaciones son por juicio, sin técnica formal.
- **Pendiente del equipo (Instancia 1):**
  1. Insertar los diagramas AS-IS y TO-BE (`figuras/`) en *Procesos involucrados*.
  2. Los `[A COMPLETAR]` de la Instancia 1 (ver `10 - Pendientes…`): Estudio Inicial (validación clínica), objetivos del piloto, presupuesto (CAPEX e infraestructura, OPEX) y columna de estado del cronograma.
  3. Revisar que el mapa global de procesos coincida con el texto nuevo.

---

## 9. Verificación de la Instancia 1 contra el Doc (15/10/2026)

Se releyó el Doc después de que el equipo completara el Estudio Inicial y el Plan de Proyecto.

### Estudio Inicial

| Contenido pedido | Estado | Detalle |
| --- | --- | --- |
| Introducción y audiencia | ✅ | |
| Objetivo, ámbito e impulsos | ✅ | |
| Procesos involucrados: descripción, flujo, participantes, información, sistemas | ✅ | Con las figuras AS-IS y TO-BE ya insertadas; flujo y participantes escritos para las dos situaciones |
| Mapa global de procesos | ✅ | Dos vistas con sus imágenes |
| Propuesta: objetivo, alcance (incluye y excluye) | ✅ | |
| Propuesta: **valor esperado** | 🟡 | No hay un apartado de valor esperado. Además, el «Objetivo de la propuesta» dice «detectar situaciones de riesgo», que es de futuras versiones |
| Dominio clínico | ✅ | Fechas y nombres de profesionales cargados. Quedan marcas `[A validar]` en tres reglas (legítimas) |

### Plan de Proyecto

| Contenido pedido | Estado | Detalle |
| --- | --- | --- |
| Introducción y audiencia | ✅ | |
| Alcance, equipo y roles | ✅ | Las horas suman 84 h semanales, como declara la propuesta metodológica |
| Propuesta metodológica con métricas de seguimiento | ✅ | |
| WBS y cronograma | ✅ | Cronograma como plan inicial, sin columna de estado |
| Plan de riesgos | ✅ | |
| Presupuesto y OPEX | 🟡 | Cargados. La suma del OPEX cierra ($10 + $15 + $5 + $0 = $30). **El resumen «Frente al tope» no se actualizó** con la infraestructura |
| Flujo de fondos y monetización | ✅ | |

### Inconsistencias que aparecieron (propuesta de arreglo, sin aplicar)

1. **Proveedor de IA.** El OPEX (cargado por el equipo) dice «hoy Gemini 3.5 Flash Lite de Google». Otras cuatro partes dicen «hoy OpenAI, con Gemini como alternativa»: riesgos (dependencia de proveedores), supuestos (disponibilidad de APIs), Arquitectura (tabla de contenedores y de sistemas externos) y Privacidad (6.2). Además el modelo en el `.env` del Worker IA es `gemini-3.1-flash-lite`, no 3.5, y el valor por defecto de `.env.example` sigue siendo OpenAI. **Hay que confirmar cuál es el proveedor y el modelo vigentes** y unificar. Si es Gemini, hay que cambiar «hoy OpenAI» por «hoy Gemini (Google)» y corregir la lista de destinatarios del consentimiento 2.
2. **Resumen del presupuesto.** Con los datos cargados: gasto real = $502.283,45 (hardware) + $72.017 (infraestructura) = **$574.300,45**; con lo pendiente ($42.892) llegaría a **$617.192,45**, es decir +$74.300,45 (+14,9 %) sobre el tope hoy y +$117.192,45 (+23,4 %) al cierre. La tabla «Frente al tope», el párrafo siguiente, el riesgo R13, el párrafo de 6.3 («Al 12/10/2026 el hardware ya suma…») y la restricción presupuestaria hablan solo del hardware y dicen que la infraestructura está «sin sumar». Conviene actualizarlos y confirmar si los $72.017 son pesos y si incluyen dominio y servicios.
3. **Valor esperado** en la Propuesta del Estudio Inicial: agregar un apartado corto con los beneficios (carga del cuidador, continuidad de rutinas, trazabilidad del cumplimiento), alineado con los objetivos O1 a O7 del Plan, y corregir «detectar situaciones de riesgo» por «alertar por omisiones».
4. **Ficha del Acta** (Versión 1.0, 05/05/2026): se resuelve con el historial de revisión del final.
5. Detalles: «VIrginia Santos» y tres encabezados vacíos.

### Conclusión

La Instancia 1 **cumple la guía** salvo el valor esperado (a agregar) y las inconsistencias anteriores, que son de coherencia y no de contenido faltante. Quedan además los 5 `[A COMPLETAR]` de Arquitectura y Plan de Testing, que son de la Instancia 2.

### Resultado de los arreglos (15/10/2026)

Con los datos que confirmó el equipo (proveedor de IA `gemini-3.5-flash-lite`; los $72.017 son pesos e incluyen dominio y servicios, y falta el mes de noviembre de Hostinger), se aplicaron en el Doc los puntos 1 a 3 y el typo. El punto 4 (ficha del Acta) queda para el historial de revisión.

**Estado final de la Instancia 1: cumple la guía.** Solo queda del lado del equipo el historial de revisión (transversal, al final) y, si se quiere, los tres encabezados vacíos con estilo de título, que no afectan el contenido.

---

## 10. Instancia 2 (aplicada en el Doc el 15/10/2026)

| Pendiente de la sección 2 | Resultado |
| --- | --- |
| Introducción y audiencia en Gestión de la Configuración, User Story Mapping y Product Backlog | ✅ Agregadas. La del Backlog incluye cómo se estima |
| ADR de diseño de API | ✅ **ADR-012: Diseño de API** (REST sobre HTTPS con versionado `/api/v1/`, contrato OpenAPI generado con drf-spectacular, autenticación diferenciada, formato de errores y chequeo de compatibilidad para los dispositivos Home). Armado desde `AuroraCore` (`api-openapi.yaml`, `config/settings/base.py`, `scripts/check_home_contract_compatibility.py`) |
| Alternativas con criterios en los ADR | ✅ Agregadas a los ADR-001, 002, 003, 004, 005, 007 y 008 (3 o 4 alternativas cada uno, comparadas con los drivers del propio ADR). **No se agregaron** al ADR-006 (reemplazado por el ADR-011, que ya tiene alternativas) ni al ADR-009 (sin implementar; compara REST y MQTT en la decisión) |
| Product Backlog: épicas 4 a 9 | ✅ Agregadas con 21 historias, criterios de aceptación, prioridad, estimación y referencia a Jira (AURA-16 alertas, AURA-15 IA, AURA-17 rutinas y medicación, AURA-18 panel, AURA-20 seguridad, AURA-21 orquestación) |
| Estimación en las historias | ✅ Todas las historias la tienen. Las 1.1 y 1.2 suman las estimaciones que existen en Jira; **el resto es propuesta**, porque Jira solo tiene puntos en 42 tickets (tareas de los Sprints 0 y 1 y la AURA-109), no en las historias de los Sprints 2 a 6 |

### Qué tiene que revisar el equipo (son borradores míos)

1. **Alternativas de los ADR.** Están escritas a partir de los drivers de cada ADR y de lo que se sabe del proyecto (por ejemplo, Auth0 y Render sí se usaron, AURA-92 y AURA-82). Las demás (Flutter, GraphQL, Kafka, etc.) son las opciones habituales; conviene que el equipo confirme que se discutieron o las ajuste. Si alguna no se consideró de verdad, hay que sacarla.
2. **Estimaciones propuestas** de las historias 2.1, 2.2 y 4.1 a 9.1: escala 1, 2, 3, 5 y 8 con el Login de Care (3 puntos) como referencia.
3. **Criterios de aceptación** de las épicas 4 a 9: salen de los requerimientos, del Plan de Testing y de los tickets de Jira; verificar que reflejan lo implementado.

### Pendiente de Instancia 2 del lado del equipo

- Los 5 `[A COMPLETAR]` de Arquitectura y Plan de Testing (ver `10`).
- Reemplazar los tres diagramas C4 por los de `figuras/` y verificar que la sección 2.1 (Contexto) tenga su diagrama.
- Revisar la figura de la estructura del repositorio en Gestión de la Configuración y la de CI/CD (5.2).

---

## 11. Instancia 4 (aplicada el 15/10/2026)

| Entregable | Resultado |
| --- | --- |
| Paper, póster y video | ✅ Se agregó al Doc la sección **«Jornada de Presentación Aurora»** (introducción, audiencia y material presentado), con el **link a la carpeta de Drive** (<https://drive.google.com/drive/folders/1f0UUx19_2XY1bp-2ClbyupcR-_oQchJu>). Los archivos no se copiaron, a pedido del equipo |
| Repositorio | ✅ `Document Hub/INSTANCIA 4 — Jornada de presentación/Jornada de Presentación.md` con el mismo contenido y enlace desde `Índice Aurora.md` |

### A confirmar por el equipo

- **Qué es cada archivo (confirmado por el equipo).** `_1` es portada + póster + paper, `_2` es póster + paper, `_3` es solo el póster, `_4` (claro y oscuro) es el logo y `_5` es el video. Se agregó además la landing presentada en la jornada: <https://landing-nu-kohl-45.vercel.app/>.
- **Que el contenido siga vigente.** Las fechas de modificación de los archivos son de agosto y septiembre, anteriores a la corrección de alcance del 12/10 (Aurora Band fuera del MVP, voz en la nube con Azure, Supabase como base y autenticación). Si el paper o el póster mencionan Aurora Band como parte del MVP o la voz 100 % local, hay que decidir si se aclara o se actualiza.
- **Que la carpeta sea accesible** para los docentes (permiso de lectura con el enlace).

---

## 12. Revisión conjunta de las Instancias 2 y 4 (16/10/2026)

**Alternativas de los ADR.** El equipo confirmó cuáles se evaluaron de verdad y el Doc quedó así:

| ADR | Alternativas que quedan | Se sacaron |
| --- | --- | --- |
| ADR-001 backend | Node.js (NestJS o Express); Python con FastAPI | Java con Spring Boot |
| ADR-002 app móvil | **Next.js** (primera versión de Aurora Care, abandonada porque la app necesita funciones nativas del dispositivo); React Native sin Expo | Flutter, nativo (Kotlin y Swift), PWA |
| ADR-003 base de datos | PostgreSQL en AWS (RDS); PostgreSQL propio en el VPS | MongoDB con base vectorial, Firebase |
| ADR-004 patrón | Monolito Django con la IA incluida | Serverless, broker (Kafka o RabbitMQ) |
| ADR-005, 007, 008, 012 | Sin cambios (el equipo no objetó ninguna) | |

**Estimaciones del Backlog:** se dejan como están (propuesta del equipo, aclarado en la introducción del Backlog).

**Instancia 4:** el paper y el póster se elaboraron en junio y julio, cuando Aurora Band todavía era parte del alcance; el equipo decidió **dejarlos sin tocar**. Se agregó al Doc (y al repo) una línea en la introducción de la sección de la Jornada: elaborados en junio y julio de 2026, con la anticipación que pidió la cátedra, antes de la decisión del 29/08/2026 que dejó Aurora Band fuera del MVP.

**Pendiente de las Instancias 2 y 4 del lado del equipo:** reemplazar los tres diagramas C4 y verificar el diagrama de Contexto (2.1); revisar las figuras de estructura del repositorio y de CI/CD; confirmar que la carpeta de Drive se abre con el enlace.

---

## 13. Historial de revisión (agregado el 16/10/2026)

Se agregó al Doc, entre la carátula y el índice, la sección **«Historial de revisión»** con una tabla de 8 versiones (versión, fecha, autor y descripción del cambio). Cubre el punto «formato estándar» de la guía (carátula única, historial, tabla de contenido, introducción y audiencia).

| Versión | Fecha | Autor | Cambio |
| --- | --- | --- | --- |
| 1.0 | 05/05/2026 | Jeremías Maldonado Gómez | Acta de Constitución y Plan de Proyecto |
| 1.1 | 26/05/2026 | Equipo Aurora | Estudio Inicial |
| 2.0 | 07/06/2026 | Equipo Aurora | Instancia 2 (Sprint 0) |
| 2.1 | 09/07/2026 | Equipo Aurora | Modelo de datos y design system |
| 3.0 | 25/08/2026 | Equipo Aurora | Informe de los Sprints 0, 1 y 2 |
| 3.1 | 29/08/2026 | Equipo Aurora | Aurora Band fuera del MVP |
| 4.0 | 12/10/2026 | Equipo Aurora | Correcciones de la cátedra |
| 4.1 | 16/10/2026 | Equipo Aurora | Revisión contra la guía |

**A confirmar por el equipo:** las fechas de las versiones 1.1 a 3.1 se reconstruyeron del historial de commits de `Document Hub/` y de los archivos de las presentaciones (por ejemplo, 26/05 es la fecha del archivo de la presentación del Estudio Inicial); verificar que coincidan con lo que recuerdan. Los autores se pusieron como «Equipo Aurora», salvo la versión 1.0, que figura a nombre del PM en la ficha del Acta. Si quieren nombres por versión, se ajusta.

**Pendiente de la guía:** solo queda actualizar el índice (Ctrl+clic → Actualizar) y la Instancia 5.


---

## 14. Replicación al repositorio (16/10/2026)

Se replicó el Doc completo en `Document Hub/` (el Doc es la fuente; el repo es su reflejo en Markdown):

- **Regenerados desde el Doc:** `Estudio Inicial Aurora`, `Project Charter` (Plan de Proyecto), `Working Agreement`, `Gestion de la Configuracion`, `Arquitectura y Stack Tecnológico`, `Plan de Testing`, `User Story Map` y `Product Backlog Inicial`, con su frontmatter y pie de «Documentos relacionados».
- **Nuevos:** `Glosario del Dominio`, `Historial de revisión`, `Desarrollo del Proyecto — Sprints 0, 1 y 2` (Instancia 3) y `Jornada de Presentación` (Instancia 4).
- **Imágenes:** carpetas `images/` en las Instancias 1 y 2 (AS-IS, TO-BE, Gantt, estructura del repositorio, convención de commits y los tres diagramas C4 de `figuras/`).
- **Actualizados:** `Requerimientos` (módulo 10, RF-92 a RF-98, RNF-44 a RNF-52), `Trazabilidad RF-Épicas`, `Índice Aurora`, `CLAUDE.md`, `README.md`, y los nombres «Aurora Core (entonces AuroraCareBack)» en la decisión de alcance de Band y en los artefactos de trazabilidad AURA-82/87/88/89/96.
- **No versionado:** `Proyecto Aurora 2026.md` (espejo completo del Doc) está en `.gitignore`; se regeneró solo en local.
