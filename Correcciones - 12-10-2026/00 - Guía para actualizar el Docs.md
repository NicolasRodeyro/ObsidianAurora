# Guía para actualizar el Google Doc — Correcciones de la profe (12/10/2026)

**Documento a modificar:** https://docs.google.com/document/d/1jGigjSpOtEeBZSEEqm5ijTiZy22IWZoQPIOaaxsXgbE/edit
**Fuente de las correcciones:** pestaña 2 del Doc (`Proyecto Aurora 2026-Correcciones.md`), 14 puntos.

## Cómo usar esta carpeta

1. Seguí la tabla de abajo **en orden**: cada fila dice qué sección del Docs tocar, qué hacer y en qué archivo está el texto listo para pegar.
2. Todo lo marcado `[A COMPLETAR]` o `[A CONFIRMAR]` es un dato que **no está en los repos** y que tienen que definir ustedes. La lista consolidada está al final de este archivo.
3. **Antes de subir**, leé la sección "Lo que conviene validar con ustedes": son metas y plazos que propuse yo y que, una vez en el Docs, quedan como compromisos ante la cátedra.
4. Estos archivos están en la raíz del proyecto y **no están commiteados**. Una vez que suban al Docs, aplicamos lo mismo al repo (`Document Hub/`) para que ambos queden iguales.

---

## 1. Tabla de correcciones

| # | Corrección de la profe | Archivo con el texto | Dónde se toca en el Docs | Acción principal |
| --- | ----- | ----- | ----- | ----- |
| 1 | Separar situación actual (AS-IS) de la propuesta (TO-BE) en el Estudio Inicial | **01** | Estudio Inicial → *Procesos Involucrados* (incluye Flujos, Participantes, Información, Clasificación de evento) | **Reemplazar** el bloque completo |
| 2 | Sistemas involucrados y mapa global: dominio actual primero, Aurora después | **01** | Estudio Inicial → *Sistemas involucrados* y *Mapa global de procesos* | **Reemplazar** y **rehacer la figura** del mapa en dos vistas |
| 3 | Dominio clínico: fuentes, validación profesional y límites del software | **02** | Estudio Inicial → sección nueva al final; Glosario (GDS, FAST); *Contexto y Problema* | **Insertar** sección y ajustar 3 párrafos |
| 4 | Un solo alcance y MVP en todos los documentos | **04** | Estudio Inicial (Objetivo, Alcance, RF), Plan (4.1, 4.2, WBS, cronograma), Backlog (Épica 3), Arquitectura (contenedores), Glosario | **Reemplazar** WBS y Épica 3; ajustar 14 puntos puntuales |
| 5 | Objetivos SMART y criterios de éxito del producto | **03** (sección 1) | Plan de Proyecto → *3. Objetivos y Criterios de Éxito* | **Reemplazar** la tabla |
| 6 | Alcance comercial: B2B y B2G como visión futura | **03** (sección 2) | Plan de Proyecto → *2.3*, *6.5*, *8. Interesados*, *4.3* | **Reemplazar** 2.3 y ajustar 4 filas |
| 7 | Presupuesto con costos reales: estimado vs. real vs. pendiente | **03** (sección 3) | Plan de Proyecto → *6.1*, *6.2*, *6.3 Etapa 1*, *6.6*, *7.3* | **Reemplazar** la tabla de 6.1 y ajustar 5 lugares |
| 8 | Riesgos: falsos negativos y positivos, conectividad, alucinaciones IA, datos biométricos | **03** (sección 4) | Plan de Proyecto → *7.1*, *7.2*, *7.3* | **Reemplazar** 7.1 y ajustar 7.2 y 7.3 |
| 9 | Product Owner y Scrum Master: continuidad | **05** (sección 1) | Working Agreement → *3.1*; Gestión de la Configuración → *2*; Plan de Proyecto → tabla *Equipo de Trabajo*; informe de sprints → tabla *Equipo* | **Reemplazar** 3.1, ajustar 3 filas y actualizar 2 tablas de equipo |
| 10 | Una única estrategia de ramas | **05** (sección 2) | Working Agreement → *4.1*, *4.2*, *5.2*; Gestión de la Configuración → *4*; Arquitectura → *5.1*, *5.3* | **Reemplazar** 4.1 y la sección 4 de Gestión de la Configuración |
| 11 | Arquitectura: ADR como fuente de verdad | **06** | Arquitectura → ADR-005 a ADR-009, secciones 1.3, 2.1, 2.2, 2.3, 4.2, 5.x, 6.3 y los tres diagramas C4 | **Enmendar** ADR y **rehacer los diagramas** |
| 12 | Privacidad y datos sensibles como requisitos verificables | **07** y **09** (análisis legal y textos de Care) | Arquitectura → *6.1 a 6.3*; Estudio Inicial → RF y RNF | **Reemplazar** 6.2 y **agregar** RF-92 a RF-98 y RNF-44 a RNF-52 |
| 13 | Plan de Testing: métricas concretas para funciones críticas | **08** | Plan de Testing → *3*, *4*, *5* y sección nueva | **Reemplazar** la sección 4 y ampliar P1 |
| 14 | Comentario general: consistencia y consolidación | **00** (sección 3) | Todo el Doc | **Aplicar** el checklist de consistencia |

---

## 2. Orden recomendado de trabajo en el Docs

1. **Primero el alcance** (archivos 04 y 01): todo lo demás depende de qué es MVP.
2. **Después las decisiones técnicas** (archivos 06 y 05): arquitectura y ramas.
3. **Luego el plan** (archivo 03): objetivos, presupuesto, riesgos.
4. **Por último los requisitos transversales** (archivos 02, 07, 08): dominio clínico, privacidad y testing.
5. **Cierre:** el checklist de consistencia de la sección 3.

---

## 3. Corrección 14 — Checklist de consistencia (para correr al terminar)

La profe pide "una única versión coherente del sistema que realmente están construyendo". Con **Ctrl+F** en el Doc, buscá cada término de la izquierda: lo que quede tiene que coincidir con lo de la derecha.

| Buscar | Debe quedar solo en… |
| ----- | ----- |
| `develop` | Ningún lado (ahora la rama es `staging`) |
| `Auth0` | Solo como "alternativa descartada" en ADR-005 |
| `ElevenLabs`, `Polly` | Ningún lado (el proveedor es Azure) |
| `Raspberry Pi 4`, `2GB/4GB` | Ningún lado (es Raspberry Pi 5) |
| `Redis en la Raspberry`, `Redis 7 (en Raspberry` | Ningún lado (Redis está en el backend; Home usa SQLite) |
| `Groq`, `Llama 3`, `Gemini y Claude` | Ningún lado (el proveedor de LLM es configurable; hoy OpenAI) |
| `pgcrypto` | Ningún lado (el cifrado es Fernet, ADR-010) |
| `Aurora Band` / `pulsera` / `wearable` | Solo como "futuras versiones" o en la decisión del 29/08 |
| `geofencing` / `zona segura` / `caída` / `biométric` | Solo como "futuras versiones" |
| `llamada automática` | Solo como "futuras versiones" |
| `GDS`, `etapa 5`, `nivel 5` | Debe decir siempre **FAST ≤ 5** (GDS solo en el glosario como referencia) |
| `mejor tesis` | Ningún lado |
| `B2B` / `B2G` / `geriátricos` | Solo en la sección 2.3 como visión futura |
| `$410.000` | Ningún lado (se reemplaza por la tabla estimado / real / pendiente) |
| `rotativo` / `rotados` (PO y SM) | Ningún lado referido a esos roles |
| `STT local` / `procesamiento local de voz` | Solo en "respaldo local" |
| `"Aurora Core: repositorio aún vacío"` | Ningún lado (Core está implementado) |

Además:
* Que **el índice del Doc** quede actualizado (Ctrl+clic sobre el índice → *Actualizar*).
* Que **las imágenes** de los diagramas C4 y del mapa global coincidan con el texto nuevo.
* Que el **Glosario** incluya los términos nuevos (Supabase, Worker IA, Expo Push, Fernet, FAST) y marque las funciones futuras.

---

## 4. Lo que conviene validar con ustedes antes de subir

Estos son números y decisiones que propuse yo y que, al subirlos, pasan a ser compromisos ante la cátedra:

| Qué | Dónde | Por qué importa |
| ----- | ----- | ----- |
| Las **metas numéricas** (80 % de respuestas, p95 ≤ 30 s, SUS ≥ 68, WER, etc.) | Archivos 03 y 08 | Se van a evaluar al final del proyecto. Mejor poner metas que se puedan medir y cumplir |
| **Plazos de retención** (6 meses, 2 años, 90 días, 5 años) | Archivo 07 | Es política de datos y requiere validación legal |
| **Consentimiento por representante legal** | Archivo 07 | Cuestión legal; hay que validarlo con la cátedra o un asesor |
| **Hardware real $502.283,45** (ya supera el tope de $500.000) | Archivo 03 | Es un dato delicado para presentar; conviene acordar cómo se comunica |
| **Estrategia de ramas** `feature → staging → main` | Archivo 05 | Decidido: Home y Worker IA la adoptan. El cambio en esos repositorios sigue pendiente |
| **Criterio FAST ≤ 5** | Archivo 02 | Debe coincidir con lo que validaron los profesionales de neurología |

---

## 5. Pendientes que no están en los repos (consolidado)

| # | Dato | Para qué corrección | Quién lo sabe |
| --- | ----- | ----- | ----- |
| 1 | ~~ReSpeaker y conciliación de los $462.512~~ (resueltos). **Falta el gasto de infraestructura y servicios** (VPS, dominio, voz e IA) | 7 | Octavio |
| 2 | ~~Si se compró alguna pulsera~~ (resuelto: no se compró) | 7 | — |
| 3 | Costos reales de infraestructura y servicios de voz e IA (mensuales) | 7 | Octavio / Jeremías |
| 4 | ~~Nombre del Product Owner y del Scrum Master~~ (resuelto: PO Haik Kilic, SM Jeremías Maldonado, fijos desde el inicio). Falta confirmar las horas semanales con las asignaciones actuales | 9 | Equipo |
| 5 | ~~Quién aprueba el PR `staging` → `main`~~ (resuelto: Haik Kilic, como Product Owner) | 10 | — |
| 6 | ~~Si Home y Worker IA adoptan `staging`~~ (resuelto: sí). Falta programar el cambio en los repos | 10 | Equipo |
| 7 | Nombres y fechas de la validación con la Lic. Salvador y los profesionales de neurología | 3 | Equipo |
| 8 | Confirmar el criterio FAST ≤ 5 (y no "< 5") | 3 | Equipo |
| 9 | Cantidad real de usuarios piloto | 5, 13 | Equipo |
| 10 | Herramientas existentes que usan las familias relevadas | 1 | Equipo |
| 11 | Qué herramientas de observabilidad están activas en el VPS; si se usa algo de AWS | 11 | Octavio |
| 12 | ~~Dificultad adaptativa~~ (resuelto: MVP, según Jira). Revisar que el User Story Mapping de Google Docs y el del repo reflejen los cambios de la sección 4 del archivo 04 | 4 | Equipo |
| 13 | Validación legal: las 8 preguntas de la sección 10 del archivo **09** (base legal, consentimiento por el paciente, transferencia a EE. UU., registro de la base, ANMAT) | 12 | Cátedra / abogado |
| 13b | ~~Región de Supabase y ubicación de Hostinger~~ (resuelto: se mantienen en EE. UU. y queda asentado en los consentimientos). **Averiguar quién figura como responsable del tratamiento** (sección 5.12 del archivo 09; no está en el borrador todavía) | 12 | Equipo / cátedra |
| 14 | Quién rehace los diagramas C4 y el mapa global | 2, 11 | Nicolás / Jeremías |
| 15 | Aprobar las metas del Plan de Testing y armar los conjuntos de casos | 13 | Equipo |

---

## 6. Observaciones del Doc que no son de la profe pero conviene cerrar

El Doc tiene otros comentarios abiertos del 09/06 (profe) y del 25/08 (Octavio). Quedan así:

| Comentario | Estado después de estas correcciones |
| ----- | ----- |
| "pocas US, falta glosario" | El backlog del MVP pasa de 6 a 7 historias (más 2 de futuras versiones, archivo 04); sigue siendo poco. Conviene sumar las historias de los Sprints 1 y 2 (hay trazabilidad en `Document Hub/Trazabilidad/`). El glosario existe y se amplía. |
| "glosario" (sobre DOT) | DOT está definido. |
| "Falta cronograma, métricas y flujo de fondos" | Cronograma y flujo de fondos existen. Las **métricas** del proyecto están parcialmente en la sección 6.2 del informe de sprints; los indicadores de producto quedan en el archivo 03. |
| Octavio: "462.512 / falta impresión, pulsera, infra" | Resuelto con la tabla del archivo 03. |
| Octavio: "Al final compramos las Ras 5" | Resuelto en los archivos 03 y 06. |
