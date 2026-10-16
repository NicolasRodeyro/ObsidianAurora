---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-16
---

# Plan de Proyecto Aurora

## Introducción

Este documento es el Plan de Proyecto de Aurora. Define cómo el equipo organiza el trabajo: el acta de constitución, los objetivos y criterios de éxito, el alcance, la estructura de desglose del trabajo (WBS) y el cronograma, los recursos y el presupuesto, los riesgos, supuestos y restricciones, y los interesados. Se actualiza cuando cambia la realidad del proyecto.

## Audiencia

Está dirigido a los docentes, para evaluar la viabilidad del proyecto, y al equipo, como referencia durante el año.

## Acta de Constitución del Proyecto

## 1. Información General

| **Campo** | **Descripción** |
| --- | --- |
| **Nombre del Proyecto** | Aurora |
| **Patrocinador (Sponsor)** | Mgter Ing. Santos, Virginia |
| **Director del Proyecto (PM)** | Jeremías Daniel Maldonado Gómez |
| **Fecha de Elaboración** | 05/05/2026 |
| **Versión** | 1.0 |

## 2. Propósito y Justificación (Business Case)

### 2.1 Problema u Oportunidad

Aurora busca acompañar y monitorear pacientes con alzheimer o pacientes con problemas de memoria, para brindar una mejor calidad de vida y autonomía en el hogar.

### 2.2 Alineación Estratégica

Aurora va a permitir a la organización aprobar la tesis final para recibirse de ingenieros y ser una solución útil que nos brinde experiencia como nuevos ingenieros

### 2.3 Estrategia de Monetización (visión comercial)

Esta sección describe la visión comercial de largo plazo. Está fuera del alcance del proyecto y del MVP. El alcance actual es el que define el Estudio Inicial: hogares particulares, un paciente por hogar, sin instituciones ni entornos con múltiples pacientes.

- **Modelo Particular (B2C - Directo al Consumidor):** Enfocado en familias con pacientes en el hogar. Se monetizará mediante:
  - *Venta de Hardware (One-time fee):* Adquisición inicial del dispositivo físico *Aurora Home* (gabinete, Raspberry Pi, micrófonos y parlantes).
  - *Suscripción Mensual (SaaS):* Un pago recurrente para el acceso a la aplicación *Aurora Care* (para los cuidadores), procesamiento en la nube, analítica de datos de *Aurora Core* y consumo de tokens de los LLMs.
- **Modelo Institucional (B2B - Business to Business):** Centros de salud privados, geriátricos y clínicas especializadas en neurología. Podría ofrecerse, como evolución futura y fuera del alcance del proyecto, un esquema de licenciamiento corporativo por volumen de pacientes monitoreados, permitiendo a la institución centralizar el control de múltiples usuarios desde un dashboard profesional. Requeriría soportar múltiples pacientes por cuenta, roles institucionales y un panel profesional, funciones que hoy están explícitamente excluidas del alcance.
- **Modelo Gubernamental (B2G - Business to Government):** Programas de asistencia social o ministerios de salud. Como evolución futura y fuera del alcance del proyecto, podrían plantearse contratos de provisión tecnológica a gran escala para subsidiar el ecosistema a sectores vulnerables, lo que requeriría certificaciones y cumplimiento normativo que el proyecto no contempla.

Para habilitar B2B o B2G habría que revisar antes el alcance, el modelo de datos (un paciente por cuenta DOT) y el marco regulatorio.

## 3. Objetivos y Criterios de Éxito

Los objetivos se separan en dos grupos: los del producto (qué problema resuelve Aurora y cómo se mide) y los del equipo académico (qué necesita el equipo para cerrar el Proyecto Final). Solo los primeros son criterios de éxito del producto. Todos los indicadores del producto corresponden al MVP.

### 3.1 Objetivos del producto (SMART)

| **Objetivo** | **Indicador** | **Meta** | **Cómo se mide** |
| --- | --- | --- | --- |
| O1. Que el paciente reciba y responda sus recordatorios | Tasa de recordatorios con respuesta registrada (cumplido, rechazado o pospuesto) sobre los emitidos | ≥ 80 % durante el piloto | Registro de interacciones en Aurora Core. Se excluyen los horarios en que el cuidador marcó al paciente como ausente |
| O2. Que las alertas sean confiables | Falsos negativos: omisiones críticas de medicación sin alerta | 0 en los escenarios de prueba (100 % de las omisiones simuladas generan alerta) | Pruebas E2E con escenarios de omisión (ver Plan de Testing) |
| O2. Que las alertas sean confiables | Falsos positivos: alertas por omisión cuando el cuidador informa que sí se cumplió | ≤ 10 % de las alertas del piloto | Marca "falsa alerta" en Aurora Care y encuesta al cuidador |
| O3. Que el cuidador sea notificado a tiempo | Tiempo entre la detección de la omisión y la entrega de la notificación push | p95 ≤ 30 segundos | Marcas de tiempo del evento y del recibo de entrega |
| O4. Que la interacción por voz sea fluida | Tiempo de síntesis de voz de un recordatorio | < 2 segundos | Instrumentación de latencia en Aurora Home |
| O5. Que el sistema sea fácil de usar | Puntaje SUS (System Usability Scale) del cuidador | ≥ 68 | Cuestionario SUS al finalizar el piloto |
| O5. Que el sistema sea fácil de usar | Configuración inicial sin ayuda (alta de paciente, una rutina y una medicación) | ≥ 80 % de los cuidadores en 10 minutos o menos | Observación de sesiones de prueba |
| O6. Que el paciente y el cuidador lo acepten | Cuidadores que continúan usando el sistema hasta el final del piloto | ≥ 70 % | Registro de uso y entrevista de cierre |
| O6. Que el paciente y el cuidador lo acepten | Sesiones de actividad que el paciente completa sin abandonar | ≥ 70 % | Registro de sesiones de actividad |
| O7. Que las funciones críticas estén disponibles | Disponibilidad de recordatorios y alertas | ≥ 99 % durante el piloto, incluido el funcionamiento degradado sin internet | Monitoreo de salud de los servicios y de Aurora Home |

**Satisfacción de usuarios.** Se considera satisfecho al cuidador que, en el cuestionario de cierre, califique con 4 o más sobre 5 la utilidad general y obtenga un puntaje SUS (System Usability Scale) de 68 o más. Meta: al menos el 70 % de los usuarios del piloto conformado por 10 cuidadores que hayan utilizado Aurora Care durante las pruebas piloto y completado el cuestionario de satisfacción al finalizar la evaluación.

Los indicadores de falsos positivos y negativos en la detección de caídas, agitación y anomalías biométricas se definirán cuando esas funciones entren al alcance.

### 3.2 Objetivos del equipo académico (no son criterios de éxito del producto)

| **Objetivo** | **Criterio** |
| --- | --- |
| Aprobar y regularizar el Proyecto Final | Alcanzar el puntaje requerido por la cátedra y defender el trabajo en la fecha de entrega (05/11/2026) |
| Entregar documentación consistente y trazable | Requisitos, riesgos, pruebas y arquitectura coherentes entre sí (checklist de consistencia al cierre) |

## 4. Descripción y Alcance de Alto Nivel

### 4.1 Descripción del Proyecto

El proyecto Aurora consiste en el diseño y desarrollo de un ecosistema tecnológico integrado de software y hardware enfocado en brindar acompañamiento cognitivo personalizado y monitoreo preventivo a pacientes en fases iniciales y moderadas de la enfermedad de Alzheimer o patologías asociadas a la pérdida de memoria. El objetivo fundamental de la solución es ralentizar el impacto del desgaste neurológico de estas afecciones, promoviendo la autonomía funcional y extendiendo la independencia del paciente dentro de su entorno doméstico. Paralelamente, el sistema está concebido para mitigar los niveles de estrés y sobrecarga (*burnout*) en los cuidadores primarios y el entorno familiar del paciente.

Este propósito se logrará mediante la interacción sinérgica de tres componentes principales:

1. Una interfaz conversacional física basada en voz (*Aurora Home*) que actuará como asistente interactivo en el hogar.
2. Un núcleo centralizado en la nube (Aurora Core) que gestiona los datos, la lógica de negocio y la inteligencia artificial.
3. Una plataforma de gestión web/móvil (*Aurora Care*) destinada al entorno de cuidado.

La orquestación completa de los datos, el procesamiento de eventos de cumplimiento y la lógica conversacional inteligente serán gestionados en la nube por Aurora Core, el cual consumirá modelos de lenguaje de gran escala (LLM) optimizados mediante infraestructura de inferencia rápida, garantizando viabilidad económica, baja latencia en la voz y privacidad en el tratamiento de los datos. La integración con un dispositivo corporal comercial (Aurora Band) queda como evolución futura, fuera del MVP.

### 4.2 Entregables Principales

- **Entregable 1 - Módulo Aurora Home (Dispositivo de Voz Local):** Prototipo funcional de hardware embebido compuesto por una computadora de placa única (SBC), matriz de micrófonos de campo lejano, parlante integrado y un sistema de retroalimentación visual mediante indicadores LED. A nivel de software, incluirá el pipeline de voz (transcripción y síntesis con proveedor en la nube y respaldo local) y una cola local de eventos para el funcionamiento sin conexión.
- **Entregable 2 - Integración con wearable comercial (Aurora Band), postergada:** queda fuera del MVP por restricción presupuestaria (decisión del 29/08/2026). No se compra hardware ni se integra la API del fabricante en este ciclo.
- **Entregable 3 - Plataforma Aurora Care (Aplicación para Cuidadores):** Aplicación móvil multiplataforma para Android e iOS, desarrollada con React Native, destinada a los cuidadores. Permitirá la configuración de agendas de rutinas diarias, alertas de tratamiento médico, carga de bitácoras biográficas (base de conocimiento de recuerdos para la IA) y la recepción en tiempo real de notificaciones ante omisiones críticas de medicación o rutinas.
- **Entregable 4 - Sistema Central Aurora Core (Backend y Orquestación de IA):** Infraestructura lógica centralizada en la nube responsable de la persistencia de datos, el cifrado de los datos identificatorios del paciente y la gestión de prompts con el modelo fundacional de IA seleccionado.
- **Entregable 5 - Cuerpo de Documentación Técnica y Académica:** Repositorio incremental que recopila los artefactos de ingeniería exigidos por la cátedra (Estudio Inicial, Plan de Proyecto, Registros de Decisión Arquitectónica [ADRs], Informes de Sprint, Planes de Testing, Manuales de Operación y el Paper de grado final).

### 4.3 Fuera de Alcance (Exclusiones)

- **Entornos físicos multifamiliares o institucionales masivos:** El sistema está diseñado y restringido conceptualmente para interactuar y procesar la información de un único paciente por hogar (entorno unifamiliar controlado). Esto incluye geriátricos, clínicas y programas gubernamentales, que solo se mencionan como visión comercial futura (ver 2.3).
- **Diseño, fabricación o modificación de hardware vestible:** El dispositivo físico *Aurora Band* queda estrictamente excluido del desarrollo de hardware del equipo; el alcance del proyecto se limita exclusivamente al consumo de los datos crudos expuestos por las APIs del fabricante, y esa integración queda fuera del MVP.
- **Infraestructura de red o conectividad autónoma celular en la vía pública:** Las alertas de localización en tiempo real fuera del hogar dependen de la conectividad y el enlace Bluetooth del teléfono móvil del paciente o del cuidador como dispositivo puente. El proyecto no contempla la provisión de planes de datos móviles ni hardware de comunicación celular independiente al reloj.
- **Pacientes fuera del perfil clínico estipulado:** El alcance conversacional y de asistencia de la Inteligencia Artificial está estrictamente delimitado para personas con un nivel de autonomía funcional igual o inferior al Nivel 5 en la escala FAST (*Functional Assessment Staging* / Escala de Reisberg). Quedan excluidas las etapas severas de la enfermedad que presenten pérdida total de la comprensión verbal o de la capacidad de responder a estímulos auditivos.

## 5. Estructura WBS - Work Breakdown Structure

1. **Gestión del Proyecto y Documentación Académica:**
  1. Instancia 1: Estudio Inicial y Plan de Proyecto
  2. Instancia 2: Working Agreement, Arquitectura y Product Backlog
  3. Instancia 3: Informes de Sprint y Trazabilidad (Sprints 1 a N)
  4. Instancia 4 y 5: Elaboración de Paper, Póster, Video y Documentación Final
2. **Ingeniería de Datos e Inteligencia Artificial (Aurora Core)**
  5. Diseñar Esquema DB (Supabase)
  6. Configuración de la integración con el proveedor de modelos de lenguaje (configurable por entorno)
  7. Lógica de negocio: rutinas, medicación, recordatorios y registro de respuestas
  8. Ingeniería de Prompts y memoria del paciente para terapias cognitivas y reminiscencia
  9. Lógica de alertas por omisión crítica y clasificación de eventos del MVP.
3. **Desarrollo de Interfaces de Usuario (Aurora Care)**
  10. Diseño UX/UI de la aplicación web *Aurora Care* (Figma)
  11. Desarrollar Frontend React Native.
  12. Implementación del sistema de notificaciones en tiempo real push nativas.
  13. Pantallas de estado del paciente, dispositivos e historial de cumplimiento.
4. **Hardware e Interfaz de Voz (Aurora Home)**
  14. Ensamblado y configuración del sistema operativo en hardware (Raspberry Pi 5)
  15. Integración de periféricos (Módulos de audio, micrófonos e indicadores LED)
  16. Pipeline de voz: transcripción (STT) y síntesis (TTS) con proveedor en la nube y respaldo local
  17. Lógica de interacción vocal y de ejecución de actividades.
  18. Modo offline y cola de eventos pendientes.
5. **Aseguramiento de la Calidad (Testing) y DevOps**
  19. Configuración de entornos (Desarrollo, Staging, Producción)
  20. Pipeline de Integración y Despliegue Continuo (CI/CD)
  21. Ejecución de Pruebas Unitarias, Integración y End-to-End (E2E)
6. **Lanzamiento y Aspectos Legales**
  22. Redacción de Términos y Condiciones y Políticas de Privacidad de Datos Médicos
  23. Pruebas piloto con usuarios reales (Grupo de control de 10 usuarios)

Futuras versiones (fuera del MVP, no se desarrollan en este proyecto): integración de dispositivo biométrico (Aurora Band), detección de eventos de riesgo (caídas, deambulación, agitación y zonas seguras), comunicación de emergencia (llamadas automáticas) y reportes exportables.

## 6. Recursos y Presupuesto

El modelo financiero de Aurora se divide en el presupuesto inicial para el desarrollo del Producto Mínimo Viable (MVP) exigido para la tesis, y el costo operativo proyectado para su posterior etapa de producción bajo el modelo de negocio establecido.

### 6.1 Presupuesto de Desarrollo (CAPEX - Inversión Inicial)

Este presupuesto contempla los gastos necesarios durante los 6 meses de desarrollo (Mayo - Noviembre 2026). Se actualiza con los costos reales: estimado inicial (Acta de Constitución, 05/05/2026), real (comprado) y pendiente. Los importes en dólares se convirtieron a pesos al tipo de cambio de la compra (aproximadamente $1.533 por USD).

**Desglose de Inversión Inicial (CAPEX): estimado, real y pendiente**

Estado al 12/10/2026. Se muestran el estimado inicial, lo comprado hasta hoy y lo pendiente:

| **Categoría** | **Componente** | **Estimado inicial** | **Real (comprado)** | **Pendiente** | **Estado** |
| --- | --- | --- | --- | --- | --- |
| **Hardware Aurora Home** | Kit Raspberry Pi 5 de 8 GB (placa, microSD de 64 GB, 2 lectores de tarjeta, disipador activo, gabinete, 2 cables micro-HDMI a 4K y fuente GaN USB-C de 27 W), USD 257 | $200.000 (Pi 4, fuente y microSD) | $393.988,45 | $0 | Comprado |
|   | ReSpeaker 2-Mics Pi HAT v2.0 y parlante Seeed Studio 4 Ω 5 W (se compraron juntos) | $100.000 | $66.640,00 | $0 | Comprado |
|   | Cable plano IDE de 40 pines, 9,5 cm | No previsto | $20.655,00 | $0 | Comprado |
|   | Gabinete impreso en 3D | $50.000 | $21.000,00 | $0 | Impreso |
| **Wearable** | Pulsera AmazFit Bip 5 o similar | $100.000 | $0 | $0 | Descartada: Aurora Band queda fuera del MVP |
| **Subtotal hardware de Aurora Home** | Sin pulsera ni infraestructura | $350.000 | $502.283,45 | $0 |   |
| **Infraestructura** | VPS Hostinger, dominio y servicios en la nube (voz e IA), 3 meses | $60.000 | $ 72.017 | $42.892 | VPS comprado mes septiembre y octubre.<br>Falta noviembre. |
| **Mano de Obra** | Valorización simbólica (equipo, 2.016 hs ad honorem) | $8.064.000 | No se desembolsa | No se desembolsa | Aporte del equipo |

Frente al tope de la restricción presupuestaria, la situación es la siguiente:

| **Indicador** | **Valor** |
| --- | --- |
| **Tope de la restricción presupuestaria** | $500.000 |
| **Gasto real (hardware de Aurora Home e infraestructura)** | $574.300,45 ($502.283,45 + $72.017) |
| **Desvío ya confirmado sobre el tope** | +$74.300,45 (+14,9 %) |
| **Gasto pendiente** | Mes de noviembre de Hostinger: $42.892. Con ese pago el total llega a $617.192,45 (+$117.192,45, +23,4 % sobre el tope) |

**El tope de $500.000 ya está superado: el hardware solo lo excede, y con la infraestructura el gasto real llega a $574.300,45. Falta pagar el mes de noviembre de Hostinger ($42.892), con lo que el total proyectado es $617.192,45.** El desvío se registra como riesgo R13 con su plan de contención.

**Análisis del desvío.** La diferencia principal está en la Raspberry Pi: la estimación original era de $200.000 para placa, fuente y microSD (Pi 4), y el kit de Pi 5 de 8 GB costó $393.988,45. Se compensa en parte porque el módulo de audio con el parlante costó $66.640 en lugar de $100.000, el gabinete impreso costó $21.000 en lugar de $50.000 y no se compró la pulsera ($100.000). Como la placa se pagó en dólares, el costo en pesos fue calculado en el momento que se compró la placa, el cuál fué de: 256,67 usd. *(1 dólar = $1535 pesos argentinos - Julio de 2026).*

**Plan de contención:** (a) la pulsera queda descartada; (b) no se compran más componentes de hardware; (c) infraestructura: Se priorizará el uso de planes gratuitos y recursos locales para el desarrollo y las pruebas. Se establecerán límites de consumo y alertas de gasto en los servicios de nube, voz e inteligencia artificial. No se contratarán nuevos servicios pagos hasta contar con la autorización presupuestaria correspondiente; (d) se informa a la cátedra del desvío y se solicita la ratificación del tope o su ajuste, con este detalle como respaldo.

### 6.2 Costo Operativo Mensual (OPEX - Sistema en Producción)

Proyección financiera para mantener el sistema funcional con un grupo de control de **10 usuarios activos** interactuando diariamente con el ecosistema (Aurora Home + Aurora Care):

| **Concepto Tecnológico** | **Detalle del Servicio** | **Costo Mensual Estimado (USD)** |
| --- | --- | --- |
| **Infraestructura de Backend** | Servidor Virtual Privado (VPS) para alojar Aurora Core y el Worker IA (Python/Django). | $10.00 USD |
| **Persistencia de Datos** | Supabase (PostgreSQL con pgvector, autenticación y almacenamiento de archivos). Hoy se usa el plan gratuito (Free); el monto es una estimación para un plan pago con backups diarios. | $15.00 USD (estimado; hoy $0 con el plan Free) |
| **Consumo de Inteligencia Artificial** | Modelo de lenguaje con proveedor configurable (hoy Gemini 3.5 Flash Lite de Google). El costo depende del uso real. | $5,00 USD/mes (presupuesto inicial estimado). El consumo real registrado es de USD 0,39 al 15/10/2026. |
| **Servicios de voz en la nube** | Azure Speech (reconocimiento y síntesis de voz). Hoy se usa el nivel gratuito (F0); en producción habría que presupuestar el nivel pago. | $0,00 USD/mes durante la etapa de pruebas (nivel gratuito F0). |
| **Total Operativo Mensual (10 usuarios)** | Punto de equilibrio técnico (Break-even de infraestructura). | $30,00USD/mes estimados como base, sujetos a costos adicionales de Azure Speech y a la validación del consumo real con 10 usuarios activos. |

*Nota Estratégica:* La voz se procesa primero en la nube (Azure) con respaldo local en la Raspberry Pi cuando no hay conexión; el costo de los servicios de voz se incluye en el costo operativo mensual. El modelo de negocio B2C propuesto depende de que ese costo, junto con el de la IA, quede por debajo del valor de la suscripción.

**Equipo de Trabajo**

| **Nombre** | **Roles** | **Horas Semanales** |
| --- | --- | --- |
| **Romero Plaza, Mateo** | Frontend, Base de datos, Aurora Home, Analista funcional | 16 hs |
| **Kilic Aslan, Haik Martín** | Backend, Backend del Worker IA, Analista funcional, Product Owner | 18 hs |
| **Rodeyro Contarino, Nicolás** | Frontend, Base de datos, Diseño UX/UI | 22 hs |
| **Maldonado Gómez, Jeremías Daniel** | Project Manager, DevOps, Diseño UX/UI, Scrum Master | 13 hs |
| **Escudero, Octavio** | Backend, Backend del Worker IA, Aurora Home | 15 hs |

**Propuesta Metodológica**: La metodología a utilizar será Scrum con Sprints de 3 semanas. La técnica de estimación se basará en la capacidad del equipo (Capacity Planning). Contamos con un total de 84 horas semanales. Al inicio de cada Sprint, se estimará el esfuerzo de los tickets en horas y se asignan asegurando no superar el rango horario de cada integrante, dejando un margen (buffer) del 20% para imprevistos.

**Métricas de seguimiento:** en cada Sprint Review y retrospectiva el equipo revisa las métricas siguientes, tomadas del tablero de Jira y de los repositorios, y analiza su tendencia respecto de los sprints anteriores en lugar de presentar sólo el número. Las estimaciones se hacen por juicio del equipo, en horas y sin una técnica formal; por eso se informa el cumplimiento y el desvío del sprint y no una velocidad en puntos de historia. Las metas son una propuesta del equipo.

- **Cumplimiento del sprint:** tickets Finalizados sobre los tickets comprometidos al inicio del sprint. Meta: al menos 80 %.
- **Desvío de cierre:** días entre la fecha planificada y la fecha real de cierre del sprint. Meta: hasta 2 días.
- **Carga por integrante:** horas estimadas contra la capacidad semanal declarada, con el margen del 20 % para imprevistos. Meta: ninguna persona está por encima de su capacidad.
- **Trabajo arrastrado:** tickets que pasan al sprint siguiente sin terminarse. Meta: se registra la causa de cada uno.
- **Incidencias abiertas por criticidad:** errores P1 y P2 abiertos al cierre del sprint (ver Plan de Testing, sección 5). Meta: ningún P1 abierto al cierre.
- **Calidad del código:** pruebas pasando y cobertura del código nuevo (ver Plan de Testing, sección 4.7). Meta: al menos 80 % de cobertura.
- **Mejora del proceso:** porcentaje de los action items de la retrospectiva anterior que se implementaron.

Aclaración: en los Sprints 0 a 2 los valores «planificados» de Jira no son confiables (dos iteraciones llamadas Sprint 0, tickets arrastrados y tickets sin sprint). Para ese período solo se informan los tickets Finalizados, como se detalla en el Informe de Sprints.

**Cronograma**

| **Sprint / Etapa** | **Periodo** | **Objetivo principal** | **Hito** |
| --- | --- | --- | --- |
| **Sprint 1** | 22/06 al 12/07 | Construir la base técnica del ecosistema | Inicio de infraestructura |
| **Sprint 2** | 13/07 al 02/08 | Implementar los primeros componentes funcionales | **Release 1: Base técnica** |
| **Sprint 3** | 03/08 al 23/08 | Incorporar inteligencia artificial e integración entre módulos | Integración parcial |
| **Sprint 4** | 24/08 al 13/09 | Integrar los flujos críticos del MVP (recordatorio, respuesta y alerta al cuidador) | **Release 2: Integración funcional** |
| **Sprint 5** | 14/09 al 04/10 | Validar y estabilizar las funcionalidades desarrolladas | **Release 3: Candidata final** |
| **Sprint 6** | 05/10 al 25/10 | Estabilizar la solución, corregir incidencias y completar la documentación final | Documentación, paper, video y demo |
| **Preparación final** | 26/10 al 05/11 | Preparar la exposición, revisión final y entrega definitiva | **Presentación final: 05/11** |

![Diagrama de Gantt](images/Diagrama%20de%20Gantt.png)

El proyecto Aurora se organiza en seis sprints consecutivos de tres semanas. Los dos primeros sprints se enfocan en construir la base técnica, definir la arquitectura y desarrollar los primeros componentes funcionales. Los Sprints 3 y 4 concentran la integración de la inteligencia artificial, la interacción por voz, el procesamiento de eventos, el historial y el funcionamiento offline.

El Sprint 5 está destinado a la validación, calibración de los componentes de inteligencia artificial y ejecución de pruebas integrales. Al finalizar este sprint se obtiene la release candidata y se alcanza el cierre técnico del proyecto.

El Sprint 6 se utiliza para estabilizar la solución, corregir incidencias, completar la documentación académica y técnica. El periodo restante hasta el 5 de noviembre queda reservado para la preparación de la exposición y la entrega definitiva.

Nota sobre la numeración: el campo "Sprint" de Jira no coincide con la numeración de sprints de la documentación. Este documento usa la numeración de la documentación y, en los informes de sprint, aclara a qué iteración de Jira corresponde cada uno.

**Estrategia de Trabajo en Paralelo (Reglas de Oro)**

Deben aplicar estas reglas para que el trabajo paralelo no genere conflictos:

- **Contratos de API primero:** Antes de empezar a programar Aurora Care o Aurora Home, el encargado de **Aurora Core (Backend)** debe definir el "Contrato de API" (Swagger/OpenAPI). Así, el encargado del Frontend y el de Aurora Home pueden trabajar con *mocks* (datos falsos) sin esperar a que el Core esté terminado.
- **Infraestructura como Código (IaC):** El encargado de DevOps debe crear un **docker-compose** inicial. Los demás integrantes solo deben ejecutar **docker-compose up** para tener el entorno listo. No deben perder tiempo configurando dependencias.
- **Documentación como "Definition of Done":** Ninguna tarea se considera terminada si no se actualizó el manual técnico. Si el integrante de **Aurora Home** termina el pipeline de voz, debe actualizar el Manual de Operación inmediatamente. Esto evita el cuello de botella de documentación en noviembre.
- **Gestión de conflictos:** Utilizar ramas **feature/**  estrictas. Si dos personas tocan la misma parte del código (ej: Auth), deben reunirse 15 min antes de empezar para acordar la estructura.

### 6.3 Flujo de Fondos y Estrategias de Monetización

### Flujo de Fondos del Proyecto

El flujo de fondos del proyecto Aurora permite estimar los ingresos, egresos e inversión necesaria para desarrollar, validar y sostener económicamente la solución. Dado que el proyecto se encuentra en una etapa académica y de validación inicial, el análisis financiero se divide en dos momentos: una etapa de desarrollo del MVP y una etapa futura de operación comercial.

#### Etapa 1: Desarrollo del MVP

Durante la etapa de desarrollo del Producto Mínimo Viable, el proyecto no generará ingresos comerciales, ya que el foco estará puesto en el diseño, construcción, prueba y validación funcional del sistema.

Los principales egresos previstos para esta etapa son:

- Compra de hardware para el prototipo de Aurora Home.
- Costos de infraestructura cloud y APIs durante el desarrollo.
- Impresión o armado del gabinete físico del dispositivo.
- Costos operativos asociados a pruebas, conectividad y servicios externos.

El presupuesto estimado inicial era de $510.000 ARS sin mano de obra. Al 12/10/2026 el hardware de Aurora Home ya suma $502.283,45 y, con la infraestructura, el gasto real llega a $574.300,45 (ver 6.1). La mano de obra del equipo se considera aporte ad honorem, ya que el proyecto se desarrolla en el marco académico de Proyecto Final.

#### Etapa 2: Validación con Usuarios Piloto

Una vez desarrollado el MVP, se prevé una etapa de validación con un grupo reducido de usuarios piloto. El objetivo de esta fase será comprobar la utilidad del sistema, la aceptación por parte de cuidadores y pacientes, la confiabilidad de las alertas y la viabilidad técnica del ecosistema.

En esta etapa, los ingresos pueden ser nulos o simbólicos, ya que el foco principal será obtener retroalimentación y validar el funcionamiento real del sistema. Los egresos estarán asociados principalmente al mantenimiento de la infraestructura, consumo de servicios de IA, soporte técnico y eventuales ajustes del hardware.

Para un grupo inicial de 10 usuarios activos, el costo operativo mensual estimado es de aproximadamente 27 USD mensuales, contemplando infraestructura de backend, persistencia de datos y consumo de inteligencia artificial.

#### Etapa 3: Operación Comercial

En una futura etapa de producción, Aurora podrá comenzar a generar ingresos mediante la venta del dispositivo físico Aurora Home y el cobro de una suscripción mensual por el uso del ecosistema digital.

Los ingresos proyectados surgirán principalmente de:

- Venta inicial del dispositivo Aurora Home.
- Suscripción mensual por acceso a Aurora Care.
- Servicios de procesamiento, almacenamiento, alertas y analítica en Aurora Core.

Los egresos recurrentes estarán compuestos por:

- Infraestructura cloud.
- Base de datos y almacenamiento.
- Consumo de modelos de inteligencia artificial.
- Servicios externos de notificación, telefonía o mensajería.
- Soporte técnico y mantenimiento.
- Reposición o actualización de hardware.
- Mejoras evolutivas del sistema.

### 6.4 Flujo de Fondos Básico Proyectado

| **Concepto** | **Etapa MVP** | **Etapa Piloto** | **Etapa Comercial** |
| --- | --- | --- | --- |
| **Venta de hardware Aurora Home** | $0 | $0 o bonificado | Ingreso inicial por dispositivo |
| **Suscripción mensual** | $0 | $0 o valor simbólico | Ingreso recurrente mensual |
| **Infraestructura cloud** | Egreso | Egreso | Egreso operativo |
| **Consumo de IA** | Egreso | Egreso | Egreso variable según uso |
| **Hardware de prototipo** | Egreso inicial | Reposición puntual | Costo de producción o compra |
| **Soporte y mantenimiento** | Aporte del equipo | Aporte del equipo | Egreso operativo |
| **Resultado esperado** | Negativo | Negativo o equilibrado | Positivo si la suscripción supera el costo operativo |

Este flujo refleja que Aurora requiere una inversión inicial durante el desarrollo y validación, pero presenta potencial de sostenibilidad económica si logra convertir su modelo en una combinación de venta de hardware y suscripción mensual.

### 6.5 Estrategias de Monetización

Aurora podrá monetizarse, en primera instancia, mediante un modelo B2C, el cual está orientado a familias que tienen un paciente con pérdida de memoria o deterioro cognitivo dentro del hogar. Los modelos B2B y B2G se describen como visión futura en 2.3 y no forman parte del alcance del proyecto.

La monetización se plantea mediante:

- Venta inicial del dispositivo Aurora Home.
- Suscripción mensual para acceder a Aurora Care.
- Procesamiento en la nube mediante Aurora Core.
- Gestión de rutinas, alertas, historial, reportes y memoria contextual.
- Consumo de servicios de inteligencia artificial.

Este modelo permite que una familia adquiera el dispositivo físico y luego pague una cuota mensual para mantener activo el servicio. La cuota debería cubrir los costos operativos de infraestructura, IA, almacenamiento, soporte y dejar un margen de rentabilidad.

### 6.6 Estrategia de Precios Inicial

Para una futura etapa comercial, se propone una estrategia de precios compuesta por dos elementos:

- Un pago inicial por el dispositivo Aurora Home, destinado a cubrir el costo del hardware, ensamblado, gabinete, configuración inicial y margen de comercialización.
- Una suscripción mensual, destinada a cubrir infraestructura, almacenamiento, IA, notificaciones, soporte y mantenimiento evolutivo.

De esta forma, el proyecto evita depender únicamente de la venta inicial del hardware y construye un ingreso recurrente que permite sostener el funcionamiento del sistema a largo plazo.

Considerando un costo operativo estimado de 27 USD mensuales para 10 usuarios activos, el costo técnico promedio por usuario sería bajo. Esto permite proyectar que, con una suscripción mensual razonable, Aurora podría cubrir sus costos de infraestructura y generar margen para soporte, mantenimiento y evolución del producto.

La voz se procesa primero en la nube con respaldo local en Aurora Home. El audio solo se envía durante las ventanas de interacción (recordatorios y actividades) y los servicios de voz forman parte del costo operativo mensual.

## 7. Riesgos, Supuestos y Restricciones

### 7.1 Riesgos Principales (Amenazas)

Los riesgos de seguridad del paciente (R8, R9, R10 y R11) se tratan como prioritarios: una falla no es solo un defecto funcional, porque una alerta que no llega o una respuesta incorrecta del asistente puede influir en la conducta de un paciente o en la reacción de un cuidador ante una situación potencialmente crítica.

| **ID** | **Riesgo (Amenaza)** | **Probabilidad** | **Impacto** | **Estrategia de Mitigación** |
| --- | --- | --- | --- | --- |
| **R1** | Falta de información médica útil para alimentar las terapias de Aurora Home. | Media | Alto | Mitigar: validación realizada con una psicopedagoga y con profesionales del ámbito de la neurología (ver Dominio clínico en el Estudio Inicial). Pendiente formalizar fechas y alcance. |
| **R2** | No conseguir una pulsera biométrica accesible o adecuada para Aurora Band. Riesgo materializado: queda fuera del MVP. | Alta | Alto | Aceptado: Aurora Band queda fuera del MVP (decisión del 29/08/2026 por restricción presupuestaria). No se compra hardware ni se integra la API del fabricante. Se conserva la visión y el código inerte. |
| **R3** | Incremento exponencial en los costos de tokenización de las IA. | Media | Medio | Mitigar: Implementar una capa de caché local para preguntas repetitivas y configurar alertas de facturación (budgets) diarias. |
| **R4** | Rechazo o baja adopción tecnológica por parte del paciente con Alzheimer. | Alta | Alto | Mitigar: Diseñar una interfaz de voz extremadamente simple, sin comandos complejos, testeada iterativamente con adultos mayores. |
| **R5** | Filtración o vulnerabilidad en la seguridad de datos médicos sensibles. | Baja | Muy Alto | Mitigar: cifrar los datos identificatorios en la base (Fernet), usar conexiones cifradas, registrar el consentimiento y definir una política de retención verificable; revisar qué datos salen del hogar hacia proveedores externos. |
| **R6** | Dificultad en la importación o abastecimiento de los componentes de hardware en Argentina. | Media | Alto | Mitigado: la Raspberry Pi 5, el módulo de audio con el parlante, el cable y el gabinete ya fueron comprados. |
| **R7** | Sobrecarga de tareas o deserción de integrantes por falta de tiempo (Burnout). | Media | Alto | Mitigar: Revisar la capacidad real del equipo cada 3 semanas en la Sprint Planning. Si un integrante está saturado, redistribuir tickets o recortar alcance del MVP. |
| **R8** | Falso negativo: el sistema no detecta o no comunica una situación que el cuidador debería conocer (por ejemplo, un recordatorio sin respuesta que no genera alerta). | Media | Muy Alto | Mitigar: probar de punta a punta el flujo recordatorio, respuesta y alerta (Plan de Testing, métricas críticas), registrar cada alerta con su estado de envío y revisar los casos no entregados. |
| **R9** | Falso positivo: alertas innecesarias que generan fatiga en el cuidador y la pérdida de confianza en el sistema. | Media | Alto | Mitigar: ajustar los umbrales con el uso real, evitar alertas duplicadas y permitir al cuidador configurar qué avisos recibe. |
| **R10** | Indisponibilidad de conectividad: sin internet, Aurora Home no puede usar los servicios en la nube (voz, IA y Aurora Core) y los avisos al cuidador pueden demorarse. | Media | Alto | Mitigar: reconocimiento y síntesis de voz locales de respaldo (Whisper.cpp y Piper), datos locales en SQLite y reenvío de lo pendiente al recuperar la conexión. Verificar el comportamiento sin conexión en las pruebas. |
| **R11** | Alucinaciones de la IA: respuestas incorrectas, inventadas o inapropiadas que pueden confundir al paciente o simular un diagnóstico o una recomendación médica. | Media | Muy Alto | Mitigar: límites explícitos en las instrucciones del asistente (no diagnosticar ni recomendar tratamientos), respuestas basadas en la memoria registrada del paciente, validación de los textos terapéuticos con profesionales y revisión de conversaciones de prueba. |
| **R12** | Fallas biométricas diferidas: al dejar Aurora Band fuera del MVP, el sistema no mide frecuencia cardíaca, movimiento ni ubicación, y esas funciones llegarían sin validación previa. | Alta | Medio | Aceptado: se documenta como trabajo futuro y se valida con datos reales antes de habilitarlas. El MVP no ofrece monitoreo biométrico ni detección de caídas. |
| **R13** | Desvío presupuestario materializado: el hardware ya superó el tope de $500.000 y, con la infraestructura, el gasto real llega a $574.300,45 (ver sección 6.1). | Alta (ocurrido) | Medio | Mitigar: no comprar más hardware, informar a la cátedra y solicitar la ratificación del tope o su ajuste. Plan de contención en la sección 6.1. |
| **R14** | Dependencia de proveedores externos (Azure, Gemini de Google, Supabase, Hostinger, Expo): cambios de precio, de condiciones o caídas del servicio. | Media | Alto | Mitigar: proveedor de IA configurable, voz local de respaldo, datos portables (PostgreSQL) y seguimiento de costos y cuotas de cada servicio. |

### 7.2 Supuestos del Proyecto

- Disponibilidad de APIs: Se asume que las APIs de los modelos fundacionales de Inteligencia Artificial (hoy Gemini de Google y Azure, con OpenAI como alternativa configurable) mantendrán su disponibilidad, estabilidad técnica y términos de servicio estables durante todo el ciclo de desarrollo.
- Acceso a datos de Hardware Tercerizado (futuras versiones, fuera del MVP): Se asume que, si se retoma la integración, el fabricante de la pulsera biométrica seleccionada para Aurora Band proveerá documentación abierta o SDK/API accesible que permita la extracción de datos biométricos en tiempo real sin costos ocultos de licenciamiento.
- Validación de Profesionales: El equipo recibió validación de una psicopedagoga y de profesionales del ámbito de la neurología sobre las terapias y los estadios cubiertos (ver Dominio clínico en el Estudio Inicial).
- Conectividad del Entorno: Se asume que el hogar de pruebas piloto contará con una infraestructura de red Wi-Fi estable y continua para la comunicación entre Aurora Home y Aurora Core.
- Estabilidad del Equipo: Se asume el compromiso e ininterrumpida disponibilidad horaria acordada de los 5 integrantes del equipo de trabajo a lo largo de los Sprints académicos.

### 7.3 Restricciones (Constraints)

- **Restricción Presupuestaria:** El costo total del diseño, adquisición de hardware de prototipado y licencias preliminares de software para el desarrollo del MVP no debe exceder los $500.000 ARS inicialmente estipulados. Estado al 12/10/2026: el hardware de Aurora Home supera el tope en $2.283,45 y, con la infraestructura, el gasto real supera el tope en $74.300,45 (ver 6.1 y riesgo R13).
- **Restricción Temporal Académica:** El proyecto está estrictamente atado al calendario académico 2026 de la UTN-FRC. El cierre absoluto de la ejecución debe realizarse el 05/10/2026 y el lanzamiento/entrega final inamovible es el 05/11/2026 para permitir la defensa de la tesis.
- **Restricción de Hardware (Alcance):** No se desarrolla ni se integra hardware vestible en el MVP.
- **Restricción de Entorno y Perfil:** El ecosistema está restringido para operar exclusivamente en entornos domésticos unifamiliares (un dispositivo por paciente) y para pacientes con un nivel igual o inferior a 5 en la escala FAST.
- **Restricción Legal de Datos:** Al tratar datos de salud y de comportamiento diarios, el sistema debe restringirse y alinearse de manera obligatoria a la Ley 25.326 de Protección de Datos Personales en Argentina (encriptación y anonimización de registros médicos).

## 8. Interesados Clave (Stakeholders)

| **Nombre / Grupo** | **Rol en el Proyecto** | **Impacto / Expectativa principal** |
| --- | --- | --- |
| **Cátedra Proyecto Final (UTN-FRC)** | Docentes evaluadores | Muy Alto. Exigen rigor metodológico y evalúan la viabilidad para la obtención del título. |
| **Virginia Santos** | Sponsor del Proyecto | Alto. Autoriza el Acta de Constitución y valida que se cumplan los objetivos estratégicos. |
| **Equipo de Desarrollo** | Creadores y gestores | Muy Alto. Responsables de la ejecución del sistema buscando regularizar y defender la tesis. |
| **Pacientes con pérdida de memoria** | Usuarios de Aurora Home | Alto. Requieren una interfaz de voz intuitiva que extienda su autonomía sin fricción. |
| **Cuidadores y Familiares** | Usuarios de Aurora Care | Alto. Esperan centralizar alertas en tiempo real, reportes fidedignos y mitigar el burnout. |
| **Centros de Salud y Geriátricos** | Interesado futuro (fuera del alcance actual) | Potenciales clientes en una etapa comercial posterior. |
| **Ministerios / Entes de Gobierno** | Interesado futuro (fuera del alcance actual) | Potenciales clientes en una etapa comercial posterior. |
| **Profesionales de la salud validadores** | Lic. V. Salvador y profesionales de neurología | Alto. Validan el enfoque terapéutico y los estadios cubiertos. |

## 9. Autorización y Aprobaciones

**Aprobado por: Jeremías Daniel Maldonado Gómez**

Virginia Santos - Sponsor del Proyecto

Fecha:

Jeremías Daniel Maldonado Gómez - Director de Proyecto

Fecha:
