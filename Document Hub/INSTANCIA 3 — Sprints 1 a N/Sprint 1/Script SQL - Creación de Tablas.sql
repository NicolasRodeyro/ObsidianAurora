-- ============================================================================
-- Script de Creación de Base de Datos — Aurora
-- Motor: PostgreSQL 16 + pgvector
-- Esquema: 10 schemas, ~47 tablas
-- Convenciones:
--   - PKs: UUID v4 con default gen_random_uuid()
--   - Timestamps: timestamptz NOT NULL DEFAULT NOW()
--   - Soft-delete: deleted_at timestamptz NULL
--   - JSONB para metadata extensible
-- ============================================================================

-- ============================================================================
-- Extensiones requeridas
-- ============================================================================
CREATE EXTENSION IF NOT EXISTS pgcrypto;          -- gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS vector;            -- pgvector (embeddings)


-- ============================================================================
-- SCHEMAS
-- ============================================================================
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS routines;
CREATE SCHEMA IF NOT EXISTS voice;
CREATE SCHEMA IF NOT EXISTS biometrics;
CREATE SCHEMA IF NOT EXISTS events;
CREATE SCHEMA IF NOT EXISTS alerts;
CREATE SCHEMA IF NOT EXISTS ai;
CREATE SCHEMA IF NOT EXISTS caregiver;
CREATE SCHEMA IF NOT EXISTS orchestration;
CREATE SCHEMA IF NOT EXISTS compliance;


-- ============================================================================
-- SCHEMA: core — Entidades transversales
-- ============================================================================

CREATE TABLE core.patients (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name            text NOT NULL,
    dni             text,
    birth_date      date,
    fast_level      smallint CHECK (fast_level BETWEEN 1 AND 5),
    medical_info    jsonb DEFAULT '{}',
    status          text NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    consent_id      uuid,
    created_at      timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW(),
    deleted_at      timestamptz
);

CREATE TABLE core.caregivers (
    id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    auth_user_id        uuid NOT NULL UNIQUE,
    name                text NOT NULL,
    email               text,
    phone               text,
    notification_prefs  jsonb DEFAULT '{}',
    created_at          timestamptz NOT NULL DEFAULT NOW(),
    updated_at          timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE core.caregiver_patient (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    caregiver_id    uuid NOT NULL REFERENCES core.caregivers(id) ON DELETE CASCADE,
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    role            text NOT NULL DEFAULT 'support' CHECK (role IN ('primary', 'support')),
    permissions     jsonb DEFAULT '{}',
    assigned_at     timestamptz NOT NULL DEFAULT NOW(),
    UNIQUE (caregiver_id, patient_id)
);

CREATE TABLE core.emergency_contacts (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    name            text NOT NULL,
    relationship    text,
    phone           text,
    email           text,
    priority        smallint NOT NULL DEFAULT 1,
    created_at      timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE core.consent_records (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    consent_type    text NOT NULL,
    status          text NOT NULL DEFAULT 'granted' CHECK (status IN ('granted', 'revoked', 'expired')),
    scope           text,
    granted_at      timestamptz NOT NULL DEFAULT NOW(),
    revoked_at      timestamptz,
    expires_at      timestamptz
);

CREATE TABLE core.audit_logs (
    id              bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    table_name      text NOT NULL,
    record_id       uuid NOT NULL,
    action          text NOT NULL CHECK (action IN ('create', 'update', 'delete')),
    changed_fields  jsonb DEFAULT '{}',
    changed_by      uuid,
    changed_at      timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE core.data_retention_policies (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    data_category   text NOT NULL UNIQUE,
    retention_days  int NOT NULL,
    action          text NOT NULL DEFAULT 'delete' CHECK (action IN ('archive', 'delete', 'anonymize')),
    active          boolean NOT NULL DEFAULT true
);


-- ============================================================================
-- SCHEMA: routines — Rutinas y Medicación
-- ============================================================================

CREATE TABLE routines.routines (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    name            text NOT NULL,
    category        text NOT NULL CHECK (category IN ('hygiene', 'meal', 'rest', 'exercise', 'therapy')),
    description     text,
    active          boolean NOT NULL DEFAULT true,
    created_at      timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW(),
    deleted_at      timestamptz
);

CREATE TABLE routines.routine_schedules (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    routine_id      uuid NOT NULL REFERENCES routines.routines(id) ON DELETE CASCADE,
    days_of_week    jsonb NOT NULL DEFAULT '[1,2,3,4,5,6,7]',
    time_of_day     time NOT NULL,
    recurrence      jsonb DEFAULT '"daily"',
    enabled         boolean NOT NULL DEFAULT true
);

CREATE TABLE routines.routine_compliance (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    routine_id      uuid NOT NULL REFERENCES routines.routines(id) ON DELETE CASCADE,
    schedule_id     uuid NOT NULL REFERENCES routines.routine_schedules(id) ON DELETE CASCADE,
    scheduled_date  date NOT NULL,
    status          text NOT NULL CHECK (status IN ('completed', 'skipped', 'missed')),
    completed_at    timestamptz
);

CREATE TABLE routines.medications (
    id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id          uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    name                text NOT NULL,
    active_ingredient   text,
    dosage              text,
    unit                text,
    route               text CHECK (route IN ('oral', 'topical', 'injection', 'inhalation', 'sublingual')),
    instructions        text,
    active              boolean NOT NULL DEFAULT true,
    created_at          timestamptz NOT NULL DEFAULT NOW(),
    updated_at          timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE routines.medication_schedules (
    id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    medication_id           uuid NOT NULL REFERENCES routines.medications(id) ON DELETE CASCADE,
    days_of_week            jsonb NOT NULL DEFAULT '[1,2,3,4,5,6,7]',
    time_of_day             time NOT NULL,
    quantity                numeric NOT NULL,
    unit                    text NOT NULL,
    requires_confirmation   boolean NOT NULL DEFAULT true,
    enabled                 boolean NOT NULL DEFAULT true
);

CREATE TABLE routines.medication_compliance (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    schedule_id     uuid NOT NULL REFERENCES routines.medication_schedules(id) ON DELETE CASCADE,
    medication_id   uuid NOT NULL REFERENCES routines.medications(id) ON DELETE CASCADE,
    scheduled_date  date NOT NULL,
    status          text NOT NULL CHECK (status IN ('taken', 'missed', 'skipped', 'no_response')),
    confirmed_at    timestamptz,
    note            text
);


-- ============================================================================
-- SCHEMA: voice — Interacción con el Paciente
-- ============================================================================

CREATE TABLE voice.interaction_sessions (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    initiator       text NOT NULL CHECK (initiator IN ('system', 'patient')),
    session_type    text NOT NULL CHECK (session_type IN ('conversation', 'reminder', 'cognitive', 'game', 'reminiscence')),
    status          text NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'closed', 'interrupted')),
    estimated_mood  text,
    started_at      timestamptz NOT NULL DEFAULT NOW(),
    ended_at        timestamptz
);

CREATE TABLE voice.interaction_messages (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id      uuid NOT NULL REFERENCES voice.interaction_sessions(id) ON DELETE CASCADE,
    role            text NOT NULL CHECK (role IN ('patient', 'system')),
    content         text NOT NULL,
    content_type    text NOT NULL DEFAULT 'text' CHECK (content_type IN ('text', 'stt_transcript', 'tts_audio_ref')),
    metadata        jsonb DEFAULT '{}',
    created_at      timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE voice.voice_recordings (
    id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    message_id              uuid NOT NULL REFERENCES voice.interaction_messages(id) ON DELETE CASCADE,
    file_path               text NOT NULL,
    duration_ms             int,
    file_size_bytes         int,
    retention_expires_at    date,
    created_at              timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE voice.reminders (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id        uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    type              text NOT NULL CHECK (type IN ('medication', 'meal', 'hygiene', 'rest', 'general')),
    message_template  text NOT NULL,
    schedule          jsonb NOT NULL DEFAULT '{}',
    active            boolean NOT NULL DEFAULT true,
    created_at        timestamptz NOT NULL DEFAULT NOW(),
    updated_at        timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE voice.reminder_confirmations (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    reminder_id     uuid NOT NULL REFERENCES voice.reminders(id) ON DELETE CASCADE,
    session_id      uuid REFERENCES voice.interaction_sessions(id),
    response        text NOT NULL CHECK (response IN ('confirmed', 'denied', 'no_response')),
    responded_at    timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE voice.cognitive_activities (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name              text NOT NULL,
    category          text NOT NULL CHECK (category IN ('memory', 'attention', 'language', 'orientation', 'reasoning')),
    description       text,
    difficulty_levels jsonb DEFAULT '{}',
    configuration     jsonb DEFAULT '{}',
    active            boolean NOT NULL DEFAULT true
);

CREATE TABLE voice.cognitive_activity_results (
    id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id          uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    activity_id         uuid NOT NULL REFERENCES voice.cognitive_activities(id) ON DELETE CASCADE,
    session_id          uuid REFERENCES voice.interaction_sessions(id),
    score               int,
    completion_percent  smallint CHECK (completion_percent BETWEEN 0 AND 100),
    metrics             jsonb DEFAULT '{}',
    performed_at        timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE voice.game_activities (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name            text NOT NULL,
    category        text,
    description     text,
    configuration   jsonb DEFAULT '{}',
    active          boolean NOT NULL DEFAULT true
);

CREATE TABLE voice.game_activity_results (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id        uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    game_id           uuid NOT NULL REFERENCES voice.game_activities(id) ON DELETE CASCADE,
    session_id        uuid REFERENCES voice.interaction_sessions(id),
    score             int,
    duration_seconds  int,
    metrics           jsonb DEFAULT '{}',
    played_at         timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE voice.reminiscence_topics (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    memory_id       uuid,
    topic_type      text NOT NULL CHECK (topic_type IN ('family', 'life_event', 'preference', 'achievement', 'other')),
    content         text NOT NULL,
    media_refs      jsonb DEFAULT '[]',
    created_at      timestamptz NOT NULL DEFAULT NOW()
);


-- ============================================================================
-- SCHEMA: biometrics — Monitoreo Biométrico
-- ============================================================================

CREATE TABLE biometrics.patient_devices (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id        uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    device_type       text NOT NULL CHECK (device_type IN ('aurora_band', 'smartphone', 'gateway')),
    manufacturer      text,
    model             text,
    firmware_version  text,
    status            text NOT NULL DEFAULT 'unknown' CHECK (status IN ('online', 'offline', 'unknown')),
    battery_level     smallint CHECK (battery_level BETWEEN 0 AND 100),
    last_seen_at      timestamptz,
    created_at        timestamptz NOT NULL DEFAULT NOW(),
    updated_at        timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE biometrics.device_status_logs (
    id              bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    device_id       uuid NOT NULL REFERENCES biometrics.patient_devices(id) ON DELETE CASCADE,
    status          text NOT NULL,
    battery_level   smallint CHECK (battery_level BETWEEN 0 AND 100),
    error_code      text,
    recorded_at     timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE biometrics.biometric_readings (
    id              bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    device_id       uuid NOT NULL REFERENCES biometrics.patient_devices(id) ON DELETE CASCADE,
    reading_type    text NOT NULL CHECK (reading_type IN ('heart_rate', 'movement', 'location', 'temperature', 'eda')),
    value           jsonb NOT NULL,
    recorded_at     timestamptz NOT NULL DEFAULT NOW()
);

-- Índice para time-series: consultas por dispositivo + rango de tiempo
CREATE INDEX idx_biometric_readings_device_time
    ON biometrics.biometric_readings (device_id, recorded_at DESC);

-- Índice para limpieza por TTL (retención 90 días)
CREATE INDEX idx_biometric_readings_recorded_at
    ON biometrics.biometric_readings (recorded_at);


-- ============================================================================
-- SCHEMA: events — Detección de Eventos
-- ============================================================================

CREATE TABLE events.detected_events (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    event_type      text NOT NULL CHECK (event_type IN ('fall', 'wandering', 'agitation', 'geofence_exit', 'inactivity', 'biometric_anomaly', 'other')),
    severity        text NOT NULL CHECK (severity IN ('informative', 'preventive', 'critical')),
    source          text NOT NULL CHECK (source IN ('sensor', 'ia', 'caregiver', 'system')),
    source_id       uuid,
    metadata        jsonb DEFAULT '{}',
    status          text NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'acknowledged', 'resolved', 'false_positive')),
    detected_at     timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW(),
    deleted_at      timestamptz
);

CREATE TABLE events.event_classifications (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id        uuid NOT NULL REFERENCES events.detected_events(id) ON DELETE CASCADE,
    classified_by   text NOT NULL CHECK (classified_by IN ('system', 'ia', 'caregiver')),
    severity        text NOT NULL CHECK (severity IN ('informative', 'preventive', 'critical')),
    reasoning       text,
    confidence      numeric CHECK (confidence >= 0 AND confidence <= 1),
    classified_at   timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE events.detection_criteria (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    criteria_type   text NOT NULL CHECK (criteria_type IN ('heart_rate', 'movement', 'location', 'inactivity', 'agitation', 'other')),
    thresholds      jsonb NOT NULL DEFAULT '{}',
    schedule        jsonb DEFAULT '{}',
    active          boolean NOT NULL DEFAULT true,
    created_at      timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE events.geofence_zones (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    name            text NOT NULL,
    zone_type       text NOT NULL CHECK (zone_type IN ('home', 'safe', 'restricted')),
    boundaries      jsonb NOT NULL,
    active          boolean NOT NULL DEFAULT true,
    created_at      timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE events.geofence_exit_events (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    zone_id         uuid NOT NULL REFERENCES events.geofence_zones(id) ON DELETE CASCADE,
    event_id        uuid NOT NULL REFERENCES events.detected_events(id) ON DELETE CASCADE,
    exit_latitude   numeric NOT NULL,
    exit_longitude  numeric NOT NULL,
    exited_at       timestamptz NOT NULL DEFAULT NOW(),
    returned_at     timestamptz
);


-- ============================================================================
-- SCHEMA: alerts — Alertas y Comunicación
-- ============================================================================

CREATE TABLE alerts.alerts (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id        uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    source_event_id   uuid REFERENCES events.detected_events(id),
    level             text NOT NULL CHECK (level IN ('low', 'medium', 'high', 'critical')),
    status            text NOT NULL DEFAULT 'generated' CHECK (status IN ('generated', 'sent', 'attended', 'closed', 'escalated')),
    message           text NOT NULL,
    context           jsonb DEFAULT '{}',
    generated_at      timestamptz NOT NULL DEFAULT NOW(),
    resolved_at       timestamptz
);

CREATE TABLE alerts.alert_rules (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id        uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    event_type        text NOT NULL,
    min_severity      text NOT NULL CHECK (min_severity IN ('informative', 'preventive', 'critical')),
    channels          jsonb NOT NULL DEFAULT '["push"]',
    escalation_config jsonb DEFAULT '{}',
    active            boolean NOT NULL DEFAULT true,
    created_at        timestamptz NOT NULL DEFAULT NOW(),
    updated_at        timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE alerts.alert_escalation_steps (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    rule_id         uuid NOT NULL REFERENCES alerts.alert_rules(id) ON DELETE CASCADE,
    step_order      smallint NOT NULL,
    wait_minutes    int NOT NULL,
    action          text NOT NULL CHECK (action IN ('notify', 'call', 'escalate')),
    target          text NOT NULL CHECK (target IN ('caregiver', 'emergency_contact', 'emergency_service')),
    params          jsonb DEFAULT '{}'
);

CREATE TABLE alerts.notification_logs (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    alert_id        uuid NOT NULL REFERENCES alerts.alerts(id) ON DELETE CASCADE,
    channel         text NOT NULL CHECK (channel IN ('push', 'whatsapp', 'telegram', 'email', 'call', 'sms')),
    destination     text NOT NULL,
    status          text NOT NULL CHECK (status IN ('sent', 'delivered', 'failed', 'read')),
    external_id     text,
    error_message   text,
    sent_at         timestamptz NOT NULL DEFAULT NOW(),
    delivered_at    timestamptz
);

CREATE TABLE alerts.alert_acknowledgments (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    alert_id          uuid NOT NULL REFERENCES alerts.alerts(id) ON DELETE CASCADE,
    caregiver_id      uuid NOT NULL REFERENCES core.caregivers(id),
    response          text NOT NULL CHECK (response IN ('acknowledged', 'investigating', 'resolved', 'false_alarm')),
    note              text,
    acknowledged_at   timestamptz NOT NULL DEFAULT NOW()
);


-- ============================================================================
-- SCHEMA: ai — Motor de IA y Memoria del Paciente
-- ============================================================================

CREATE TABLE ai.patient_memories (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    category        text NOT NULL CHECK (category IN ('biography', 'family', 'preference', 'achievement', 'routine', 'life_event')),
    content         text NOT NULL,
    metadata        jsonb DEFAULT '{}',
    created_at      timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE ai.memory_embeddings (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    memory_id       uuid NOT NULL UNIQUE REFERENCES ai.patient_memories(id) ON DELETE CASCADE,
    embedding       vector(768) NOT NULL,
    model_used      text NOT NULL,
    generated_at    timestamptz NOT NULL DEFAULT NOW()
);

-- Índice HNSW para búsqueda vectorial
CREATE INDEX idx_memory_embeddings_hnsw
    ON ai.memory_embeddings
    USING hnsw (embedding vector_cosine_ops);

CREATE TABLE ai.cognitive_state_records (
    id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id          uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    session_id          uuid REFERENCES voice.interaction_sessions(id),
    state_type          text NOT NULL CHECK (state_type IN ('confusion', 'anxiety', 'disorientation', 'calm', 'agitated', 'other')),
    confidence          numeric CHECK (confidence >= 0 AND confidence <= 1),
    multimodal_signals  jsonb DEFAULT '{}',
    estimated_at        timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE ai.llm_interaction_logs (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id        uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    session_id        uuid REFERENCES voice.interaction_sessions(id),
    prompt_truncated  text,
    response_truncated text,
    prompt_tokens     int,
    response_tokens   int,
    latency_ms        int,
    model_used        text,
    created_at        timestamptz NOT NULL DEFAULT NOW()
);


-- ============================================================================
-- SCHEMA: caregiver — Panel del Cuidador
-- ============================================================================

CREATE TABLE caregiver.caregiver_dashboard_prefs (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    caregiver_id      uuid NOT NULL REFERENCES core.caregivers(id) ON DELETE CASCADE,
    layout_config     jsonb DEFAULT '{}',
    refresh_intervals jsonb DEFAULT '{}',
    updated_at        timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE caregiver.caregiver_notification_channels (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    caregiver_id    uuid NOT NULL REFERENCES core.caregivers(id) ON DELETE CASCADE,
    channel         text NOT NULL CHECK (channel IN ('push', 'whatsapp', 'telegram', 'email', 'sms')),
    destination     text NOT NULL,
    enabled         boolean NOT NULL DEFAULT true,
    quiet_hours     jsonb DEFAULT '{}',
    created_at      timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW()
);


-- ============================================================================
-- SCHEMA: orchestration — Orquestación y Automatización [vision]
-- ============================================================================

CREATE TABLE orchestration.action_flows (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    trigger_type    text NOT NULL CHECK (trigger_type IN ('event', 'schedule', 'manual')),
    trigger_config  jsonb NOT NULL DEFAULT '{}',
    actions         jsonb NOT NULL DEFAULT '[]',
    active          boolean NOT NULL DEFAULT true,
    created_at      timestamptz NOT NULL DEFAULT NOW(),
    updated_at      timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE orchestration.workflow_executions (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    flow_id           uuid NOT NULL REFERENCES orchestration.action_flows(id) ON DELETE CASCADE,
    trigger_event_id  uuid,
    status            text NOT NULL CHECK (status IN ('running', 'completed', 'failed', 'partial')),
    results           jsonb DEFAULT '{}',
    started_at        timestamptz NOT NULL DEFAULT NOW(),
    completed_at      timestamptz
);

CREATE TABLE orchestration.orchestration_logs (
    id              bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    execution_id    uuid NOT NULL REFERENCES orchestration.workflow_executions(id) ON DELETE CASCADE,
    source_module   text NOT NULL,
    action          text NOT NULL,
    payload         jsonb DEFAULT '{}',
    status          text NOT NULL CHECK (status IN ('success', 'error')),
    error_message   text,
    logged_at       timestamptz NOT NULL DEFAULT NOW()
);


-- ============================================================================
-- SCHEMA: compliance — Seguridad y Privacidad
-- ============================================================================

CREATE TABLE compliance.encryption_keys_metadata (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    key_identifier  text NOT NULL UNIQUE,
    algorithm       text NOT NULL,
    rotated_at      date,
    expires_at      date,
    active          boolean NOT NULL DEFAULT true,
    notes           text
);

CREATE TABLE compliance.data_access_logs (
    id                bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    patient_id        uuid NOT NULL REFERENCES core.patients(id) ON DELETE CASCADE,
    accessed_by       uuid NOT NULL,
    accessed_table    text NOT NULL,
    accessed_record_id uuid,
    action            text NOT NULL CHECK (action IN ('read', 'export')),
    reason            text,
    accessed_at       timestamptz NOT NULL DEFAULT NOW()
);


-- ============================================================================
-- ÍNDICES ADICIONALES (rendimiento)
-- ============================================================================

-- core: búsqueda de pacientes activos
CREATE INDEX idx_patients_status ON core.patients (status) WHERE deleted_at IS NULL;

-- core: audit logs por tabla y registro
CREATE INDEX idx_audit_logs_record ON core.audit_logs (table_name, record_id, changed_at DESC);

-- events: eventos activos por paciente
CREATE INDEX idx_detected_events_patient ON events.detected_events (patient_id, detected_at DESC) WHERE deleted_at IS NULL;

-- alerts: alertas activas por paciente
CREATE INDEX idx_alerts_patient_status ON alerts.alerts (patient_id, status, generated_at DESC);

-- routines: schedules activos por rutina
CREATE INDEX idx_routine_schedules_routine ON routines.routine_schedules (routine_id) WHERE enabled = true;

-- medication: schedules activos por medicamento
CREATE INDEX idx_medication_schedules_med ON routines.medication_schedules (medication_id) WHERE enabled = true;


-- ============================================================================
-- SEED DATA — Datos iniciales del sistema
-- ============================================================================

-- Políticas de retención default
INSERT INTO core.data_retention_policies (data_category, retention_days, action) VALUES
    ('voice_recordings',       30,  'delete'),
    ('biometric_readings',     90,  'archive'),
    ('detected_events',        730, 'archive'),   -- 2 años
    ('alerts',                 730, 'archive'),   -- 2 años
    ('interaction_messages',   180, 'delete'),
    ('location_readings',      7,   'delete'),
    ('audit_logs',             730, 'archive'),
    ('cognitive_state_records',90,  'delete'),
    ('llm_interaction_logs',   180, 'delete');

-- Actividades cognitivas iniciales
INSERT INTO voice.cognitive_activities (name, category, description) VALUES
    ('Ejercicio de memoria reciente',       'memory',      'Recordar qué comió hoy, qué hizo ayer'),
    ('Asociación nombre - rostro',          'memory',      'Relacionar nombres de familiares con fotos'),
    ('Sopa de letras',                      'attention',   'Encontrar palabras en una grilla'),
    ('Completar refranes',                  'language',    'Terminar dichos y refranes populares'),
    ('Orientación temporal',                'orientation', 'Preguntar día, fecha, estación del año'),
    ('Orientación espacial',                'orientation', 'Describir su casa, barrio, ciudad'),
    ('Clasificación de objetos',            'reasoning',   'Agrupar objetos por categoría'),
    ('Secuencia lógica',                    'reasoning',   'Ordenar pasos de una actividad cotidiana');

-- Juegos iniciales
INSERT INTO voice.game_activities (name, category, description) VALUES
    ('Adivina la canción',          'music',    'Reproducir fragmento de canción conocida y adivinar'),
    ('Cuento colaborativo',         'story',    'Completar una historia entre el sistema y el paciente'),
    ('Preguntas de trivia',         'trivia',   'Preguntas de cultura general adaptadas');


-- ============================================================================
-- NOTAS DE IMPLEMENTACIÓN
-- ============================================================================

-- Particionamiento (aplicar cuando biometric_readings supere 5M filas):
--   CREATE TABLE biometrics.biometric_readings_2026_07
--       PARTITION OF biometrics.biometric_readings
--       FOR VALUES FROM ('2026-07-01') TO ('2026-08-01');

-- RLS (Row Level Security) — aplicar por tabla:
--   ALTER TABLE core.patients ENABLE ROW LEVEL SECURITY;
--   CREATE POLICY patient_isolation ON core.patients
--       USING (id IN (
--           SELECT patient_id FROM core.caregiver_patient
--           WHERE caregiver_id = auth.uid()
--       ));

-- Updates automáticos para updated_at:
--   CREATE OR REPLACE FUNCTION set_updated_at()
--   RETURNS TRIGGER AS $$ BEGIN NEW.updated_at = NOW(); RETURN NEW; END; $$ LANGUAGE plpgsql;
--   CREATE TRIGGER trg_patients_updated_at
--       BEFORE UPDATE ON core.patients
--       FOR EACH ROW EXECUTE FUNCTION set_updated_at();
