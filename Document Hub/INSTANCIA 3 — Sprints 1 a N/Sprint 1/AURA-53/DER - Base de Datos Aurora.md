---
base: "[[Document Hub.base]]"
Category:
  - Base de Datos
  - Sprint 1
Last updated time: 2026-07-18
---

# DER - Base de Datos Aurora

Documento DER completo para la propuesta final de AURA-53. El modelo parte de la decision de trabajar con una cuenta DOT por hogar, un paciente por cuenta DOT y multiples cuidadores autenticados por OAuth asociados a esa cuenta.

## Convenciones

- Los nombres del diagrama usan prefijos por schema para evitar conflictos de Mermaid: `CORE_PATIENTS` representa `core.patients`.
- Las claves primarias UUID son generadas por la aplicacion Python y almacenadas como tipo `uuid` en PostgreSQL.
- Las tablas de alta frecuencia de biometria usan `bigint GENERATED ALWAYS AS IDENTITY`.
- Las referencias polimorficas auditables usan `text` cuando pueden apuntar a registros con distinto tipo de ID.
- `activity_sessions.memory_refs` y `ai.ai_decisions.related_entity_id` se mantienen como referencias logicas, no como foreign keys fisicas.

## Diagrama ER

```mermaid
erDiagram
    CORE_HOME_ACCOUNTS {
        uuid id PK
        text name
        text dot_identifier UK
        text status
        text timezone
        jsonb configuration
        timestamptz created_at
        timestamptz updated_at
        timestamptz deleted_at
    }

    CORE_PATIENTS {
        uuid id PK
        uuid home_account_id FK
        text name
        text dni
        date birth_date
        smallint fast_level
        jsonb medical_info
        text status
        timestamptz created_at
        timestamptz updated_at
        timestamptz deleted_at
    }

    CORE_CAREGIVERS {
        uuid id PK
        text auth_provider
        text auth_subject
        text name
        text email
        text phone
        jsonb notification_prefs
        timestamptz created_at
        timestamptz updated_at
    }

    CORE_HOME_ACCOUNT_CAREGIVERS {
        uuid id PK
        uuid home_account_id FK
        uuid caregiver_id FK
        text role
        text status
        timestamptz associated_at
    }

    CORE_EMERGENCY_CONTACTS {
        uuid id PK
        uuid patient_id FK
        text name
        text relationship
        text phone
        text email
        smallint priority
        timestamptz created_at
    }

    CORE_CONSENT_RECORDS {
        uuid id PK
        uuid patient_id FK
        text consent_type
        text status
        text scope
        timestamptz granted_at
        timestamptz revoked_at
        timestamptz expires_at
    }

    CORE_AUDIT_LOGS {
        bigint id PK
        text table_name
        text record_id
        text action
        jsonb changed_fields
        text changed_by_type
        uuid changed_by FK
        timestamptz changed_at
    }

    CORE_DATA_RETENTION_POLICIES {
        uuid id PK
        text data_category UK
        int retention_days
        text action
        boolean active
    }

    ROUTINES_ROUTINES {
        uuid id PK
        uuid patient_id FK
        text name
        text category
        text description
        boolean active
        timestamptz created_at
        timestamptz updated_at
        timestamptz deleted_at
    }

    ROUTINES_ROUTINE_SCHEDULES {
        uuid id PK
        uuid routine_id FK
        jsonb days_of_week
        time time_of_day
        jsonb recurrence
        boolean enabled
    }

    ROUTINES_ROUTINE_COMPLIANCE {
        uuid id PK
        uuid routine_id FK
        uuid schedule_id FK
        date scheduled_date
        text status
        timestamptz completed_at
    }

    ROUTINES_MEDICATIONS {
        uuid id PK
        uuid patient_id FK
        text name
        text active_ingredient
        text dosage
        text unit
        text route
        text instructions
        boolean active
        timestamptz created_at
        timestamptz updated_at
    }

    ROUTINES_MEDICATION_SCHEDULES {
        uuid id PK
        uuid medication_id FK
        jsonb days_of_week
        time time_of_day
        numeric quantity
        text unit
        boolean requires_confirmation
        boolean enabled
    }

    ROUTINES_MEDICATION_COMPLIANCE {
        uuid id PK
        uuid schedule_id FK
        uuid medication_id FK
        date scheduled_date
        text status
        timestamptz confirmed_at
        text note
    }

    VOICE_INTERACTION_SESSIONS {
        uuid id PK
        uuid patient_id FK
        text initiator
        text session_type
        text status
        text estimated_mood
        timestamptz started_at
        timestamptz ended_at
    }

    VOICE_INTERACTION_MESSAGES {
        uuid id PK
        uuid session_id FK
        text role
        text content
        text content_type
        jsonb metadata
        timestamptz created_at
    }

    VOICE_VOICE_RECORDINGS {
        uuid id PK
        uuid message_id FK
        text file_path
        int duration_ms
        int file_size_bytes
        date retention_expires_at
        timestamptz created_at
    }

    VOICE_REMINDERS {
        uuid id PK
        uuid patient_id FK
        text type
        text message_template
        jsonb schedule
        boolean active
        timestamptz created_at
        timestamptz updated_at
    }

    VOICE_REMINDER_CONFIRMATIONS {
        uuid id PK
        uuid reminder_id FK
        uuid session_id FK
        text response
        timestamptz responded_at
    }

    VOICE_ACTIVITIES {
        uuid id PK
        text activity_type
        text name
        text category
        text difficulty
        text description
        jsonb configuration
        boolean active
        timestamptz created_at
        timestamptz updated_at
    }

    VOICE_ACTIVITY_SESSIONS {
        uuid id PK
        uuid patient_id FK
        uuid activity_id FK
        uuid session_id FK
        text status
        int score
        smallint completion_percent
        int duration_seconds
        jsonb memory_refs
        jsonb metrics
        timestamptz started_at
        timestamptz ended_at
    }

    VOICE_DROP_IN_SESSIONS {
        uuid id PK
        uuid home_account_id FK
        uuid patient_id FK
        uuid caregiver_id FK
        text status
        text audio_mode
        timestamptz requested_at
        timestamptz started_at
        timestamptz ended_at
        text failure_reason
        jsonb metadata
    }

    BIOMETRICS_PATIENT_DEVICES {
        uuid id PK
        uuid patient_id FK
        text device_type
        text manufacturer
        text model
        text firmware_version
        text status
        smallint battery_level
        timestamptz last_seen_at
        timestamptz created_at
        timestamptz updated_at
    }

    BIOMETRICS_DEVICE_STATUS_LOGS {
        bigint id PK
        uuid device_id FK
        text status
        smallint battery_level
        text error_code
        timestamptz recorded_at
    }

    BIOMETRICS_BIOMETRIC_READINGS {
        bigint id PK
        uuid device_id FK
        text reading_type
        jsonb value
        timestamptz recorded_at
    }

    EVENTS_DETECTED_EVENTS {
        uuid id PK
        uuid patient_id FK
        text event_type
        text severity
        text source
        bigint source_biometric_reading_id FK
        bigint source_device_status_log_id FK
        uuid source_interaction_session_id FK
        uuid source_caregiver_id FK
        jsonb metadata
        text status
        timestamptz detected_at
        timestamptz updated_at
        timestamptz deleted_at
    }

    EVENTS_EVENT_STATUS_HISTORY {
        uuid id PK
        uuid event_id FK
        text previous_status
        text new_status
        text changed_by_type
        uuid changed_by FK
        text reason
        timestamptz changed_at
    }

    EVENTS_EVENT_CLASSIFICATIONS {
        uuid id PK
        uuid event_id FK
        text classified_by
        text severity
        text reasoning
        numeric confidence
        timestamptz classified_at
    }

    EVENTS_DETECTION_CRITERIA {
        uuid id PK
        uuid patient_id FK
        text criteria_type
        jsonb thresholds
        jsonb schedule
        boolean active
        timestamptz created_at
        timestamptz updated_at
    }

    EVENTS_GEOFENCE_ZONES {
        uuid id PK
        uuid patient_id FK
        text name
        text zone_type
        jsonb boundaries
        boolean active
        timestamptz created_at
        timestamptz updated_at
    }

    EVENTS_GEOFENCE_EXIT_EVENTS {
        uuid id PK
        uuid zone_id FK
        uuid event_id FK
        numeric exit_latitude
        numeric exit_longitude
        timestamptz exited_at
        timestamptz returned_at
    }

    ALERTS_ALERTS {
        uuid id PK
        uuid patient_id FK
        uuid source_event_id FK
        text level
        text status
        text message
        jsonb context
        timestamptz generated_at
        timestamptz resolved_at
    }

    ALERTS_ALERT_STATUS_HISTORY {
        uuid id PK
        uuid alert_id FK
        text previous_status
        text new_status
        text changed_by_type
        uuid changed_by FK
        text reason
        timestamptz changed_at
    }

    ALERTS_ALERT_RULES {
        uuid id PK
        uuid patient_id FK
        text event_type
        text min_severity
        jsonb channels
        jsonb escalation_config
        boolean active
        timestamptz created_at
        timestamptz updated_at
    }

    ALERTS_ALERT_ESCALATION_STEPS {
        uuid id PK
        uuid rule_id FK
        smallint step_order
        int wait_minutes
        text action
        text target
        jsonb params
    }

    ALERTS_NOTIFICATION_LOGS {
        uuid id PK
        uuid alert_id FK
        text channel
        text destination
        text status
        text external_id
        text error_message
        timestamptz sent_at
        timestamptz delivered_at
    }

    ALERTS_EMERGENCY_CALL_ATTEMPTS {
        uuid id PK
        uuid alert_id FK
        text destination
        text provider
        text external_call_id
        int attempt_number
        text status
        timestamptz started_at
        timestamptz answered_at
        timestamptz ended_at
        text failure_reason
    }

    ALERTS_ALERT_ACKNOWLEDGMENTS {
        uuid id PK
        uuid alert_id FK
        uuid caregiver_id FK
        text response
        text note
        timestamptz acknowledged_at
    }

    AI_PATIENT_MEMORIES {
        uuid id PK
        uuid patient_id FK
        text category
        text content
        jsonb metadata
        timestamptz created_at
        timestamptz updated_at
    }

    AI_MEMORY_EMBEDDINGS {
        uuid id PK
        uuid memory_id FK
        int chunk_index
        vector embedding
        text model_name
        text model_version
        text content_hash
        timestamptz generated_at
    }

    AI_COGNITIVE_STATE_RECORDS {
        uuid id PK
        uuid patient_id FK
        uuid session_id FK
        text state_type
        numeric confidence
        jsonb multimodal_signals
        timestamptz estimated_at
    }

    AI_AI_DECISIONS {
        uuid id PK
        uuid patient_id FK
        text decision_type
        text related_entity_type
        text related_entity_id
        text model_used
        jsonb input_refs
        jsonb output
        text reasoning
        numeric confidence
        timestamptz decided_at
    }

    AI_LLM_INTERACTION_LOGS {
        uuid id PK
        uuid patient_id FK
        uuid session_id FK
        text prompt_truncated
        text response_truncated
        int prompt_tokens
        int response_tokens
        int latency_ms
        text model_used
        timestamptz created_at
    }

    CAREGIVER_CAREGIVER_DASHBOARD_PREFS {
        uuid id PK
        uuid caregiver_id FK
        jsonb layout_config
        jsonb refresh_intervals
        timestamptz updated_at
    }

    CAREGIVER_CAREGIVER_NOTIFICATION_CHANNELS {
        uuid id PK
        uuid caregiver_id FK
        text channel
        text destination
        boolean enabled
        jsonb quiet_hours
        timestamptz created_at
        timestamptz updated_at
    }

    ORCHESTRATION_ACTION_FLOWS {
        uuid id PK
        uuid patient_id FK
        text trigger_type
        jsonb trigger_config
        jsonb actions
        boolean active
        timestamptz created_at
        timestamptz updated_at
    }

    ORCHESTRATION_WORKFLOW_EXECUTIONS {
        uuid id PK
        uuid flow_id FK
        uuid trigger_event_id FK
        text status
        jsonb results
        timestamptz started_at
        timestamptz completed_at
    }

    ORCHESTRATION_ORCHESTRATION_LOGS {
        bigint id PK
        uuid execution_id FK
        text source_module
        text action
        jsonb payload
        text status
        text error_message
        timestamptz logged_at
    }

    COMPLIANCE_ENCRYPTION_KEYS_METADATA {
        uuid id PK
        text key_identifier UK
        text algorithm
        date rotated_at
        date expires_at
        boolean active
        text notes
    }

    COMPLIANCE_DATA_ACCESS_LOGS {
        bigint id PK
        uuid patient_id FK
        text accessed_by_type
        uuid accessed_by FK
        text accessed_table
        text accessed_record_id
        text action
        text reason
        timestamptz accessed_at
    }

    CORE_HOME_ACCOUNTS ||--|| CORE_PATIENTS : "contiene"
    CORE_HOME_ACCOUNTS ||--o{ CORE_HOME_ACCOUNT_CAREGIVERS : "asocia"
    CORE_CAREGIVERS ||--o{ CORE_HOME_ACCOUNT_CAREGIVERS : "pertenece"
    CORE_PATIENTS ||--o{ CORE_EMERGENCY_CONTACTS : "tiene"
    CORE_PATIENTS ||--o{ CORE_CONSENT_RECORDS : "autoriza"
    CORE_CAREGIVERS ||--o{ CORE_AUDIT_LOGS : "modifica"

    CORE_PATIENTS ||--o{ ROUTINES_ROUTINES : "tiene"
    ROUTINES_ROUTINES ||--o{ ROUTINES_ROUTINE_SCHEDULES : "programa"
    ROUTINES_ROUTINES ||--o{ ROUTINES_ROUTINE_COMPLIANCE : "registra"
    ROUTINES_ROUTINE_SCHEDULES ||--o{ ROUTINES_ROUTINE_COMPLIANCE : "controla"
    CORE_PATIENTS ||--o{ ROUTINES_MEDICATIONS : "recibe"
    ROUTINES_MEDICATIONS ||--o{ ROUTINES_MEDICATION_SCHEDULES : "programa"
    ROUTINES_MEDICATIONS ||--o{ ROUTINES_MEDICATION_COMPLIANCE : "registra"
    ROUTINES_MEDICATION_SCHEDULES ||--o{ ROUTINES_MEDICATION_COMPLIANCE : "controla"

    CORE_PATIENTS ||--o{ VOICE_INTERACTION_SESSIONS : "participa"
    VOICE_INTERACTION_SESSIONS ||--o{ VOICE_INTERACTION_MESSAGES : "contiene"
    VOICE_INTERACTION_MESSAGES ||--o{ VOICE_VOICE_RECORDINGS : "adjunta"
    CORE_PATIENTS ||--o{ VOICE_REMINDERS : "recibe"
    VOICE_REMINDERS ||--o{ VOICE_REMINDER_CONFIRMATIONS : "confirma"
    VOICE_INTERACTION_SESSIONS ||--o{ VOICE_REMINDER_CONFIRMATIONS : "origina"
    VOICE_ACTIVITIES ||--o{ VOICE_ACTIVITY_SESSIONS : "ejecuta"
    CORE_PATIENTS ||--o{ VOICE_ACTIVITY_SESSIONS : "realiza"
    VOICE_INTERACTION_SESSIONS ||--o{ VOICE_ACTIVITY_SESSIONS : "contextualiza"
    CORE_HOME_ACCOUNTS ||--o{ VOICE_DROP_IN_SESSIONS : "habilita"
    CORE_PATIENTS ||--o{ VOICE_DROP_IN_SESSIONS : "recibe"
    CORE_CAREGIVERS ||--o{ VOICE_DROP_IN_SESSIONS : "inicia"
    CORE_HOME_ACCOUNT_CAREGIVERS ||--o{ VOICE_DROP_IN_SESSIONS : "autoriza"

    CORE_PATIENTS ||--o{ BIOMETRICS_PATIENT_DEVICES : "usa"
    BIOMETRICS_PATIENT_DEVICES ||--o{ BIOMETRICS_DEVICE_STATUS_LOGS : "reporta"
    BIOMETRICS_PATIENT_DEVICES ||--o{ BIOMETRICS_BIOMETRIC_READINGS : "emite"

    CORE_PATIENTS ||--o{ EVENTS_DETECTED_EVENTS : "genera"
    BIOMETRICS_BIOMETRIC_READINGS ||--o{ EVENTS_DETECTED_EVENTS : "origina"
    BIOMETRICS_DEVICE_STATUS_LOGS ||--o{ EVENTS_DETECTED_EVENTS : "origina"
    VOICE_INTERACTION_SESSIONS ||--o{ EVENTS_DETECTED_EVENTS : "origina"
    CORE_CAREGIVERS ||--o{ EVENTS_DETECTED_EVENTS : "reporta"
    EVENTS_DETECTED_EVENTS ||--o{ EVENTS_EVENT_STATUS_HISTORY : "cambia_estado"
    EVENTS_DETECTED_EVENTS ||--o{ EVENTS_EVENT_CLASSIFICATIONS : "clasifica"
    CORE_CAREGIVERS ||--o{ EVENTS_EVENT_STATUS_HISTORY : "actualiza"
    CORE_PATIENTS ||--o{ EVENTS_DETECTION_CRITERIA : "configura"
    CORE_PATIENTS ||--o{ EVENTS_GEOFENCE_ZONES : "define"
    EVENTS_GEOFENCE_ZONES ||--o{ EVENTS_GEOFENCE_EXIT_EVENTS : "detecta"
    EVENTS_DETECTED_EVENTS ||--o{ EVENTS_GEOFENCE_EXIT_EVENTS : "detalla"

    CORE_PATIENTS ||--o{ ALERTS_ALERTS : "recibe"
    EVENTS_DETECTED_EVENTS ||--o{ ALERTS_ALERTS : "dispara"
    ALERTS_ALERTS ||--o{ ALERTS_ALERT_STATUS_HISTORY : "cambia_estado"
    CORE_CAREGIVERS ||--o{ ALERTS_ALERT_STATUS_HISTORY : "actualiza"
    CORE_PATIENTS ||--o{ ALERTS_ALERT_RULES : "configura"
    ALERTS_ALERT_RULES ||--o{ ALERTS_ALERT_ESCALATION_STEPS : "ordena"
    ALERTS_ALERTS ||--o{ ALERTS_NOTIFICATION_LOGS : "notifica"
    ALERTS_ALERTS ||--o{ ALERTS_EMERGENCY_CALL_ATTEMPTS : "llama"
    ALERTS_ALERTS ||--o{ ALERTS_ALERT_ACKNOWLEDGMENTS : "atiende"
    CORE_CAREGIVERS ||--o{ ALERTS_ALERT_ACKNOWLEDGMENTS : "confirma"

    CORE_PATIENTS ||--o{ AI_PATIENT_MEMORIES : "posee"
    AI_PATIENT_MEMORIES ||--o{ AI_MEMORY_EMBEDDINGS : "vectoriza"
    CORE_PATIENTS ||--o{ AI_COGNITIVE_STATE_RECORDS : "estima"
    VOICE_INTERACTION_SESSIONS ||--o{ AI_COGNITIVE_STATE_RECORDS : "evidencia"
    CORE_PATIENTS ||--o{ AI_AI_DECISIONS : "audita"
    CORE_PATIENTS ||--o{ AI_LLM_INTERACTION_LOGS : "consulta"
    VOICE_INTERACTION_SESSIONS ||--o{ AI_LLM_INTERACTION_LOGS : "contextualiza"

    CORE_CAREGIVERS ||--o{ CAREGIVER_CAREGIVER_DASHBOARD_PREFS : "personaliza"
    CORE_CAREGIVERS ||--o{ CAREGIVER_CAREGIVER_NOTIFICATION_CHANNELS : "configura"

    CORE_PATIENTS ||--o{ ORCHESTRATION_ACTION_FLOWS : "automatiza"
    ORCHESTRATION_ACTION_FLOWS ||--o{ ORCHESTRATION_WORKFLOW_EXECUTIONS : "ejecuta"
    EVENTS_DETECTED_EVENTS ||--o{ ORCHESTRATION_WORKFLOW_EXECUTIONS : "dispara"
    ORCHESTRATION_WORKFLOW_EXECUTIONS ||--o{ ORCHESTRATION_ORCHESTRATION_LOGS : "registra"

    CORE_PATIENTS ||--o{ COMPLIANCE_DATA_ACCESS_LOGS : "audita"
    CORE_CAREGIVERS ||--o{ COMPLIANCE_DATA_ACCESS_LOGS : "accede"
```

## Notas de integridad

- `core.patients.home_account_id` es `UNIQUE`, por lo tanto una cuenta DOT tiene como maximo un paciente.
- `core.home_account_caregivers` define la asociacion N:M entre cuidadores y cuentas DOT, con rol operativo `primary` o `support`.
- `voice.drop_in_sessions` valida por foreign keys compuestas que el paciente pertenezca a la cuenta DOT y que el cuidador este asociado a esa misma cuenta.
- `events.detected_events` evita el `source_id` polimorfico y usa columnas explicitas para los origenes hoy relevantes.
- `ai.memory_embeddings` permite multiples versiones por recuerdo, modelo, version y chunk.
- `core.audit_logs` y `compliance.data_access_logs` usan identificadores auditados como `text` para poder registrar tablas con PK `uuid` o `bigint`.

