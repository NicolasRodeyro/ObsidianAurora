# Correcciones 9 y 10 — Working Agreement y Gestión de la Configuración

> **Qué cambia en el Docs:**
>
> | Corrección | Sección del Docs | Acción |
> | --- | --- | --- |
> | 9 | **Working Agreement → 3.1 Roles Scrum** | Reemplazar el párrafo y agregar una subsección |
> | 9 | **Gestión de la Configuración → 2 (tabla de ciclo de vida)** | Cambiar los responsables "rotativos" |
> | 10 | **Working Agreement → 4.1 Versionado, 4.2 Revisión de Código y 5.2 Definition of Done** | Reemplazar 4.1 y ajustar 4.2 y 5.2 |
> | 10 | **Gestión de la Configuración → 4 Política de ramas** | Reemplazar completa, para que sea idéntica al Working Agreement |
> | 10 | **Arquitectura → 5.1 Ambientes y 5.3 Estrategia de releases** | Ajustar (se detalla en el archivo 06) |
>
> `[A COMPLETAR]`: nombres que no están en los repos.

---

## 1. Corrección 9 — Product Owner y Scrum Master: continuidad

**Aclaración de fondo:** los roles de **Product Owner** y **Scrum Master fueron siempre fijos** desde el inicio del proyecto; nunca rotaron. Lo que sí cambió a lo largo del proyecto fueron las **asignaciones de los desarrolladores** (en qué componente trabaja cada uno). El Working Agreement decía que esos roles serían "distribuidos y rotados al inicio de cada ciclo", y eso **no describía la práctica real**. La corrección entonces no cambia la forma de trabajar: **corrige el documento para que diga lo que el equipo hace**, y registra la responsabilidad de cada rol.

### Working Agreement → 3.1 Roles Scrum (reemplaza el primer párrafo)

#### 3.1 Roles Scrum

El equipo se organiza bajo Scrum. Los roles de **Product Owner** y **Scrum Master** son **permanentes** durante todo el proyecto, porque requieren continuidad en la priorización del producto y en la facilitación del proceso. Lo que se ajusta de un ciclo a otro son las **asignaciones de desarrollo** (qué componente atiende cada integrante), según las necesidades del producto y la capacidad del equipo.

| Rol | Responsable | Responsabilidad |
| ----- | ----- | ----- |
| **Product Owner** | Haik Martín Kilic Aslan | Mantiene la coherencia del Product Backlog, prioriza según el valor para el paciente y el cuidador, y tiene la **decisión final sobre el producto y el alcance del MVP**. Aprueba los cambios en la línea de corte del User Story Mapping y el paso de `staging` a `main`. |
| **Scrum Master** | Jeremías Daniel Maldonado Gómez | Facilita las ceremonias, remueve impedimentos y vela por el cumplimiento del Working Agreement. Facilita la votación ante un impasse. También es Project Manager del proyecto. |
| **Equipo de desarrollo** | Los cinco integrantes (incluidos el Product Owner y el Scrum Master) | Diseña, desarrolla, prueba y documenta el incremento. |

#### Asignaciones de desarrollo (pueden ajustarse entre ciclos)

| Integrante | Asignación actual |
| ----- | ----- |
| Mateo Romero Plaza | Frontend · Base de datos · Aurora Home · Analista funcional |
| Nicolás Rodeyro Contarino | Frontend · Base de datos · UX/UI |
| Octavio Escudero | Backend · Backend del Worker IA · Aurora Home |
| Haik Martín Kilic Aslan | Backend · Backend del Worker IA · Analista funcional · **Product Owner** |
| Jeremías Daniel Maldonado Gómez | Project Manager · DevOps · Diseño UX/UI · **Scrum Master** |

**Qué cambió respecto de las asignaciones del Plan original (05/05/2026):** Mateo suma Aurora Home. Nicolás deja el rol de ingeniería de IA. Octavio deja DevOps y QA y pasa a Backend, Worker IA y Aurora Home. Haik suma el Worker IA. DevOps queda en Jeremías. `[A CONFIRMAR: las horas semanales de cada integrante, que el Plan fija en 16, 18, 22, 13 y 15]`.

**Cómo se evitan los cambios de criterio entre sprints:**

1. Toda priorización o cambio de alcance se registra en el Product Backlog y en Jira, con el motivo.
2. Una modificación de la línea de corte del MVP solo la aprueba el Product Owner y queda documentada en una decisión de alcance (por ejemplo, la *Decisión de Alcance — Aurora Band fuera del MVP*, 29/08/2026).
3. La Sprint Review y la Retrospectiva revisan si las decisiones del sprint mantuvieron el criterio.
4. Al reasignar a un desarrollador entre componentes, se deja una nota de traspaso en el ticket para no perder contexto.

> **Para el Docs:** además de reemplazar 3.1, corregir en el Plan de Proyecto la tabla **"Equipo de Trabajo"** (sección 6.2) con las asignaciones de arriba, y la tabla **"Equipo"** del informe "Desarrollo del Proyecto Aurora — Sprints 0, 1 y 2", que hoy muestra asignaciones distintas (por ejemplo, Octavio como Backend · DevOps · QA).

### Gestión de la Configuración → 2 (tabla de ciclo de vida): qué cambia

| Artefacto | Dice hoy | Debe decir |
| ----- | ----- | ----- |
| Plan de Proyecto | "Scrum Master del Sprint (Rotativo)" | "Scrum Master" |
| User Story Mapping y Backlog Inicial | "Product Owner del Sprint (Rotativo)" | "Product Owner" |
| Estudio Inicial | "Rotativo por Sprint (Según asignación en Jira)" | "Quien tenga asignado el ticket en Jira" |

---

## 2. Corrección 10 — Una única estrategia de ramas

### Qué había

| Documento | Estrategia que describía |
| ----- | ----- |
| Working Agreement 4.1 | `main` protegida + `develop` de integración + `feature/*` hacia `develop` |
| Gestión de la Configuración 4 | GitHub Flow simplificado: `feature/*` desde `main`, PR a `main` |
| Arquitectura 5.3 | `feature/*` → `develop`; `develop` → `main`; `hotfix/*` desde `main` |
| **Código real** (AuroraCore, `docs/agent-lessons.md`; AuroraCare) | `feature → staging → main`. **La rama base es `staging`**; `main` es la de producción |

Ninguno de los documentos describía lo que el equipo hace. Se adopta **una única estrategia, la que está en uso**, con `staging` como rama de integración (reemplaza a `develop`).

### Estrategia única (idéntica en el Working Agreement y en Gestión de la Configuración)

**Flujo:** `feature/*` → `staging` → `main`

| Rama | Rol | Protección | Despliegue |
| ----- | ----- | ----- | ----- |
| `main` | Código estable de producción y de entrega a la cátedra | Protegida; solo recibe PR desde `staging` o `hotfix/*` | Producción |
| `staging` | **Rama de integración.** Es la rama base de todo el desarrollo | Protegida; solo recibe PR | Entorno de staging (automático) |
| `feature/<descripcion>` | Una tarea o historia de usuario | Nace de `staging`, se elimina al mergear | — |
| `hotfix/<descripcion>` | Corrección urgente de producción | Nace de `main`; PR a `main` y luego **a `staging`** para que no se pierda | — |

**Reglas:**

1. Toda rama de trabajo se crea **desde `staging`**. Confirmar la rama base antes de crearla.
2. Todo PR de trabajo apunta a `staging`. Nadie integra directo en `staging` ni en `main`.
3. Cada PR requiere la revisión y aprobación de **al menos un integrante distinto del autor**.
4. Los tests automáticos (CI) deben pasar antes de mergear.
5. Se promueve a producción con un PR `staging` → `main`, aprobado por el **Product Owner (Haik Kilic)**; si él es el autor del cambio, lo aprueba otro integrante (regla 3).
6. Un PR apilado sobre otra rama de trabajo se mergea en esa rama, no en `staging`; verificar siempre que el cambio llegó a `staging`.
7. Nomenclatura: `feature/AURA-<número>-<descripcion-breve>` (el prefijo es el de la clave del proyecto en Jira, que es `AURA`; el Working Agreement decía `AUR`).

### Working Agreement → 4.1 Versionado (reemplaza)

#### 4.1 Versionado

El versionado se basa en ramas controladas con el flujo `feature` → `staging` → `main`, descrito en *Gestión de la Configuración*, sección 4. `main` contiene el código estable de producción; `staging` es la rama de integración; el trabajo se hace en ramas `feature/` creadas desde `staging`.

### Working Agreement → 4.2 Revisión de Código (cambiar solo el primer punto)

* "Todo código debe integrarse a **`staging`** exclusivamente a través de Pull Requests (PR)."

### Working Agreement → 5.2 Definition of Done (cambiar el segundo punto)

* "El código fue subido, cuenta con revisión aprobada y está integrado sin errores en **`staging`**."
  *(Se elimina "rama principal o de desarrollo", que era ambiguo.)*

### Gestión de la Configuración → 4 (reemplaza completa)

#### 4. Política de ramas y proceso de revisión de pull requests

Se adopta el flujo `feature` → `staging` → `main` (ver la tabla de ramas y las reglas de este documento, que son las mismas del Working Agreement 4.1).

**Proceso de revisión de PR:**

1. El desarrollador finaliza la tarea en su rama `feature/` y abre un PR hacia **`staging`**.
2. **Regla de aprobación:** al menos un miembro del equipo ajeno al código lo revisa y aprueba (revisión por pares), y el CI debe estar en verde.
3. Una vez aprobado y sin conflictos, se mergea en `staging` y la rama de origen se elimina.
4. Para publicar una versión, se abre un PR de `staging` hacia `main`, que dispara el despliegue a producción.

### Estado de adopción por repositorio (para incluir como tabla informativa)

| Repositorio | Rama base de los PR | Despliegue |
| ----- | ----- | ----- |
| AuroraCore | `staging` | Push a `staging` → staging; push a `main` → producción |
| AuroraCare (frontend) | `staging` | Distribución de builds de staging (EAS) |
| Aurora Home | `main` hoy → **`staging`** (decidido el 12/10/2026) | Releases registrados manualmente en la Raspberry Pi |
| Aurora Worker IA | `main` hoy → **`staging`** (decidido el 12/10/2026) | Despliegue automático cuando el CI de `main` termina |

> **Decisión del equipo (12/10/2026):** Aurora Home y Aurora Worker IA **adoptan el mismo flujo** `feature → staging → main` que Core y Care, para unificar el criterio. Hoy integran directo en `main`, así que la adopción es un trabajo pendiente en esos dos repositorios:
>
> 1. Crear la rama `staging` a partir de `main` y protegerla (PR obligatorio, revisión de otro integrante, CI en verde).
> 2. Cambiar la rama base de los PR a `staging` (y actualizar `AGENTS.md` de cada repo, que hoy indica `main`).
> 3. Ajustar el CI para que corra también sobre PR hacia `staging`.
> 4. **Despliegue:** hoy ninguno de los dos tiene un entorno de staging propio (el Worker IA se despliega automáticamente al terminar el CI de `main`; Home se actualiza a mano en la Raspberry). Mientras no exista ese entorno, `staging` funciona como rama de **integración** y el despliegue se mantiene al fusionar a `main`. Si más adelante se crea un entorno de staging, se le agrega el despliegue automático desde `staging`, como en Core.

---

## 3. Pendiente de definición del equipo

1. ~~Quiénes son el Product Owner y el Scrum Master~~ (resuelto; fueron fijos desde el inicio). Queda **confirmar las horas semanales** de cada integrante con las asignaciones actuales.
2. ~~Quién aprueba el PR `staging` → `main`~~ (resuelto: el Product Owner, Haik Kilic).
3. ~~Aurora Home y Worker IA~~ (resuelto: adoptan `staging`). Queda **programar el cambio** en esos dos repositorios (ver los 4 pasos de arriba).
4. **Prefijo de ramas:** el documento decía `AUR-` y Jira usa `AURA-`; en la práctica los repos también usan `feature/core/…` y `feature/worker-ia/…`. ¿Cuál queda como estándar?
