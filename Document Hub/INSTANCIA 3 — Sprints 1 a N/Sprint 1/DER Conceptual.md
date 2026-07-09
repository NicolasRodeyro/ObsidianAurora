---
base: "[[Document Hub.base]]"
Category:
  - Base de Datos
  - Sprint 1
Last updated time: 2026-07-09
---

# DER Conceptual — Aurora

Diagrama entidad-relación de alto nivel. Dividido por módulo funcional para legibilidad.
Notación: Mermaid `erDiagram`. Entidades sombreadas con `[vision]` corresponden al Módulo 6 (scope pöst-MVP).

---

## Vista General — Relaciones entre módulos

```mermaid
erDiagram
    caregivers ||--o{ caregiver_patient : "asigna"
    patients ||--o{ caregiver_patient : "pertenece"
    patients ||--o{ interaction_sessions : "conversa"
    patients ||--o{ patient_devices : "usa"
    patients ||--o{ detected_events : "genera"
    patients ||--o{ alerts : "dispara"
    patients ||--o{ patient_memories : "tiene"
    patients ||--o{ routines : "sigue"
    patients ||--o{ medications : "toma"
    patients ||--o{ emergency_contacts : "tiene"
    patients ||--o{ consent_records : "otorgo"
    patients ||--o{ detection_criteria : "configura"
    patients ||--o{ geofence_zones : "delimita"
    patients ||--o{ action_flows : "dispara"
    detected_events ||--o{ alerts : "origina"
```

---

## Módulo 0 — Transversal / Base del Sistema

```mermaid
erDiagram
    caregivers {
        uuid id PK
        uuid auth_user_id FK "Supabase Auth"
        string name
        string email
        string phone
        jsonb notification_prefs
        timestamp created_at
        timestamp updated_at
    }

    patients {
        uuid id PK
        string name "cifrado"
        string dni "cifrado"
        date birth_date
        int fast_level "1-5"
        jsonb medical_info
        string status "active / inactive"
        uuid consent_id FK
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at "soft-delete"
    }

    caregiver_patient {
        uuid id PK
        uuid caregiver_id FK
        uuid patient_id FK
        string role "primary / support"
        jsonb permissions
        timestamp assigned_at
    }

    emergency_contacts {
        uuid id PK
        uuid patient_id FK
        string name
        string relationship
        string phone "cifrado"
        string email
        int priority
        timestamp created_at
    }

    consent_records {
        uuid id PK
        uuid patient_id FK
        string consent_type
        string status "granted / revoked / expired"
        text scope
        timestamp granted_at
        timestamp revoked_at
        timestamp expires_at
    }

    audit_logs {
        bigint id PK
        string table_name
        uuid record_id
        string action "create / update / delete"
        jsonb changed_fields
        uuid changed_by FK "caregiver o sistema"
        timestamp changed_at
    }

    data_retention_policies {
        uuid id PK
        string data_category
        int retention_days
        string action "archive / delete / anonymize"
        boolean active
    }

    caregivers ||--o{ caregiver_patient : ""
    patients ||--o{ caregiver_patient : ""
    patients ||--o{ emergency_contacts : ""
    patients ||--o{ consent_records : ""
```

---

## Módulo 1 — Interacción con el Paciente (AURA-14)

```mermaid
erDiagram
    interaction_sessions {
        uuid id PK
        uuid patient_id FK
        string initiator "system / patient"
        string session_type "conversation / reminder / cognitive / game / reminiscence"
        string status "active / closed / interrupted"
        string estimated_mood
        timestamp started_at
        timestamp ended_at
    }

    interaction_messages {
        uuid id PK
        uuid session_id FK
        string role "patient / system"
        text content
        string content_type "text / stt_transcript / tts_audio_ref"
        jsonb metadata "tono estimado, duracion, etc"
        timestamp created_at
    }

    voice_recordings {
        uuid id PK
        uuid message_id FK
        string file_path
        int duration_ms
        int file_size_bytes
        date retention_expires_at
        timestamp created_at
    }

    reminders {
        uuid id PK
        uuid patient_id FK
        string type "medication / meal / hygiene / rest"
        text message_template
        jsonb schedule "dias, hora, recurrencia"
        boolean active
        timestamp created_at
        timestamp updated_at
    }

    reminder_confirmations {
        uuid id PK
        uuid reminder_id FK
        uuid session_id FK
        string response "confirmed / denied / no_response"
        timestamp responded_at
    }

    cognitive_activities {
        uuid id PK
        string name
        string category "memory / attention / language / orientation / reasoning"
        text description
        jsonb difficulty_levels
        jsonb configuration
        boolean active
    }

    cognitive_activity_results {
        uuid id PK
        uuid patient_id FK
        uuid activity_id FK
        uuid session_id FK
        int score
        int completion_percent
        jsonb metrics "tiempo por respuesta, errores, etc"
        timestamp performed_at
    }

    game_activities {
        uuid id PK
        string name
        string category
        text description
        jsonb configuration
        boolean active
    }

    game_activity_results {
        uuid id PK
        uuid patient_id FK
        uuid game_id FK
        uuid session_id FK
        int score
        int duration_seconds
        jsonb metrics
        timestamp played_at
    }

    reminiscence_topics {
        uuid id PK
        uuid patient_id FK
        uuid memory_id FK "opcional, si se vincula a patient_memories"
        string topic_type "family / life_event / preference / achievement"
        text content
        jsonb media_refs
        timestamp created_at
    }

    patients ||--o{ interaction_sessions : ""
    interaction_sessions ||--o{ interaction_messages : ""
    interaction_messages ||--o{ voice_recordings : ""
    patients ||--o{ reminders : ""
    reminders ||--o{ reminder_confirmations : ""
    interaction_sessions ||--o{ reminder_confirmations : ""
    patients ||--o{ cognitive_activity_results : ""
    cognitive_activities ||--o{ cognitive_activity_results : ""
    interaction_sessions ||--o{ cognitive_activity_results : ""
    patients ||--o{ game_activity_results : ""
    game_activities ||--o{ game_activity_results : ""
    interaction_sessions ||--o{ game_activity_results : ""
    patients ||--o{ reminiscence_topics : ""
```

---

## Módulo 2 — Monitoreo Biométrico — Aurora Band (AURA-19)

```mermaid
erDiagram
    patient_devices {
        uuid id PK
        uuid patient_id FK
        string device_type "aurora_band / smartphone"
        string manufacturer
        string model
        string firmware_version
        string mac_address "cifrado"
        string status "online / offline / unknown"
        int battery_level
        timestamp last_seen_at
        timestamp created_at
        timestamp updated_at
    }

    device_status_logs {
        bigint id PK
        uuid device_id FK
        string status "online / offline / low_battery / error"
        int battery_level
        string error_code
        timestamp recorded_at
    }

    heart_rate_readings {
        bigint id PK
        uuid device_id FK
        int bpm
        timestamp recorded_at
    }

    movement_readings {
        bigint id PK
        uuid device_id FK
        float accel_x
        float accel_y
        float accel_z
        float gyro_x
        float gyro_y
        float gyro_z
        timestamp recorded_at
    }

    location_readings {
        bigint id PK
        uuid device_id FK
        decimal latitude
        decimal longitude
        decimal altitude
        float accuracy_meters
        timestamp recorded_at
    }

    temperature_readings {
        bigint id PK
        uuid device_id FK
        decimal celsius
        timestamp recorded_at
    }

    eda_readings {
        bigint id PK
        uuid device_id FK
        decimal conductance_microsiemens
        timestamp recorded_at
    }

    patients ||--o{ patient_devices : ""
    patient_devices ||--o{ device_status_logs : ""
    patient_devices ||--o{ heart_rate_readings : ""
    patient_devices ||--o{ movement_readings : ""
    patient_devices ||--o{ location_readings : ""
    patient_devices ||--o{ temperature_readings : ""
    patient_devices ||--o{ eda_readings : ""
```

> Las tablas time-series (`*_readings`, `device_status_logs`) se particionarán por mes.

---

## Módulo 3 — Detección de Eventos y Riesgos (AURA-22)

```mermaid
erDiagram
    detected_events {
        uuid id PK
        uuid patient_id FK
        string event_type "fall / wandering / agitation / geofence_exit / inactivity / biometric_anomaly"
        string severity "informative / preventive / critical"
        string source "sensor / ia / caregiver / system"
        uuid source_id FK "polimórfico: id de lectura, id de clasificacion IA, etc"
        jsonb metadata "datos contextuales del evento"
        string status "new / acknowledged / resolved / false_positive"
        timestamp detected_at
        timestamp updated_at
        timestamp deleted_at "soft-delete"
    }

    event_classifications {
        uuid id PK
        uuid event_id FK
        string classified_by "system / ia / caregiver"
        string severity "informative / preventive / critical"
        text reasoning
        float confidence "0-1"
        timestamp classified_at
    }

    detection_criteria {
        uuid id PK
        uuid patient_id FK
        string criteria_type "heart_rate / movement / location / inactivity / agitation"
        jsonb thresholds "limites configurables"
        jsonb schedule "ventana horaria de aplicacion"
        boolean active
        timestamp created_at
        timestamp updated_at
    }

    geofence_zones {
        uuid id PK
        uuid patient_id FK
        string name "ej: Casa, Plaza, Casa de hijo"
        string zone_type "home / safe / restricted"
        jsonb boundaries "centro + radio, o poligono GeoJSON"
        boolean active
        timestamp created_at
        timestamp updated_at
    }

    geofence_exit_events {
        uuid id PK
        uuid zone_id FK
        uuid event_id FK "vinculo a detected_events"
        decimal exit_latitude
        decimal exit_longitude
        timestamp exited_at
        timestamp returned_at "si regreso"
    }

    patients ||--o{ detected_events : ""
    detected_events ||--o{ event_classifications : ""
    patients ||--o{ detection_criteria : ""
    patients ||--o{ geofence_zones : ""
    geofence_zones ||--o{ geofence_exit_events : ""
    detected_events ||--o{ geofence_exit_events : ""
```

---

## Módulo 4 — Alertas y Comunicación con el Cuidador (AURA-16)

```mermaid
erDiagram
    alerts {
        uuid id PK
        uuid patient_id FK
        uuid source_event_id FK "opcional: evento que origino la alerta"
        string level "low / medium / high / critical"
        string status "generated / sent / attended / closed / escalated"
        text message
        jsonb context "datos contextuales para el cuidador"
        timestamp generated_at
        timestamp resolved_at
    }

    alert_rules {
        uuid id PK
        uuid patient_id FK
        string event_type
        string min_severity
        jsonb channels "[""push"", ""whatsapp"", ""telegram"", ""call""]"
        jsonb escalation_config
        boolean active
        timestamp created_at
        timestamp updated_at
    }

    alert_escalation_steps {
        uuid id PK
        uuid rule_id FK
        int step_order
        int wait_minutes
        string action "notify / call / escalate"
        string target "caregiver / emergency_contact / emergency_service"
        jsonb params "configuracion adicional"
    }

    notification_logs {
        uuid id PK
        uuid alert_id FK
        string channel "push / whatsapp / telegram / email / call"
        string destination
        string status "sent / delivered / failed / read"
        string external_id "id del mensaje en el servicio externo"
        text error_message
        timestamp sent_at
        timestamp delivered_at
    }

    alert_acknowledgments {
        uuid id PK
        uuid alert_id FK
        uuid caregiver_id FK
        string response "acknowledged / investigating / resolved / false_alarm"
        text note
        timestamp acknowledged_at
    }

    patients ||--o{ alerts : ""
    detected_events ||--o{ alerts : ""
    patients ||--o{ alert_rules : ""
    alert_rules ||--o{ alert_escalation_steps : ""
    alerts ||--o{ notification_logs : ""
    alerts ||--o{ alert_acknowledgments : ""
    caregivers ||--o{ alert_acknowledgments : ""
```

---

## Módulo 5 — Motor de IA y Memoria del Paciente (AURA-15)

```mermaid
erDiagram
    patient_memories {
        uuid id PK
        uuid patient_id FK
        string category "biography / family / preference / achievement / routine / event"
        text content
        jsonb metadata "tags, sentimiento asociado, fecha del recuerdo"
        timestamp created_at
        timestamp updated_at
    }

    memory_embeddings {
        uuid id PK
        uuid memory_id FK "1:1 con patient_memories"
        vector embedding "dimension segun modelo: 384 / 768 / 1536"
        string model_used "ej: text-embedding-3-small"
        timestamp generated_at
    }

    cognitive_state_records {
        uuid id PK
        uuid patient_id FK
        uuid session_id FK "opcional: interaccion asociada"
        string state_type "confusion / anxiety / disorientation / calm / agitated"
        float confidence "0-1"
        jsonb multimodal_signals "voz, biometria, comportamiento"
        timestamp estimated_at
    }

    llm_interaction_logs {
        uuid id PK
        uuid patient_id FK
        uuid session_id FK
        text prompt_truncated "primeros N caracteres"
        text response_truncated
        int prompt_tokens
        int response_tokens
        int latency_ms
        string model_used
        timestamp created_at
    }

    patients ||--o{ patient_memories : ""
    patient_memories ||--|| memory_embeddings : "1:1"
    patients ||--o{ cognitive_state_records : ""
    interaction_sessions ||--o{ cognitive_state_records : ""
    patients ||--o{ llm_interaction_logs : ""
    interaction_sessions ||--o{ llm_interaction_logs : ""
```

> `memory_embeddings.embedding` usa el tipo `vector(N)` de pgvector. Se creará un índice HNSW.

---

## Módulo 6 — Orquestación y Automatización (AURA-21) [vision]

```mermaid
erDiagram
    action_flows {
        uuid id PK
        uuid patient_id FK
        string trigger_type "event / schedule / manual"
        jsonb trigger_config "evento que lo activa o cron"
        jsonb actions "lista de pasos del flujo"
        boolean active
        timestamp created_at
        timestamp updated_at
    }

    workflow_executions {
        uuid id PK
        uuid flow_id FK
        uuid trigger_event_id FK "opcional"
        string status "running / completed / failed / partial"
        jsonb results
        timestamp started_at
        timestamp completed_at
    }

    orchestration_logs {
        bigint id PK
        uuid execution_id FK
        string source_module
        string action
        jsonb payload
        string status "success / error"
        text error_message
        timestamp logged_at
    }

    patients ||--o{ action_flows : ""
    action_flows ||--o{ workflow_executions : ""
    workflow_executions ||--o{ orchestration_logs : ""
```

---

## Módulo 7 — Panel del Cuidador / Aurora Care (AURA-18)

```mermaid
erDiagram
    caregiver_dashboard_prefs {
        uuid id PK
        uuid caregiver_id FK
        jsonb layout_config "orden de widgets, visibilidad"
        jsonb refresh_intervals
        timestamp updated_at
    }

    caregiver_notification_channels {
        uuid id PK
        uuid caregiver_id FK
        string channel "push / whatsapp / telegram / email / sms"
        string destination "token, numero, email"
        boolean enabled
        jsonb quiet_hours
        timestamp created_at
        timestamp updated_at
    }

    caregivers ||--o{ caregiver_dashboard_prefs : ""
    caregivers ||--o{ caregiver_notification_channels : ""
```

---

## Módulo 8 — Seguridad, Privacidad y Cumplimiento (AURA-20)

```mermaid
erDiagram
    encryption_keys_metadata {
        uuid id PK
        string key_identifier
        string algorithm "AES-256 / RSA-4096"
        date rotated_at
        date expires_at
        boolean active
        text notes
    }

    data_access_logs {
        bigint id PK
        uuid patient_id FK
        uuid accessed_by FK "caregiver_id o system"
        string accessed_table
        uuid accessed_record_id
        string action "read / export"
        string reason
        timestamp accessed_at
    }

    patients ||--o{ data_access_logs : ""
    caregivers ||--o{ data_access_logs : ""
```

> Las claves en sí no se almacenan en la BD. `encryption_keys_metadata` solo guarda metadata de rotación.

---

## Módulo 9 — Administración de Rutinas y Medicación (AURA-17)

```mermaid
erDiagram
    routines {
        uuid id PK
        uuid patient_id FK
        string name
        string category "hygiene / meal / rest / exercise / therapy"
        text description
        boolean active
        timestamp created_at
        timestamp updated_at
        timestamp deleted_at "soft-delete"
    }

    routine_schedules {
        uuid id PK
        uuid routine_id FK
        jsonb days_of_week "[1, 3, 5] o [""monday"", ""wednesday""]"
        time time_of_day
        jsonb recurrence "daily / weekly / custom"
        boolean enabled
    }

    routine_compliance {
        uuid id PK
        uuid routine_id FK
        uuid schedule_id FK
        date scheduled_date
        string status "completed / skipped / missed"
        timestamp completed_at "cuando se confirmo"
    }

    medications {
        uuid id PK
        uuid patient_id FK
        string name
        string active_ingredient
        string dosage
        string unit "mg / ml / pills"
        string route "oral / topical / injection"
        text instructions
        boolean active
        timestamp created_at
        timestamp updated_at
    }

    medication_schedules {
        uuid id PK
        uuid medication_id FK
        jsonb days_of_week
        time time_of_day
        float quantity
        string unit
        boolean requires_confirmation
        boolean enabled
    }

    medication_compliance {
        uuid id PK
        uuid schedule_id FK
        uuid medication_id FK
        date scheduled_date
        string status "taken / missed / skipped / no_response"
        timestamp confirmed_at
        text note
    }

    patients ||--o{ routines : ""
    routines ||--o{ routine_schedules : ""
    routine_schedules ||--o{ routine_compliance : ""
    patients ||--o{ medications : ""
    medications ||--o{ medication_schedules : ""
    medication_schedules ||--o{ medication_compliance : ""
```

---

## Convenciones generales del schema

| Elemento | Convención |
|----------|------------|
| **Nombres de tablas** | `snake_case` plural (`patients`, `heart_rate_readings`) |
| **Primary Keys** | `UUID v4` — necesario para sync offline |
| **Foreign Keys** | `snake_case` con nombre de tabla (`patient_id`, `device_id`) |
| **Timestamps** | `timestamptz` siempre en UTC |
| **Soft-delete** | `deleted_at timestamp NULL` — no se destruyen registros clínicos |
| **Metadata flexible** | `jsonb` para datos extensibles (contexto de eventos, preferencias) |
| **Auditoría** | `audit_logs` captura todo cambio via trigger o middleware |
| **RLS** | Toda tabla con `patient_id` tiene policy Row Level Security |

---

## Resumen cuantitativo

| Módulo | Entidades | Tablas time-series | Atributos totales (aprox) |
|--------|-----------|-------------------|--------------------------|
| M0 | 7 | 0 | ~50 |
| M1 | 10 | 0 | ~65 |
| M2 | 7 | 6 | ~40 |
| M3 | 5 | 0 | ~35 |
| M4 | 5 | 0 | ~35 |
| M5 | 4 | 1 (cognitive_state) | ~25 |
| M6 [vision] | 3 | 1 (orchestration_logs) | ~15 |
| M7 | 2 | 0 | ~10 |
| M8 | 2 | 1 (data_access_logs) | ~10 |
| M9 | 6 | 2 | ~40 |
| **Total** | **51** | **11** | **~325** |
