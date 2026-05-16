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

Aurora busca acompañar y monitorear pacientes con alzeimher o pacintes con problemas de memoria, para brindar una 

### 2.2 Alineación Estratégica

Aurora va a permitir a la organización aprobar la tesis final para recibirse de ingenieros y ser una solución útil que nos brinde experiencia como nuevos ingenieros

---

## 3. Objetivos y Criterios de Éxito

| Objetivo (SMART) | Criterio de Éxito |
| --- | --- |
| Aprobar la Tesis | Alcanzar un 80% o más a principios de noviembre para regularizar la tesis y poder defenderla |
| Ser la mejor Tesis del año | Ser reconocida como la mejor tesis del año en el concurso que se realiza mediados de septiembre |
| Ofrecer una solución util para sus usuarios | Obtener al menos 10 usuarios que lo hayan usado y estén satisfechos |

---

## 4. Descripción y Alcance de Alto Nivel

### 4.1 Descripción del Proyecto

El proyecta cuenta con un sistema de software y hardware que busca brindar acompañamiento personalizado para pacientes con alzheimer y problemas de memoria, alargando su independencia y autonomía funcional, atrasando el desgaste neurologíco de estas enfermerdades. También busca reducir el burnout en las personas que conforman el entorno del paciente.

Esto Se logrará ofreciendo un dispositivo que funciona con voz, una pulsera que vigila biometría, una aplicación mobile para los cuidadores, conformando un ecosistema de monitoreo y acompañamiento.

Aurora está pensado para funcionar dentro del hogar del paciente

### 4.2 Entregables Principales

- Entregable 1: Prototipo de Aurora Home: un asistente de voz que responde e inicia dialogos con el paciente
- Entregable 2: Prototipo de Aurora Band: una pulsera que realiza analisis biometricos para evaluar eventos relativos al paciente como signos vitales y los mande al sistema principal de Aurora para su analisis
- Entregable 3: Aurora Care: Una aplicación web para “cuidadores” personas del entorno del paciente que envía actualizaciones del paciente y permite mandar notificaciones al AURORA HOME brindando comunicación eficaz con el paciente
- Entregable 4: Aurora Core → Es el sistema por detrás del ecosistema de Aurora, orquesta al resto del ecosistema brindando, analisis de datos, creación de notificaciones, filtrado de eventos, comunicación entre APIS, Automatización de procesos, Coordinación de mensajes entre los componentes del ecosistema
- Entregable 5: Documento de Objetivos y Alcance

### 4.3 Fuera de Alcance (Exclusiones)

Entornos físicos con múltiples pacientes, aurora está pensado para comunicarse con un solo paciente

Entornos fuera del hogar, aurora acompaña el envejecimiento en el hogar

Aurora Band no es un dispositivo desarrollado por nosotros, será tercearizado, nosotros nos encargamos de la comunicación y el destino de los datos que recopila

Aurora está pensado para pacientes con autonomía funcional de nivel 5 en la escala de degradación del alzheimer

---

## 5. Cronograma de Hitos Principales

| Hito / Fase | Fecha Estimada |
| --- | --- |
| Inicio del Proyecto | 26/05/2026 |
| Finalización de Diseño | 07/06/2026 |
| Cierre de Ejecución | 05/10/2026 |
| Lanzamiento / Entrega Final | 05/11/2026 |
|   |   |
|   |   |
|   |   |
|   |   |
|   |   |

---

## 6. Recursos y Presupuesto

- **Presupuesto Estimado:** 500.000 pesos(Arg)
- **Recursos Críticos:** Equipo de Desarrollo, Licencia de Claude, Licencia de Gemini, hardware de Aurora Home, Pulsera de Aurora Band, Marketing y Publicidad, Servidor para BD y Computo para LLM, Cloud computing(computo, network transit), API’s Pagas

---

## 7. Riesgos, Supuestos y Restricciones

### 7.1 Riesgos Principales (Amenazas)

1. No obtener suficiente información de terapias efectivas y útiles para entregar valor con Aurora Home
2. Aurora Home no cumpla todos los alcances dispuestos
3. No conseguir una pulsera biométrica adecuada para usar como Aurora Band
4. Aumento en costos de tokenización de modelos de IA a utilizar con consecuente aumento de costos
5. Nuevas disposiciones legales para tratado de pacientes objetivo y su información
6. Cambio en el alcance por uso de tiempo en investigación de soluciones, objetivos y tecnologías

### 7.2 Supuestos (Assumptions)

- [Ej: El equipo tendrá acceso total a los datos desde el día 1.]
- [Ej: La aprobación de fondos se dará en la primera semana.]

### 7.3 Restricciones (Constraints)

- [Ej: El presupuesto no puede exceder los $X.]
- [Ej: El proyecto debe finalizar antes de la temporada de ventas.]

---

## 8. Interesados Clave (Stakeholders)

| Nombre / Grupo | Rol en el Proyecto |
| --- | --- |
| [Ej: Cliente Externo] | [Receptor final del producto] |
| [Ej: Equipo de TI] | [Soporte técnico y despliegue] |

---

## 9. Autorización y Aprobaciones

**Aprobado por: Jeremías Daniel Maldonado Gómez**

---

VIrgina Santos - Sponsor del Proyecto

Fecha: 

---

Jeremías Daniel Maldonado Gómez - Director de Proyecto

Fecha: 