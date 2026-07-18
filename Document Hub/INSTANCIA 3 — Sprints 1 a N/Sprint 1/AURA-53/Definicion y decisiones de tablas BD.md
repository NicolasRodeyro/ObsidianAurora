---
base: "[[Document Hub.base]]"
Category:
  - Base de Datos
  - Sprint 1
Last updated time: 2026-07-18
---

# Definicion y decisiones de tablas BD

Documento breve de apoyo al DER de AURA-53. Resume que representa cada tabla y por que se tomaron las decisiones principales del modelo.

## Decisiones finales

1. **Cuenta DOT como raiz funcional.** `core.home_accounts` representa la cuenta del hogar. Cada cuenta DOT tiene un unico paciente y puede tener multiples cuidadores asociados.
2. **Cuidadores con cuenta propia OAuth.** Cada cuidador se autentica con una identidad externa (`auth_provider`, `auth_subject`) y luego selecciona una cuenta DOT asociada.
3. **Roles simples por asociacion.** Se conserva `primary/support` en `core.home_account_caregivers` para distinguir cuidador principal y cuidador de apoyo. No se modelan permisos granulares en el MVP.
4. **Biometria consolidada.** Se usa `biometrics.biometric_readings` con `reading_type` y `value jsonb` para evitar cinco tablas casi iguales y simplificar integraciones con wearables.
5. **Eventos con origen explicito.** Se reemplaza `source_id` polimorfico por columnas FK concretas para lecturas biometricas, estado de dispositivo, sesiones de voz y cuidador.
6. **Actividades unificadas.** Actividades cognitivas, juegos y reminiscencia viven en `voice.activities` y sus ejecuciones en `voice.activity_sessions`.
7. **Embeddings versionables.** `ai.memory_embeddings` permite varios chunks y varias versiones por modelo, sin atarse a una dimension fija antes de elegir proveedor.
8. **UUID generado por Python.** PostgreSQL almacena columnas `uuid`, pero no genera los valores con `gen_random_uuid()`.
9. **Auditoria compatible con IDs mixtos.** Logs generales guardan `record_id` como `text` porque algunas tablas tienen PK `uuid` y otras `bigint`.
10. **Integridad de drop-in.** `voice.drop_in_sessions` valida que el paciente pertenezca a la cuenta DOT y que el cuidador este asociado a esa misma cuenta.

## Definicion de tablas

### core

| Tabla | Definicion |
|---|---|
| `core.home_accounts` | Cuenta unica del hogar/DOT. Agrupa configuracion, estado y vinculacion funcional del entorno del paciente. |
| `core.patients` | Perfil del paciente asociado a una cuenta DOT. Guarda datos personales, nivel FAST y datos medicos generales. |
| `core.caregivers` | Perfil funcional del cuidador autenticado por OAuth. No guarda password local. |
| `core.home_account_caregivers` | Asociacion entre cuidador y cuenta DOT, con rol `primary/support` y estado de acceso. |
| `core.emergency_contacts` | Contactos externos para emergencias, ordenados por prioridad. |
| `core.consent_records` | Historial de consentimientos del paciente para tratamiento de datos sensibles. |
| `core.audit_logs` | Registro general de altas, bajas y modificaciones sobre datos sensibles o relevantes. |
| `core.data_retention_policies` | Politicas de retencion, borrado, archivo o anonimizacion por categoria de dato. |

### routines

| Tabla | Definicion |
|---|---|
| `routines.routines` | Rutinas diarias o terapeuticas del paciente. |
| `routines.routine_schedules` | Programacion horaria y recurrencia de una rutina. |
| `routines.routine_compliance` | Registro de cumplimiento, omision o perdida de una rutina programada. |
| `routines.medications` | Medicamentos o tratamientos registrados para el paciente. |
| `routines.medication_schedules` | Horarios, dosis y reglas de confirmacion para cada medicamento. |
| `routines.medication_compliance` | Historial de toma, omision o falta de respuesta ante medicacion programada. |

### voice

| Tabla | Definicion |
|---|---|
| `voice.interaction_sessions` | Sesiones de interaccion entre Aurora Home y el paciente. |
| `voice.interaction_messages` | Mensajes individuales de una sesion de voz o texto. |
| `voice.voice_recordings` | Referencias a archivos de audio asociados a mensajes. |
| `voice.reminders` | Recordatorios configurados para ser comunicados al paciente. |
| `voice.reminder_confirmations` | Respuestas del paciente ante recordatorios. |
| `voice.activities` | Catalogo unico de actividades cognitivas, juegos y reminiscencia. |
| `voice.activity_sessions` | Ejecuciones de actividades, resultados, metricas y referencias a recuerdos usados. |
| `voice.drop_in_sessions` | Sesiones remotas unidireccionales cuidador -> Aurora Home. |

### biometrics

| Tabla | Definicion |
|---|---|
| `biometrics.patient_devices` | Dispositivos vinculados al paciente, como Aurora Band, smartphone o gateway. |
| `biometrics.device_status_logs` | Historial operativo del dispositivo: estado, bateria y errores. |
| `biometrics.biometric_readings` | Lecturas biometricas consolidadas por tipo, valor JSON y timestamp. |

### events

| Tabla | Definicion |
|---|---|
| `events.detected_events` | Eventos de riesgo o informacion detectados por sensores, IA, sistema o cuidador. |
| `events.event_status_history` | Historial de cambios de estado de un evento. |
| `events.event_classifications` | Clasificaciones y razonamiento asociado a eventos detectados. |
| `events.detection_criteria` | Umbrales y criterios configurables para detectar riesgos. |
| `events.geofence_zones` | Zonas seguras, de hogar o restringidas para el paciente. |
| `events.geofence_exit_events` | Detalle de salidas de zonas seguras asociadas a eventos. |

### alerts

| Tabla | Definicion |
|---|---|
| `alerts.alerts` | Alertas generadas a partir de eventos o condiciones relevantes. |
| `alerts.alert_status_history` | Historial de cambios de estado de alertas. |
| `alerts.alert_rules` | Reglas configurables para decidir canales y escalamiento. |
| `alerts.alert_escalation_steps` | Pasos ordenados de escalamiento ante falta de respuesta. |
| `alerts.notification_logs` | Registro de notificaciones enviadas por canal y resultado. |
| `alerts.emergency_call_attempts` | Intentos de llamada automatica de emergencia con proveedor, destino, tiempos y estado. |
| `alerts.alert_acknowledgments` | Confirmaciones o respuestas de cuidadores ante alertas. |

### ai

| Tabla | Definicion |
|---|---|
| `ai.patient_memories` | Recuerdos, preferencias, vinculos y datos biograficos usados por el motor de IA. |
| `ai.memory_embeddings` | Embeddings versionados de recuerdos para busqueda semantica/RAG. |
| `ai.cognitive_state_records` | Estimaciones de estado cognitivo o emocional del paciente. |
| `ai.ai_decisions` | Registro auditable de decisiones tomadas o asistidas por IA. |
| `ai.llm_interaction_logs` | Log tecnico de interacciones con modelos LLM. |

### caregiver

| Tabla | Definicion |
|---|---|
| `caregiver.caregiver_dashboard_prefs` | Preferencias visuales y de refresco del panel del cuidador. |
| `caregiver.caregiver_notification_channels` | Canales de notificacion configurados por cuidador. |

### orchestration

| Tabla | Definicion |
|---|---|
| `orchestration.action_flows` | Flujos automatizables definidos para un paciente. |
| `orchestration.workflow_executions` | Ejecuciones concretas de flujos, opcionalmente disparadas por eventos. |
| `orchestration.orchestration_logs` | Logs de acciones ejecutadas por la capa de orquestacion. |

### compliance

| Tabla | Definicion |
|---|---|
| `compliance.encryption_keys_metadata` | Metadata de claves criptograficas, rotacion y vigencia. |
| `compliance.data_access_logs` | Registro de accesos o exportaciones de datos sensibles. |

## Criterio para avanzar

Esta estructura queda lista para iniciar desarrollo backend: modelos, migraciones, serializers y endpoints base. Las decisiones pendientes no bloqueantes son proveedor final de embeddings, estrategia de cache/colas con Redis y modelo local offline de Aurora Home.

