---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-18
---

# Trabajo pendiente y próximos pasos

Al 17/10/2026 faltan tres semanas para la entrega final del 05/11. Lo pendiente se agrupa por naturaleza. El detalle de los riesgos está en el [[Registro de Riesgos]] y el avance del sprint en el [[Informe Sprint 6]].

## 1. Producto

- **Drop-in en vivo (AURA-134):** sigue en revisión. Falta cerrar AURA-173 (el cuidador principal se crea sin permiso de Drop-in) y hacer una demostración de punta a punta con audio real entre Aurora Care y Aurora Home (AURA-192).
- **Validación de recuerdos (AURA-76):** el backend existe, pero falta demostrarla ante el equipo y la docente.
- **Memoria contextual (AURA-104) y pantalla de Privacidad (AURA-109):** en revisión. La revocación del consentimiento con efectos sobre el tratamiento de datos (RF-93) no está demostrada.
- **Errores abiertos:** AURA-164 (en el sprint) y, fuera de todo sprint, AURA-110, 111 y 175. Los cuatro afectan lo que el cuidador ve (riesgo R8).
- **Voz de Aurora Home:** la latencia de la respuesta hablada supera el objetivo (p95 de 8,02 s frente a 2 s) y falta una decisión del Product Owner. También quedó diferida la validación con hardware real del botón SOS durante una conversación y con el micrófono desconectado.

## 2. Seguridad y operación

- Gestión de secretos (AURA-147) y respaldos, monitoreo y guía de operación (AURA-148): ambos fuera de todo sprint. El equipo debe aceptar el riesgo por escrito o reconsiderar la decisión (riesgos R5, R8 y R20).
- Validación legal de los textos de consentimiento y de la política de privacidad por una persona con matrícula.
- Definir si las fotos de los recuerdos tienen límite de tamaño y de tipos de archivo.

## 3. Calidad y trazabilidad

- Registrar el ADR de la heurística determinista de dificultad adaptativa (AURA-77) y el ADR de LiveKit como proveedor de media (propuesto como ADR-013).
- Agregar pruebas de API para `mark-omitted` (AURA-89) y para los endpoints de contactos de emergencia (AURA-84).
- Cobertura de pruebas: Aurora Home mide líneas y ramas con un mínimo de 80 %; Aurora Core exige 80 % de líneas, sin ramas; Aurora Care no tiene umbral. Decidir si se agrega el gate de ramas a Core y el umbral a Care, o si se ajusta la meta del Plan de Testing.
- Definir si corregir un registro de medicación o rutina ya confirmado u omitido es una regla válida (hoy los endpoints confirm y mark-omitted lo permiten): si lo es, documentarlo en el diagrama de estados; si no, restringirlo en el código.

## 4. Proceso y documentación

- Completar los campos marcados como [A COMPLETAR] en los informes: asistentes y feedback de cada Sprint Review, retrospectivas de los Sprints 4 a 6 y responsables de las acciones. Son datos que solo puede aportar el equipo.
- Entregables de la Instancia 5: documentación del proceso actualizado (AURA-187), instructivos de uso (AURA-188), manual de instalación y operación (AURA-189, que se escribe al final porque depende de la gestión de secretos y de los respaldos), análisis de impacto ambiental (AURA-190), retrospectiva de proyecto (AURA-191) y presentación final (AURA-192).
- Repartir responsables para los tickets AURA-187 a 192, que hoy no tienen.
- Mantener este documento y su réplica en el repositorio sincronizados hasta la entrega.
