# Formulario para el equipo — Sprint Review y retrospectivas

Preguntas rápidas para completar los informes de sprint de la Instancia 3. Se pueden pasar por el chat del equipo o cargar en un Google Forms. Cada persona tarda unos 10 minutos.

## Para qué sirve y qué es cada cosa

- **Sprint Review:** reunión al final del sprint donde el equipo **muestra lo que construyó** y recibe opiniones (de la profe, del sponsor o del propio equipo). Responde a «¿qué hicimos y qué nos dijeron?».
- **Retrospectiva:** reunión **solo del equipo** donde se mira *cómo trabajamos*: qué funcionó, qué aprendimos, qué faltó y qué vamos a cambiar. Responde a «¿cómo mejoramos?».
- Los informes ya tienen los datos de Jira y de los repositorios. Lo que falta es **lo que solo el equipo sabe**.

Qué sprint es cuál (numeración de la documentación):

| Sprint | Fechas | Iteración de Jira |
|---|---|---|
| 1 | 17/06 a 08/07 | Sprint 2 |
| 2 | 08/07 a 04/08 | Sprint 3 (vacío) |
| 3 | 04/08 a 25/08 | Sprint 4 |
| 4 | 27/08 a 16/09 | Sprint 5 |
| 5 | 16/09 a 07/10 | Sprint 6 |
| 6 | 14/10 a 05/11 | Sprint 7 (en curso) |

---

## Parte A. Sprint Review (la responden Haik como Product Owner y Jeremías como Scrum Master, consultando al resto)

Para **cada sprint del 1 al 5** (basta con una o dos líneas):

1. **¿Se hizo alguna demostración de lo construido?** ¿Cuándo y ante quién (profe, sponsor, equipo)? Si no hubo, escribir «no hubo».
2. **¿Qué se mostró?** (por ejemplo, la app funcionando, el prototipo, un documento).
3. **¿Qué feedback se recibió?** Comentarios de la profe, del sponsor o del equipo, aunque sean informales.
4. **¿Qué cambió en el backlog por ese feedback?** (algo que se agregó, se sacó o se repriorizó).

> Si no hubo reunión formal, no pasa nada: se registra como «sin Sprint Review formal» y se indica cuál fue la demostración más cercana (por ejemplo, la jornada del 06/10). Lo importante es que el informe diga la verdad.

---

## Parte B. Retrospectiva (la responde **cada integrante** por separado)

Para los **Sprints 4 y 5** (todavía no tienen retro), y opcionalmente para el 6 cuando cierre. Una frase por punto alcanza.

1. **¿Qué funcionó bien?** (algo que repetirías)
2. **¿Qué aprendiste?** (técnico o de proceso)
3. **¿Qué faltó o qué te frenó?**
4. **¿Qué hubieras querido tener?**
5. **Si tuvieras que cambiar una sola cosa para el próximo sprint, ¿cuál sería?**

Pistas para recordar (las vi en Jira y en los repositorios; no son respuestas, solo ayudan):

| Sprint | Cosas que pasaron |
|---|---|
| 4 | Aurora Home en la Raspberry con voz local y recordatorios sin conexión; CI y plantilla de PR; los 19 tickets iniciales eran del sprint anterior. |
| 5 | Pico de actividad entre el 01 y el 06/10 (cierre con apuro); staging en el VPS; Drop-in; consentimiento obligatorio; unos 47 tickets propios (Jira muestra 63 porque incluye tickets viejos reasignados) y cierre 7 días tarde. |

---

## Parte C. Acciones de mejora (la responde el equipo en conjunto)

Las 6 acciones de la retro combinada no tienen responsable. Para cada una, **¿quién se encargó o se encarga?**

| # | Acción | ¿Quién? | Estado según los repositorios |
|---|---|---|---|
| 1 | DoD como normativa para cada IA o skill | | Implementada |
| 2 | GitHub Actions para CI/CD | | Implementada |
| 3 | PRs vinculadas al ticket y con convención de nombres | | Parcial (pocas ramas llevan el ticket) |
| 4 | Restringir PRs que no cumplan la convención | | No implementada |
| 5 | Cron para Supabase | | Sin evidencia |
| 6 | Llenar la base de datos de prueba | | Parcial |

**Preguntas:**

- ¿Está bien el estado de cada una? Si alguna se hizo de otra manera (por ejemplo, reglas de protección de ramas en GitHub), ¿cuál?
- ¿Qué **dos o tres acciones nuevas** quieren tomar para lo que queda (hasta el 05/11)? Cada una con una persona y una fecha.

---

## Parte D. Confirmaciones sobre los informes

Para que los informes sean consistentes con lo que el equipo vivió:

1. **Retro del Sprint 2 vs. Sprint 3.** En la planilla, los aprendizajes de backend (queryset, N+1, `bulk_create`, etc.) figuran como «sprint 2», pero los commits son del 22/08, o sea del Sprint 3. ¿Los dejamos en el Sprint 3?
2. **Tickets creados a último momento.** El 23/08 se crearon 9 tickets (AURA-95 a 103), dos días antes del cierre del Sprint 3. ¿Eran trabajo que ya se estaba haciendo y se cargó después?
3. **Responsables en Jira.** Octavio figura con el 42 % de los tickets del Sprint 3 y Nicolás con uno solo. ¿Refleja quién trabajó, o el campo *assignee* no se usó bien?
4. **Estimación.** Los puntos de historia se usaron hasta el Sprint 1 y después se dejaron de cargar. ¿Fue una decisión del equipo? ¿Qué prefieren desde ahora: horas por ticket o solo cantidad de tickets?
5. **Capacidad real.** ¿Las horas declaradas (84 por semana en total) se cumplieron? Una estimación por persona, aunque sea aproximada, sirve para el análisis de carga.

---

## Cómo usamos las respuestas

- Parte A completa la sección «Sprint Review» de cada informe.
- Parte B completa la retrospectiva de los Sprints 4, 5 y 6.
- Parte C completa la tabla de acciones, con responsable y fecha.
- Parte D ajusta los números y los textos de los informes.

Nada de lo que contesten se usa para evaluar a una persona: es información para mejorar cómo trabaja el equipo.
