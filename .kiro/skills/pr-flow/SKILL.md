---
name: pr-flow
description: Prepara y abre una Pull Request en los repos de Aurora siguiendo el flujo del equipo. Separa el trabajo por ticket, crea la rama con la convención correcta, verifica cada rama en aislamiento con los checks reales del repo, corre el checklist de seguridad, redacta el commit y el cuerpo de la PR, asigna el revisor según el área y actualiza el ticket de Jira. Usar cuando el usuario pida commitear, armar una PR, subir cambios o preparar una entrega en AuroraCareBack, AuroraCareFront, AuroraCore, AuroraHome u ObsidianAurora.
---

# pr-flow — armar una PR en Aurora

`$ARGUMENTS` puede traer el ticket (`AURA-109`), el repo y/o el revisor. Si falta algo, inferilo del working tree y del área que toca el cambio.

## Reglas duras

Estas no se negocian y no se piden por excepción:

- **Nunca commitear ni pushear a `main`.** Todo va por rama y PR.
- **Nunca `--force`, `push --force`, `reset --hard` ni `clean -f`** sin confirmación explícita del usuario en ese mismo mensaje.
- **Nunca `--amend` sobre un commit ya pusheado.**
- **Nunca `--no-verify`**: si hay hooks, corren.
- **Un ticket por rama.** Si el working tree mezcla dos tickets, se parte (ver Paso 2).
- **Ningún secreto en el diff.** Ver el checklist de seguridad.
- No commitear si el usuario no lo pidió. Esta skill se invoca explícitamente.

## Mapa de repos

Working dir: `/home/jeremaldonado/Escritorio/Tesis-Obsidian`

| Directorio | Remoto | Base |
| --- | --- | --- |
| `AuroraCareBack` | `AuroraMemory/AuroraCareBack` | `main` |
| `AuroraCareFront` | `AuroraMemory/AuroraCareFront` | `main` |
| `AuroraCore` | `AuroraMemory/AuroraCore` | `main` |
| `AuroraHome` | `AuroraMemory/AuroraHome` | `main` |
| `ObsidianAurora` | `NicolasRodeyro/ObsidianAurora` | `main` |

Los repos de `AuroraMemory/*` son privados y sólo los ve la cuenta `SantoriniRings`. **Antes de cualquier `gh`:**

```bash
gh auth switch --user SantoriniRings
```

## Revisores por área

`gh pr create --reviewer <login>`. Elegí **uno** según lo que domina el diff, no por turno:

| Login | Persona | Pedirle review de |
| --- | --- | --- |
| `mateoromero12` | Mateo Romero Plaza | Backend, modelos, contratos de API, BD |
| `HaikKilic` | Haik Kilic Aslan | Backend, análisis funcional |
| `NicolasRodeyro` | Nicolás Rodeyro Contarino | Frontend, UX/UI, copy, IA. Admin de los repos |
| `Octavioescudero` | Octavio Escudero | DevOps, deploy, CI, QA |

`SantoriniRings` es la cuenta que abre las PRs: no se puede autoasignar.

Si el diff es mayormente una **propuesta de contrato de backend** aunque los archivos sean de frontend, el revisor es de backend. Decilo en el cuerpo de la PR para que se entienda por qué se le pidió.

## Paso 1: fotografiar el estado

```bash
git -C <repo> fetch origin --prune
git -C <repo> status --short --branch
git -C <repo> log --oneline -5
```

Chequeá tres cosas antes de tocar nada:

1. **¿En qué rama está?** Si está en `main` con cambios sin commitear, hay que crear la rama antes de stagear.
2. **¿El working tree mezcla tickets?** Muy común. Listá qué archivo pertenece a qué ticket y confirmá el reparto con el usuario si no es obvio.
3. **¿Hay cambios ajenos?** Archivos borrados o modificados que no son del trabajo actual (p. ej. `.gitkeep` de otra rama). **No los stagees ni los restaures**: son de otra persona o de otro trabajo en curso. Dejalos como están y avisá.

## Paso 2: rama por ticket

Convención de nombres:

| Prefijo | Cuándo |
| --- | --- |
| `feature/AURA-NNN-slug` | funcionalidad nueva |
| `fix/AURA-NNN-slug` | defecto |
| `docs/AURA-NNN-slug` | documentación o contratos |
| `chore/slug` | tooling, sin ticket |

```bash
git checkout -b feature/AURA-109-privacidad-y-datos main
```

Siempre **desde `main`**, no desde la rama anterior, salvo que una PR dependa de la otra de verdad.

### Partir un working tree mezclado

Stagear sólo los archivos del ticket y verificar la rama **en aislamiento**, guardando el resto:

```bash
git add <archivos del ticket>
git commit -F - <<'MSG'
...
MSG
git stash push -u -m "AURA-NN wip" -- <rutas del otro ticket>
# correr los checks: el tree tiene que quedar limpio
git stash pop
```

Si no se verifica en aislamiento, una rama puede compilar sólo porque los cambios de la otra están presentes en el tree, y romper al mergear sola. Esto ya pasó: verificalo siempre.

Para la segunda rama, salir de la primera hacia una nueva desde `main` y hacer `git stash pop` ahí.

## Paso 3: checks reales por repo

Corré los del repo que tocás. Si alguno falla, **arreglar antes de pushear**.

**AuroraCareFront** (Expo + TS + Jest)

```bash
npx tsc --noEmit
npm run lint          # expo lint
npm run test:ci       # jest --runInBand
```

**AuroraCareBack / AuroraCore** (Django + Ruff + pytest)

```bash
ruff check .
ruff format --check .
pytest                # DJANGO_SETTINGS_MODULE=config.settings.local, testpaths=apps
```

**AuroraHome** (replica el CI de `.github/workflows/ci.yml`)

```bash
python -m ruff check .
python -m mypy src tests
python -m coverage run -m pytest && python -m coverage report
```

**ObsidianAurora**: no hay suite. Verificá a mano que el frontmatter YAML esté bien formado, que los wikilinks `[[...]]` apunten a notas que existen y que el doc esté en la carpeta de INSTANCIA correcta.

Anotá los resultados: van textuales en el cuerpo de la PR.

## Paso 4: checklist de seguridad

Recorrelo sobre el diff staged (`git diff --cached`), no de memoria:

- [ ] **Sin secretos**: tokens, API keys, client secrets, contraseñas, connection strings, certificados. Revisar también los tests y los fixtures.
- [ ] **Sin archivos de entorno**: `.env`, `.env.local`, `credentials.json`, keystores. Sólo `.env.example` con las claves **vacías**.
- [ ] **Configuración por variable de entorno**, nunca hardcodeada. En el front, `EXPO_PUBLIC_*`.
- [ ] **Sin datos personales reales** en fixtures, mocks ni ejemplos: nombres, DNI, teléfonos, direcciones, datos clínicos. Placeholders siempre. Es un proyecto con datos de salud bajo Ley 25.326.
- [ ] **Autorización explícita** en toda acción sensible: rol de cuidador verificado, scope de hogar respetado, y un test que lo cubra. En backend, heredar de `PatientScopedWriteViewSet` en vez de repetir el chequeo.
- [ ] **Nada presentado como confirmado sin respuesta de la API.** Es criterio de cierre del MVP: no mostrar un estado tranquilizador ni un dato guardado que el backend no confirmó.
- [ ] **Dependencias nuevas**: versión pineada, paquete conocido y mantenido, y justificada en el cuerpo de la PR. Ojo con typosquatting.
- [ ] **Sin `console.log` ni `print` de datos sensibles**, y sin logs que expongan PII.
- [ ] **Migraciones** (backend): reversibles y sin pérdida de datos. Si una migración toca tablas en uso, decilo en la PR y pedí review de backend.

## Paso 5: mensaje de commit

Conventional commits, con el ticket en el asunto:

```
<tipo>(<scope>): <qué hace, en imperativo> (AURA-NNN)

<por qué existe el cambio y qué decisiones se tomaron>

<lo que un revisor necesita saber y no se ve en el diff:
supuestos, dependencias de otros tickets, cosas dejadas
afuera a propósito>
```

- **Idioma**: los repos de código usan **inglés** (`feat(care): integrate core-backed care workflows`); `ObsidianAurora` usa **español** (`docs(retro): mega retrospectiva Sprints 0-2`). Seguí el repo.
- Tipos: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`.
- El cuerpo explica **el por qué**, no reescribe el diff.
- Si algo quedó detrás de un flag o sin construir a propósito, decilo y referenciá el ticket que lo desbloquea.

## Paso 6: push y PR

```bash
git push -u origin <rama>
gh pr create -R <owner/repo> --base main --head <rama> \
  --title "<tipo>(<scope>): <título en español> (AURA-NNN)" \
  --reviewer <login> --body '<cuerpo>'
```

Título de PR: **menos de 70 caracteres**, en español, con el ticket. El detalle va en el cuerpo.

### Plantilla del cuerpo

```markdown
<Una o dos oraciones: qué resuelve y para quién.>

Ticket: [AURA-NNN](https://project-aurora-alz.atlassian.net/browse/AURA-NNN) · Épica AURA-NN · RF-NN

## Qué incluye
- <cambios agrupados por intención, no archivo por archivo>

## Decisiones que conviene mirar en la review
<Lo que no es obvio: por qué un flag, por qué no se filtra por X, por qué
se eligió una ruta sobre otra. Esto es lo que hace útil la review.>

## Seguridad
<Permisos verificados, ausencia de secretos, dependencias nuevas. Si el
cambio no toca nada sensible, decilo en una línea.>

## Verificación
<Los comandos del Paso 3 con su resultado real. Números concretos.>

## Fuera de alcance
<Lo que alguien podría esperar y no está, con el ticket que lo cubre.>

## Relacionada
<PRs y tickets vinculados, y si hay orden de merge.>
```

Reglas del cuerpo: nada de resultados de verificación inventados — si un check no se corrió, no se lista. Si el cambio depende de otra PR, decí si hay orden de merge o si son independientes.

## Paso 7: cerrar el círculo en Jira

Después de abrir la PR:

1. Comentar el ticket con el link de la PR y un resumen de lo hecho y verificado (ver la skill `jira-describe` para el formato y las advertencias de markdown → ADF).
2. Transicionar a **In Revision** (id `31`). No a Finalizada: eso lo decide quien revisa o el QA pendiente.
3. Si quedó bloqueado por otro ticket, crear el link con `createIssueLink` (`Blocks`) y avisar antes de mover el estado a PAUSED/BLOCKED (id `2`).

## Paso 8: informar

Cerrá con: rama y PR de cada ticket (con URL), revisor asignado y por qué, resultado de los checks, y lo que quedó pendiente de decisión. Si el working tree quedó con cambios ajenos sin tocar, recordalo.

## Notas

- El directorio raíz `Tesis-Obsidian` **no es un repo**: cada componente tiene el suyo. Lo que vive sólo en la raíz (como `.kiro/skills/`) no se versiona ahí; hay que ubicarlo dentro de un repo.
- Si una PR queda grande y mezcla intenciones, es señal de que había más de un ticket. Partila.
- Ante la duda sobre a quién pedirle review, mirá quién tocó esos archivos por última vez con `git log --format='%an' -5 -- <ruta>`.
