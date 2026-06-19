---
base: "[[Document Hub.base]]"
Created time: 2026-05-05T19:53:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Documentación Interna
Last updated time: 2026-05-05T20:36:00
---

# Acta de Constitución del Proyecto (Project Charter)

## 1. Información General

| Campo | Descripción |
| --- | --- |
| **Nombre del Proyecto** | Aurora |
| **Patrocinador (Sponsor)** | Virgina Santos |
| **Director del Proyecto (PM)** | Jeremías Daniel Maldonado Gómez |
| **Fecha de Elaboración** | 05/05/2026 |
| **Versión** | 1.0 |

---

## 2. Propósito y Justificación (Business Case)

### 2.1 Problema u Oportunidad

Aurora busca acompañar y monitorear pacientes con alzheimer o pacientes con problemas de memoria, para brindar una 

### 2.2 Alineación Estratégica

Aurora va a permitir a la organización aprobar la tesis final para recibirse de ingenieros y ser una solución útil que nos brinde experiencia como nuevos ingenieros

### 2.3 Estrategia de Monetización
- **Modelo Particular (B2C - Directo al Consumidor):** Enfocado en familias con pacientes en el hogar. Se monetizará mediante:
   - _Venta de Hardware (One-time fee):_ Adquisición inicial del dispositivo físico _Aurora Home_ (gabinete, Raspberry Pi, micrófonos y parlantes).         
   -  _Suscripción Mensual (SaaS):_ Un pago recurrente para el acceso a la aplicación _Aurora Care_ (para los cuidadores), procesamiento en la nube, analítica de datos de _Aurora Core_ y consumo de tokens de los LLMs.      

-  **Modelo Institucional (B2B - Business to Business):** Centros de salud privados, geriátricos y clínicas especializadas en neurología. Se ofrecerá un esquema de licenciamiento corporativo por volumen de pacientes monitoreados, permitiendo a la institución centralizar el control de múltiples usuarios desde un dashboard profesional.

 - **Modelo Gubernamental (B2G - Business to Government):** Programas de asistencia social o ministerios de salud. Contratos de provisión tecnológica a gran escala para subsidiar el ecosistema a sectores vulnerables.

---

## 3. Objetivos y Criterios de Éxito

| Objetivo (SMART)                            | Criterio de Éxito                                                                               |
| ------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| Aprobar la Tesis                            | Alcanzar un 80% o más a principios de noviembre para regularizar la tesis y poder defenderla    |
| Ser la mejor Tesis del año                  | Ser reconocida como la mejor tesis del año en el concurso que se realiza mediados de septiembre |
| Ofrecer una solución util para sus usuarios | Obtener al menos 10 usuarios que lo hayan usado y estén satisfechos                             |

---

### 4. Descripción y Alcance de Alto Nivel

#### 4.1 Descripción del Proyecto

El proyecto Aurora consiste en el diseño y desarrollo de un ecosistema tecnológico integrado de software y hardware enfocado en brindar acompañamiento cognitivo personalizado y monitoreo preventivo a pacientes en fases iniciales y moderadas de la enfermedad de Alzheimer o patologías asociadas a la pérdida de memoria. El objetivo fundamental de la solución es ralentizar el impacto del desgaste neurológico de estas afecciones, promoviendo la autonomía funcional y extendiendo la independencia del paciente dentro de su entorno doméstico. Paralelamente, el sistema está concebido para mitigar los niveles de estrés y sobrecarga (_burnout_) en los cuidadores primarios y el entorno familiar del paciente.

Este propósito se logrará mediante la interacción sinérgica de tres componentes principales:

1. Una interfaz conversacional física basada en voz (_Aurora Home_) que actuará como asistente interactivo en el hogar.

2. Un dispositivo corporal comercial (_Aurora Band_) para el seguimiento continuo de variables biométricas, eventos cinéticos y geolocalización.

3. Una plataforma de gestión web/móvil (_Aurora Care_) destinada al entorno de cuidado.

La orquestación completa de los datos, el filtrado de eventos, el análisis predictivo y la lógica conversacional inteligente serán gestionados en la nube por un núcleo centralizado (_Aurora Core_), el cual consumirá modelos de lenguaje de gran escala (LLM) optimizados mediante infraestructura de inferencia rápida, garantizando viabilidad económica, baja latencia en la voz y privacidad en el tratamiento de los datos.

#### 4.2 Entregables Principales

- **Entregable 1 - Módulo Aurora Home (Dispositivo de Voz Local):** Prototipo funcional de hardware embebido compuesto por una computadora de placa única (SBC), matriz de micrófonos de campo lejano, parlante integrado y un sistema de retroalimentación visual mediante indicadores LED. A nivel de software, incluirá la lógica local para la transcripción de voz a texto (STT), síntesis de habla (TTS) y un sistema de caché de consultas offline.

- **Entregable 2 - Módulo Aurora Band (Integración de Wearable Comercial):** Componente de software encargado del consumo, mapeo y normalización de las variables biométricas, acelerometría y coordenadas de posicionamiento (GPS) provistas por un reloj inteligente comercial con API abierta, sin manipulación de su firmware nativo.

- **Entregable 3 - Plataforma Aurora Care (Aplicación para Cuidadores):** Interfaz web y móvil responsiva destinada a los cuidadores. Permitirá la configuración de agendas de rutinas diarias, alertas de tratamiento médico, carga de bitácoras biográficas (base de conocimiento de recuerdos para la IA) y la recepción en tiempo real de notificaciones ante anomalías críticas.

- **Entregable 4 - Sistema Central Aurora Core (Backend y Orquestación de IA):** Infraestructura lógica centralizada en la nube responsable de la persistencia de datos, el procesamiento de algoritmos para la inferencia de caídas y deambulación (_geofencing_), la anonimización de registros médicos y la gestión de prompts con el modelo fundacional de IA seleccionado.

- **Entregable 5 - Cuerpo de Documentación Técnica y Académica:** Repositorio incremental que recopila los artefactos de ingeniería exigidos por la cátedra (Estudio Inicial, Plan de Proyecto, Registros de Decisión Arquitectónica [ADRs], Informes de Sprint, Planes de Testing, Manuales de Operación y el Paper de grado final) .


#### 4.3 Fuera de Alcance (Exclusiones)

- **Entornos físicos multifamiliares o institucionales masivos:** El sistema está diseñado y restringido conceptualmente para interactuar y procesar la información de un único paciente por hogar (entorno unifamiliar controlado).

- **Diseño, fabricación o modificación de hardware vestible:** El dispositivo físico _Aurora Band_ queda estrictamente excluido del desarrollo de hardware del equipo; el alcance del proyecto se limita exclusivamente al consumo de los datos crudos expuestos por las APIs del fabricante.

- **Infraestructura de red o conectividad autónoma celular en la vía pública:** Las alertas de localización en tiempo real fuera del hogar dependerán de la conectividad y el enlace Bluetooth del teléfono móvil del paciente o del cuidador como dispositivo puente. El proyecto no contempla la provisión de planes de datos móviles ni hardware de comunicación celular independiente en el reloj.

- **Pacientes fuera del perfil clínico estipulado:** El alcance conversacional y de asistencia de la Inteligencia Artificial está estrictamente delimitado para personas con un nivel de autonomía funcional equivalente al **Nivel 5 en la escala FAST** (_Functional Assessment Staging_ / Escala de Reisberg). Quedan excluidas las etapas severas de la enfermedad que presenten pérdida total de la comprensión verbal o de la capacidad de responder a estímulos auditivos.

---

## 5. Estructura WBS - Work Breakdown Structure

- 1. Gestión del Proyecto y Documentación Académica
    
    - 1.1. Instancia 1: Estudio Inicial y Plan de Proyecto

    - 1.2. Instancia 2: Working Agreement, Arquitectura y Product Backlog
    
    - 1.3. Instancia 3: Informes de Sprint y Trazabilidad (Sprints 1 a N)
    
    - 1.4. Instancia 4 y 5: Elaboración de Paper, Póster, Video y Documentación Final
    
- **2. Ingeniería de Datos e Inteligencia Artificial (Aurora Core)**
    
    - 2.1. Diseño del Modelo de Datos (Base de Datos Relacional/NoSQL)
    
    - 2.2. Configuración y Orquestación de APIs (Gemini / Claude)
    
    - 2.3. Desarrollo de la lógica de negocio y filtrado de eventos biométricos
    
    - 2.4. Ingeniería de Prompts y Base de Conocimiento (RAG) para terapias cognitivas
    
- **3. Desarrollo de Interfaces de Usuario**
    
    - 3.1. Diseño UX/UI de la aplicación web _Aurora Care_ (Figma)
    
    - 3.2. Desarrollo Frontend (Login, Dashboard del Paciente, Historial Biométrico)
    
    - 3.3. Implementación del sistema de notificaciones en tiempo real (WebSockets / Push)
    
- **4. Hardware e Interfaz de Voz (Aurora Home)**
    
    - 4.1. Ensamblado y configuración del sistema operativo en hardware (Raspberry Pi)
    
    - 4.2. Integración de periféricos (Módulos de audio, micrófonos e indicadores LED)
    
    - 4.3. Desarrollo del módulo de transcripción de voz a texto (STT) y texto a voz (TTS)
    
- **5. Integración de Dispositivo Biométrico (Aurora Band)**
    
    - 5.1. Conexión y consumo de la API/Bluetooth de la pulsera tercerizada
    
    - 5.2. Mapeo y normalización de datos de signos vitales (pulsaciones, oxígeno, etc.)
    
- 6. Aseguramiento de la Calidad (Testing) y DevOps
    
    - 6.1. Configuración de entornos (Desarrollo, Staging, Producción)
    
    - 6.2. Pipeline de Integración y Despliegue Continuo (CI/CD)
    
    - 6.3. Ejecución de Pruebas Unitarias, Integración y End-to-End (E2E)
    
- **7. Lanzamiento y Aspectos Legales**
    
    - 7.1. Redacción de Términos y Condiciones y Políticas de Privacidad de Datos Médicos
    
    - 7.2. Pruebas piloto con usuarios reales (Grupo de control de 10 usuarios)

---

### 6. Recursos y Presupuesto

El modelo financiero de Aurora se divide en el presupuesto inicial para el desarrollo del Producto Mínimo Viable (MVP) exigido para la tesis, y el costo operativo proyectado para su posterior etapa de producción bajo el modelo de negocio establecido.

#### 6.1 Presupuesto de Desarrollo (CAPEX - Inversión Inicial)

Este presupuesto contempla los gastos necesarios durante los 6 meses de desarrollo (Mayo - Noviembre 2026).

- **Hardware de Prototipado (Aurora Home & Band): $350.000 ARS aprox.**
    
    - _Cerebro y Audio:_ Placa SBC Raspberry Pi 4 (2GB/4GB), módulo matriz de micrófonos ReSpeaker 2-Mics Pi HAT, mini parlante interno (3W), fuente de alimentación y memoria MicroSD.
    
    - _Wearable:_ Reloj biométrico Amazfit Bip 5 (o similar con GPS integrado, acelerómetro y conectividad Bluetooth soportada por Zepp OS API).
    
    - _Gabinete:_ Diseño e impresión 3D del chasis contenedor de _Aurora Home_.
    
- **Infraestructura Cloud y APIs (Desarrollo): $60.000 ARS aprox.**
    
    - _Base de Datos y Backend:_ Entorno de desarrollo (ej. Supabase o VPS básica) durante 6 meses.
    
    - _Procesamiento IA:_ Consumo de tokens (pago por uso) utilizando modelos Open Weights (ej. Llama 3) vía proveedores de inferencia rápida (Tercera Vía, ej. Groq) para pruebas del equipo. Al ser micro-consumos de desarrollo, el costo es nominal ($10.000 ARS/mes).
    
- **Licencias y Herramientas: $0 ARS**
    
    - Se utilizarán repositorios gratuitos (GitHub) y licencias educacionales (Figma, IDEs).
    
- **Valorización de Mano de Obra (Aporte Ad Honorem): $8.064.000 ARS aprox.**
    
    - Basado en la capacidad del equipo (Capacity Planning), se disponen de **84 horas semanales totales** (Haik: 18h, Jere: 13h, Mateo: 16h, Nico: 22h, Octa: 15h).
    
    - Proyectado a 24 semanas (6 meses), representa **2.016 horas de ingeniería**. Valorizando simbólicamente la hora Junior a $4.000 ARS, se evidencia el costo real de mercado para desarrollar esta solución.
    

> **Presupuesto Total Estimado a Desembolsar:** $410.000 ARS (Cumpliendo holgadamente la restricción de no superar los $500.000 ARS establecidos).

#### 6.2 Costo Operativo Mensual (OPEX - Sistema en Producción)

Proyección financiera para mantener el sistema funcional con un grupo de control de **10 usuarios activos** interactuando diariamente con el ecosistema (Aurora Home + Aurora Band + Aurora Care):

| **Concepto Tecnológico**                  | **Detalle del Servicio**                                                                                                                                 | **Costo Mensual Estimado (USD)** |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| **Infraestructura de Backend**            | Servidor Virtual Privado (VPS) para alojar _Aurora Core_ (Node.js/Python).                                                                               | $10.00 USD                       |
| **Persistencia de Datos**                 | Base de Datos Relacional / NoSQL alojada en la nube con backups diarios.                                                                                 | $15.00 USD                       |
| **Consumo de Inteligencia Artificial**    | Procesamiento ultrarrápido de LLMs (ej. Llama 3 8B vía Groq). Estimando 2 millones de tokens por paciente al mes (20M tokens totales a $0.10 el millón). | $2.00 USD                        |
| **Total Operativo Mensual (10 usuarios)** | Punto de equilibrio técnico (Break-even de infraestructura).                                                                                             | **$27.00 USD / mes**             |

- _Nota Estratégica:_ Al ejecutar la transcripción de voz (STT) y la síntesis de audio (TTS) de manera **local** en el hardware de la Raspberry Pi de cada paciente, el costo operativo mensual en la nube se reduce drásticamente, haciendo que el modelo de negocio B2B y B2C propuesto sea altamente rentable y escalable.

### EQUIPO

| Nombre                              | Roles                                                                                 | Horas Semanales |
| ----------------------------------- | ------------------------------------------------------------------------------------- | --------------- |
| Romero Plaza, Mateo                 | DesarrolladorBackend, Administrador de Bases de Datos, Analista Funcional             | 16hs            |
| Kilic Aslan, Haik Martín            | Desarrollador Backend- Analista Funcional                                             | 18hs            |
| Rodeyro Contarino, Nicolás          | Diseñador UX/UI, Administrador de Base de Datos, Ingeniero AI, Desarrollador Frontend | 22hs            |
| Maldonado Gómez,<br>Jeremías Daniel | Project Manager-DevOps-Diseñador UX/UI                                                | 13hs            |
| Escudero, Octavio                   | DevOps, Frontend, Analista QA                                                         | 15hs            |
**Propuesta Metodológica**: La metodología a utilizar será Scrum con Sprints de 3 semanas. La técnica de estimación se basará en la capacidad del equipo (Capacity Planning). Contamos con un total de [84] horas semanales. Al inicio de cada Sprint, se estimará el esfuerzo de los tickets en horas y se asignarán asegurando no superar el rango horario de cada integrante, dejando un margen (buffer) del 20% para imprevistos.

---

## 7. Riesgos, Supuestos y Restricciones

### 7.1 Riesgos Principales (Amenazas)
| **ID** | **Riesgo (Amenaza)**                                                                           | **Probabilidad** | **Impacto** | **Estrategia de Mitigación**                                                                                                                                                    |
| ------ | ---------------------------------------------------------------------------------------------- | ---------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **R1** | **Falta de información médica útil para alimentar las terapias de _Aurora Home_.**             | Media            | Alto        | **Mitigar:** Realizar entrevistas con especialistas en gerontología/neurología en los primeros Sprints para validar el contenido.                                               |
| **R2** | **No conseguir una pulsera biométrica accesible o adecuada para _Aurora Band_.**               | Alta             | Alto        | **Evitar/Mitigar:** Investigar y adquirir smartwatches comerciales con APIs abiertas (ej. Xiaomi/Fitbit) en el Sprint 1. Tener un bypass en la App móvil si el hardware falla.  |
| **R3** | **Incremento exponencial en los costos de tokenización de las IA.**                            | Media            | Medio       | **Mitigar:** Implementar una capa de caché local para preguntas repetitivas y configurar alertas de facturación (budgets) diarias.                                              |
| **R4** | **Rechazo o baja adopción tecnológica por parte del paciente con Alzheimer.**                  | Alta             | Alto        | **Mitigar:** Diseñar una interfaz de voz extremadamente simple, sin comandos complejos, testeada iterativamente con adultos mayores.                                            |
| **R5** | **Filtración o vulnerabilidad en la seguridad de datos médicos sensibles.**                    | Baja             | Muy Alto    | **Mitigar:** Encriptar los datos biométricos de extremo a extremo y disociar los nombres reales de los pacientes de sus registros de salud en la base de datos (Anonimización). |
| **R6** | **Dificultad en la importación o abastecimiento de los componentes de hardware en Argentina.** | Media            | Alto        | **Evitar:** Comprar los componentes críticos (Raspberry Pi, micrófonos de matriz) al inicio del proyecto con los fondos iniciales.                                              |
| **R7** | **Sobrecarga de tareas o deserción de integrantes por falta de tiempo (Burnout).**             | Media            | Alto        | **Mitigar:** Revisar la capacidad real del equipo cada 3 semanas en la Sprint Planning. Si un integrante está saturado, redistribuir tickets o recortar alcance del MVP.        |

### 7.2 Supuestos del Proyecto

- Disponibilidad de APIs: Se asume que las APIs de los modelos fundacionales de Inteligencia Artificial (Gemini y Claude) mantendrán su disponibilidad, estabilidad técnica y términos de servicio estables durante todo el ciclo de desarrollo.

- Acceso a datos de Hardware Tercerizado: Se asume que el fabricante de la pulsera biométrica seleccionada para Aurora Band proveerá documentación abierta o SDK/API accesible que permita la extracción de datos biométricos en tiempo real sin costos ocultos de licenciamiento.  

- Validación de Profesionales: Se asume que el equipo logrará establecer contacto y recibir feedback de al menos dos especialistas médicos (neurólogos o gerontólogos) en las etapas tempranas para validar la base de conocimiento de terapias cognitivas.

- Conectividad del Entorno: Se asume que el hogar de pruebas piloto contará con una infraestructura de red Wi-Fi estable y continua para la comunicación entre Aurora Home y Aurora Core.

- Estabilidad del Equipo: Se asume el compromiso e ininterrumpida disponibilidad horaria acordada de los 5 integrantes del equipo de trabajo a lo largo de los Sprints académicos.

### 7.3 Restricciones (Constraints)

* **Restricción Presupuestaria:** El costo total del diseño, adquisición de hardware de prototipado y licencias preliminares de software para el desarrollo del MVP no debe exceder los $500.000 ARS inicialmente estipulados. 

* **Restricción Temporal Académica:** El proyecto está estrictamente atado al calendario académico 2026 de la UTN-FRC. El cierre absoluto de la ejecución debe realizarse el 05/10/2026 y el lanzamiento/entrega final inamovible es el 05/11/2026 para permitir la defensa de la tesis. 

* **Restricción de Hardware (Alcance):** El dispositivo _Aurora Band_ no será modificado a nivel de microcódigo o hardware; el alcance del equipo se restringe a la captura, transmisión y analítica de la información provista por el fabricante. 

* **Restricción de Entorno y Perfil:** El ecosistema está restringido para operar exclusivamente en entornos domésticos unifamiliares (un dispositivo por paciente) y para pacientes que presenten un nivel 5 de autonomía funcional en la escala de degradación del Alzheimer.

- **Restricción Legal de Datos:** Al capturar datos biométricos y de comportamiento diarios, el sistema debe restringirse y alinearse de manera obligatoria a la Ley 25.326 de Protección de Datos Personales en Argentina (encriptación y anonimización de registros médicos).

---

## 8. Interesados Clave (Stakeholders)

|**Nombre / Grupo**|**Rol en el Proyecto**|**Impacto / Expectativa principal**|
|---|---|---|
|**Cátedra Proyecto Final (UTN-FRC)**|Docentes evaluadores|**Muy Alto.** Exigen rigor metodológico y evalúan la viabilidad para la obtención del título.|
|**Virginia Santos**|Sponsor del Proyecto|**Alto.** Autoriza el Acta de Constitución y valida que se cumplan los objetivos estratégicos.|
|**Equipo de Desarrollo**|Creadores y gestores|**Muy Alto.** Responsables de la ejecución del sistema buscando regularizar y defender la tesis.|
|**Pacientes con Alzheimer**|Usuarios de _Aurora Home_|**Alto.** Requieren una interfaz de voz intuitiva que extienda su autonomía sin fricción.|
|**Cuidadores y Familiares**|Usuarios de _Aurora Care_|**Alto.** Esperan centralizar alertas en tiempo real, reportes fidedignos y mitigar el burnout.|
|**Centros de Salud y Geriátricos**|Clientes corporativos (B2B)|**Medio.** Buscan optimizar el monitoreo de múltiples pacientes desde un dashboard unificado.|
|**Ministerios / Entes de Gobierno**|Clientes públicos (B2G)|**Medio.** Interesados en la viabilidad de costos para programas de asistencia social.|

---

## 9. Autorización y Aprobaciones

**Aprobado por: Jeremías Daniel Maldonado Gómez**

---

VIrgina Santos - Sponsor del Proyecto

Fecha: 

---

Jeremías Daniel Maldonado Gómez - Director de Proyecto

Fecha: 

## Documentos relacionados
- [[Requerimientos]]
- [[Arquitectura y Stack Tecnológico]]
- [[Estudio Inicial]]
- [[Índice Aurora]]
