---
base: "[[Document Hub.base]]"
Category:
  - Base de Datos
  - Sprint 1
Last updated time: 2026-07-09
---

# Schemas de Base de Datos — Aurora

Organización de tablas en schemas PostgreSQL dentro de `public`.
Separación por dominio funcional. Cada schema agrupa tablas de un mismo módulo.

---

## core — Entidades transversales

```sql
CREATE SCHEMA IF NOT EXISTS core;
```

| Tabla | Propósito |
|-------|-----------|
| `core.patients` | Perfiles de paciente |
| `core.caregivers` | Perfiles de cuidador |
| `core.caregiver_patient` | Asignación N:M cuidador ↔ paciente |
| `core.emergency_contacts` | Contactos de emergencia |
| `core.consent_records` | Consentimiento para tratamiento de datos |
| `core.audit_logs` | Trazabilidad de modificaciones |
| `core.data_retention_policies` | Políticas de retención por tipo de dato |

> Dependencias: ninguna. Es la base del sistema.

---

## routines — Rutinas y Medicación

```sql
CREATE SCHEMA IF NOT EXISTS routines;
```

| Tabla | Propósito |
|-------|-----------|
| `routines.routines` | Rutinas diarias del paciente |
| `routines.routine_schedules` | Programación de cada rutina |
| `routines.routine_compliance` | Historial de cumplimiento de rutinas |
| `routines.medications` | Medicamentos y tratamientos |
| `routines.medication_schedules` | Horarios de medicación |
| `routines.medication_compliance` | Confirmación u omisión de toma |

> Dependencias: `core.patients`

---

## voice — Interacción con el Paciente

```sql
CREATE SCHEMA IF NOT EXISTS voice;
```

| Tabla | Propósito |
|-------|-----------|
| `voice.interaction_sessions` | Sesiones de conversación |
| `voice.interaction_messages` | Mensajes paciente ↔ sistema |
| `voice.voice_recordings` | Archivos de audio capturados |
| `voice.reminders` | Recordatorios programados |
| `voice.reminder_confirmations` | Confirmaciones de cumplimiento |
| `voice.cognitive_activities` | Catálogo de actividades cognitivas |
| `voice.cognitive_activity_results` | Resultados de actividades |
| `voice.game_activities` | Catálogo de juegos recreativos |
| `voice.game_activity_results` | Resultados de juegos |
| `voice.reminiscence_topics` | Temas de reminiscencia digital |

> Dependencias: `core.patients`, `ai.patient_memories` (opcional)

---

## biometrics — Monitoreo Biométrico

```sql
CREATE SCHEMA IF NOT EXISTS biometrics;
```

| Tabla | Propósito |
|-------|-----------|
| `biometrics.patient_devices` | Dispositivos vinculados al paciente |
| `biometrics.device_status_logs` | Log de estado y conectividad |
| `biometrics.biometric_readings` | Lecturas biométricas (time-series consolidada) |

> Opcional: si el volumen crece, `biometric_readings` se puede separar en `heart_rate_readings`, `movement_readings`, `location_readings`, `temperature_readings`, `eda_readings` dentro del mismo schema.
>
> Dependencias: `core.patients`

---

## events — Detección de Eventos

```sql
CREATE SCHEMA IF NOT EXISTS events;
```

| Tabla | Propósito |
|-------|-----------|
| `events.detected_events` | Eventos de riesgo detectados |
| `events.event_classifications` | Clasificaciones asignadas a eventos |
| `events.detection_criteria` | Criterios y umbrales configurables |
| `events.geofence_zones` | Zonas seguras del paciente |
| `events.geofence_exit_events` | Eventos de salida de zona segura |

> Dependencias: `core.patients`, `biometrics.biometric_readings` (source_id polimórfico)

---

## alerts — Alertas y Comunicación

```sql
CREATE SCHEMA IF NOT EXISTS alerts;
```

| Tabla | Propósito |
|-------|-----------|
| `alerts.alerts` | Alertas generadas |
| `alerts.alert_rules` | Reglas de notificación configurables |
| `alerts.alert_escalation_steps` | Pasos de escalado progresivo |
| `alerts.notification_logs` | Registro de notificaciones enviadas |
| `alerts.alert_acknowledgments` | Confirmaciones de atención |

> Dependencias: `core.patients`, `core.caregivers`, `events.detected_events`

---

## ai — Motor de IA y Memoria del Paciente

```sql
CREATE SCHEMA IF NOT EXISTS ai;
```

| Tabla | Propósito |
|-------|-----------|
| `ai.patient_memories` | Hechos, recuerdos, preferencias del paciente |
| `ai.memory_embeddings` | Vectores de embedding para RAG (pgvector) |
| `ai.cognitive_state_records` | Estado cognitivo y emocional estimado |
| `ai.llm_interaction_logs` | Log de consultas al LLM |

> Dependencias: `core.patients`, `voice.interaction_sessions`

---

## caregiver — Panel del Cuidador

```sql
CREATE SCHEMA IF NOT EXISTS caregiver;
```

| Tabla | Propósito |
|-------|-----------|
| `caregiver.caregiver_dashboard_prefs` | Preferencias de visualización |
| `caregiver.caregiver_notification_channels` | Canales de notificación preferidos |

> Dependencias: `core.caregivers`

---

## orchestration — Orquestación [vision]

```sql
CREATE SCHEMA IF NOT EXISTS orchestration;
```

| Tabla | Propósito |
|-------|-----------|
| `orchestration.action_flows` | Flujos de acción configurables |
| `orchestration.workflow_executions` | Ejecuciones de flujos n8n |
| `orchestration.orchestration_logs` | Log de eventos orquestados |

> Dependencias: `core.patients`

---

## compliance — Seguridad y Privacidad

```sql
CREATE SCHEMA IF NOT EXISTS compliance;
```

| Tabla | Propósito |
|-------|-----------|
| `compliance.encryption_keys_metadata` | Metadata de claves de cifrado |
| `compliance.data_access_logs` | Registro de accesos a datos sensibles |

> Dependencias: `core.patients`, `core.caregivers`

---

## Mapa de dependencias entre schemas

```
core ─────────────────────────────────────────────────────────┐
  │                                                            │
  ├──► routines                                                │
  ├──► voice ──────────► ai                                    │
  ├──► biometrics                                              │
  ├──► events ─────────► alerts ───► caregiver                 │
  ├──► orchestration                                           │
  └──► compliance                                              │
                                                               │
  caregiver ───► solo depende de core                           │
  ai ──────────► depende de core + voice                        │
  alerts ──────► depende de core + events                       │
```

Ningún schema tiene dependencias circulares. El orden de creación lógico es:

1. `core`
2. `routines`, `biometrics`, `caregiver`, `compliance` (solo dependen de core)
3. `voice`, `events`, `orchestration` (solo dependen de core)
4. `ai` (depende de core + voice)
5. `alerts` (depende de core + events)

---

## Resumen

| Schema | Tablas | Dependencias externas |
|--------|--------|----------------------|
| `core` | 7 | — |
| `routines` | 6 | core |
| `voice` | 10 | core, ai (opcional) |
| `biometrics` | 3 | core |
| `events` | 5 | core, biometrics |
| `alerts` | 5 | core, events |
| `ai` | 4 | core, voice |
| `caregiver` | 2 | core |
| `orchestration` | 3 | core |
| `compliance` | 2 | core |
| **Total** | **47** | — |

> Nota: `data_retention_policies` y `encryption_keys_metadata` tienen pocas filas (decenas, no millones). Van dentro del schema correspondiente sin necesidad de schema propio.
