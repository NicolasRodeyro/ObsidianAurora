---
base: "[[Document Hub.base]]"
Created time: 2026-07-19T06:30:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Análisis
Last updated time: 2026-07-19T06:30:00
---
# Investigación — Almacenamiento de Datos y Ley 25.326

Investigación sobre la mejor forma de almacenar los datos de Aurora cumpliendo la **Ley 25.326 de Protección de Datos Personales** al mejor costo, evaluando el stack decidido en [[Arquitectura y Stack Tecnológico]] (ADR-003 Supabase, ADR-007 Hostinger VPS) contra alternativas con datacenter en Argentina. Cubre el módulo 8 de [[Requerimientos]] (RF-76–81, RNF-34–38) y la restricción legal del [[Project Charter]] §7.3.

> **Metodología y estado de verificación.** Investigación web multi-fuente con verificación adversarial (harness de deep research, 19/07/2026) completada con fetches dirigidos a fuentes primarias. Cada afirmación está marcada: ✅ **verificado** contra fuente primaria (con fecha de consulta) · 🔶 **interpretación** del equipo a validar · ⚠️ **sin verificar**. Nada de esto es asesoramiento legal; para un despliegue con pacientes reales debe validarlo un abogado.

---

## 1. Resumen ejecutivo

1. **Los datos de Aurora son "datos sensibles"** (art. 2, Ley 25.326): medicación, diagnóstico y biométricos en contexto de monitoreo clínico son "información referente a la salud". Rigen las reglas más estrictas de la ley. ✅
2. **La ley NO exige que los datos residan en Argentina.** El art. 12 es un régimen de *transferencia internacional* basado en la adecuación del destino: se puede alojar afuera si el país es "adecuado" o si existe un mecanismo habilitante. ✅
3. **EE.UU. y Brasil NO son jurisdicciones adecuadas** según la AAIP; la UE/EEE, Reino Unido, Suiza, Uruguay e Israel sí. Alojar en Supabase São Paulo o en Auth0/Groq (EE.UU.) requiere un mecanismo: el más práctico para Aurora es el **consentimiento expreso del titular** (Decreto 1558/2001, art. 12). ✅
4. **El consentimiento informado ya es un requerimiento del proyecto (RF-81)** y se necesita de todos modos para tratar datos sensibles (art. 5.1: libre, expreso, informado y **por escrito**) — incorporarle la cláusula de transferencia internacional tiene costo marginal. 🔶
5. **Recomendación: Camino B (híbrido cloud) con región definida conscientemente** — mantener Supabase Cloud creando el proyecto en **São Paulo (sa-east-1)** con consentimiento expreso documentado (alternativa conservadora: región UE, jurisdicción adecuada), VPS Hostinger para Core+n8n, backups diarios propios cifrados (soluciona que el plan Free no incluye backups), y hardening de n8n. El escenario todo-en-Argentina cuesta 2–3× el presupuesto del MVP, exige más operación de un equipo de 5 estudiantes, y **no elimina la necesidad de consentimiento** (el LLM en Groq/EE.UU. recibe datos igual). Ver §6.

---

## 2. Marco legal verificado

### 2.1 Los datos de Aurora son datos sensibles ✅

El art. 2 de la Ley 25.326 define datos sensibles como los que revelan "*origen racial y étnico, opiniones políticas, convicciones religiosas, filosóficas o morales, afiliación sindical e información referente a la salud o a la vida sexual*". Medicación, diagnóstico, transcripciones sobre el estado del paciente y biométricos (HR, EDA, temperatura) en un sistema de monitoreo de Alzheimer revelan directamente información de salud.
— Fuente: [texto actualizado Ley 25.326, InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/60000-64999/64790/texact.htm) (verificado 19/07/2026, voto adversarial 3-0).

Matiz: la Resolución AAIP 4/2019 considera sensibles a los datos biométricos *identificatorios* solo cuando revelan información adicional (p. ej. de salud). En Aurora eso se cumple — pero no generalizar a huellas/reconocimiento facial. ⚠️ (apareció en evidencia del verificador; citar la resolución directamente si se usa en la tesis).

Consecuencias directas en la ley (texto consultado 19/07/2026):
- **Art. 5.1**: el consentimiento debe ser libre, expreso, informado y **por escrito** (o medio equiparable) para datos sensibles.
- **Art. 7**: regla general restrictiva para formar archivos de datos sensibles; el art. 8 habilita a establecimientos sanitarios/profesionales bajo secreto profesional. 🔶 Aurora no es establecimiento sanitario → su base de licitud es el consentimiento del art. 5.1 (interpretación; validar con la cátedra).
- **Art. 9**: obliga a medidas técnicas y organizativas de seguridad — es la base legal de RF-79/RF-80 (cifrado) y RNF-38 (recuperación).

### 2.2 Transferencia internacional: régimen del art. 12 ✅

- El art. 12 **prohíbe** transferir datos personales a países que no proporcionen "niveles de protección adecuados", con excepciones tasadas (incisos a–e: colaboración judicial, intercambio médico *exigido por el tratamiento del afectado*, transferencias bancarias, tratados, inteligencia). **No hay obligación de residencia local en ningún artículo de la ley.** — [InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/60000-64999/64790/texact.htm) + [página oficial AAIP](https://www.argentina.gob.ar/transferencias-internacionales) (19/07/2026, voto 3-0).
- **El consentimiento expreso como excepción NO está en el texto legal del art. 12**: surge del **art. 12 del Decreto reglamentario 1558/2001**: "*La prohibición… no rige cuando el titular de los datos hubiera consentido expresamente la cesión*". Citarlo con precisión en la tesis. — [Decreto 1558/2001, InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/70000-74999/70368/texact.htm) (19/07/2026, voto 2-0).
- 🔶 La excepción del inciso b ("intercambio de datos de carácter médico cuando lo exija el tratamiento del afectado") probablemente **no** ampare el hosting rutinario de la BD — interpretación restrictiva esperable; no apoyarse en ella.

### 2.3 Jurisdicciones adecuadas según la AAIP ✅

Verificado contra la [página oficial de la AAIP](https://www.argentina.gob.ar/transferencias-internacionales) el 19/07/2026, sobre la base de la **Disposición DNPDP 60-E/2016** y la **Resolución AAIP 34/2019**:

| Adecuados | NO adecuados (relevantes para Aurora) |
| --- | --- |
| Estados miembros de la UE y del EEE · Reino Unido · Suiza · Guernsey · Jersey · Isla de Man · Islas Feroe · Canadá (solo sector privado) · Andorra · Nueva Zelanda · Uruguay · Israel (solo datos automatizados) | **Estados Unidos** (Supabase región US, Auth0, Groq, AWS us-east-1) · **Brasil** (AWS São Paulo, Supabase sa-east-1) |

**Mecanismos habilitantes para destinos no adecuados** (misma fuente):
1. **Consentimiento expreso** del titular (Decreto 1558/2001).
2. **Cláusulas Contractuales Modelo** — Resolución AAIP 198/2023 (modelos de cesión y de prestación de servicios, + versiones RIPD Responsable/Responsable y Responsable/Encargado). No requieren aprobación previa; los contratos que se aparten de los modelos deben presentarse a la AAIP dentro de los **30 días corridos** desde la firma.
3. **Normas Corporativas Vinculantes** (Resolución 159/2018) — no aplica a Aurora.
4. Excepciones legales del art. 12 inc. 2.

🔶 Implicancia práctica: Supabase/Auth0/Groq no van a firmar las cláusulas modelo de la AAIP con un proyecto de tesis. El mecanismo realista para Aurora es el **consentimiento expreso**, que ya debemos implementar por RF-81. Como refuerzo del deber de seguridad (art. 9) conviene documentar las garantías del encargado: Supabase declara **AES-256 en reposo, TLS en tránsito, SOC 2 Type 2, ISO 27001 y elegibilidad HIPAA con BAA** — [supabase.com/security](https://supabase.com/security) (19/07/2026).

### 2.4 Ley 26.529 (Derechos del Paciente) ✅

Verificado contra el [texto actualizado en InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/160000-164999/160432/texact.htm) (19/07/2026):
- **Art. 1 (ámbito)**: obliga a *profesionales de la salud, instituciones de salud y agentes del seguro de salud*. **Aurora no es un establecimiento sanitario** → la ley no le aplica directamente. 🔶 Pero si Aurora se integra con médicos o se comercializa en contexto asistencial, sus registros pueden constituir documentación clínica.
- **Art. 13**: historia clínica informatizada permitida si se asegura "*integridad, autenticidad, inalterabilidad, perdurabilidad y recuperabilidad*", con accesos por claves y medios no reescribibles.
- **Art. 18**: inviolabilidad y conservación por **mínimo 10 años** desde la última actuación.
- **Art. 14**: copia de la historia clínica al paciente dentro de las **48 horas** de solicitada.
- **Art. 2 inc. c/d**: remite a la Ley 25.326 para intimidad y confidencialidad.

**Impacto en Aurora**: la política de retención de [[Arquitectura y Stack Tecnológico]] §6 (eventos 2 años) es válida para el MVP porque no somos efectores de salud; para la visión productiva con integración médica, los eventos clínicos deberían alinearse al estándar de 10 años y Aurora Care ya debería contemplar **exportación de datos del paciente en 48hs** (se integra bien con el portal ARCO ya previsto). 🔶

### 2.5 Estado de la reforma legislativa (riesgo de contexto)

- A agosto 2025 existían tres proyectos para reemplazar la 25.326: **644-S-2025** (Senado) y **1948-D-2025** (Diputados), de contenido idéntico, más un proyecto del diputado Yeza con enfoque pro-innovación — [Marval, O'Farrell & Mairal, 25/08/2025](https://www.marval.com/publicacion/nuevos-proyectos-de-ley-de-datos-personales-en-argentina-17289?lang=en) (fuente secundaria de estudio jurídico, consultada 19/07/2026).
- ⚠️ IAPP menciona un proyecto Yeza 2026 (1751-D-2026) que derogaría la 25.326 — sin verificar contra fuente parlamentaria.
- **Ninguno sancionado a julio 2026**: la [página de la AAIP sobre el proyecto de ley](https://www.argentina.gob.ar/aaip/datospersonales/proyecto-ley-datos-personales) no reporta sanción (consultada 19/07/2026). La 25.326 sigue vigente.
- **Riesgo**: si se sanciona una nueva ley antes del cierre (05/10/2026), revisar este análisis — los tres proyectos endurecen sanciones y modernizan el régimen de transferencias.

---

## 3. Mapa de transferencias del stack actual

Dónde queda cada dato con el stack de ADR-003/007, y qué necesita:

| Servicio | Datos que recibe | Jurisdicción | Situación legal |
| --- | --- | --- | --- |
| Supabase Cloud | **Toda la BD** (sensibles) | ⚠️ **Región nunca definida en los ADRs** — puede ser EE.UU. (no adecuado), São Paulo (no adecuado) o UE (adecuado) | Definir región **antes de cargar datos**; ver escenarios §4 |
| Auth0 | Identidad de **cuidadores** (email, nombre — personales, no sensibles) | EE.UU. (no adecuado) | Consentimiento del cuidador al registrarse (checkbox en términos) o migrar a alternativa self-hosted/Supabase Auth |
| Groq (LLM, Llama 3) | Transcripciones/prompts con contexto del paciente — **sensibles** | EE.UU. (no adecuado) | **Punto ciego de los ADRs**: minimizar payload (seudonimizar antes de enviar) + cubrir en el consentimiento. Esto hace que "todo en Argentina" no elimine el problema |
| AWS S3+CloudFront | Frontend estático — sin datos de pacientes | s/región | Sin impacto (no hay datos personales en el bucket) |
| Hostinger VPS | Core + n8n + worker (procesan sensibles en tránsito/memoria; logs) | ⚠️ Región contratable (tiene DCs en varias regiones; "South America" mencionada sin detalle — [hostinger.com/vps-hosting](https://www.hostinger.com/vps-hosting), 19/07/2026) | Elegir DC conscientemente; no persistir sensibles en logs del VPS |
| Raspberry Pi (hogar) | Audio (buffer 5 min), Redis local | Argentina (domicilio) | Sin transferencia; cifrar comunicación RPi↔VPS (RF-80) |

---

## 4. Escenarios evaluados

Cotización de referencia: **USD oficial venta $1.500 · tarjeta $1.950** — [dolarapi.com](https://dolarapi.com/v1/dolares/oficial), datos al 17/07/2026. Los servicios del exterior pagados con tarjeta argentina se estiman al valor tarjeta.

### Escenario A — Todo en Argentina (residencia local)

PostgreSQL+pgvector, Django, n8n y Keycloak/Authentik self-hosted vía Docker Compose en VPS con datacenter en Argentina.

Precios verificados (19/07/2026):
- **Baehost** (empresa argentina; ubicación exacta del DC no confirmada en la página ⚠️): plan HV-2-4 (2 vCPU/4 GB/60 GB) **ARS 22.125/mes** ≈ USD 14,8 oficial; VM-2-6 (2/6 GB/200 GB) ARS 51.625/mes. Backups opcionales con costo extra — [baehost.com/cloud-vps](https://www.baehost.com/cloud-vps).
- **DonWeb**: "nodos de Cloud Servers localizados en Argentina, en alguno de nuestros cuatro datacenter" ✅; configurable, desde ARS 4.621/mes (config mínima ~1 vCPU/1 GB — insuficiente); precio de una config de 4 GB **a cotizar en el configurador**. Backups semanales incluidos, diarios con cargo extra, 2 snapshots sin cargo — [donweb.com/es-ar/hosting-cloud-servers-vps](https://donweb.com/es-ar/hosting-cloud-servers-vps).
- **AWS Local Zone Buenos Aires**: existe (`us-east-1-bue-1a`, zona padre us-east-1) — [aws.amazon.com/localzones/locations](https://aws.amazon.com/about-aws/global-infrastructure/localzones/locations/) (19/07/2026). ⚠️ Catálogo de servicios limitado (RDS no confirmado) y sin free tier equivalente; los datos residen físicamente en Argentina pero el plano de control es de us-east-1 🔶. Descartada por costo/complejidad para este proyecto.

**Evaluación**: ~ARS 22.000/mes ≈ **ARS 132.750 en 6 meses — 2,2× el presupuesto de infra del MVP** (ARS 60.000, [[Project Charter]] §6.1). Suma operación de Postgres, backups, Keycloak y actualizaciones al equipo (5 personas, ya al límite). Y **no elimina el consentimiento**: Groq (EE.UU.) sigue recibiendo datos sensibles, y Auth0 identidades. Se paga el sobrecosto sin obtener simplicidad legal completa.

### Escenario B1 — Supabase en región UE (jurisdicción adecuada)

Supabase Cloud permite elegir región al crear el proyecto; ofrece 6 regiones europeas (Irlanda, Londres, París, Frankfurt, Zurich, Estocolmo) — [supabase.com/docs/guides/platform/regions](https://supabase.com/docs/guides/platform/regions) (19/07/2026).

- ✅ Legalmente lo más limpio: la UE es jurisdicción adecuada → la transferencia queda habilitada por el propio art. 12, sin depender del consentimiento *para la transferencia* (el consentimiento por tratamiento de sensibles del art. 5.1 se necesita igual).
- ➖ Latencia Argentina↔Europa sensiblemente mayor que a São Paulo — impacta las consultas RAG del pipeline de voz de Aurora Home (los tiempos de respuesta conversacional son críticos para el paciente). 🔶 Medir antes de descartar.
- Mismo costo que B2 ($0 Free / $25 Pro).

### Escenario B2 — Supabase en São Paulo (sa-east-1) + consentimiento expreso ⭐ recomendado

- Región `sa-east-1` (São Paulo) disponible ✅ (misma fuente). Brasil **no** es jurisdicción adecuada → la transferencia se funda en el **consentimiento expreso** (Decreto 1558/2001, art. 12), que Aurora ya debe implementar por **RF-81** y que además debe cubrir Groq y Auth0. Un solo documento de consentimiento resuelve las tres transferencias. 🔶
- Mejor latencia desde Argentina que cualquier región UE/US.
- Supabase Free: 500 MB DB, 1 GB storage, 50k MAU, 2 proyectos, **sin backups automáticos** y **pausa el proyecto tras 1 semana de inactividad** (riesgo bajo: Aurora escribe biométricos continuamente, pero cubrirlo). Pro: **USD 25/mes**, 8 GB, backups diarios con 7 días de retención — [supabase.com/pricing](https://supabase.com/pricing) (19/07/2026).
- **Mitigación de backups sin pagar Pro** (cumple RNF-38): `pg_dump` diario desde el VPS (cron), **cifrado client-side** (age/GPG) antes de subir a un object storage barato; retención según la política de [[Arquitectura y Stack Tecnológico]] §6; prueba de restore mensual. 🔶 Un backup cifrado en origen mitiga fuertemente el riesgo de la ubicación del storage, aunque legalmente sigue siendo dato personal — documentarlo como medida del art. 9.

---

## 5. Arquitectura de datos recomendada (independiente del hosting)

### 5.1 Cifrado por capas (RF-79/RF-80, RNF-36)

| Capa | Qué cubre | Cómo |
| --- | --- | --- |
| Transporte | Todo (RF-80) | TLS 1.3 (ya previsto); incluir RPi↔VPS (WireGuard/Tailscale o mTLS), no solo "comunicaciones externas" |
| Reposo (plataforma) | Toda la BD | Supabase: AES-256 verificado ✅; en VPS self-hosted: LUKS/cifrado de volumen del proveedor |
| **Columna (aplicación)** | Identificadores directos: nombre, DNI, teléfono, dirección, coordenadas de zonas seguras | **Cifrado en Django** (p. ej. campos Fernet con `cryptography`) antes de escribir. 🔶 Preferido sobre `pgcrypto` porque con pgcrypto la clave viaja en cada SQL y puede quedar en logs de consultas (que Supabase registra); con cifrado en la app la clave nunca llega a la BD |
| Hash de búsqueda | DNI u otros campos cifrados que necesiten lookup | Columna adicional con digest (SHA-256 + salt) |

**Gestión de claves realista en VPS (sin KMS pago)**: clave en Docker secrets / archivo `.env` con permisos 600 fuera del repo, respaldo de la clave en el gestor de contraseñas del equipo, y plan de rotación documentado (versionar `key_id` junto al ciphertext). La clave de cifrado **nunca** en la BD ni en n8n. 🔶

**No cifrar por columna los biométricos**: mata las consultas de agregación/tendencias (RF de detección de eventos). En su lugar: **seudonimización** — las tablas de series temporales solo llevan `paciente_id` (UUID), nunca identificadores directos; el vínculo UUID↔identidad vive en la tabla cifrada. Cubre RNF-36 sin sacrificar analítica. 🔶

### 5.2 Separación clínico / operativo / configuración (RNF-37)

Tres schemas de PostgreSQL (`clinico`, `operativo`, `config`) con roles distintos:
- `clinico`: biométricos, eventos, medicación, memoria del paciente (pgvector). Acceso solo del backend Django con rol propio.
- `operativo`: alertas, notificaciones, estados de dispositivos.
- `config`: rutinas, zonas seguras, cuentas y permisos de cuidadores.
- **Row Level Security** (nativo de Supabase) para RF-77 (un cuidador solo ve sus pacientes) y tabla de auditoría por triggers para RF-78.

### 5.3 Biométricos: particionado nativo, no TimescaleDB

**TimescaleDB está deprecado en Supabase** para Postgres 17 (soportado solo en proyectos legacy PG15, EOL ~mayo 2026); Supabase recomienda migrar a particionado nativo/pg_partman — [supabase.com/docs/…/timescaledb](https://supabase.com/docs/guides/database/extensions/timescaledb) y [discusión oficial](https://github.com/orgs/supabase/discussions/35851) (19/07/2026). Para el volumen de Aurora alcanza sobradamente:

- Particionado por rango mensual + índice BRIN sobre timestamp.
- 🔶 Estimación (a validar con la frecuencia real de la API de la Band): 10 pacientes × 1 muestra/min × 3 métricas ≈ 1,3 M filas/mes. Con la retención de 90 días ya definida, el estado estacionario ronda los ~400 MB — **al límite de los 500 MB del Free**. Mitigación: agregar a promedios por minuto/hora los datos de más de 30 días, o bajar frecuencia de muestreo. Dimensionar en el Sprint que implemente RF-15–19.
- **Retención automatizada** (tabla de [[Arquitectura y Stack Tecnológico]] §6: GPS 7 días, biométricos 90, eventos 2 años): job diario que dropea particiones vencidas — management command de Django agendado por cron en el VPS (evita depender de extensiones).

### 5.4 n8n sin fugas de datos sensibles

n8n **persiste por defecto los payloads completos de cada ejecución** en su BD — con datos del paciente incluidos. Configuración verificada — [docs de n8n, variables de ejecuciones](https://docs.n8n.io/deploy/host-n8n/configure-n8n/basic-configuration/use-environment-variables/executions) (19/07/2026):

```yaml
# docker-compose del VPS
EXECUTIONS_DATA_SAVE_ON_SUCCESS: "none"   # default: all ← fuga principal
EXECUTIONS_DATA_SAVE_ON_ERROR: "all"      # conservar errores para debug
EXECUTIONS_DATA_SAVE_ON_PROGRESS: "false" # default
EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS: "false"  # default: true
EXECUTIONS_DATA_PRUNE: "true"             # default
EXECUTIONS_DATA_MAX_AGE: "72"             # horas (default 336 = 14 días)
```

Además: 🔶
- **Pasar referencias, no payloads**: los workflows reciben `evento_id`/`paciente_id` y el nodo que necesita el dato lo consulta — así ni los logs de error persisten datos clínicos completos.
- Usuario de BD **propio para n8n** con grants mínimos (vistas de `operativo`); nunca la `service_role` key de Supabase.
- Editor de n8n no expuesto a internet (bind a localhost + acceso por VPN/Tailscale o al menos basic auth), y respaldo de la *encryption key* de credenciales de n8n junto a la clave de la app.
- Cuidado con redactar alertas: RNF-35 pide no exponer datos personales en notificaciones — plantillas con mínimo necesario.

---

## 6. Costos comparados

Referencias verificadas 19/07/2026: [Hostinger VPS](https://www.hostinger.com/vps-hosting) (KVM 1: 1 vCPU/4 GB/50 GB — USD 6,49/mes promo, 11,99 renovación; KVM 2: 2/8 GB — 8,79/14,99; backups semanales incluidos) · [Supabase pricing](https://supabase.com/pricing) · [Baehost](https://www.baehost.com/cloud-vps) · dólar tarjeta $1.950 (17/07/2026).

### MVP tesis (6 meses, presupuesto infra: ARS 60.000 ≈ ARS 10.000/mes)

| Escenario | Componentes | USD/mes | ARS/mes (tarjeta u oficial) | 6 meses |
| --- | --- | --- | --- | --- |
| **B2/B1 (recomendado)** | Hostinger KVM 1 promo + Supabase Free (región elegida) + backups propios + dominio | ~6,5–7 | ~13.000 | **~78.000** |
| B2/B1 a precio de renovación | ídem con KVM 1 renovación | ~12 | ~23.400 | ~140.000 |
| A (todo Argentina) | Baehost HV-2-4 todo self-hosted | ~14,8 | 22.125 (oficial, sin recargo tarjeta) | **132.750** |
| B con Supabase Pro | ídem B2 + Pro USD 25 | ~31,5 | ~61.400 | ~369.000 |

⚠️ **Ningún escenario entra en los ARS 60.000 del Charter a precios de julio 2026** — el más barato (B con promo de Hostinger pagada por adelantado) queda ~30% arriba. Conviene actualizar la línea de infra del [[Project Charter]] o pagar el VPS anual con promo.

### Producción 10 usuarios (objetivo OPEX: USD 27/mes, Charter §6.2)

| Escenario | Componentes | USD/mes | ¿Cumple ≤27? |
| --- | --- | --- | --- |
| **B2 (recomendado)** | KVM 2 renovación 14,99 + Supabase Free + backups propios ~1 + Groq 2 + dominio ~1 | **~19** | ✅ |
| B2 con Pro | ídem + Supabase Pro 25 en lugar de Free | ~43 | ❌ (adoptar solo si los 500 MB quedan cortos) |
| A | Baehost VM-2-6 (~34 USD) o HV-2-4 (~14,8) + Groq 2 | ~17–36 | ⚠️ justo con el plan chico; sin margen para separar BD |

---

## 7. Recomendación

**Camino B2 — mantener el stack de ADR-003/007 con tres correcciones obligatorias:**

1. **Definir la región de Supabase YA, antes de cargar ningún dato real**: crear el proyecto en **sa-east-1 (São Paulo)**. La región no se cambia después sin migrar el proyecto. Alternativa conservadora si la cátedra prioriza la limpieza jurídica sobre la latencia: región UE (adecuada). Decidirlo en equipo y registrarlo como **ADR-010**.
2. **Consentimiento informado (RF-81) redactado como pieza legal central**: por escrito (art. 5.1), otorgado por el titular o su representante 🔶 (paciente con Alzheimer: consentimiento por representación — curador/apoyos del CCyC; **validar con abogado o la cátedra**), cubriendo: (a) tratamiento de datos sensibles con finalidad explícita, (b) **transferencia internacional expresa** a los encargados nombrados (Supabase/Brasil o UE, Auth0/EE.UU., Groq/EE.UU.) citando Decreto 1558/2001 art. 12, (c) derechos ARCO y canal para ejercerlos, (d) plazos de retención (tabla §6 de Arquitectura). Mientras el MVP use datos de prueba sintéticos no hay transferencia real de datos de titulares — pero el diseño y el documento deben estar listos antes del primer piloto.
3. **Cerrar las brechas técnicas**: backups diarios cifrados propios (RNF-38, §4), cifrado de columna en la app + seudonimización de series (RF-79/RNF-36, §5.1), separación por schemas + RLS (RNF-37, §5.2), hardening de n8n (§5.4), y minimización del payload a Groq (seudonimizar el contexto antes del LLM).

**Por qué no el Camino A**: 2–3× el costo del MVP, más carga operativa para 5 estudiantes, y la ventaja legal es parcial — Groq y Auth0 siguen exigiendo el mismo consentimiento que habilita Supabase en São Paulo. Tiene sentido reevaluarlo solo para la fase comercial (donde habrá revisión legal profesional de todos modos), o si la reforma legislativa introdujera requisitos de localización.

### Próximos pasos
- [ ] Decidir región (São Paulo vs UE) en equipo → redactar **ADR-010** en [[Arquitectura y Stack Tecnológico]] y actualizar ADR-003/007 con región y mecanismo legal.
- [ ] Redactar el documento de consentimiento informado (RF-81) y validar el esquema de representación con la cátedra/abogado.
- [ ] Ticket de hardening de n8n (variables §5.4) y de backups cifrados (RNF-38) en el board AURA (épica AURA-20).
- [ ] Dimensionar volumen biométrico real cuando se implemente la ingesta de la Band (¿entra en 500 MB con retención 90 días?).
- [ ] Monitorear la reforma de la 25.326 (644-S-2025 / 1948-D-2025 / proyecto Yeza) hasta la entrega.

---

## 8. Fuentes

**Primarias (verificadas 19/07/2026):**
- [Ley 25.326 — texto actualizado, InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/60000-64999/64790/texact.htm)
- [Decreto 1558/2001 — texto actualizado, InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/70000-74999/70368/texact.htm)
- [AAIP — Transferencias internacionales](https://www.argentina.gob.ar/transferencias-internacionales) (lista de adecuación Disp. 60-E/2016 + Res. 34/2019; mecanismos Res. 198/2023 y 159/2018)
- [Ley 26.529 — texto actualizado, InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/160000-164999/160432/texact.htm)
- [AAIP — Proyecto de Ley de Protección de Datos Personales](https://www.argentina.gob.ar/aaip/datospersonales/proyecto-ley-datos-personales)

**Proveedores y documentación técnica (verificadas 19/07/2026):**
- [Supabase — regiones](https://supabase.com/docs/guides/platform/regions) · [precios](https://supabase.com/pricing) · [seguridad](https://supabase.com/security) · [deprecación TimescaleDB](https://github.com/orgs/supabase/discussions/35851)
- [Hostinger — VPS](https://www.hostinger.com/vps-hosting) · [Baehost — Cloud VPS](https://www.baehost.com/cloud-vps) · [DonWeb — Cloud Servers](https://donweb.com/es-ar/hosting-cloud-servers-vps)
- [AWS — Local Zones locations](https://aws.amazon.com/about-aws/global-infrastructure/localzones/locations/)
- [n8n — variables de entorno de ejecuciones](https://docs.n8n.io/deploy/host-n8n/configure-n8n/basic-configuration/use-environment-variables/executions)
- [dolarapi.com](https://dolarapi.com/) (cotización 17/07/2026)

**Secundarias:**
- [Marval — Nuevos proyectos de ley de datos personales (25/08/2025)](https://www.marval.com/publicacion/nuevos-proyectos-de-ley-de-datos-personales-en-argentina-17289?lang=en)
