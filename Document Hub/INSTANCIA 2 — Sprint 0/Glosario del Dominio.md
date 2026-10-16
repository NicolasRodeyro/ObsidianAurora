---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-16
---

# Glosario del dominio Aurora

**Actividad:** Unidad de interacción guiada por Aurora Home que puede ser cognitiva, recreativa o de reminiscencia. Cada actividad tiene tipo, categoría, dificultad, configuración y sesiones de ejecución registradas.

**Alerta:** Aviso generado por el sistema cuando se detecta una situación relevante, preventiva o crítica que requiere atención del cuidador.

**Alerta crítica:** Notificación de máxima gravedad generada ante eventos que pueden comprometer la integridad física del paciente, como la omisión crítica de una medicación (MVP) o, en futuras versiones, una caída o una frecuencia cardíaca anormalmente elevada.

**Aurora:** Sistema inteligente de asistencia y acompañamiento domiciliario para personas con deterioro cognitivo leve o pérdida de memoria.

**Aurora Care:** Aplicación móvil utilizada por los cuidadores para configurar rutinas, consultar el estado del paciente, recibir alertas y visualizar historial.

**Aurora Core:** Núcleo central del sistema. Se encarga de la lógica de negocio, orquestación, procesamiento de eventos, integración con IA, persistencia de datos y comunicación entre módulos.

**Aurora Home:** Dispositivo de interacción por voz ubicado en el hogar del paciente. Permite emitir recordatorios, interactuar con el paciente y comunicarse con Aurora Core.

**Base de datos del paciente:** Repositorio donde se almacena información personal, rutinas, medicación, eventos, alertas, configuraciones y datos relevantes del paciente.

**Clasificación de eventos:** Proceso mediante el cual Aurora determina la gravedad de una situación detectada, pudiendo ser baja, media, alta o crítica.

**Comunicación de emergencia:** Funcionalidad que permite notificar a los cuidadores ante un evento crítico. En el MVP se hace con notificaciones push; la llamada automática es de futuras versiones.

**Cuidador:** Familiar o responsable que configura rutinas, consulta información del paciente y responde ante alertas.

**Datos biométricos:** Información fisiológica o de actividad del paciente, como frecuencia cardíaca, movimiento, ubicación, temperatura o señales de estrés. El MVP no mide datos biométricos (futuras versiones).

**Datos sensibles:** Información personal, médica, biométrica o contextual que debe protegerse especialmente por privacidad y seguridad.

**Deambulación errática:** Movimiento o desplazamiento inusual del paciente que puede indicar desorientación, riesgo o necesidad de asistencia. Su detección es de futuras versiones.

**Deterioro cognitivo:** Disminución de capacidades mentales como memoria, orientación, atención, lenguaje o toma de decisiones.

**Deterioro cognitivo leve:** Estado inicial o moderado de pérdida cognitiva donde la persona aún conserva capacidad de interacción básica y puede beneficiarse de asistencia tecnológica.

**DOT:** Cuenta y dispositivo principal asociado al hogar. Representa el entorno domiciliario de Aurora, centraliza la configuración del paciente y permite asociar cuidadores autorizados que acceden con cuentas personales.

**Escalamiento de alertas:** Proceso mediante el cual una alerta se intensifica o se envía por otros canales si no obtiene respuesta del cuidador. Función de futuras versiones.

**Escala GDS:** Escala Global de Deterioro (Reisberg, 1982), de 7 estadios, que clasifica el deterioro cognitivo. Se usa como referencia clínica complementaria.

**Evento:** Situación detectada o registrada por el sistema, como una omisión de medicación o una interacción relevante. La detección de caídas y de salidas de zona segura es de futuras versiones.

**Evento crítico:** Situación que puede comprometer la integridad física del paciente y requiere acción inmediata.

**Expo:** Framework de código abierto creado para facilitar el desarrollo de aplicaciones con React Native. Permite crear apps para iOS, Android y la web usando JavaScript o TypeScript sin necesidad de configurar complejos entornos nativos

**Expo Go:** Aplicación móvil gratuita y un entorno de pruebas (sandbox) que te permite ejecutar, probar y compartir proyectos creados con React Native y Expo directamente en tu teléfono o emulador

**Expo Push:** Servicio de notificaciones push de Expo que Aurora Core usa para enviar los avisos y las alertas a la app Aurora Care del cuidador.

**FAST:** Functional Assessment Staging (Reisberg, 1988). Escala funcional de la enfermedad de Alzheimer. Es el criterio que delimita el perfil del paciente de Aurora: nivel FAST igual o inferior a 5.

**Fernet:** Esquema de cifrado simétrico autenticado de la biblioteca cryptography de Python. Aurora lo usa para cifrar a nivel de aplicación los datos identificatorios (nombre, DNI y contactos) antes de guardarlos en la base de datos (ADR-010).

**Geofencing:** Delimitación de zonas seguras mediante perímetros virtuales en un mapa. Permite detectar si el paciente sale de un área configurada. Función de futuras versiones.

**Historial:** Registro ordenado de eventos, rutinas, medicación, alertas, interacciones y acciones realizadas en el sistema.

**IA (Inteligencia Artificial):** Tecnología utilizada por Aurora para interpretar información, personalizar interacciones, asistir en la clasificación de eventos y generar respuestas contextualizadas.

**Interacción por voz:** Comunicación entre el paciente y Aurora Home mediante habla y respuestas auditivas.

**Ley 25.326:** Ley argentina de Protección de Datos Personales. En Aurora se toma como marco obligatorio para proteger información personal, médica y biométrica.

**Memoria contextual:** Información del paciente utilizada por el sistema para personalizar respuestas, como recuerdos, vínculos familiares, preferencias y rutinas.

**MVP (Producto Mínimo Viable):** Primera versión funcional del sistema que incluye las funcionalidades esenciales para validar la propuesta.

**Notificación push:** Aviso enviado al dispositivo del cuidador mediante la aplicación Aurora Care.

**Orquestador:** Componente encargado de coordinar acciones automáticas entre distintos módulos del sistema.

**Paciente:** Persona con pérdida de memoria o deterioro cognitivo que recibe asistencia dentro del hogar mediante Aurora.

**RAG (Retrieval-Augmented Generation):** Técnica que permite recuperar información relevante desde una base de conocimiento para generar respuestas más contextualizadas y precisas.

**Raspberry Pi:** Computadora de placa única (modelo 5) utilizada como base de hardware para Aurora Home.

**React Native:** framework de código abierto creado por Meta (Facebook) que permite crear aplicaciones móviles nativas para iOS y Android usando una sola base de código en JavaScript y React.

**Recordatorio:** Aviso emitido por el sistema para ayudar al paciente a cumplir rutinas, medicación, alimentación, higiene o descanso.

**Reminiscencia cognitiva:** Técnica que utiliza recuerdos personales, familiares o emocionalmente significativos para estimular la memoria e identidad del paciente.

**Rutina:** Actividad programada del paciente, como tomar medicación, alimentarse, hidratarse, descansar o realizar ejercicios cognitivos.

**STT (Speech-to-Text):** Conversión de voz a texto. En Aurora se realiza principalmente en la nube (Azure Speech), con respaldo local (Whisper.cpp) cuando no hay conexión.

**Supabase:** Plataforma de datos gestionada que ofrece PostgreSQL con la extensión pgvector, autenticación (Supabase Auth) y almacenamiento de archivos. Es la base de datos y el proveedor de identidad de Aurora (ADR-003 y ADR-005).

**Terapia de reminiscencia:** Uso guiado de recuerdos personales para estimular la memoria, reforzar identidad y mejorar el bienestar emocional.

**TTS (Text-to-Speech):** Conversión de texto a voz. Permite que Aurora Home emita respuestas habladas al paciente..

**Worker IA:** Servicio independiente (Python y FastAPI) que realiza la inferencia con el modelo de lenguaje, la memoria del paciente y los resúmenes. Aurora Core no llama al modelo directamente: delega siempre en este servicio.

**Zona segura:** Área configurada en el sistema donde se espera que el paciente permanezca. Si sale de ella, Aurora puede generar un evento o alerta. Función de futuras versiones.
