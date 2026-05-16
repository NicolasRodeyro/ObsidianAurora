---
base: "[[Document Hub.base]]"
Created time: 2026-04-25T16:14:00
Last edited by: Mateo Romero Plaza
Created by: Mateo Romero Plaza
Category:
  - Documentación Interna
Last updated time: 2026-04-25T16:19:00
---
# **Introducción**

La demencia es un síndrome que afecta la memoria, el pensamiento y la capacidad de realizar actividades cotidianas, y constituye un reto sanitario y social de gran escala. La Organización Mundial de la Salud estima que en 2021 había alrededor de 57 millones de personas viviendo con demencia en el mundo y que se registran casi 10 millones de casos nuevos por año; además, señala que la enfermedad de Alzheimer es la forma más frecuente y puede contribuir a 60–70% de los casos. La carga no recae solo en el paciente: el impacto también es económico y sobre los cuidadores informales y familiares; por ejemplo, la OMS reporta costos globales del orden de USD $1.3 billones en 2019 y destaca que gran parte de la atención proviene de cuidadores no remunerados.

Para el contexto local, Argentina es un país con envejecimiento marcado: el Instituto Nacional de Estadística y Censos reporta que 11.9% de la población tiene 65 años o más, lo que incrementa la exposición poblacional a demencias y Alzheimer. En febrero de 2026, el Ministerio de Salud de la Nación aprobó el Plan Nacional de Alzheimer y Trastornos Relacionados mediante la Resolución 279/2026, formalizada en el Boletín Oficial de la República Argentina; el propio texto normativo reconoce la ausencia de cifras oficiales y cita estimaciones médicas del orden de ~500 mil personas afectadas en el país.

En Alzheimer, los cambios cerebrales se acumulan durante años y se expresan como deterioro progresivo de memoria y autonomía. El National Institute on Aging describe como características centrales la pérdida de conexiones neuronales y la atrofia cerebral, con afectación inicial de áreas vinculadas a memoria y progresión hacia otras funciones.

Aunque no existe una cura definitiva para la demencia, sí hay estrategias efectivas para apoyar la calidad de vida y el bienestar, incluyendo intervenciones psicosociales, la actividad física y la estimulación cognitiva.

A medida que la prevalencia de la enfermedad aumenta, la carga sobre los sistemas de salud pública y, de forma más crítica, sobre los cuidadores familiares, se vuelve operativa y financieramente insostenible. Ante este panorama, organizaciones internacionales como la OMS y la Alzheimer's Disease International (ADI) han recomendado enfáticamente la integración de intervenciones no farmacológicas, destacando la **Terapia de Estimulación Cognitiva** (CST) como uno de los tratamientos más eficaces para mantener el funcionamiento cognitivo y el bienestar emocional de las personas que viven con demencia.

La progresión de la enfermedad implica una pérdida gradual de autonomía, lo que genera una creciente dependencia del cuidador y una elevada carga emocional, física y económica. En este contexto, la tecnología se posiciona como una aliada estratégica para ofrecer asistencia, monitoreo y acompañamiento continuo, complementando —pero no reemplazando— la atención médica profesional.

A partir de esta problemática surge la presente propuesta: el desarrollo e implementación de un **Sistema de Asistencia y Acompañamiento Global**, diseñado para brindar soporte integral a personas con Alzheimer y a sus cuidadores.

# **Objetivo del Proyecto**

El objetivo principal es diseñar, desarrollar e implementar un sistema inteligente de asistencia y acompañamiento que transforme el paradigma de cuidado para personas con Alzheimer, pasando de un modelo de monitoreo pasivo y reactivo a una plataforma de acompañamiento proactivo e inteligente. El foco está en que el sistema incremente la seguridad del paciente, prolongue su autonomía en actividades cotidianas y reduzca la carga del cuidador.

En concreto, el sistema busca tres cosas simultáneamente:

- **Prolongar la independencia del paciente**, estimulando su función cognitiva mediante diálogos terapéuticos automatizados.
- **Salvaguardar su integridad física**, detectando caídas, deambulación errática y alertas biométricas antes de que se conviertan en emergencias.
- **Reducir el burnout del cuidador**, automatizando tareas de monitoreo y alertas que hoy recaen completamente sobre personas sin formación médica formal.

**Ámbito o contexto de aplicación**

En general, el ámbito se puede justificar en dos escenarios:

1. **En el hogar**. Muchas personas con demencia viven con apoyo de familiares, y la necesidad práctica es ayudar a ellos con interacciones simples y prácticas, monitoreos para sostener rutinas y detectar riesgos cuando el cuidador no está con la persona afectada. Ésto es consistente con la carga que la OMS atribuye al cuidado informal y con el hecho de que el deterioro suele requerir supervisión creciente con el tiempo.
2. **En instituciones o centros de cuidado**. En etapas avanzadas, los pacientes requieren institucionalización. Aquí el sistema debe escalar de uno a cientos de pacientes monitoreados simultáneamente. La necesidad se centra en supervisión y respuesta: detectar eventos (caídas, salidas no autorizadas, agitación), priorizar alertas, reducir tiempos de reacción del personal y facilitar el seguimientos de pacientes.

**Descripción de la Solución**

La solución propuesta puede describirse como un ecosistema (no solo una app), compuesto por componentes que trabajan juntos: interacción con el paciente, sensado/monitoreo, inteligencia y automatización, y un panel para el cuidador. Este enfoque encaja con revisiones recientes de soluciones IoT orientadas a Alzheimer, que suelen combinar monitoreo, apoyo cognitivo y comunicación con cuidadores.

El objetivo de un sistema de asistencia moderno es facilitar el "envejecimiento en el hogar" (ageing-in-place) preservando la dignidad y autonomía del paciente el mayor tiempo posible.

A diferencia de la tecnología reactiva tradicional, la "Inteligencia Asistencial" propone un enfoque humano-céntrico donde la IA aprende las rutinas del usuario y solo interviene de forma sutil cuando detecta una desviación del patrón normal. Por ejemplo, en lugar de un dispensador de pastillas ruidoso, un sistema inteligente podría utilizar una luz suave o la voz grabada de un familiar para recordar la dosis, reduciendo la ansiedad del paciente.

**Funcionalidades principales**

- **Interacción vocal proactiva:** A diferencia de Alexa o Siri, el sistema inicia las conversaciones basándose en el contexto del paciente (hora del día, métricas de inactividad, estado de ánimo inferido). El paciente no necesita recordar ningún comando de activación.
- **Terapia de Reminiscencia Digital**: Una base de datos, almacena la biografía del paciente (eventos de vida, voces de familiares, fotos). Cuando el sistema detecta confusión o angustia, recupera narrativas personalizadas para orientar y calmar al paciente.
- **Detección predictiva de caídas y deambulación errática**: Usando datos de la pulsera IoT, el sistema establece geocercas dinámicas y analiza patrones de marcha para emitir alertas antes de que el paciente se extravíe o caiga.
- **Monitorización biométrica en tiempo real**: Análisis continuo de frecuencia cardíaca, temperatura y actividad electrodérmica para detectar estados de agitación de forma temprana.
- **Gestión inteligente de alertas y escalamiento automático**: El sistema distingue niveles de urgencia y envía alertas de forma inteligente: un mensaje de Telegram (o WhatsApp) para una anomalía menor, una llamada telefónica SOS automática ante una caída o evento grave.
- **Terapia de Estimulación Cognitiva: Conjunto de actividades orientadas a mantener, fortalecer o estimular funciones cognitivas como la memoria, la atención, el lenguaje, la orientación y el razonamiento. Su objetivo es favorecer la autonomía de la persona, ralentizar el deterioro cognitivo y mejorar su calidad de vida mediante ejercicios adaptados a sus capacidades.**
- **Terapia basada en recreación o juegos: Enfoque terapéutico que utiliza actividades lúdicas, recreativas y juegos como medio para estimular capacidades cognitivas, emocionales y sociales. A través de dinámicas entretenidas y motivadoras, se busca promover la participación activa, reducir el estrés o la apatía y generar un entorno más ameno para la estimulación.**

**Tecnologías a implementar**

El stack tecnológico del sistema se organiza en cuatro capas principales, cada una con una función específica dentro de la solución integral. Esta arquitectura permite distribuir responsabilidades entre el hardware, la captura de datos biométricos, el procesamiento inteligente de la información y la automatización de las respuestas del sistema.

**Capa 1 – Hardware embebido (Edge Device)**

Esta capa corresponde al dispositivo físico principal de interacción con el usuario, diseñado para operar de forma local dentro del entorno cotidiano del paciente. Se prevé el uso de una plataforma embebida como ESP32-S3 o Raspberry Pi, según las necesidades finales de procesamiento, consumo energético y costo.

El dispositivo incorporará micrófonos MEMS con supresión de ruido, lo que permitirá captar la voz del usuario incluso en contextos con interferencias o cuando presente dificultades en el habla, como voz débil o disartria. También contará con un altavoz de buena calidad, necesario para garantizar una reproducción clara del audio, especialmente considerando problemas auditivos frecuentes en adultos mayores, como la presbiacusia. Además, incluirá una matriz LED o indicadores visuales discretos, que funcionarán como apoyo no invasivo para brindar retroalimentación al usuario.

Una de las características clave de esta capa es el procesamiento local de funciones críticas, lo que reduce la dependencia de la nube y mejora la velocidad de respuesta, la privacidad de los datos y la disponibilidad del sistema ante fallas de conectividad.

**Capa 2 – Pulsera IoT (sensórica vestible)**

La segunda capa está compuesta por una pulsera inteligente o dispositivo vestible, encargada de recolectar datos fisiológicos y de movimiento del paciente en tiempo real. Su objetivo es complementar la interacción por voz con una monitorización continua del estado físico y conductual del usuario.

Entre los sensores contemplados se incluyen:

- **PPG (fotopletismografía)**: para estimar frecuencia cardíaca y detectar variaciones asociadas al estrés o estados de agitación.
- **IMU (acelerómetro y giroscopio):** para detectar caídas, analizar patrones de marcha y registrar movimientos anómalos.
- **Sensores de temperatura corporal y actividad electrodérmica**: útiles para identificar cambios fisiológicos que puedan asociarse a malestar, ansiedad o situaciones de riesgo.
- **GPS integrado: para reconocer la ubicación de la persona en tiempo real.**

La comunicación entre esta pulsera y el resto del sistema se realizará mediante tecnologías de bajo consumo y alta eficiencia. En este punto, conviene diferenciar que MQTT es un protocolo de mensajería liviano para transmitir datos, mientras que LoRa es una tecnología de comunicación inalámbrica de largo alcance. Dependiendo del diseño final, podrían utilizarse de manera complementaria junto con Bluetooth o Wi-Fi, según el alcance, la autonomía y la infraestructura requerida.

**Capa 3 – Motor de Inteligencia Artificial (LLM + RAG)**

Esta capa constituye el núcleo cognitivo del sistema, ya que es la encargada de interpretar información, generar respuestas y personalizar la interacción con el usuario. Para ello, se propone utilizar modelos de lenguaje de código abierto, como Llama, adaptados al dominio del proyecto mediante técnicas de ajuste eficiente, por ejemplo QLoRA, sobre corpus relacionados con salud, acompañamiento y contexto clínico.

A su vez, el sistema incorpora una arquitectura RAG (Retrieval-Augmented Generation), que combina la capacidad generativa del modelo con la recuperación de información específica almacenada previamente. Esto permitirá que el asistente no responda solo “por conocimiento general”, sino también basándose en datos concretos del paciente, tales como recuerdos importantes, rutinas, preferencias, vínculos familiares o antecedentes relevantes. Para ello, se utilizará una base de datos vectorial, como pgVector, que hará posible implementar la base de datos,  donde se organizará y consultará información personalizada del usuario.

En cuanto a la interacción por voz, esta capa integrará un pipeline específico compuesto por modelos de IA con reconocimiento automático de voz, como puede ser Whisper o gpt-4o-transcribe-diarize para una diarización de hablantes integrada. También se puede hacer uso de XTTS-v2, para síntesis de voz natural, incluyendo la posibilidad de personalizar la voz del asistente e incluso recrear voces familiares, con el objetivo de generar una interacción más cercana, familiar y emocionalmente significativa para el paciente.

De esta manera, la IA no solo actuará como interfaz conversacional, sino también como un sistema de apoyo contextualizado, capaz de adaptarse a las necesidades particulares de cada usuario.

**Capa 4 – Orquestación clínica y automatización (n8n)**

La cuarta capa corresponde a la coordinación general del sistema, y tiene como función integrar todos los componentes anteriores en flujos de trabajo automáticos, trazables y escalables. Para ello, se propone utilizar n8n como plataforma de automatización y orquestación.

En términos prácticos, n8n funcionará como el sistema nervioso central de la solución, recibiendo eventos desde el hardware embebido, la pulsera IoT y el motor de IA, y transformándolos en acciones concretas según reglas definidas. Por ejemplo, podrá:

- ejecutar flujos inteligentes y escalamiento de alertas;
- registrar e incorporar nuevas memorias o eventos relevantes del paciente;
- integrarse con sistemas clínicos o historiales electrónicos de salud;
- monitorear el estado operativo de los dispositivos IoT;
- disparar notificaciones, mensajes o llamadas automáticas ante situaciones de riesgo.

El uso de esta capa permite que el sistema opere de forma autónoma, auditable y modular, facilitando tanto el mantenimiento técnico como la supervisión clínica de su funcionamiento.

**Temáticas a Investigar o Desafíos**

Hay cuatro frentes de investigación que le dan profundidad académica al proyecto:

3. **Eficacia clínica de la IA en terapia cognitiva**: ¿Es más efectivo usar recuerdos personalizados o materiales genéricos (canciones de la época del paciente) para evocar respuestas en personas con demencia? El LLM debe poder alternar entre ambos enfoques y medir el impacto en fluidez verbal y reducción de apatía. También se investigará el uso de la voz del paciente como biomarcador digital para detectar cambios en el estado de ánimo.
4. **Algoritmos de detección de deambulación y caídas en dispositivos de bajo consumo**: El desafío es lograr detecciones sub-segundo con mínimas falsas alarmas (que generan "fatiga de alertas" en los cuidadores), implementando CNNs livianas y fusión de sensores GPS/Wi-Fi/IMU con filtros como el Filtro de Kalman, todo dentro de las limitaciones energéticas de una pulsera.
5. **Diseño de interfaz para alteraciones cognitivas (VUI/UX):** Los principios estándar de usabilidad no se aplican a esta población. Se deben definir patrones específicos: pausas artificiales en el discurso del asistente, lenguaje no condescendiente, botones con áreas táctiles mínimas de 44×44px, fuentes de ultra-alto contraste y eliminación de animaciones distractoras.
6. **Gobernanza de datos y cumplimiento normativo: **Un sistema médico global debe cumplir simultáneamente con HIPAA (EE.UU.), GDPR (Europa) y las normativas de SaMD (Software as a Medical Device). Esto implica investigar cifrado extremo a extremo, privacidad diferencial, procesamiento en el borde para evitar transferir datos sensibles a la nube, y gestión del sesgo algorítmico (por ejemplo, que los sensores PPG funcionen correctamente en distintos tonos de piel).
7. **Selección y validación del hardware: Uno de los desafíos centrales será definir qué hardware utilizar en cada capa del sistema. Esto implica investigar plataformas embebidas, sensores biométricos, micrófonos, altavoces y módulos de comunicación, evaluando precisión, consumo energético, autonomía, costo y facilidad de integración. También será necesario analizar la comodidad y confiabilidad de los dispositivos en situaciones reales de uso, especialmente en adultos mayores. Este frente permitirá determinar la viabilidad técnica del proyecto y elegir una base de hardware adecuada para sostener el funcionamiento del sistema de manera estable, eficiente y escalable.**

**Metodología y Estimaciones Generales**

**Metodología: Modelo en V Ágil**

Para un sistema de grado médico, la norma IEC 62304 exige trazabilidad y documentación rigurosa, lo que históricamente llevaba a usar modelos en cascada, muy rígidos. Sin embargo, el desarrollo de algoritmos de ML y flujos en n8n necesita iteración rápida. La solución es el Modelo en V Ágil: una capa externa formal (requisitos, arquitectura, análisis de riesgos) que cumple con la normativa, y una capa interna ágil (sprints de desarrollo, pruebas iterativas) que permite pivotar basándose en retroalimentación real.

**Validación: Marco V3 de DiMe**

La validación no se limita a métricas de software sino que sigue tres fases clínicas:

- Verificación: Los sensores miden con precisión frente a instrumentos clínicos de referencia.
- Validación analítica: Los algoritmos de IA alcanzan métricas aceptables (sensibilidad, especificidad, AUC-ROC) para detección de caídas, estrés y recuperación de memorias.
- Validación clínica: En un piloto con usuarios reales (bajo consentimiento ético), se comprueba que las respuestas del sistema impactan positiva y medible mente el estado del paciente.

**Cronograma estimado (12 meses)**

| **Fase** | **Período** | **Foco** |
| --- | --- | --- |
| 1 – Prototipado | Meses 4-6 | Ensamblaje ESP32, sensores IoT, configuración base de n8n y IA |
| 2 – Arquitectura cognitiva | Meses 7-8 | Base de datos vectorial, pipeline STT/TTS, fine-tuning del LLM |
| 3 – Validación analítica | Meses 9-10 | Entrenamiento de clasificadores, integración segura con EHR (HIPAA/GDPR) |
| 4 – Piloto de usabilidad | Meses 11-12 | Pruebas con usuarios reales, refinamiento de VUI, consolidación del Marco V3 |