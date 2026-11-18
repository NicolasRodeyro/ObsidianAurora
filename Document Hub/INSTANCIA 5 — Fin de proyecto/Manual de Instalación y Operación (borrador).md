---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
tipo: manual-instalacion-y-operacion
ticket: AURA-189
estado: borrador al 2026-11-17, a validar por quien opera el VPS
Last updated time: "2026-11-17T00:00:00"
---

# Manual de Instalación y Operación Aurora (borrador)

> [!warning] Borrador para validar
> Entregable de la Instancia 5 (AURA-189, responsable Octavio). Se armó el 17/11/2026 leyendo los repositorios (`AuroraCore`, `AuroraHome`, `Aurora-Worker-IA` y `AuroraCare`): `docker-compose.yml`, scripts de despliegue, flujos de GitHub Actions, plantillas de variables de entorno y la documentación de cada repo. **No se ejecutó ningún procedimiento**: lo que no se pudo comprobar en el código queda marcado **[A CONFIRMAR]**. Nunca se escriben valores de secretos, solo sus nombres.

## 1. Introducción y audiencia

Explica cómo instalar, configurar y operar Aurora. Está escrito para quien administra el servidor y los equipos Aurora Home (el equipo técnico), no para los cuidadores: para ellos están los Instructivos de Uso. Se asume conocimiento básico de Linux, Docker y Git.

## 2. Qué se instala y dónde

| Componente | Dónde corre | Cómo se despliega |
| --- | --- | --- |
| **Aurora Core** (Django, servidor ASGI Daphne) | VPS de Hostinger, en Docker Compose, detrás de Traefik | GitHub Actions por SSH al subir a `staging` o `main`; o `deploy/deploy.sh` a mano |
| **Aurora Worker IA** (FastAPI) | El mismo VPS, como proyecto de Compose propio en `/docker/Aurora-Worker-IA` | GitHub Actions cuando el CI de `main` termina en verde |
| **Redis 7** | El mismo VPS, servicio `redis` del compose de Core | Con Core |
| **Traefik** (proxy inverso, certificados Let's Encrypt) | El mismo VPS, en `/docker/traefik`, compartido con n8n | Manual, una sola vez |
| **n8n** (orquestación) | El mismo VPS | Manual, una sola vez |
| **Base de datos, autenticación y archivos** | Supabase (PostgreSQL 16, Supabase Auth, Storage) | Servicio gestionado, un proyecto por entorno |
| **Aurora Care** (app móvil) | Celulares de los cuidadores y de los pacientes | Compilación con EAS (Expo) |
| **Aurora Home** | Raspberry Pi 5 en cada hogar | Release etiquetada con `systemd` y actualización por tags |

Hay **dos entornos en el mismo VPS**: `staging` (rama `staging`, `https://staging-api.<dominio>`) y producción (rama `main`, `https://api.<dominio>`), cada uno con su propio proyecto de Supabase. El dominio base se define con la variable `TRAEFIK_HOST`.

## 3. Requisitos previos

- **VPS** con Ubuntu o Debian y Docker con el plugin Compose. El plan actual es de 1 vCPU y 4 GB (ver el Análisis de Impacto Ambiental).
- **Dominio** que resuelva por DNS a la IP del VPS **antes** del primer arranque: Let's Encrypt usa el desafío HTTP-01 y no emite certificados para una IP.
- **Cuentas**: Supabase (un proyecto por entorno, con claves asimétricas), GitHub (organización `AuroraMemory`), Expo/EAS, Expo Push, LiveKit Cloud, Resend (correo de invitaciones, opcional) y el proveedor de modelo de lenguaje.
- **Para Aurora Home**: Raspberry Pi 5 con el HAT de micrófono ReSpeaker y parlante, red WiFi de 2,4 GHz y la etiqueta del equipo (QR, código corto y contraseña de la red temporal).

## 4. Instalación del servidor (Aurora Core)

1. **Instalar Docker** en el VPS: `curl -fsSL https://get.docker.com | sh`.
2. **Clonar el repositorio** `AuroraCore` en el VPS.
3. **Crear el archivo de variables**: copiar `deploy/.env.example` a `deploy/.env` y completarlo. El archivo **no se versiona**.
4. **Preparar Traefik** en `/docker/traefik` (corre con `network_mode: host`, descubre contenedores por el socket de Docker y emite certificados con Let's Encrypt). Core se conecta a la red `deploy_traefik`.
5. **Desplegar un entorno**: `./deploy/deploy.sh staging` (o `main`). El script espeja la rama del origen (`git fetch` y `git reset --hard origin/<rama>`, por lo que descarta cualquier edición local), construye la imagen y levanta solo el servicio de ese entorno, para no dar caída al otro.
6. **Migraciones**: corren solas en cada arranque (`python manage.py migrate --noinput`), antes de iniciar Daphne. Staging y producción arrancan **vacíos**: se pueblan con uso real.

### 4.1 Variables de entorno de Core

Las que el arranque exige (falla sin ellas), con su prefijo `STAGING_` o `MAIN_`:

| Variable | Para qué sirve | Cómo generarla |
| --- | --- | --- |
| `DJANGO_SECRET_KEY_*` | Firma de sesiones | `openssl rand -base64 50` |
| `*_FERNET_KEY` | Cifra los datos identificatorios (nombre, DNI, contactos) | `Fernet.generate_key()` de la biblioteca `cryptography` |
| `*_HASH_SALT` | Sal de los campos buscables | `openssl rand -hex 32` |
| `*_HOME_SIGNING_SECRET` | Deriva las claves API de los dispositivos Aurora Home; distinto de la clave de Django | secreto aleatorio |
| `*_DB_HOST`, `*_DB_PORT`, `*_DB_NAME`, `*_DB_USER`, `*_DB_PASSWORD` | Base de datos | datos del **Session pooler** de Supabase (puerto 6543 por defecto) |
| `*_SUPABASE_URL` | URL del proyecto de Supabase: de ahí salen el emisor y las claves públicas de los tokens | panel de Supabase |
| `*_CORS_ALLOWED_ORIGINS`, `*_DJANGO_ALLOWED_HOSTS` | Orígenes y hosts permitidos | dominios de cada entorno |

Opcionales (sin ellas la función se **degrada en silencio** o falla cerrada, no rompe el arranque):

| Función | Variables | Sin ellas |
| --- | --- | --- |
| Drop-in | `LIVEKIT_URL`, `LIVEKIT_API_KEY`, `LIVEKIT_API_SECRET` | La sesión de media responde 503 |
| Fotos y audios de recuerdos y terapias | `*_ASSET_STORAGE_*` y `SUPABASE_STORAGE_S3_*` | Los adjuntos responden 503 |
| Servicio de IA | `*_WORKER_IA_URL`, `*_WORKER_IA_API_KEY` | Core no genera planes ni consultas de memoria |
| Disparadores de n8n | `*_DAILY_INTERACTIONS_TRIGGER_API_KEY` y claves de purga | Los endpoints internos responden 401 |
| Notificaciones push | `EXPO_PUSH_ACCESS_TOKEN` | **[A CONFIRMAR]** el comportamiento sin token |
| Correo de invitaciones | `*_RESEND_API_KEY`, `*_INVITATION_EMAIL_FROM` | La invitación se crea, pero no se envía el correo |
| Voz de respaldo en la nube | `OPENAI_API_KEY` | Aurora Home usa Piper local |
| Generación automática de terapias | `*_AUTO_THERAPY_GENERATION_ENABLED` | Viene **apagada**: el texto lo redacta un modelo y necesita validación clínica |

El detalle completo, con comentarios, está en `deploy/.env.example` y `.env.template` del repositorio.

### 4.2 Aurora Worker IA

1. Clonar `Aurora-Worker-IA` en `/docker/Aurora-Worker-IA` (rama `main`).
2. Completar su `.env` con `WORKER_IA_API_KEY` y `OPENAI_API_KEY`. El proveedor del modelo se cambia **solo por variables** (`OPENAI_BASE_URL` y `LLM_MODEL`), por ejemplo hacia la capa compatible de Gemini.
3. Levantarlo con `docker compose up -d --build` (usa un archivo `docker-compose.override.yml` del VPS que lo conecta a la red `deploy_traefik`).
4. En el entorno de Core, apuntar `WORKER_IA_URL=http://worker-ia:8000` con el **mismo** `WORKER_IA_API_KEY`. Si faltan, Core falla cerrado y no genera nada.
5. Verificar: `GET /health`.

### 4.3 Supabase

Un proyecto por entorno. Debe usar **claves asimétricas**: comprobar que `<SUPABASE_URL>/auth/v1/.well-known/jwks.json` no devuelva `{"keys":[]}`. Core solo **valida** los tokens y no necesita ningún secreto de Supabase. Conexión a la base siempre por el **Session pooler** (la conexión directa es solo IPv6). La configuración de Auth está en `docs/supabase-auth-setup.md` de Core.

### 4.4 n8n

n8n dispara por horario los endpoints internos de Core, que se protegen con la cabecera `X-Internal-API-Key`: la generación diaria del plan de terapia y del ancla del día, y el barrido de sesiones huérfanas. **Falta agendar en n8n** la purga diaria de ubicaciones (7 días), la purga de reportes de error (30 días) y el barrido de silencio del celular (AURA-221, por hacer). Hasta entonces, los comandos `purge_phone_locations`, `purge_client_errors` y `sweep_silent_phones` se ejecutan a mano con `manage.py`.

## 5. Despliegue continuo

- **Core:** el flujo `deploy.yml` se dispara al subir a `staging` o `main`; entra por SSH al VPS y ejecuta el despliegue. Necesita tres secretos en GitHub: `VPS_HOST`, `VPS_USER` y `VPS_SSH_KEY` (la clave privada cuya pública está en `authorized_keys` del VPS).
- **Worker IA:** su flujo se dispara cuando el CI de `main` termina en verde, hace `git pull --ff-only` y `docker compose up -d --build`, y verifica `/health`. Usa los mismos tres secretos.
- **Integración continua:** en Core corre `pytest` con exigencia de 80 % de cobertura de líneas; en Home, líneas y ramas con 80 %; Aurora Care no tiene umbral.

## 6. Aurora Care (app móvil)

La app se compila con **EAS (Expo)**. El perfil `staging` de `eas.json` genera un APK de distribución interna (canal `staging`). Las variables públicas de la compilación son: `EXPO_PUBLIC_API_URL`, `EXPO_PUBLIC_SUPABASE_URL`, `EXPO_PUBLIC_SUPABASE_PUBLISHABLE_KEY`, `EXPO_PUBLIC_EAS_PROJECT_ID` y las del Bluetooth de provisión de Aurora Home (UUID del servicio y las características). Los cuidadores instalan la app desde la página de builds de EAS, cuyo enlace Core incluye en el correo de invitación (`CARE_APP_INSTALL_URL`). **[A CONFIRMAR]** el comando exacto de compilación y la distribución en tiendas, que no figuran en el repositorio.

## 7. Aurora Home (Raspberry Pi)

### 7.1 Estructura en el equipo

- Código por releases en `/opt/aurora/releases/<sha>`, con el enlace `/opt/aurora/current` apuntando a la versión activa.
- Servicio `aurora-home.service` (usuario sin privilegios `aurora-home`, con reinicio automático y vigilancia de 30 s). No espera `network-online`, para poder arrancar sin internet.
- Variables en `/etc/aurora-home/aurora-home.env`; datos (SQLite) en `/var/lib/aurora-home`.

### 7.2 Alta de un equipo

1. **Registrar la identidad** del equipo en Core, desde el servidor: `python manage.py register_aurora_home --device-identifier <id>` (admite `--batch-file` para lotes). El secreto de fábrica se pasa con `--secret-sha256` o `--secret`, y no queda en el historial.
2. **Etiquetar** el equipo con su QR, código corto y contraseña de la red temporal.
3. **Vincularlo desde Aurora Care** por Bluetooth: el cuidador escanea el QR, elige la red WiFi de 2,4 GHz y la app entrega al equipo un token de un solo uso (vence a los 10 minutos). Los pasos para el cuidador están en los Instructivos de Uso.
4. Para sacar un equipo de servicio: `revoke_aurora_home_identity`; `list_aurora_home_identities` lista los registrados.

### 7.3 Actualización

- **Automática (reversible), apagada por defecto.** Un `timer` de `systemd` revisa cada 15 minutos si hay un tag de git nuevo (`v*`). Se activa con `AURORA_HOME_AUTO_UPDATE_ENABLED=true` y requiere una deploy key de solo lectura. No actualiza si hay un SOS pendiente o una ocurrencia en ejecución. Si el health check falla, vuelve a la versión anterior y deja el tag fallido en cuarentena.
- **Manual.** Armar `/opt/aurora/releases/<sha>` con `git archive`, copiar el entorno virtual, instalar con `pip install -e --no-deps`, cambiar el enlace `current` y reiniciar el servicio. **Rollback:** repetir el cambio apuntando a la versión anterior. El procedimiento completo está en `docs/04-runtime-offline-seguridad-y-operacion.md` de AuroraHome.

## 8. Operación diaria

| Tarea | Cómo |
| --- | --- |
| Ver si Core responde | `curl https://<host>/health/` debe devolver `{"status":"ok"}` |
| Ver estado y logs de Core | `docker compose -f deploy/docker-compose.yml ps` y `logs -f staging` (o `main`) |
| Ver los logs de Aurora Home | `journalctl -u aurora-home.service` y buscar `runtime_started` con `degraded_components` vacío |
| Procesar recibos de push | comando `process_push_receipts` o el servicio `push-receipts` del compose local |
| Retención de datos | transcripciones 6 meses, ubicaciones de alertas 7 días, reportes de error 30 días (ver Arquitectura, sección 6.3) |

## 9. Seguridad

- Los secretos viven en `deploy/.env` del VPS, en texto plano y sin gestor de secretos (**AURA-147, sin hacer**). Solo el equipo con acceso SSH al servidor puede leerlos; no hay rotación definida.
- Los datos identificatorios se cifran en la aplicación con Fernet; rotar la clave se hace con `"nueva,vieja"` en la variable.
- La comunicación es por HTTPS con certificados automáticos. Los dispositivos usan una clave API propia por equipo.
- Hay escaneo de secretos con gitleaks en la integración continua.

## 10. Lo que NO está resuelto (limitaciones vigentes)

1. **No hay respaldos de la base de datos ni monitoreo del servidor** (AURA-148, sin hacer). Con el plan gratuito de Supabase tampoco hay respaldos automáticos. Recomendación de la investigación de infraestructura (Anexo D): un `pg_dump` diario por cron, **cifrado** antes de subirlo a un almacenamiento externo.
2. **Gestión de secretos sin hacer** (AURA-147), como se indicó en la sección 9.
3. **Staging y producción comparten el servidor**: una falla del VPS afecta a los dos.
4. **La purga automática de ubicaciones y de reportes de error no corre sola** hasta agendarla en n8n (AURA-221). La promesa de borrado a los 7 días de los textos de consentimiento depende de eso.
5. **Procedimiento de rollback de Core:** no se encontró documentado. Como el despliegue espeja la rama, volver atrás implica revertir el commit en la rama y volver a desplegar. **[A CONFIRMAR]**
6. **El `README` de `deploy/` en el repositorio está desactualizado:** habla de Nginx, de puertos 8080 y 8081 y del nombre AuroraCareBack, y hoy se usa Traefik con dominio y HTTPS. Hay que corregirlo.
7. **Actualización automática de Aurora Home apagada por defecto** y sin plan de flota (ver `docs/13-ota-flota.md` de AuroraHome).

## 11. Cómo se mantiene este documento

Cada vez que cambie una variable de entorno, un servicio o un procedimiento de despliegue, se actualizan las secciones 4 a 8 y se revisa la sección 10. La fuente de cada dato son los archivos citados de cada repositorio.
