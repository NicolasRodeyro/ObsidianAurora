---
base: "[[Document Hub.base]]"
Category:
  - Base de Datos
  - Sprint 1
Last updated time: 2026-07-09
---

# Mapa de Almacenamiento — PostgreSQL vs Redis vs SQLite

Define dónde vive cada dato de Aurora según su ciclo de vida, criticidad y necesidad de sincronización.

---

## Leyenda

| Destino | Rol | Persistencia | Ubicación |
|---------|-----|-------------|-----------|
| **PG** = PostgreSQL (Supabase) | Datos relacionales con retención larga, joins, RLS, cifrado | Duradera (años) | Nube (Supabase Cloud) |
| **Redis** = Redis | Cache, estado efímero, colas, pub/sub, rate limiting | Volátil (TTL configurable) | VPS + RPi local |
| **SQLite** = SQLite embebido | Buffer offline, config local, sync pendiente | Persistente localmente (se descarta al reconectar) | Raspberry Pi (Aurora Home) |

---

## Baseline (21 tablas para arrancar)

### Capa 0 — Fundación

| # | Tabla | Destino | Motivo |
|---|-------|---------|--------|
| 1 | `patients` | **PG** | Datos maestros. Retención permanente. RLS. Cifrado obligatorio |
| 2 | `caregivers` | **PG** | Datos maestros. Vinculado a Auth0 |
| 3 | `caregiver_patient` | **PG** | Relación N:M. Habilita RLS multi-tenant |
| 4 | `consent_records` | **PG** | Compliance legal. Retención >= 2 años |
| 5 | `emergency_contacts` | **PG** | Datos del paciente. Se consultan en alertas críticas |
| 6 | `audit_logs` | **PG** | Trazabilidad. Consultas forenses. Retención 2+ años |

### Capa 1 — Rutinas y Medicación

| # | Tabla | Destino | Motivo |
|---|-------|---------|--------|
| 7 | `routines` | **PG** | Configuración del cuidador. Se sincroniza a RPi para offline |
| 8 | `medications` | **PG** | Catálogo de medicamentos del paciente |
| 9 | `medication_schedules` | **PG** | Horarios. Se cachean en Redis + SQLite para recordatorios offline |
| 10 | `reminders` | **PG** | Recordatorios programados. Se cachean en RPi |

### Capa 2 — Monitoreo y Eventos

| # | Tabla | Destino | Motivo |
|---|-------|---------|--------|
| 11 | `patient_devices` | **PG** | Estado del dispositivo. Consulta del cuidador (RF-71) |
| 12 | `biometric_readings` | **PG** | Time-series. Retención 90 días. Particionada por mes |
| 13 | `device_status_logs` | **PG** | Historial de conectividad. Depuración |
| 14 | `detected_events` | **PG** | Eventos de riesgo. Retención 2 años. Consulta histórica |
| 15 | `geofence_zones` | **PG** | Configuración de zonas seguras |

### Capa 3 — Alertas e Interacciones

| # | Tabla | Destino | Motivo |
|---|-------|---------|--------|
| 16 | `alerts` | **PG** | Alertas con estado. Retención 2 años |
| 17 | `notification_logs` | **PG** | Trazabilidad de notificaciones enviadas |
| 18 | `interaction_sessions` | **PG** | Historial de conversaciones. Contexto para IA |
| 19 | `interaction_messages` | **PG** | Mensajes individuales. Fuente para RAG y auditoría |

### Capa 4 — Memoria e IA

| # | Tabla | Destino | Motivo |
|---|-------|---------|--------|
| 20 | `patient_memories` | **PG** | Memoria del paciente. Persistente. Fuente de RAG |
| 21 | `memory_embeddings` | **PG** | Vectores pgvector. Índice HNSW. Búsqueda semántica |

---

## DER Completo (tablas adicionales, no baseline)

### Módulo 1 — Interacción

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `voice_recordings` | **PG** + **S3** | Metadata en PG (path, duración). Archivo de audio en S3/Supabase Storage |
| `reminder_confirmations` | **PG** | Registro de cumplimiento. Se vincula a compliance |
| `cognitive_activities` | **PG** | Catálogo maestro. Seed data inicial |
| `cognitive_activity_results` | **PG** | Historial de desempeño del paciente |
| `game_activities` | **PG** | Catálogo maestro |
| `game_activity_results` | **PG** | Historial de participación |
| `reminiscence_topics` | **PG** | Temas de reminiscencia. Vinculados a `patient_memories` |

### Módulo 2 — Monitoreo (si se separan las readings)

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `heart_rate_readings` | **PG** | Time-series. Separar solo si `biometric_readings` crece > 10M filas/mes |
| `movement_readings` | **PG** | Time-series. Ídem |
| `location_readings` | **PG** | Time-series. Consulta de mapa en Aurora Care |
| `temperature_readings` | **PG** | Time-series |
| `eda_readings` | **PG** | Time-series |

### Módulo 3 — Eventos

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `event_classifications` | **PG** | Clasificaciones por IA/cuidador sobre un evento |
| `detection_criteria` | **PG** | Configuración. Cambia poco |
| `geofence_exit_events` | **PG** | Se puede absorber en `detected_events` con `event_type = 'geofence_exit'` |

### Módulo 4 — Alertas

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `alert_rules` | **PG** | Configuración del cuidador |
| `alert_escalation_steps` | **PG** | Configuración anidada |
| `alert_acknowledgments` | **PG** | Registro de atención del cuidador |

### Módulo 5 — IA

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `cognitive_state_records` | **PG** | Time-series liviana. Estados inferidos por IA |
| `llm_interaction_logs` | **PG** | Auditoría de prompts/respuestas. Retención 6 meses |

### Módulo 6 — Orquestación [vision]

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `action_flows` | **PG** | Configuración de flujos. Seed data + ABMC cuidador |
| `workflow_executions` | **PG** | Trazabilidad de ejecuciones n8n |
| `orchestration_logs` | **PG** | Logs de eventos orquestados |

### Módulo 7 — Cuidador

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `caregiver_dashboard_prefs` | **PG** | Preferencias. Pocas filas, consulta frecuente → cachear en Redis |
| `caregiver_notification_channels` | **PG** | Configuración. Se consulta en cada alerta |

### Módulo 8 — Seguridad

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `encryption_keys_metadata` | **PG** | Solo metadata, no las claves. Rara vez se consulta |
| `data_access_logs` | **PG** | Auditoría de accesos a datos sensibles |

### Módulo 9 — Rutinas

| Tabla | Destino | Motivo |
|-------|---------|--------|
| `routine_schedules` | **PG** | Horarios de rutinas. Se cachean en Redis para el scheduler |
| `routine_compliance` | **PG** | Historial de cumplimiento |
| `medication_compliance` | **PG** | Historial de cumplimiento de medicación |

---

## Datos que NO van a PostgreSQL

### Redis — en memoria (VPS + RPi local)

| Dato | Destino específico | TTL sugerido | Por qué acá y no en PG |
|------|-------------------|--------------|------------------------|
| **Estado actual del paciente** (último HR, última ubicación, última interacción) | Redis VPS | 5 min | Consulta constante del dashboard. No necesita persistencia histórica (eso está en PG) |
| **Sesiones activas de conversación** (contexto de interacción en curso) | Redis RPi | 1 hora | Muere cuando termina la interacción. Si persistiéramos en PG serían cientos de writes innecesarios |
| **Rate limiting** (intentos de login, frecuencia de interacciones) | Redis VPS | 1 min | Latencia crítica. No justifica escritura en disco |
| **Cola de eventos offline** (pendientes de sincronizar desde RPi) | Redis RPi | 24 horas (o hasta ACK) | Buffer transitorio. Se drena cuando reconecta |
| **Cache de respuestas LLM** (prompts frecuentes) | Redis VPS | 1 hora | Evita llamadas repetidas a API de IA. Reduce costo y latencia |
| **Pub/Sub event bus** (Aurora Core ↔ n8n ↔ Worker IA) | Redis VPS | — (no almacena, solo encola) | Comunicación en tiempo real entre servicios |
| **Token cache** (JWT revocados, sesiones activas) | Redis VPS | Variable | Verificación rápida sin consultar Auth0 |
| **Recordatorios del día** (cache para RPi) | Redis RPi | 24 horas | Sincronizados desde PG al inicio del día. Ejecución offline |
| **Últimas N lecturas biométricas** (para gráficos del dashboard en tiempo real) | Redis VPS | 1 hora | Evita consultas pesadas a PG time-series para datos recientes |

### SQLite — local en Raspberry Pi (modo offline)

| Dato | Archivo / Tabla SQLite | Propósito |
|------|------------------------|-----------|
| `reminders_cache` | `aurora_cache.db` → `reminders` | Recordatorios del día para ejecutar sin internet |
| `pending_transcriptions` | `aurora_offline.db` → `pending_messages` | Transcripciones STT generadas offline, pendientes de envío |
| `pending_events` | `aurora_offline.db` → `pending_events` | Eventos críticos (caídas) detectados localmente |
| `current_session_state` | `aurora_session.db` → `session_state` | Contexto de la conversación activa (no perder si se reinicia) |
| `interaction_log_buffer` | `aurora_offline.db` → `interaction_buffer` | Últimos mensajes de la sesión para sincronización batch |
| `device_config_cache` | `aurora_cache.db` → `config` | Configuración local (volumen TTS, sensibilidad micrófono, etc.) |
| `biometric_buffer` | `aurora_offline.db` → `pending_readings` | Lecturas biométricas recibidas vía BT de la Band mientras no hay conexión |

> **Sync offline (ADR-008):** Cuando la RPi recupera conectividad, el contenido de SQLite se drena a PostgreSQL vía API REST y se limpia. Si hay conflictos de UUID, ganó el que tenga timestamp más antiguo (LWW - Last Writer Wins).

---

## Resumen visual

```
                         ┌──────────────────────────────────────┐
                         │         PostgreSQL (Supabase)         │
                         │  51 tablas · RLS · Cifrado · Joins   │
                         │  "La fuente de verdad"               │
                         └──────────┬───────────────────────────┘
                                    │
                      ┌─────────────┼─────────────┐
                      │             │             │
                      ▼             ▼             ▼
              ┌───────────┐ ┌───────────┐ ┌───────────┐
              │  Redis   │ │  Redis   │ │  SQLite  │
              │  (VPS)   │ │  (RPi)   │ │  (RPi)   │
              ├───────────┤ ├───────────┤ ├───────────┤
              │ Estado    │ │ Cola      │ │ Buffer    │
              │ actual    │ │ offline   │ │ offline   │
              │ Cache LLM │ │ Sesiones  │ │ Pendientes│
              │ Pub/Sub   │ │ activas   │ │ de sync   │
              │ Rate lim  │ │ Cache     │ │ Config    │
              │ Token     │ │ reminders │ │ local     │
              └───────────┘ └───────────┘ └───────────┘
                          volátil                └──► Se drena a PG
                          TTL corto                  cuando reconecta
```

---

## Notas importantes

1. **PG es la fuente de verdad.** Redis y SQLite son cachés/buffers. Si se pierden, se regeneran desde PG.
2. **Las time-series biométricas** arrancan en PG con particionado por mes y una sola tabla (`biometric_readings`). Si el volumen escala >10M filas/mes, migrar a TimescaleDB o tabla separada por tipo.
3. **Los archivos de audio** (`voice_recordings`) van a Supabase Storage / S3, no a la BD. En PG solo guardamos la referencia (path + metadata).
4. **Los vectores pgvector** (`memory_embeddings`) van en PG con índice HNSW. Si el volumen de embeddings supera 1M, evaluar Qdrant/Pinecone como alternativa.
5. **n8n** puede leer/escribir directo a PG o vía API de Django. Si es directo, solo sobre tablas de configuración (no time-series).
