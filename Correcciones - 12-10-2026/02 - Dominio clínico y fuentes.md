# Corrección 3 — Delimitación del dominio clínico, fuentes y validación

> **Qué cambia en el Docs:** se **agrega una sección nueva** al final del Estudio Inicial, después de *Reglas de Negocio*, con el título **"Dominio clínico: fundamento, validación y límites del software"**. Además se ajustan 3 definiciones (ver sección 5).
>
> **Criterio de la profe:** toda regla o afirmación con fundamento clínico debe tener fuente o validación profesional; hay que distinguir qué decide el software y qué proviene del conocimiento médico; y el límite "no diagnosticar, no recomendar tratamientos, no modificar medicación" debe ser explícito y trazable.
>
> **Importante:** las referencias bibliográficas de la sección 3 las cargué desde mi conocimiento. **Verificar título, año y DOI en PubMed antes de presentar.** Los nombres de los contactos de neurología quedan `[A COMPLETAR]`.

---

## 1. Texto para pegar (sección nueva)

### Dominio clínico: fundamento, validación y límites del software

#### 1. Principio de separación de responsabilidades

Aurora trabaja con una población vulnerable. Por eso el proyecto separa de forma explícita dos tipos de decisión:

* **Decisiones clínicas:** qué terapias son adecuadas, qué tipo de actividades son seguras, para qué estadios de la enfermedad es apropiado el sistema y qué se considera una señal de riesgo. **No las toma el equipo de software.** Provienen de bibliografía publicada o de profesionales de la salud que las validaron.
* **Decisiones de software:** cómo se implementa una regla ya definida (por ejemplo, que un recordatorio se emita a las 9:00, que una omisión genere una alerta, que una respuesta no supere cierta cantidad de palabras). Se documentan, se prueban y son trazables.

Cuando una regla requiere un umbral clínico que no fue validado por un profesional, **la funcionalidad no entra al MVP** y queda marcada como pendiente de validación.

#### 2. Validación profesional realizada

| Aspecto validado | Quién | Qué se validó | Fecha |
| ----- | ----- | ----- | ----- |
| Enfoque terapéutico y actividades | **Lic. Virginia Salvador** (psicopedagoga) | El tipo de terapias que Aurora puede realizar y qué clase de juegos o actividades propone. Pautas de diseño: anticipar siempre lo que va a ocurrir y sostener una rutina diaria para apoyar la memoria de corto plazo. | `[A COMPLETAR]` |
| Estadios del paciente a cubrir | Profesionales del ámbito de la neurología `[A COMPLETAR: nombre y matrícula/institución]` | Qué etapas de la enfermedad puede cubrir el sistema. | `[A COMPLETAR]` |
| Investigación de dominio | Equipo Aurora, con aportes de los profesionales anteriores | Documento *Investigación sobre neurología* (AURA-6 y AURA-7). | Sprint 0 |

> **Aclaración a incluir en el texto:** la validación realizada fue una consulta de orientación, no una certificación del producto ni un estudio clínico. Aurora no es un dispositivo médico.

#### 3. Fundamento bibliográfico

| Afirmación o regla | Fuente |
| ----- | ----- |
| La escala GDS clasifica el deterioro cognitivo en 7 estadios. | Reisberg B, Ferris SH, de Leon MJ, Crook T. *The Global Deterioration Scale for assessment of primary degenerative dementia.* Am J Psychiatry. 1982;139(9):1136-1139. |
| La escala FAST describe la progresión funcional de la enfermedad de Alzheimer. | Reisberg B. *Functional Assessment Staging (FAST).* Psychopharmacol Bull. 1988;24(4):653-659. |
| La terapia de reminiscencia puede beneficiar la calidad de vida, la comunicación y el estado de ánimo en personas con demencia. Los efectos sobre la cognición son pequeños o inciertos. | Woods B, O'Philbin L, Farrell EM, Spector AE, Orrell M. *Reminiscence therapy for dementia.* Cochrane Database Syst Rev. 2018;3:CD001120. |
| La estimulación cognitiva se asocia con mejoras en la cognición en demencia leve a moderada. | Woods B, Aguirre E, Spector AE, Orrell M. *Cognitive stimulation to improve cognitive functioning in people with dementia.* Cochrane Database Syst Rev. 2012;(2):CD005562. |
| La rehabilitación cognitiva se basa en la neuroplasticidad y en objetivos personalizados de la vida cotidiana. | Fuentes citadas en *Investigación sobre neurología* (PubMed, 2024). `[A COMPLETAR: pasar el enlace de PMC a cita completa]` |
| Marco legal del tratamiento de datos personales y de salud. | Ley 25.326 de Protección de Datos Personales (Argentina). |

> Los hallazgos de las revisiones Cochrane son **moderados**: Aurora no promete efectos terapéuticos. Su objetivo es **acompañar, sostener la rutina y reducir la carga del cuidador**, que es lo que el producto puede sostener sin validación clínica propia. Conviene que la hipótesis de validación del Estudio Inicial ("ayudar a la rehabilitación cognitiva…") se reformule en ese sentido.

#### 4. Matriz de reglas: qué decide el software y qué proviene del conocimiento clínico

| # | Regla o afirmación | Tipo de decisión | Respaldo | Estado |
| ---- | ----- | ----- | ----- | ----- |
| C1 | Perfil de paciente: FAST ≤ 5 (interacción básica conservada). | **Clínica** | Reisberg 1982 y 1988; consulta con profesionales de neurología | Validado informalmente. Confirmar que el criterio es "≤ 5" y no "< 5" |
| C2 | Anticipar lo que va a ocurrir y sostener una rutina diaria. | **Clínica** | Lic. V. Salvador | Validado |
| C3 | Tipos de terapia: reminiscencia y estimulación cognitiva. | **Clínica** | Cochrane 2018 y 2012; Lic. V. Salvador | Validado |
| C4 | Tipo de actividades y juegos que Aurora puede proponer. | **Clínica** | Lic. V. Salvador | Validado |
| C5 | Actividades breves y simples. | Mixta | Lic. V. Salvador; regla de negocio 5 | Validado en criterio; la duración exacta es de software |
| S1 | Respuestas del asistente de máximo 40 palabras por turno (hablables). | **Software** | Criterio de diseño (RNF-01 y RNF-03) | `[A VALIDAR con la Lic. Salvador]` |
| S2 | El micrófono se cierra a los 10 segundos sin respuesta. | **Software** | Criterio de diseño | `[A VALIDAR]` |
| S3 | Margen de tiempo para registrar una omisión de medicación. | **Software, configurable** | Regla de negocio 7; lo fija el cuidador, no el sistema | No requiere validación clínica |
| S4 | Cuatro niveles de gravedad de eventos. | **Software** | Estudio Inicial | Los ejemplos clínicos (caída, frecuencia cardíaca alta) son de futuras versiones y requieren validación |
| F1 | Detección de caídas, agitación y frecuencia cardíaca anormal. | **Clínica + software** | Sin validación | **Fuera del MVP.** No se implementa hasta contar con umbrales validados por un profesional |
| S5 | Ajuste de la dificultad de los ejercicios con una regla simple (participación y ánimo, últimas 5 sesiones). Está en el MVP (AURA-77). | **Clínica + software** | La regla es de software; los criterios de qué es "baja participación" o "mal ánimo" y cuándo bajar la dificultad son clínicos | `[A VALIDAR con la Lic. Salvador]` |
| F2 | Adaptación de la dificultad mediante un modelo de IA entrenado. | **Clínica + software** | Sin validación | **Fuera del MVP** |

#### 5. Límites del software (explícitos y trazables)

Aurora **no**:

1. Diagnostica Alzheimer ni otras enfermedades.
2. Recomienda tratamientos médicos ni dosis.
3. Modifica automáticamente la medicación.
4. Reemplaza al cuidador ni al profesional.

Cada límite se hace cumplir y se verifica así:

| Límite | Regla de negocio | Requisito no funcional | Mecanismo en el sistema | Cómo se verifica |
| ----- | ----- | ----- | ----- | ----- |
| No diagnosticar ni recomendar tratamientos | RN 4 y RN 13 | RNF-21 | Instrucción explícita en los prompts del Worker IA: "NUNCA indiques iniciar, suspender ni cambiar una medicación, ni des diagnóstico" y "NO des consejo ni diagnóstico médico" | Pruebas de evaluación de IA (ver archivo 08). Falta un conjunto de casos adversarios específico `[PENDIENTE]` |
| No modificar medicación | RN 3 | RNF-40 y RNF-43 | La medicación solo la carga o valida un cuidador; el asistente no tiene herramientas de escritura sobre ella | Pruebas de API: el asistente no puede crear ni editar medicación |
| Ante síntomas, derivar al cuidador | RN 14 | RNF-21 | El prompt indica responder que no tiene ese registro y sugerir hablar con el cuidador | Casos de prueba con preguntas por síntomas y por dosis |
| Mantener las respuestas dentro del contexto asistencial | RN 13 | RNF-20 y RNF-22 | Memoria del paciente validada por el cuidador (RN 6) | Evaluación de respuestas fuera de contexto |

> **Hallazgo honesto:** hoy el límite se aplica mediante **instrucciones en el prompt**, que reducen pero no eliminan el riesgo. Se recomienda agregar en una iteración futura un filtro de salida (palabras clave de dosis y diagnóstico) y un conjunto de pruebas adversarias. Esto está registrado como riesgo en el archivo 03.

---

## 2. Qué reemplazar en el Docs

| Ubicación | Acción |
| ----- | ----- |
| Estudio Inicial, después de *Reglas de Negocio* | **Insertar** la sección de arriba completa. |
| Estudio Inicial → *Contexto y Problema a Validar*, último párrafo ("El problema principal que Aurora busca validar es si un sistema…") | **Reemplazar** por: "El problema principal que Aurora busca validar es si un sistema de apoyo domiciliario puede **sostener las rutinas, los recordatorios y las actividades significativas** de personas con deterioro cognitivo, y **reducir la carga del cuidador**. La evidencia disponible sobre terapias no farmacológicas muestra beneficios moderados, por lo que Aurora no promete efectos terapéuticos." |
| Glosario → **Escala GDS** | **Reemplazar** por: "Escala Global de Deterioro (Reisberg, 1982), de 7 estadios, que clasifica el deterioro cognitivo. Se usa como referencia clínica complementaria." |
| Glosario → **FAST** | **Reemplazar** por: "Functional Assessment Staging (Reisberg, 1988). Escala funcional de la enfermedad de Alzheimer. **Es el criterio que delimita el perfil del paciente de Aurora: nivel FAST igual o inferior a 5.**" |
| Estudio Inicial → *Ámbito de aplicación* (restricción) y *Alcance del sistema* | **Reemplazar** "menor a la etapa 5 de la escala GDS" por "nivel FAST igual o inferior a 5". |
| Plan de Proyecto → Fuera de alcance → *Pacientes fuera del perfil clínico* | Ya dice FAST nivel 5; agregar "(igual o inferior)". |

## 3. Pendiente de definición del equipo

1. **Nombres y fechas** de la validación con la Lic. Salvador y con los profesionales de neurología.
2. **Criterio exacto del perfil:** hoy el Estudio Inicial dice "menor a 5" y el Plan "nivel 5". Este documento adopta **FAST ≤ 5**, que es lo que figura en el resto del proyecto. Confirmar que es lo que validaron los profesionales.
3. **S1 y S2** (40 palabras y 10 segundos): si quieren que figuren como validados, hay que consultarlos con la Lic. Salvador.
