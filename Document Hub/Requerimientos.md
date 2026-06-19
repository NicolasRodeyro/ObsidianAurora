---
base: "[[Document Hub.base]]"
Created time: 2026-05-03T21:16:00
Last edited by: Haik Kilic
Created by: Mateo Romero Plaza
Category:
  - Análisis
Last updated time: 2026-05-04T19:05:00
---
---

## 1. Módulo de Interacción con el Paciente

### Requerimientos funcionales

- Iniciar interacciones vocales proactivas según horario, inactividad o estado estimado del paciente.
- Capturar audio del paciente durante una interacción.
- Transcribir la voz del paciente a texto.
- Generar respuestas conversacionales adaptadas al contexto del paciente.
- Reproducir respuestas mediante audio.
- Emitir recordatorios de alimentación, descanso e higiene.
- Emitir recordatorios de medicación y tratamientos configurados.
- Registrar confirmación de cumplimiento de medicación o rutina cuando el paciente responda.
- Emitir recuerdos personalizados mediante terapia de reminiscencia digital.
- Proponer actividades de estimulación cognitiva según perfil del paciente.
- Iniciar actividad de estimulación cognitiva según perfil del paciente.
- Proponer juegos o actividades recreativas simples según preferencias del paciente.
- Iniciar juegos o actividades recreativas simples según preferencias del paciente.
- Actualizar el contenido de la interacción según historial, estado estimado y preferencias del paciente.

### Requerimientos no funcionales

- Usar mensajes breves, claros y comprensibles para adultos mayores.
- Evitar tonos condescendientes o infantilizantes en las respuestas.
- Incorporar pausas suficientes entre preguntas o indicaciones.
- Limitar la frecuencia de interacciones proactivas para evitar ansiedad o confusión.
- Mantener tiempos de respuesta adecuados durante conversaciones.
- Reproducir audio con volumen y claridad suficientes para un entorno hogareño.

---

## 2. Módulo de Monitoreo Biométrico — Pulsera IoT

### Requerimientos funcionales

- Registrar frecuencia cardíaca mediante sensor PPG.
- Registrar movimiento mediante acelerómetro y giroscopio.
- Registrar ubicación del paciente mediante GPS.
- Registrar temperatura corporal mediante sensor “x”.
- Registrar actividad electrodérmica mediante sensor “x”.
- Informar pérdida de conexión de la pulsera.
- Informar ausencia prolongada de datos biométricos.
- Consultar estado operativo de la pulsera.
- Consultar nivel de batería de la pulsera.

### Requerimientos no funcionales

- Mantener bajo consumo energético durante el monitoreo continuo.
- Proteger la transmisión de datos entre la pulsera y el sistema principal.

---

## 3. Módulo de Detección y Eventos

### Requerimientos funcionales

- Registrar posibles caídas a partir de datos de movimiento.
- Registrar patrones de deambulación errática.
- Registrar posibles estados de agitación mediante biometría y comportamiento.
- Detectar salida del paciente de una zona segura.
- Generar eventos ante situaciones de riesgo.
- Registrar fecha, hora, tipo y datos asociados de cada evento.
- Modificar datos de evento.
- Eliminar evento.
- Clasificar eventos como informativos, preventivos o críticos.
- Enviar eventos relevantes al módulo de alertas.
- Registar criterios de detección.
- Modificar critesrios de detección.

### Requerimientos no funcionales

- Minimizar falsos positivos en detección de eventos.
- Procesar eventos críticos con baja latencia.
- Mantener trazabilidad de eventos detectados.
- Permitir ajuste de sensibilidad de detección.
- Operar de forma continua mientras los dispositivos estén activos.
- Diferenciar eventos reales de movimientos cotidianos esperables.

---

## 4. Módulo de Alertas y Comunicación

### Requerimientos funcionales

- Generar alertas a partir de eventos relevantes.
- Clasificar alertas según nivel de gravedad.
- Notificar al cuidador ante eventos preventivos o críticos.
- Enviar notificaciones mediante aplicación móvil.
- Enviar notificaciones mediante WhatsApp, Telegram u otro canal integrado.
- Escalar alertas graves cuando no exista respuesta del cuidador.
- Ejecutar llamada automática de emergencia ante eventos críticos.
- Registrar fecha, hora, canal y destinatario de cada alerta enviada.
- Registrar estado de cada alerta: generada, enviada, atendida o cerrada.
- Configurar reglas de notificación por tipo de evento.
- Notificar salida del paciente de una zona segura.

### Requerimientos no funcionales

- Priorizar el envío de alertas críticas.
- Evitar duplicación innecesaria de alertas.
- Redactar mensajes de alerta claros y accionables.
- Proteger datos sensibles.
- Mantener disponibilidad del servicio de alertas ante eventos urgentes.

---

## 5. Módulo de Motor de Inteligencia Artificial

### Requerimientos funcionales

- Interpretar texto transcripto durante interacciones con el paciente.
- Generar respuestas contextualizadas según perfil, historial y estado estimado.
- Recuperar recuerdos, rutinas, preferencias y vínculos familiares desde la memoria del paciente.
- Incorporar nueva información relevante a la memoria del paciente.
- Detectar estado cognitivo o emocional estimado a partir de voz, biometría e historial, asociadas a confusión, angustia o desorientación.
- Adaptar actividades cognitivas según desempeño previo del paciente.
- Adaptar respuestas según estado emocional o cognitivo estimado.
- Asistir en la clasificación de eventos cuando se requiera contexto adicional.

### Requerimientos no funcionales

- Generar respuestas coherentes con la información disponible del paciente.
- Evitar indicaciones médicas no validadas.
- Reducir respuestas fuera de contexto mediante recuperación de información personalizada.
- Mantener baja latencia en interacciones conversacionales.
- Permitir auditoría de decisiones relevantes tomadas por IA.
- Proteger datos personales utilizados por el motor de IA.

---

## 6. Módulo de Orquestación y Automatización

### Requerimientos funcionales

- Ejecutar flujos automáticos ante eventos detectados.
- Ejecutar recordatorios según horarios y rutinas configuradas.
- Ejecutar alertas según reglas definidas.
- Registrar eventos generados por sensores, IA, interacción vocal y cuidador.
- Registrar datos provenientes de pulsera, dispositivo del hogar, IA e interfaz del cuidador.

### Requerimientos no funcionales

- Registrar trazabilidad de flujos ejecutados.
- Evitar acciones repetidas o contradictorias.
- Responder ante fallas parciales sin detener todo el sistema.
- Registrar errores técnicos para diagnóstico.

---

## 7. Módulo del Cuidador

### Requerimientos funcionales

- Visualizar estado actual del paciente.
- Visualizar datos biométricos recientes.
- Visualizar ubicación actual o última ubicación registrada del paciente.
- Visualizar historial de eventos.
- Visualizar alertas activas e históricas.
- Configurar rutinas diarias del paciente.
- ABMC horarios de medicación y tratamientos.
- ABMC reglas y niveles de alerta.
- ABMC datos personales, preferencias y recuerdos del paciente.
- ABMC contactos de emergencia.
- ABMC zonas seguras para el paciente.
- Consultar estado de dispositivos conectados.
- Registrar confirmación de atención de una alerta.
- Iniciar comunicación directa con el paciente IN-DROP. 
- ABMC información del perfil del paciente.
- ABMC nuevos flujos de acción ante eventos.

### Requerimientos no funcionales

- Presentar información crítica con prioridad visual.
- Organizar la información en pantallas simples y comprensibles.
- Actualizar información en tiempos adecuados para seguimiento doméstico.
- Evitar sobrecarga visual de datos no prioritarios.

---

## 8. Módulo de Seguridad, Privacidad y Datos

### Requerimientos funcionales

- Autenticar cuidadores autorizados.
- Gestionar permisos de acceso a la información del paciente.
- Registrar modificaciones de datos personales, rutinas, alertas y zonas seguras.
- Cifrar datos sensibles almacenados.
- Cifrar comunicaciones entre dispositivos y servicios.
- Gestionar consentimiento para el tratamiento de datos sensibles.

### Requerimientos no funcionales

- Cumplir criterios básicos de confidencialidad, integridad y disponibilidad.
- Evitar exposición de datos personales en notificaciones innecesarias.
- Priorizar almacenamiento seguro de datos biométricos y de ubicación.
- Mantener separación entre datos clínicos, datos operativos y datos de configuración.
- Recuperar información crítica ante fallas.

---

## 9. Módulo de Administración de Rutinas y Medicación

### Requerimientos funcionales

- Registrar rutinas diarias del paciente.
- Modificar rutinas existentes.
- Eliminar rutinas configuradas.
- Registrar medicamentos y tratamientos.
- Configurar horarios de medicación.
- Modificar horarios de medicación.
- Registrar confirmación de toma de medicación.
- Registrar omisión de medicación cuando no exista confirmación.
- Visualizar historial de cumplimiento de rutinas.
- Visualizar historial de cumplimiento de medicación.

### Requerimientos no funcionales

- Presentar horarios de forma clara y ordenada.
- Evitar configuraciones ambiguas de medicación.
- Validar datos mínimos antes de guardar una rutina o tratamiento.
- Mantener consistencia entre recordatorios, alertas e historial.
- Proteger información relacionada con tratamientos del paciente.

---

## **Tabla de requerimientos funcionales**

| ID | Módulo | Requerimiento funcional | Dificultad |
| --- | --- | --- | --- |
| RF-01 | Interacción con el Paciente | Iniciar interacciones vocales proactivas según horario, inactividad o estado estimado del paciente. | Alta |
| RF-02 | Interacción con el Paciente | Capturar audio del paciente durante una interacción. | Media |
| RF-03 | Interacción con el Paciente | Transcribir la voz del paciente a texto. | Alta |
| RF-04 | Interacción con el Paciente | Generar respuestas conversacionales adaptadas al contexto del paciente. | Alta |
| RF-05 | Interacción con el Paciente | Reproducir respuestas mediante audio. | Media |
| RF-06 | Interacción con el Paciente | Emitir recordatorios de alimentación, descanso e higiene. | Baja |
| RF-07 | Interacción con el Paciente | Emitir recordatorios de medicación y tratamientos configurados. | Media |
| RF-08 | Interacción con el Paciente | Registrar confirmación de cumplimiento de medicación o rutina cuando el paciente responda. | Media |
| RF-09 | Interacción con el Paciente | Emitir recuerdos personalizados mediante terapia de reminiscencia digital. | Alta |
| RF-10 | Interacción con el Paciente | Proponer actividades de estimulación cognitiva según perfil del paciente. | Media |
| RF-11 | Interacción con el Paciente | Iniciar actividad de estimulación cognitiva según perfil del paciente. | Media |
| RF-12 | Interacción con el Paciente | Proponer juegos o actividades recreativas simples según preferencias del paciente. | Media |
| RF-13 | Interacción con el Paciente | Iniciar juegos o actividades recreativas simples según preferencias del paciente. | Media |
| RF-14 | Interacción con el Paciente | Actualizar el contenido de la interacción según historial, estado estimado y preferencias del paciente. | Alta |
| RF-15 | Monitoreo Biométrico — Pulsera IoT | Registrar frecuencia cardíaca mediante sensor PPG. | Alta |
| RF-16 | Monitoreo Biométrico — Pulsera IoT | Registrar movimiento mediante acelerómetro y giroscopio. | Alta |
| RF-17 | Monitoreo Biométrico — Pulsera IoT | Registrar ubicación del paciente mediante GPS. | Alta |
| RF-18 | Monitoreo Biométrico — Pulsera IoT | Registrar temperatura corporal mediante sensor compatible. | Media |
| RF-19 | Monitoreo Biométrico — Pulsera IoT | Registrar actividad electrodérmica mediante sensor compatible. | Alta |
| RF-20 | Monitoreo Biométrico — Pulsera IoT | Informar pérdida de conexión de la pulsera. | Media |
| RF-21 | Monitoreo Biométrico — Pulsera IoT | Informar ausencia prolongada de datos biométricos. | Media |
| RF-22 | Monitoreo Biométrico — Pulsera IoT | Consultar estado operativo de la pulsera. | Media |
| RF-23 | Monitoreo Biométrico — Pulsera IoT | Consultar nivel de batería de la pulsera. | Media |
| RF-24 | Detección y Eventos | Registrar posibles caídas a partir de datos de movimiento. | Alta |
| RF-25 | Detección y Eventos | Registrar patrones de deambulación errática. | Alta |
| RF-26 | Detección y Eventos | Registrar posibles estados de agitación mediante biometría y comportamiento. | Muy alta |
| RF-27 | Detección y Eventos | Detectar salida del paciente de una zona segura. | Alta |
| RF-28 | Detección y Eventos | Generar eventos ante situaciones de riesgo. | Media |
| RF-29 | Detección y Eventos | Registrar fecha, hora, tipo y datos asociados de cada evento. | Baja |
| RF-30 | Detección y Eventos | Modificar datos de evento. | Baja |
| RF-31 | Detección y Eventos | Eliminar evento. | Baja |
| RF-32 | Detección y Eventos | Clasificar eventos como informativos, preventivos o críticos. | Media |
| RF-33 | Detección y Eventos | Enviar eventos relevantes al módulo de alertas. | Media |
| RF-34 | Detección y Eventos | Registrar criterios de detección. | Media |
| RF-35 | Detección y Eventos | Modificar criterios de detección. | Media |
| RF-36 | Alertas y Comunicación | Generar alertas a partir de eventos relevantes. | Media |
| RF-37 | Alertas y Comunicación | Clasificar alertas según nivel de gravedad. | Media |
| RF-38 | Alertas y Comunicación | Notificar al cuidador ante eventos preventivos o críticos. | Alta |
| RF-39 | Alertas y Comunicación | Enviar notificaciones mediante aplicación móvil. | Alta |
| RF-40 | Alertas y Comunicación | Enviar notificaciones mediante WhatsApp, Telegram u otro canal integrado. | Alta |
| RF-41 | Alertas y Comunicación | Escalar alertas graves cuando no exista respuesta del cuidador. | Alta |
| RF-42 | Alertas y Comunicación | Ejecutar llamada automática de emergencia ante eventos críticos. | Muy alta |
| RF-43 | Alertas y Comunicación | Registrar fecha, hora, canal y destinatario de cada alerta enviada. | Baja |
| RF-44 | Alertas y Comunicación | Registrar estado de cada alerta: generada, enviada, atendida o cerrada. | Baja |
| RF-45 | Alertas y Comunicación | Configurar reglas de notificación por tipo de evento. | Media |
| RF-46 | Alertas y Comunicación | Notificar salida del paciente de una zona segura. | Alta |
| RF-47 | Motor de Inteligencia Artificial | Interpretar texto transcripto durante interacciones con el paciente. | Alta |
| RF-48 | Motor de Inteligencia Artificial | Generar respuestas contextualizadas según perfil, historial y estado estimado. | Alta |
| RF-49 | Motor de Inteligencia Artificial | Recuperar recuerdos, rutinas, preferencias y vínculos familiares desde la memoria del paciente. | Alta |
| RF-50 | Motor de Inteligencia Artificial | Incorporar nueva información relevante a la memoria del paciente. | Alta |
| RF-51 | Motor de Inteligencia Artificial | Detectar estado cognitivo o emocional estimado a partir de voz, biometría e historial, asociadas a confusión, angustia o desorientación. | Muy alta |
| RF-52 | Motor de Inteligencia Artificial | Adaptar actividades cognitivas según desempeño previo del paciente. | Alta |
| RF-53 | Motor de Inteligencia Artificial | Adaptar respuestas según estado emocional o cognitivo estimado. | Alta |
| RF-54 | Motor de Inteligencia Artificial | Asistir en la clasificación de eventos cuando se requiera contexto adicional. | Alta |
| RF-55 | Orquestación y Automatización | Ejecutar flujos automáticos ante eventos detectados. | Alta |
| RF-56 | Orquestación y Automatización | Ejecutar recordatorios según horarios y rutinas configuradas. | Media |
| RF-57 | Orquestación y Automatización | Ejecutar alertas según reglas definidas. | Alta |
| RF-58 | Orquestación y Automatización | Registrar eventos generados por sensores, IA, interacción vocal y cuidador. | Media |
| RF-59 | Orquestación y Automatización | Registrar datos provenientes de pulsera, dispositivo del hogar, IA e interfaz del cuidador. | Alta |
| RF-60 | Cuidador | Visualizar estado actual del paciente. | Media |
| RF-61 | Cuidador | Visualizar datos biométricos recientes. | Media |
| RF-62 | Cuidador | Visualizar ubicación actual o última ubicación registrada del paciente. | Media |
| RF-63 | Cuidador | Visualizar historial de eventos. | Baja |
| RF-64 | Cuidador | Visualizar alertas activas e históricas. | Baja |
| RF-65 | Cuidador | Configurar rutinas diarias del paciente. | Baja |
| RF-66 | Cuidador | ABMC horarios de medicación y tratamientos. | Media |
| RF-67 | Cuidador | ABMC reglas y niveles de alerta. | Media |
| RF-68 | Cuidador | ABMC datos personales, preferencias y recuerdos del paciente. | Media |
| RF-69 | Cuidador | ABMC contactos de emergencia. | Baja |
| RF-70 | Cuidador | ABMC zonas seguras para el paciente. | Media |
| RF-71 | Cuidador | Consultar estado de dispositivos conectados. | Media |
| RF-72 | Cuidador | Registrar confirmación de atención de una alerta. | Baja |
| RF-73 | Cuidador | Iniciar comunicación directa con el paciente IN-DROP. | Alta |
| RF-74 | Cuidador | ABMC información del perfil del paciente. | Media |
| RF-75 | Cuidador | ABMC nuevos flujos de acción ante eventos. | Alta |
| RF-76 | Seguridad, Privacidad y Datos | Autenticar cuidadores autorizados. | Media |
| RF-77 | Seguridad, Privacidad y Datos | Gestionar permisos de acceso a la información del paciente. | Media |
| RF-78 | Seguridad, Privacidad y Datos | Registrar modificaciones de datos personales, rutinas, alertas y zonas seguras. | Media |
| RF-79 | Seguridad, Privacidad y Datos | Cifrar datos sensibles almacenados. | Alta |
| RF-80 | Seguridad, Privacidad y Datos | Cifrar comunicaciones entre dispositivos y servicios. | Alta |
| RF-81 | Seguridad, Privacidad y Datos | Gestionar consentimiento para el tratamiento de datos sensibles. | Media |
| RF-82 | Administración de Rutinas y Medicación | Registrar rutinas diarias del paciente. | Baja |
| RF-83 | Administración de Rutinas y Medicación | Modificar rutinas existentes. | Baja |
| RF-84 | Administración de Rutinas y Medicación | Eliminar rutinas configuradas. | Baja |
| RF-85 | Administración de Rutinas y Medicación | Registrar medicamentos y tratamientos. | Media |
| RF-86 | Administración de Rutinas y Medicación | Configurar horarios de medicación. | Media |
| RF-87 | Administración de Rutinas y Medicación | Modificar horarios de medicación. | Media |
| RF-88 | Administración de Rutinas y Medicación | Registrar confirmación de toma de medicación. | Media |
| RF-89 | Administración de Rutinas y Medicación | Registrar omisión de medicación cuando no exista confirmación. | Media |
| RF-90 | Administración de Rutinas y Medicación | Visualizar historial de cumplimiento de rutinas. | Baja |
| RF-91 | Administración de Rutinas y Medicación | Visualizar historial de cumplimiento de medicación. | Baja |

## **Tabla de requerimientos no funcionales**

| ID | Módulo | Requerimiento no funcional | Dificultad |
| --- | --- | --- | --- |
| RNF-01 | Interacción con el Paciente | Usar mensajes breves, claros y comprensibles para adultos mayores. | Media |
| RNF-02 | Interacción con el Paciente | Evitar tonos condescendientes o infantilizantes en las respuestas. | Media |
| RNF-03 | Interacción con el Paciente | Incorporar pausas suficientes entre preguntas o indicaciones. | Media |
| RNF-04 | Interacción con el Paciente | Limitar la frecuencia de interacciones proactivas para evitar ansiedad o confusión. | Media |
| RNF-05 | Interacción con el Paciente | Mantener tiempos de respuesta adecuados durante conversaciones. | Alta |
| RNF-06 | Interacción con el Paciente | Reproducir audio con volumen y claridad suficientes para un entorno hogareño. | Media |
| RNF-07 | Monitoreo Biométrico — Pulsera IoT | Mantener bajo consumo energético durante el monitoreo continuo. | Alta |
| RNF-08 | Monitoreo Biométrico — Pulsera IoT | Proteger la transmisión de datos entre la pulsera y el sistema principal. | Alta |
| RNF-09 | Detección y Eventos | Minimizar falsos positivos en detección de eventos. | Muy alta |
| RNF-10 | Detección y Eventos | Procesar eventos críticos con baja latencia. | Alta |
| RNF-11 | Detección y Eventos | Mantener trazabilidad de eventos detectados. | Media |
| RNF-12 | Detección y Eventos | Permitir ajuste de sensibilidad de detección. | Media |
| RNF-13 | Detección y Eventos | Operar de forma continua mientras los dispositivos estén activos. | Alta |
| RNF-14 | Detección y Eventos | Diferenciar eventos reales de movimientos cotidianos esperables. | Muy alta |
| RNF-15 | Alertas y Comunicación | Priorizar el envío de alertas críticas. | Alta |
| RNF-16 | Alertas y Comunicación | Evitar duplicación innecesaria de alertas. | Media |
| RNF-17 | Alertas y Comunicación | Redactar mensajes de alerta claros y accionables. | Baja |
| RNF-18 | Alertas y Comunicación | Proteger datos sensibles. | Alta |
| RNF-19 | Alertas y Comunicación | Mantener disponibilidad del servicio de alertas ante eventos urgentes. | Alta |
| RNF-20 | Motor de Inteligencia Artificial | Generar respuestas coherentes con la información disponible del paciente. | Alta |
| RNF-21 | Motor de Inteligencia Artificial | Evitar indicaciones médicas no validadas. | Muy alta |
| RNF-22 | Motor de Inteligencia Artificial | Reducir respuestas fuera de contexto mediante recuperación de información personalizada. | Alta |
| RNF-23 | Motor de Inteligencia Artificial | Mantener baja latencia en interacciones conversacionales. | Alta |
| RNF-24 | Motor de Inteligencia Artificial | Permitir auditoría de decisiones relevantes tomadas por IA. | Alta |
| RNF-25 | Motor de Inteligencia Artificial | Proteger datos personales utilizados por el motor de IA. | Alta |
| RNF-26 | Orquestación y Automatización | Registrar trazabilidad de flujos ejecutados. | Media |
| RNF-27 | Orquestación y Automatización | Evitar acciones repetidas o contradictorias. | Alta |
| RNF-28 | Orquestación y Automatización | Responder ante fallas parciales sin detener todo el sistema. | Alta |
| RNF-29 | Orquestación y Automatización | Registrar errores técnicos para diagnóstico. | Media |
| RNF-30 | Cuidador | Presentar información crítica con prioridad visual. | Media |
| RNF-31 | Cuidador | Organizar la información en pantallas simples y comprensibles. | Media |
| RNF-32 | Cuidador | Actualizar información en tiempos adecuados para seguimiento doméstico. | Media |
| RNF-33 | Cuidador | Evitar sobrecarga visual de datos no prioritarios. | Media |
| RNF-34 | Seguridad, Privacidad y Datos | Cumplir criterios básicos de confidencialidad, integridad y disponibilidad. | Alta |
| RNF-35 | Seguridad, Privacidad y Datos | Evitar exposición de datos personales en notificaciones innecesarias. | Media |
| RNF-36 | Seguridad, Privacidad y Datos | Priorizar almacenamiento seguro de datos biométricos y de ubicación. | Alta |
| RNF-37 | Seguridad, Privacidad y Datos | Mantener separación entre datos clínicos, datos operativos y datos de configuración. | Media |
| RNF-38 | Seguridad, Privacidad y Datos | Recuperar información crítica ante fallas. | Alta |
| RNF-39 | Administración de Rutinas y Medicación | Presentar horarios de forma clara y ordenada. | Baja |
| RNF-40 | Administración de Rutinas y Medicación | Evitar configuraciones ambiguas de medicación. | Media |
| RNF-41 | Administración de Rutinas y Medicación | Validar datos mínimos antes de guardar una rutina o tratamiento. | Baja |
| RNF-42 | Administración de Rutinas y Medicación | Mantener consistencia entre recordatorios, alertas e historial. | Media |
| RNF-43 | Administración de Rutinas y Medicación | Proteger información relacionada con tratamientos del paciente. | Alta |

## Documentos relacionados
- [[Funcionalidades del Sistema en el Hogar]]
- [[Trazabilidad RF-Épicas]]
- [[Arquitectura y Stack Tecnológico]]
- [[Product Backlog Inicial]]
- [[Índice Aurora]]
