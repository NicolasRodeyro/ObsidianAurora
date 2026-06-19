---
base: "[[Document Hub.base]]"
Created time: 2026-04-18T13:08:00
Last edited by: Mateo Romero Plaza
Created by: Mateo Romero Plaza
Category:
  - Documentación Interna
Last updated time: 2026-04-25T16:26:00
---
> [!note]+ # MÓDULO: Interacción con el Paciente
> > [!note]+ ### 🧩 Interacción vocal proactiva
> > **Descripción: **El sistema inicia interacciones conversacionales de forma autónoma en función del contexto del paciente (hora del día, nivel de actividad, estado inferido), sin requerir comandos explícitos.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Hora, datos biométricos, nivel de actividad
> > 
> > **Outputs:** Mensaje de voz
> > 
> > **Dependencias:** 
> > 
> > - Motor de IA (LLM)
> > - Sistema de TTS
> > - Inferencia de estado
> 
> ---
> 
> > [!note]+ ### 🧩 Reconocimiento de voz (STT)
> > **Descripción:** Convierte la voz del paciente en texto para su procesamiento.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Audio del paciente
> > 
> > **Outputs:** Texto transcripto
> > 
> > **Dependencias:** Motor STT
> 
> ---
> 
> > [!note]+ ### 🧩 Síntesis de voz (TTS)
> > **Descripción:** Genera respuestas en audio a partir de texto.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Texto generado
> > 
> > **Outputs:** Audio reproducible
> > 
> > **Dependencias:** Motor TTS
> 
> ---
> 
> > [!note]+ ### 🧩 Terapia de reminiscencia digital
> > **Descripción:** Recupera y presenta recuerdos personalizados del paciente con el objetivo de orientar, calmar o estimular cognitivamente mediante narrativas significativas.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Estado del paciente, base de recuerdos (biografía, vínculos, eventos)
> > 
> > **Outputs:** Narrativa personalizada
> > 
> > **Dependencias:** Base de datos + RAG + IA
> 
> ---
> 
> > [!note]+ ### 🧩 Generación de respuestas contextualizadas
> > **Descripción:** Genera respuestas dinámicas adaptadas al contexto, historial y perfil del paciente durante interacciones conversacionales.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** 
> > 
> > - Texto transcripto
> > - Contexto conversacional
> > - Memoria del paciente
> > 
> > **Outputs:** Respuesta generada
> > 
> > **Dependencias:** LLM + RAG + STT
> 
> ---
> 
> > [!note]+ ### 🧩 Recordatorios de cuidados básicos
> > **Descripción:** Genera recordatorios automáticos relacionados con rutinas esenciales del paciente, como alimentación, descanso o higiene, según reglas configuradas.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** 
> > 
> > - Horarios configurados
> > - Rutinas del paciente
> > - Contexto temporal
> > 
> > **Outputs:** Respuesta generada de audio
> > 
> > **Dependencias:** N8n + TTS + Configuración del cuidador
> 
> ---
> 
> > [!note]+ ### 🧩 Recordatorios de medicación y tratamientos
> > **Descripción:** Emite recordatorios programados para la toma de medicamentos o realización de tratamientos, pudiendo registrar cumplimiento o generar alertas ante omisiones.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** 
> > 
> > - Horarios de medicación
> > - Configuración del tratamiento
> > - Confirmación (opcional) del paciente
> > 
> > **Outputs:** 
> > 
> > - Recordatorio por voz
> > - Registro de cumplimiento
> > - Alerta en caso de omisión
> > 
> > **Dependencias:** N8n + Alertas + Configuración
> 
> ---
> 
> > [!note]+ ### 🧩 Terapia de estimulación cognitiva
> > **Descripción:** Ofrece actividades diseñadas para estimular funciones cognitivas como memoria, atención, lenguaje, orientación y razonamiento, adaptadas al perfil del paciente.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** 
> > 
> > - Perfil del paciente
> > - Nivel cognitivo estimado
> > - Historial de interacciones
> > 
> > **Outputs:** 
> > 
> > - Actividades cognitivas
> > - Respuestas del paciente
> > - Métricas de desempeño
> > 
> > **Dependencias:**  LLM + RAG
> 
> ---
> 
> > [!note]+ ### 🧩 Terapia recreativa basada en juegos
> > **Descripción:** Propone actividades lúdicas y recreativas orientadas a estimular capacidades cognitivas, emocionales y sociales, promoviendo la participación activa y reduciendo la apatía.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** 
> > 
> > - Perfil del paciente
> > - Preferencias
> > - Estado emocional estimado
> > 
> > **Outputs:** 
> > 
> > - Actividad recreativa
> > - Interacción del paciente
> > - Métricas de participación
> > 
> > **Dependencias:**  LLM + RAG

---

> [!note]+ # MÓDULO: Monitoreo Biométrico (Pulsera IoT)
> > [!note]+ ### 🧩 Monitoreo de frecuencia cardíaca
> > **Descripción:** Registra la frecuencia cardíaca en tiempo real mediante sensor PPG.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Señal PPG
> > 
> > **Outputs:** Frecuencia cardíaca BPM
> > 
> > **Dependencias:** Hardware pulsera
> 
> ---
> 
> > [!note]+ ### 🧩 Medición de temperatura corporal
> > **Descripción:** Registra cambios en la temperatura corporal del paciente. *Esto es opcional, dependiendo del tipo de pulsera que consigamos*.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Sensor térmico
> > 
> > **Outputs:** Temperatura
> > 
> > **Dependencias:** Hardware pulsera
> 
> ---
> 
> > [!note]+ ### 🧩 Detección de actividad electrodérmica
> > **Descripción:** Mide niveles de estrés o agitación mediante EDA. Registra la actividad electrodérmica para inferir niveles de estrés o activación fisiológica.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Señal EDA
> > 
> > **Outputs:** Nivel de activación
> > 
> > **Dependencias:** Sensores
> 
> ---
> 
> > [!note]+ ### 🧩 Geolocalización del paciente
> > **Descripción:** Obtiene la ubicación geográfica del paciente en tiempo real.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** GPS
> > 
> > **Outputs:** Coordenadas
> > 
> > **Dependencias:** GPS

---

> [!note]+ # MÓDULO: Detección y Eventos
> > [!note]+ ### 🧩 Detección de caídas
> > **Descripción:** Detecta caídas mediante análisis de movimiento.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Datos IMU
> > 
> > **Outputs:** Evento de caída
> > 
> > **Dependencias:** Pulsera + Algoritmos de detección de caidas
> 
> ---
> 
> > [!note]+ ### 🧩 Detección de deambulación errática
> > **Descripción:** Identifica patrones anormales de desplazamiento que pueden indicar desorientación (mental) o riesgo.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** GPS + movimiento
> > 
> > **Outputs:** Evento de riesgo
> > 
> > **Dependencias:** Algoritmos de análisis
> 
> ---
> 
> > [!note]+ ### 🧩 Detección de estados de agitación
> > **Descripción:** Identifica estados de agitación o estrés mediante análisis de biometría y comportamiento.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** HR, EDA, temperatura
> > 
> > **Outputs:** Nivel de agitación
> > 
> > **Dependencias:** IA + sensores
> 
> ---
> 
> > [!note]+ ### 🧩 Geocercas dinámicas y salida de zona segura
> > **Descripción:** Define zonas seguras adaptativas y detecta cuando el paciente se desplaza fuera de ellas.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Ubicación, movimiento
> > 
> > **Outputs:** Evento de salida de zona segura
> > 
> > **Dependencias: **GPS + IA

---

> [!note]+ # MÓDULO: Alertas y Comunicación
> > [!note]+ ### 🧩 Generación de alertas
> > **Descripción:** Crea alertas del sistema ante la detección de eventos relevantes.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Evento
> > 
> > **Outputs:** Alerta
> > 
> > **Dependencias:** Motor de reglas
> 
> ---
> 
> > [!note]+ ### 🧩 Clasificación de alertas
> > **Descripción:** DDetermina el nivel de gravedad de cada alerta en función del contexto.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Evento + contexto
> > 
> > **Outputs:** Nivel de urgencia
> > 
> > **Dependencias:** Reglas + IA
> 
> ---
> 
> > [!note]+ ### 🧩 Escalamiento automático de alertas
> > **Descripción:** Define y ejecuta acciones progresivas según el nivel de gravedad de la alerta.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Nivel de alerta
> > 
> > **Outputs:** Acción ejecutada (mensaje, llamada, etc.)
> > 
> > **Dependencias:** Orquestador
> 
> ---
> 
> > [!note]+ ### 🧩 Envío de notificaciones
> > **Descripción:** Envía notificaciones a cuidadores mediante la aplicación.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Evento
> > 
> > **Outputs:** Mensaje (WhatsApp/Notificación Push/Etc.)
> > 
> > **Dependencias:** APIs externas
> 
> ---
> 
> > [!note]+ ### 🧩 Llamada automática de emergencia
> > **Descripción:** Realiza llamadas SOS automáticas ante eventos críticos.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Evento crítico
> > 
> > **Outputs:** Llamada
> > 
> > **Dependencias:** API telefonía

---

> [!note]+ # MÓDULO: Motor de Inteligencia Artificial
> > [!note]+ ### 🧩 Gestión de memoria del paciente (RAG)
> > **Descripción:** Almacena y recupera información contextual del paciente para personalizar interacciones.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Datos del paciente
> > 
> > **Outputs:** Contexto recuperado
> > 
> > **Dependencias:** DB vectorial
> 
> ---
> 
> > [!note]+ ### 🧩 Inferencia de estado del paciente
> > **Descripción:** Determina el estado cognitivo y emocional del paciente mediante análisis multimodal.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Voz + biometría
> > 
> > **Outputs:** Estado estimado del paciente
> > 
> > **Dependencias:** IA
> 
> ---
> 
> > [!note]+ ### 🧩 Adaptación dinámica de respuestas y contenidos
> > **Descripción:** Ajusta el comportamiento del sistema y los contenidos presentados según el perfil y estado del paciente.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Historial + Estado
> > 
> > **Outputs:** Respuesta adaptada
> > 
> > **Dependencias:** IA + RAG

---

> [!note]+ # MÓDULO: Orquestación y Automatización (n8n)
> > [!note]+ ### 🧩 Automatización de acciones basadas en eventos
> > **Descripción:**** **Ejecuta flujos automáticos en respuesta a eventos del sistema.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Eventos
> > 
> > **Outputs:** Acciones
> > 
> > **Dependencias:** n8n
> 
> ---
> 
> > [!note]+ ### 🧩 Integración y coordinación entre módulos
> > **Descripción:** Gestiona la interacción y flujo de datos entre los distintos módulos del sistema.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Datos de múltiples módulos
> > 
> > **Outputs:** Acciones coordinadas
> > 
> > **Dependencias:** Orquestador
> 
> ---
> 
> > [!note]+ ### 🧩 Registro de eventos
> > **Descripción:** Almacena eventos del paciente relevantes para trazabilidad y análisis.
> > 
> > **Actor:** Sistema
> > 
> > **Inputs:** Eventos
> > 
> > **Outputs:** Logs
> > 
> > **Dependencias:** Base de datos

---

> [!note]+ # MÓDULO: Cuidador
> > [!note]+ ### 🧩 Visualización del estado del paciente
> > **Descripción:** Permite al cuidador consultar el estado actual del paciente en tiempo real.
> > 
> > **Actor:** Cuidador
> > 
> > **Inputs:** Datos del sistema
> > 
> > **Outputs:** Vista del estado
> > 
> > **Dependencias:** Sistema
> 
> ---
> 
> > [!note]+ ### 🧩 Historial de eventos
> > **Descripción:** Permite acceder a eventos históricos del paciente.
> > 
> > **Actor:** Cuidador
> > 
> > **Inputs:** Logs
> > 
> > **Outputs:** Historial
> > 
> > **Dependencias:** Base de datos
> 
> ---
> 
> > [!note]+ ### 🧩 Configuración de alertas
> > **Descripción:** Permite definir reglas de notificación y niveles de alerta.
> > 
> > **Actor:** Cuidador
> > 
> > **Inputs:** Preferencias
> > 
> > **Outputs:** Configuración
> > 
> > **Dependencias:** Sistema de reglas
> 
> ---
> 
> > [!note]+ ### 🧩 Gestión de rutinas
> > **Descripción:** Permite definir y administrar rutinas del paciente.
> > 
> > **Actor:** Cuidador
> > 
> > **Inputs:** Configuración
> > 
> > **Outputs:** Rutinas activas
> > 
> > **Dependencias:** Orquestador
> 
> ---
> 
> > [!note]+ ### 🧩 Comunicación Drop In del cuidador
> > **Descripción:** Permite iniciar comunicación directa con el paciente en cualquier momento desde la interfaz del cuidador.
> > 
> > **Actor:** Cuidador
> > 
> > **Inputs:** Acción del cuidador desde la interfaz y Canal de comunicación
> > 
> > **Outputs:** Comunicación de voz o mensaje hacia el paciente
> > 
> > **Dependencias:** 
> > 
> > - Módulo de Interacción con el Paciente
> > - Sistema de audio (entrada/salida)
> > - Conectividad (WiFi/Bluetooth)

---


## Documentos relacionados
- [[Requerimientos]]
- [[Arquitectura y Stack Tecnológico]]
- [[Índice Aurora]]
