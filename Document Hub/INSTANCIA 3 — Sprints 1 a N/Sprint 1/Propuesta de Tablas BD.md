---
base: "[[Document Hub.base]]"
Category:
  - Base de Datos
  - Sprint 1
Last updated time: 2026-07-09
---

# Propuesta de Tablas — Base de Datos Aurora

Documento de trabajo inicial. Listado de tablas propuestas por módulo funcional, **sin relaciones**, para validación del equipo. Basado en los 91 RFs, las épicas de Jira y los ADRs.

---

## Módulo 0 — Transversal / Base del Sistema

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 1 | `caregivers` | Perfiles de cuidador (nombre, teléfono, preferencias de notificación) | RF-76, RF-77 |
| 2 | `patients` | Perfiles de paciente (nombre, DNI, fecha nacimiento, nivel FAST, datos médicos) | RF-68, RF-74 |
| 3 | `caregiver_patient` | Asignación cuidador ↔ paciente (rol, permisos) | RF-77 |
| 4 | `audit_logs` | Trazabilidad de modificaciones sobre datos sensibles | RF-78 |
| 5 | `consent_records` | Consentimiento para tratamiento de datos sensibles | RF-81 |
| 6 | `emergency_contacts` | Contactos de emergencia del paciente | RF-69 |
| 7 | `data_retention_policies` | Políticas de retención por tipo de dato | Seguridad, RNF-38 |

---

## Módulo 1 — Interacción con el Paciente (AURA-14)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 8 | `interaction_sessions` | Sesiones de conversación (inicio, fin, tipo, estado) | RF-01 |
| 9 | `interaction_messages` | Mensajes individuales paciente ↔ sistema (rol, contenido, timestamp) | RF-02, RF-03, RF-04, RF-05 |
| 10 | `voice_recordings` | Archivos de audio capturados (path, duración, retention_expires_at) | RF-02, RF-05 |
| 11 | `reminders` | Recordatorios programados (tipo, mensaje, horario, recurrencia) | RF-06, RF-07 |
| 12 | `reminder_confirmations` | Confirmaciones de cumplimiento (paciente respondió sí/no/omitido) | RF-08 |
| 13 | `cognitive_activities` | Catálogo de actividades de estimulación cognitiva | RF-10, RF-11 |
| 14 | `cognitive_activity_results` | Resultados y desempeño por actividad realizada | RF-10, RF-11, RF-52 |
| 15 | `game_activities` | Catálogo de juegos recreativos simples | RF-12, RF-13 |
| 16 | `game_activity_results` | Resultados y participación por juego | RF-12, RF-13 |
| 17 | `reminiscence_topics` | Recuerdos y temas de reminiscencia digital | RF-09 |

---

## Módulo 2 — Monitoreo Biométrico — Aurora Band (AURA-19)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 18 | `patient_devices` | Dispositivos vinculados al paciente (tipo, modelo, firmware) | RF-22, RF-23 |
| 19 | `device_status_logs` | Log de estado operativo y conectividad de cada dispositivo | RF-20, RF-21, RF-22, RF-23 |
| 20 | `heart_rate_readings` | Lecturas de frecuencia cardíaca (BPM, timestamp) | RF-15 |
| 21 | `movement_readings` | Lecturas de acelerómetro y giroscopio (accel_x/y/z, gyro_x/y/z) | RF-16 |
| 22 | `location_readings` | Lecturas de GPS (latitud, longitud, altitud, precisión) | RF-17 |
| 23 | `temperature_readings` | Lecturas de temperatura corporal | RF-18 |
| 24 | `eda_readings` | Lecturas de actividad electrodérmica | RF-19 |

---

## Módulo 3 — Detección de Eventos y Riesgos (AURA-22)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 25 | `detected_events` | Eventos de riesgo detectados (tipo, severidad, timestamp, metadata) | RF-24, RF-25, RF-26, RF-28, RF-29, RF-30, RF-31 |
| 26 | `event_classifications` | Clasificaciones asignadas a eventos (informativo, preventivo, crítico) | RF-32 |
| 27 | `detection_criteria` | Criterios y umbrales de detección configurables | RF-34, RF-35 |
| 28 | `geofence_zones` | Zonas seguras definidas para el paciente (polígono, centro + radio) | RF-27, RF-70 |
| 29 | `geofence_exit_events` | Eventos de salida de zona segura | RF-27, RF-46 |

---

## Módulo 4 — Alertas y Comunicación con el Cuidador (AURA-16)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 30 | `alerts` | Alertas generadas (nivel, estado, origen, timestamp) | RF-36, RF-37, RF-44 |
| 31 | `alert_rules` | Reglas de notificación configurables por tipo de evento | RF-45 |
| 32 | `alert_escalation_steps` | Pasos de escalado progresivo (espera, acción, destino) | RF-41 |
| 33 | `notification_logs` | Registro de cada notificación enviada (canal, destinatario, resultado) | RF-38, RF-39, RF-40, RF-42, RF-43 |
| 34 | `alert_acknowledgments` | Confirmaciones de atención por parte del cuidador | RF-72 |

---

## Módulo 5 — Motor de IA y Memoria del Paciente (AURA-15)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 35 | `patient_memories` | Hechos, recuerdos, preferencias y vínculos del paciente | RF-49, RF-50, RF-68 |
| 36 | `memory_embeddings` | Vectores de embedding para RAG (pgvector) | RF-49, RF-50 |
| 37 | `cognitive_state_records` | Registros de estado cognitivo y emocional estimado | RF-51, RF-53 |
| 38 | `llm_interaction_logs` | Log de consultas al LLM (prompt, response, latencia) | RF-47, RF-48, RF-54 |

---

## Módulo 6 — Orquestación y Automatización (AURA-21) [vision]

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 39 | `workflow_executions` | Ejecuciones de flujos de n8n (workflow_id, status, resultado) | RF-55, RF-56, RF-57 |
| 40 | `orchestration_logs` | Log de eventos orquestados entre módulos | RF-58, RF-59 |
| 41 | `action_flows` | Flujos de acción configurables por el cuidador | RF-75 |

---

## Módulo 7 — Panel del Cuidador / Aurora Care (AURA-18)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 42 | `caregiver_dashboard_prefs` | Preferencias de visualización del dashboard | RF-60, RNF-30 |
| 43 | `caregiver_notification_channels` | Canales de notificación preferidos por cuidador | RF-39, RF-40 |

---

## Módulo 8 — Seguridad, Privacidad y Cumplimiento (AURA-20)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 44 | `encryption_keys_metadata` | Metadata de claves de cifrado (rotación, algoritmo, vigencia) | RF-79, RF-80 |
| 45 | `data_access_logs` | Registro de accesos a datos sensibles | RF-77 |

---

## Módulo 9 — Administración de Rutinas y Medicación (AURA-17)

| # | Tabla | Propósito | RF / Fuente |
|---|-------|-----------|-------------|
| 46 | `routines` | Rutinas diarias del paciente (nombre, descripción, tipo) | RF-82, RF-83, RF-84 |
| 47 | `routine_schedules` | Programación de cada rutina (días de la semana, hora) | RF-82 |
| 48 | `routine_compliance` | Historial de cumplimiento de rutinas | RF-90 |
| 49 | `medications` | Medicamentos y tratamientos registrados | RF-85 |
| 50 | `medication_schedules` | Horarios de medicación (dosis, hora, días, instrucciones) | RF-86, RF-87 |
| 51 | `medication_compliance` | Historial de confirmación u omisión de toma | RF-88, RF-89, RF-91 |

---

## Resumen

| Módulo | Tablas |
|--------|--------|
| M0 — Transversal | 7 |
| M1 — Interacción con el Paciente | 10 |
| M2 — Monitoreo Biométrico | 7 |
| M3 — Detección de Eventos | 5 |
| M4 — Alertas y Comunicación | 5 |
| M5 — Motor de IA | 4 |
| M6 — Orquestación [vision] | 3 |
| M7 — Panel del Cuidador | 2 |
| M8 — Seguridad | 2 |
| M9 — Rutinas y Medicación | 6 |
| **Total** | **51** |

> Pendiente de definir: tablas de Supabase Auth (manejadas por Supabase), schema de Redis para caché/colas, y schema local de SQLite en Aurora Home para modo offline.
