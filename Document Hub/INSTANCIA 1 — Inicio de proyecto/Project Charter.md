---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-07-09
---

# Plan de Proyecto Aurora

## Acta de Constitución del Proyecto

## 1. Información General

| Campo | Descripción |
| :---- | :---- |
| **Nombre del Proyecto** | Aurora |
| **Patrocinador (Sponsor)** | Mgter Ing. Santos, Virginia |
| **Director del Proyecto (PM)** | Jeremías Daniel Maldonado Gómez |
| **Fecha de Elaboración** | 05/05/2026 |
| **Versión** | 1.0 |

## 2. Propósito y Justificación (Business Case)

### 2.1 Problema u Oportunidad

Aurora busca acompañar y monitorear pacientes con alzheimer o pacientes con problemas de memoria, para brindar una mejor calidad de vida y autonomía en el hogar.

### 2.2 Alineación Estratégica

Aurora va a permitir a la organización aprobar la tesis final para recibirse de ingenieros y ser una solución útil que nos brinde experiencia como nuevos ingenieros.

### 2.3 Estrategia de Monetización

* **Modelo Particular (B2C - Directo al Consumidor):** Enfocado en familias con pacientes en el hogar. Se monetizará mediante:
  * *Venta de Hardware (One-time fee):* Adquisición inicial del dispositivo físico *Aurora Home* (gabinete, Raspberry Pi, micrófonos y parlantes).
  * *Suscripción Mensual (SaaS):* Un pago recurrente para el acceso a la aplicación *Aurora Care* (para los cuidadores), procesamiento en la nube, analítica de datos de *Aurora Core* y consumo de tokens de los LLMs.
* **Modelo Institucional (B2B - Business to Business):** Centros de salud privados, geriátricos y clínicas especializadas en neurología. Se ofrecerá un esquema de licenciamiento corporativo por volumen de pacientes monitoreados, permitiendo a la institución centralizar el control de múltiples usuarios desde un dashboard profesional.
* **Modelo Gubernamental (B2G - Business to Government):** Programas de asistencia social o ministerios de salud. Contratos de provisión tecnológica a gran escala para subsidiar el ecosistema a sectores vulnerables.

## 3. Objetivos y Criterios de Éxito

| Objetivo (SMART) | Criterio de Éxito |
| :---- | :---- |
| **Aprobar la Tesis** | Alcanzar un 80% o más a principios de noviembre para regularizar la tesis y poder defenderla |
| **Ser la mejor Tesis del año** | Ser reconocida como la mejor tesis del año en el concurso que se realiza mediados de septiembre |
| **Ofrecer una solución útil para sus usuarios** | Obtener al menos 10 usuarios que lo hayan usado y estén satisfechos |

## 4. Descripción y Alcance de Alto Nivel

### 4.1 Descripción del Proyecto

El proyecto Aurora consiste en el diseño y desarrollo de un ecosistema tecnológico integrado de software y hardware enfocado en brindar acompañamiento cognitivo personalizado y monitoreo preventivo a pacientes en fases iniciales y moderadas de la enfermedad de Alzheimer o patologías asociadas a la pérdida de memoria. El objetivo fundamental de la solución es ralentizar el impacto del desgaste neurológico de estas afecciones, promoviendo la autonomía funcional y extendiendo la independencia del paciente dentro de su entorno doméstico. Paralelamente, el sistema está concebido para mitigar los niveles de estrés y sobrecarga (*burnout*) en los cuidadores primarios y el entorno familiar del paciente.

Este propósito se logrará mediante la interacción sinérgica de tres componentes principales:

1. Una interfaz conversacional física basada en voz (*Aurora Home*) que actuará como asistente interactivo en el hogar.
2. Un dispositivo corporal comercial (*Aurora Band*) para el seguimiento continuo de variables biométricas, eventos cinéticos y geolocalización.
3. Una plataforma de gestión web/móvil (*Aurora Care*) destinada al entorno de cuidado.

La orquestación completa de los datos, el filtrado de eventos, el análisis predictivo y la lógica conversacional inteligente serán gestionados en la nube por un núcleo centralizado (*Aurora Core*), el cual consumirá modelos de lenguaje de gran escala (LLM) optimizados mediante infraestructura de inferencia rápida, garantizando viabilidad económica, baja latencia en la voz y privacidad en el tratamiento de los datos.

### 4.2 Entregables Principales

* **Entregable 1 - Módulo Aurora Home (Dispositivo de Voz Local):** Prototipo funcional de hardware embebido compuesto por una computadora de placa única (SBC), matriz de micrófonos de campo lejano, parlante integrado y un sistema de retroalimentación visual mediante indicadores LED. A nivel de software, incluirá la lógica local para la transcripción de voz a texto (STT), síntesis de habla (TTS) y un sistema de caché de consultas offline.
* **Entregable 2 - Módulo Aurora Band (Integración de Wearable Comercial):** Componente de software encargado del consumo, mapeo y normalización de las variables biométricas, acelerometría y coordenadas de posicionamiento (GPS) provistas por un reloj inteligente comercial con API abierta, sin manipulación de su firmware nativo.
* **Entregable 3 - Plataforma Aurora Care (Aplicación para Cuidadores):** Interfaz web y móvil responsiva destinada a los cuidadores. Permitirá la configuración de agendas de rutinas diarias, alertas de tratamiento médico, carga de bitácoras biográficas (base de conocimiento de recuerdos para la IA) y la recepción en tiempo real de notificaciones ante anomalías críticas.
* **Entregable 4 - Sistema Central Aurora Core (Backend y Orquestación de IA):** Infraestructura lógica centralizada en la nube responsable de la persistencia de datos, el procesamiento de algoritmos para la inferencia de caídas y deambulación (*geofencing*), la anonimización de registros médicos y la gestión de prompts con el modelo fundacional de IA seleccionado.
* **Entregable 5 - Cuerpo de Documentación Técnica y Académica:** Repositorio incremental que recopila los artefactos de ingeniería exigidos por la cátedra (Estudio Inicial, Plan de Proyecto, Registros de Decisión Arquitectónica [ADRs], Informes de Sprint, Planes de Testing, Manuales de Operación y el Paper de grado final).

### 4.3 Fuera de Alcance (Exclusiones)

* **Entornos físicos multifamiliares o institucionales masivos:** El sistema está diseñado y restringido conceptualmente para interactuar y procesar la información de un único paciente por hogar (entorno unifamiliar controlado).
* **Diseño, fabricación o modificación de hardware vestible:** El dispositivo físico *Aurora Band* queda estrictamente excluido del desarrollo de hardware del equipo; el alcance del proyecto se limita exclusivamente al consumo de los datos crudos expuestos por las APIs del fabricante.
* **Infraestructura de red o conectividad autónoma celular en la vía pública:** Las alertas de localización en tiempo real fuera del hogar dependen de la conectividad y el enlace Bluetooth del teléfono móvil del paciente o del cuidador como dispositivo puente. El proyecto no contempla la provisión de planes de datos móviles ni hardware de comunicación celular independiente al reloj.
* **Pacientes fuera del perfil clínico estipulado:** El alcance conversacional y de asistencia de la Inteligencia Artificial está estrictamente delimitado para personas con un nivel de autonomía funcional equivalente al **Nivel 5 en la escala FAST** (*Functional Assessment Staging* / Escala de Reisberg). Quedan excluidas las etapas severas de la enfermedad que presenten pérdida total de la comprensión verbal o de la capacidad de responder a estímulos auditivos.

## 5. Estructura WBS - Work Breakdown Structure

1. **Gestión del Proyecto y Documentación Académica:**
   [Proyecto Aurora - 2026](https://drive.google.com/drive/folders/1aoHTi9GMKORTwWwyiLXLUR8rNyEl0rlC)
   1. Instancia 1: Estudio Inicial y Plan de Proyecto
   2. Instancia 2: Working Agreement, Arquitectura y Product Backlog
   3. Instancia 3: Informes de Sprint y Trazabilidad (Sprints 1 a N)
   4. Instancia 4 y 5: Elaboración de Paper, Póster, Video y Documentación Final
2. **Ingeniería de Datos e Inteligencia Artificial (Aurora Core)**
   1. Diseñar Esquema DB (Supabase)
   2. Configuración y Orquestación de APIs (Gemini / Claude)
   3. Desarrollo de la lógica de negocio y filtrado de eventos biométricos
   4. Ingeniería de Prompts y Base de Conocimiento (RAG) para terapias cognitivas
   5. Programar Lógica de Alertas y Clasificación de Eventos.
3. **Desarrollo de Interfaces de Usuario (Aurora Care)**
   1. Diseño UX/UI de la aplicación web *Aurora Care* (Figma)
   2. Desarrollar Frontend (PWA/Mobile).
   3. Implementación del sistema de notificaciones en tiempo real (WebSockets / Push)
   4. Programar Dashboards de Historial y Reportes.
4. **Hardware e Interfaz de Voz (Aurora Home)**
   1. Ensamblado y configuración del sistema operativo en hardware (Raspberry Pi)
   2. Integración de periféricos (Módulos de audio, micrófonos e indicadores LED)
   3. Desarrollo del módulo de transcripción de voz a texto (STT) y texto a voz (TTS)
   4. Desarrollar Lógica de Interacción Vocal local.
   5. Desarrollar modo offline y buffer de eventos.
5. **Integración de Dispositivo Biométrico (Aurora Band)**
   1. Conexión y consumo de la API/Bluetooth de la pulsera tercerizada
   2. Mapeo y normalización de datos de signos vitales (pulsaciones, oxígeno, etc.)
   3. Implementar Gateway de datos para Aurora Core.
6. **Aseguramiento de la Calidad (Testing) y DevOps**
   1. Configuración de entornos (Desarrollo, Staging, Producción)
   2. Pipeline de Integración y Despliegue Continuo (CI/CD)
   3. Ejecución de Pruebas Unitarias, Integración y End-to-End (E2E)
7. **Lanzamiento y Aspectos Legales**
   1. Redacción de Términos y Condiciones y Políticas de Privacidad de Datos Médicos
   2. Pruebas piloto con usuarios reales (Grupo de control de 10 usuarios)

## 6. Recursos y Presupuesto

El modelo financiero de Aurora se divide en el presupuesto inicial para el desarrollo del Producto Mínimo Viable (MVP) exigido para la tesis, y el costo operativo proyectado para su posterior etapa de producción bajo el modelo de negocio establecido.

### 6.1 Presupuesto de Desarrollo (CAPEX - Inversión Inicial)

Este presupuesto contempla los gastos necesarios durante los 6 meses de desarrollo (Mayo - Noviembre 2026).

**Desglose Detallado de Inversión Inicial (CAPEX)**

| Categoría | Componente / Concepto | Costo Estimado |
| ----- | ----- | :---: |
| **Hardware Aurora Home** | Raspberry Pi 4 (2GB/4GB) | $150.000 ARS |
| | Módulo ReSpeaker 2-Mics Pi HAT | $70.000 ARS |
| | Mini parlante interno (3W) | $30.000 ARS |
| | Fuente de alimentación y MicroSD | $50.000 ARS |
| | Gabinete impreso en 3D | $50.000 ARS |
| **Wearable** | AmazFit Bit 5 o similar | $100.000 ARS |
| **Infraestructura** | Cloud y APIs (6 meses) | $60.000 ARS |
| **Mano de Obra** | Valorización simbólica (Equipo 2.016 hs ad honorem) | $8.064.000 ARS |

**Presupuesto Total Estimado a Desembolsar:** $410.000 ARS (Cumpliendo holgadamente la restricción de no superar los $500.000 ARS establecidos).

### 6.2 Costo Operativo Mensual (OPEX - Sistema en Producción)

Proyección financiera para mantener el sistema funcional con un grupo de control de **10 usuarios activos** interactuando diariamente con el ecosistema (Aurora Home + Aurora Band + Aurora Care):

| Concepto Tecnológico | Detalle del Servicio | Costo Mensual Estimado (USD) |
| :---- | :---- | :---- |
| **Infraestructura de Backend** | Servidor Virtual Privado (VPS) para alojar Aurora Core (Node.js/Python). | $10.00 USD |
| **Persistencia de Datos** | Base de Datos Relacional / NoSQL alojada en la nube con backups diarios. | $15.00 USD |
| **Consumo de Inteligencia Artificial** | Procesamiento ultrarrápido de LLMs (ej. Llama 3 8B vía Groq). Estimando 2 millones de tokens por paciente al mes (20M tokens totales a $0.10 el millón). | $2.00 USD |
| **Total Operativo Mensual (10 usuarios)** | Punto de equilibrio técnico (Break-even de infraestructura). | $27.00 USD / mes |

* *Nota Estratégica:* Al ejecutar la transcripción de voz (STT) y la síntesis de audio (TTS) de manera **local** en el hardware de la Raspberry Pi de cada paciente, el costo operativo mensual en la nube se reduce drásticamente, haciendo que el modelo de negocio B2B y B2C propuesto sea altamente rentable y escalable.

### Equipo de Trabajo

| Nombre | Roles | Horas Semanales |
| :---- | :---- | :---- |
| **Romero Plaza, Mateo** | Desarrollador Backend, Administrador de Bases de Datos, Analista Funcional | 16 hs |
| **Kilic Aslan, Haik Martín** | Desarrollador Backend- Analista Funcional | 18 hs |
| **Rodeyro Contarino, Nicolás** | Diseñador UX/UI, Administrador de Base de Datos, Ingeniero AI, Desarrollador Frontend | 22 hs |
| **Maldonado Gómez, Jeremías Daniel** | Project Manager-DevOps-Diseñador UX/UI | 13 hs |
| **Escudero, Octavio** | Desarrollador FronDevOps, Desatend, Analista QA | 15 hs |

**Propuesta Metodológica**: La metodología a utilizar será Scrum con Sprints de 3 semanas. La técnica de estimación se basará en la capacidad del equipo (Capacity Planning). Contamos con un total de 84 horas semanales. Al inicio de cada Sprint, se estimará el esfuerzo de los tickets en horas y se asignan asegurando no superar el rango horario de cada integrante, dejando un margen (buffer) del 20% para imprevistos.

### Cronograma

| Sprint / Etapa | Periodo | Objetivo principal | Hito |
| ----- | ----- | ----- | ----- |
| **Sprint 1** | 22/06 al 12/07 | Construir la base técnica del ecosistema | Inicio de infraestructura |
| **Sprint 2** | 13/07 al 02/08 | Implementar los primeros componentes funcionales | **Release 1: Base técnica** |
| **Sprint 3** | 03/08 al 23/08 | Incorporar inteligencia artificial e integración entre módulos | Integración parcial |
| **Sprint 4** | 24/08 al 13/09 | Integrar los flujos críticos del sistema | **Release 2: Integración funcional** |
| **Sprint 5** | 14/09 al 04/10 | Validar y estabilizar las funcionalidades desarrolladas | **Release 3: Candidata final** |
| **Sprint 6** | 05/10 al 25/10 | Estabilizar la solución, corregir incidencias y completar la documentación final | Documentación, paper, video y demo |
| **Preparación final** | 26/10 al 05/11 | Preparar la exposición, revisión final y entrega definitiva | **Presentación final: 05/11** |

El proyecto Aurora se organiza en seis sprints consecutivos de tres semanas. Los dos primeros sprints se enfocan en construir la base técnica, definir la arquitectura y desarrollar los primeros componentes funcionales. Los Sprints 3 y 4 concentran la integración de la inteligencia artificial, la interacción por voz, el procesamiento de eventos, el historial y el funcionamiento offline.

El Sprint 5 está destinado a la validación, calibración de los componentes de inteligencia artificial y ejecución de pruebas integrales. Al finalizar este sprint se obtiene la release candidata y se alcanza el cierre técnico del proyecto.

El Sprint 6 se utiliza para estabilizar la solución, corregir incidencias, completar la documentación académica y técnica. El periodo restante hasta el 5 de noviembre queda reservado para la preparación de la exposición y la entrega definitiva.

### Estrategia de Trabajo en Paralelo (Reglas de Oro)

1. **Contratos de API primero:** Antes de empezar a programar Aurora Care o Aurora Band, el encargado de **Aurora Core (Backend)** debe definir el "Contrato de API" (Swagger/OpenAPI). Así, el encargado del Frontend y el del Wearable pueden trabajar con *mocks* (datos falsos) sin esperar a que el Core esté terminado.
2. **Infraestructura como Código (IaC):** El encargado de DevOps debe crear un **docker-compose** inicial. Los demás integrantes solo deben ejecutar **docker-compose up** para tener el entorno listo.
3. **Documentación como "Definition of Done":** Ninguna tarea se considera terminada si no se actualizó el manual técnico.
4. **Gestión de conflictos:** Utilizar ramas **feature/** estrictas. Si dos personas tocan la misma parte del código, deben reunirse 15 min antes de empezar para acordar la estructura.

### 6.3 Flujo de Fondos y Estrategias de Monetización

#### Etapa 1: Desarrollo del MVP

Durante la etapa de desarrollo del Producto Mínimo Viable, el proyecto no generará ingresos comerciales, ya que el foco estará puesto en el diseño, construcción, prueba y validación funcional del sistema.

Los principales egresos previstos para esta etapa son:
* Compra de hardware para el prototipo de Aurora Home.
* Costos de infraestructura cloud y APIs durante el desarrollo.
* Impresión o armado del gabinete físico del dispositivo.
* Costos operativos asociados a pruebas, conectividad y servicios externos.

El presupuesto estimado a desembolsar para el desarrollo inicial es de aproximadamente $410.000 ARS, contemplando hardware, infraestructura y servicios necesarios para construir el MVP. La mano de obra del equipo se considera aporte ad honorem, ya que el proyecto se desarrolla en el marco académico de Proyecto Final.

#### Etapa 2: Validación con Usuarios Piloto

Una vez desarrollado el MVP, se prevé una etapa de validación con un grupo reducido de usuarios piloto. El objetivo de esta fase será comprobar la utilidad del sistema, la aceptación por parte de cuidadores y pacientes, la confiabilidad de las alertas y la viabilidad técnica del ecosistema.

Para un grupo inicial de 10 usuarios activos, el costo operativo mensual estimado es de aproximadamente 27 USD mensuales, contemplando infraestructura de backend, persistencia de datos y consumo de inteligencia artificial.

#### Etapa 3: Operación Comercial

En una futura etapa de producción, Aurora podrá comenzar a generar ingresos mediante la venta del dispositivo físico Aurora Home y el cobro de una suscripción mensual por el uso del ecosistema digital.

Los ingresos proyectados surgirán principalmente de:
* Venta inicial del dispositivo Aurora Home.
* Suscripción mensual por acceso a Aurora Care.
* Servicios de procesamiento, almacenamiento, alertas y analítica en Aurora Core.

Los egresos recurrentes estarán compuestos por:
* Infraestructura cloud.
* Base de datos y almacenamiento.
* Consumo de modelos de inteligencia artificial.
* Servicios externos de notificación, telefonía o mensajería.
* Soporte técnico y mantenimiento.
* Reposición o actualización de hardware.
* Mejoras evolutivas del sistema.

### 6.4 Flujo de Fondos Básico Proyectado

| Concepto | Etapa MVP | Etapa Piloto | Etapa Comercial |
| ----- | ----- | ----- | ----- |
| **Venta de hardware Aurora Home** | $0 | $0 o bonificado | Ingreso inicial por dispositivo |
| **Suscripción mensual** | $0 | $0 o valor simbólico | Ingreso recurrente mensual |
| **Infraestructura cloud** | Egreso | Egreso | Egreso operativo |
| **Consumo de IA** | Egreso | Egreso | Egreso variable según uso |
| **Hardware de prototipo** | Egreso inicial | Reposición puntual | Costo de producción o compra |
| **Soporte y mantenimiento** | Aporte del equipo | Aporte del equipo | Egreso operativo |
| **Resultado esperado** | Negativo | Negativo o equilibrado | Positivo si la suscripción supera el costo operativo |

### 6.5 Estrategias de Monetización

Aurora podrá monetizarse, en primera instancia, mediante un modelo B2C, el cual está orientado a familias que tienen un paciente con pérdida de memoria o deterioro cognitivo dentro del hogar.

La monetización se plantea mediante:
* Venta inicial del dispositivo Aurora Home.
* Suscripción mensual para acceder a Aurora Care.
* Procesamiento en la nube mediante Aurora Core.
* Gestión de rutinas, alertas, historial, reportes y memoria contextual.
* Consumo de servicios de inteligencia artificial.

### 6.6 Estrategia de Precios Inicial

Para una futura etapa comercial, se propone una estrategia de precios compuesta por dos elementos:
1. Un pago inicial por el dispositivo Aurora Home, destinado a cubrir el costo del hardware, ensamblado, gabinete, configuración inicial y margen de comercialización.
2. Una suscripción mensual, destinada a cubrir infraestructura, almacenamiento, IA, notificaciones, soporte y mantenimiento evolutivo.

Considerando un costo operativo estimado de 27 USD mensuales para 10 usuarios activos, el costo técnico promedio por usuario sería bajo. Esto permite proyectar que, con una suscripción mensual razonable, Aurora podría cubrir sus costos de infraestructura y generar margen para soporte, mantenimiento y evolución del producto.

El procesamiento local de voz en Aurora Home reduce significativamente los costos en la nube, ya que evita enviar audio crudo constantemente a servicios externos. Esta decisión mejora la privacidad del paciente y, al mismo tiempo, favorece la viabilidad económica del modelo.

## 7. Riesgos, Supuestos y Restricciones

### 7.1 Riesgos Principales (Amenazas)

| ID | Riesgo (Amenaza) | Probabilidad | Impacto | Estrategia de Mitigación |
| :---- | :---- | :---- | :---- | :---- |
| **R1** | Falta de información médica útil para alimentar las terapias de Aurora Home. | Media | Alto | Mitigar: Realizar entrevistas con especialistas en gerontología/neurología en los primeros Sprints para validar el contenido. |
| **R2** | No conseguir una pulsera biométrica accesible o adecuada para Aurora Band. | Alta | Alto | Evitar/Mitigar: Investigar y adquirir smartwatches comerciales con APIs abiertas (ej. Xiaomi/Fitbit) en el Sprint 1. Tener un bypass en la App móvil si el hardware falla. |
| **R3** | Incremento exponencial en los costos de tokenización de las IA. | Media | Medio | Mitigar: Implementar una capa de caché local para preguntas repetitivas y configurar alertas de facturación (budgets) diarias. |
| **R4** | Rechazo o baja adopción tecnológica por parte del paciente con Alzheimer. | Alta | Alto | Mitigar: Diseñar una interfaz de voz extremadamente simple, sin comandos complejos, testeada iterativamente con adultos mayores. |
| **R5** | Filtración o vulnerabilidad en la seguridad de datos médicos sensibles. | Baja | Muy Alto | Mitigar: Encriptar los datos biométricos de extremo a extremo y disociar los nombres reales de los pacientes de sus registros de salud en la base de datos (Anonimización). |
| **R6** | Dificultad en la importación o abastecimiento de los componentes de hardware en Argentina. | Media | Alto | Evitar: Comprar los componentes críticos (Raspberry Pi, micrófonos de matriz) al inicio del proyecto con los fondos iniciales. |
| **R7** | Sobrecarga de tareas o deserción de integrantes por falta de tiempo (Burnout). | Media | Alto | Mitigar: Revisar la capacidad real del equipo cada 3 semanas en la Sprint Planning. Si un integrante está saturado, redistribuir tickets o recortar alcance del MVP. |

### 7.2 Supuestos del Proyecto

* Disponibilidad de APIs: Se asume que las APIs de los modelos fundacionales de Inteligencia Artificial (Gemini y Claude) mantendrán su disponibilidad, estabilidad técnica y términos de servicio estables durante todo el ciclo de desarrollo.
* Acceso a datos de Hardware Tercerizado: Se asume que el fabricante de la pulsera biométrica seleccionada para Aurora Band proveerá documentación abierta o SDK/API accesible que permita la extracción de datos biométricos en tiempo real sin costos ocultos de licenciamiento.
* Validación de Profesionales: Se asume que el equipo logrará establecer contacto y recibir feedback de al menos dos especialistas médicos (neurólogos o gerontólogos) en las etapas tempranas para validar la base de conocimiento de terapias cognitivas.
* Conectividad del Entorno: Se asume que el hogar de pruebas piloto contará con una infraestructura de red Wi-Fi estable y continua para la comunicación entre Aurora Home y Aurora Core.
* Estabilidad del Equipo: Se asume el compromiso e ininterrumpida disponibilidad horaria acordada de los 5 integrantes del equipo de trabajo a lo largo de los Sprints académicos.

### 7.3 Restricciones (Constraints)

* **Restricción Presupuestaria:** El costo total del diseño, adquisición de hardware de prototipado y licencias preliminares de software para el desarrollo del MVP no debe exceder los $500.000 ARS inicialmente estipulados.
* **Restricción Temporal Académica:** El proyecto está estrictamente atado al calendario académico 2026 de la UTN-FRC. El cierre absoluto de la ejecución debe realizarse el 05/10/2026 y el lanzamiento/entrega final inamovible es el 05/11/2026 para permitir la defensa de la tesis.
* **Restricción de Hardware (Alcance):** El dispositivo *Aurora Band* no será modificado a nivel de microcódigo o hardware; el alcance del equipo se restringe a la captura, transmisión y analítica de la información provista por el fabricante.
* **Restricción de Entorno y Perfil:** El ecosistema está restringido para operar exclusivamente en entornos domésticos unifamiliares (un dispositivo por paciente) y para pacientes que presenten un nivel 5 de autonomía funcional en la escala de degradación del Alzheimer.
* **Restricción Legal de Datos:** Al capturar datos biométricos y de comportamiento diarios, el sistema debe restringirse y alinearse de manera obligatoria a la Ley 25.326 de Protección de Datos Personales en Argentina (encriptación y anonimización de registros médicos).

## 8. Interesados Clave (Stakeholders)

| Nombre / Grupo | Rol en el Proyecto | Impacto / Expectativa principal |
| :---- | :---- | :---- |
| **Cátedra Proyecto Final (UTN-FRC)** | Docentes evaluadores | Muy Alto. Exigen rigor metodológico y evalúan la viabilidad para la obtención del título. |
| **Virginia Santos** | Sponsor del Proyecto | Alto. Autoriza el Acta de Constitución y valida que se cumplan los objetivos estratégicos. |
| **Equipo de Desarrollo** | Creadores y gestores | Muy Alto. Responsables de la ejecución del sistema buscando regularizar y defender la tesis. |
| **Pacientes con Alzheimer** | Usuarios de Aurora Home | Alto. Requieren una interfaz de voz intuitiva que extienda su autonomía sin fricción. |
| **Cuidadores y Familiares** | Usuarios de Aurora Care | Alto. Esperan centralizar alertas en tiempo real, reportes fidedignos y mitigar el burnout. |
| **Centros de Salud y Geriátricos** | Clientes corporativos (B2B) | Medio. Buscan optimizar el monitoreo de múltiples pacientes desde un dashboard unificado. |
| **Ministerios / Entes de Gobierno** | Clientes públicos (B2G) | Medio. Interesados en la viabilidad de costos para programas de asistencia social. |

## 9. Autorización y Aprobaciones

**Aprobado por: Jeremías Daniel Maldonado Gómez**

---

Virginia Santos - Sponsor del Proyecto

Fecha:

---

Jeremías Daniel Maldonado Gómez - Director de Proyecto

Fecha:
