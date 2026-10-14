# Pendientes en el Docs: lugares marcados con `[A COMPLETAR]`

Estado al 14/10/2026. En el Google Doc (pestaña 1) se dejó el texto exacto `[A COMPLETAR]` donde falta un dato que no figura en los repos ni en lo que se informó. Para encontrarlos todos: **Ctrl+F → `A COMPLETAR`** (deberían aparecer 19 coincidencias).

Cuando se complete un dato, hay que actualizar también el mismo texto en el repo (`Document Hub/`) al aplicar las correcciones.

## 1. Estudio Inicial: Dominio clínico (sección "Validación profesional realizada")

| # | Dónde | Qué falta |
| --- | --- | --- |
| 1 | Tabla de validación, fila "Enfoque terapéutico y actividades", columna Fecha | Fecha (o mes) de la validación con la Lic. Virginia Salvador |
| 2 | Fila "Estadios del paciente a cubrir", columna Quién | Nombres, título y institución de los profesionales de neurología |
| 3 | Misma fila, columna Fecha | Fecha (o mes) de la consulta con los profesionales de neurología |
| 4 | Sección "Fundamento bibliográfico", fila de neuroplasticidad | Enlace o referencia exacta de la fuente (PubMed, 2024) |

Marcadores relacionados que **no** se cambiaron (son otro tipo de pendiente):
- `[A validar con la Lic. Salvador]` en las reglas S1 y S5 de la matriz y `[A validar]` en S2.
- `[pendiente]` en la fila "No diagnosticar ni recomendar tratamientos" de la tabla de límites: falta armar un conjunto de casos adversarios para la IA (ver Plan de Testing).
- `[Insertar aquí la figura de la Vista 1/2…]`: insertar a mano `figuras/Vista 1 - Dominio actual (AS-IS).png` y `figuras/Vista 2 - Con Aurora (TO-BE).png`.

## 2. Plan de Proyecto, 3.1 Objetivos del producto

| # | Dónde | Qué falta |
| --- | --- | --- |
| 5 | Objetivo "Satisfacción de usuarios", meta "al menos el 70 % de los usuarios del piloto [A COMPLETAR]" | Cantidad de usuarios (cuidadores) del piloto, o cómo se define el grupo |

## 3. Plan de Proyecto, 6.1 Presupuesto de Desarrollo (CAPEX)

| # | Dónde | Qué falta |
| --- | --- | --- |
| 6 | Tabla CAPEX, fila Infraestructura, columna "Real (comprado)" | Lo gastado hasta hoy en VPS Hostinger, dominio y servicios en la nube |
| 7 | Misma fila, columna "Pendiente" | Lo que falta pagar hasta el cierre |
| 8 | Misma fila, columna "Estado" | Estado (por ejemplo: pagado por adelantado, mensual, sin contratar) |
| 9 | Párrafo "Plan de contención", inciso (c) | Qué se hará con infraestructura para no agravar el desvío (por ejemplo: plan mensual, cuotas gratuitas, dar de baja al cierre) |

Dato de contexto: el hardware ya suma $502.283,45 contra un tope de $500.000 (desvío de +$2.283,45, +0,46 %), sin infraestructura. El total final depende de los datos 6 y 7.

## 4. Plan de Proyecto, 6.2 Costo Operativo Mensual (OPEX)

| # | Dónde | Qué falta |
| --- | --- | --- |
| 10 | Fila "Consumo de Inteligencia Artificial", columna Costo Mensual | Costo mensual estimado del proveedor de IA (gpt-4o-mini de OpenAI, alternativa Gemini) para 10 usuarios |
| 11 | Fila "Servicios de voz en la nube", columna Costo Mensual | Costo mensual estimado de Azure Speech en nivel pago (hoy se usa el nivel gratuito F0) |
| 12 | Fila "Total Operativo Mensual", columna Costo: `$25.00 USD + [A COMPLETAR]` | Suma de los dos datos anteriores; reemplazar por el total |

## 5. Plan de Proyecto, Cronograma: columna "Estado al 12/10/2026"

| # | Dónde | Qué falta |
| --- | --- | --- |
| 13–19 | Una celda por fila: Sprint 1, 2, 3, 4, 5, 6 y Preparación final | Estado real de cada etapa al 12/10/2026 (por ejemplo: Cerrado, En curso, Pendiente, con el desvío si lo hubo) |

Sugerencia: Sprint 1 a 5 se pueden tomar del snapshot de Jira (`jira/snapshot.json`) y de los informes de sprint; el Sprint 6 está en curso (05/10 al 25/10).

## 6. Otros datos a confirmar (no están marcados en el Doc)

| Dato | Dónde está |
| --- | --- |
| Horas semanales del equipo (se dejaron las que ya tenía la tabla, 16 hs para Mateo, etc.) | Plan de Proyecto, "Equipo de Trabajo" |
| Responsable del tratamiento de datos (nombre y domicilio: equipo, UTN o una persona); no se incluyó en el borrador de la política | `09 - Análisis legal y textos de Care.md`, sección 5.12 |
| Gasto total de infraestructura | Mismo dato que los puntos 6 a 9 |
| Validación legal de los textos de Care (política de privacidad, consentimientos, T&C) por una persona con matrícula | `09 - Análisis legal y textos de Care.md` |
