---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T22:10:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-10-21T00:00:00
---
# Accesibilidad

Capítulo 10 del [[Manual de UX-UI Aurora]]. Piso normativo: **[WCAG 2.2](https://www.w3.org/TR/WCAG22/) nivel AA** en Aurora Care. Aurora Home no incorpora display en el MVP: combina voz y LED para estados locales no sensibles, y Care ofrece el texto/diagnóstico al cuidador.

> [!warning] Contradicción documentada — el display del dispositivo (21/10/2026)
> Esta cabecera dice que el MVP **no incorpora display**, pero [[Proto-personas]], [[Tipografía]], [[Identidad de Marca]] y [[Fundamentos Visuales]] **sí diseñan** el display del dispositivo, y existe la pantalla `Design/previews/screens-06-device.html`.
> **Las dos afirmaciones conviven y no se borra ninguna:** el diseño se conserva como referencia y el MVP no incorpora display como superficie. La consecuencia práctica para accesibilidad es la que ya dice §2 (punto 3): la ausencia de pantalla limita la redundancia visual del paciente, y hay que validarla en HIL con acompañamiento profesional.
> **Alcance de la feature de recuerdos (US-D5 a US-D7):** el display del dispositivo queda **fuera del alcance**. La línea de tiempo y la ficha de persona viven en **Aurora Care**; en el dispositivo se recorre **por voz**, con redundancia de voz y LED. Ver [[VUI — Diseño Conversacional]] §5.

## 1. Compromisos WCAG 2.2 AA (y cómo se cumplen)

| Criterio | Compromiso en Aurora |
| --- | --- |
| 1.4.3 / 1.4.11 Contraste | 34/34 pares de tokens verificados por script ([[Color]] §5); tokens nuevos no entran sin pasar `contrast.py` |
| 1.4.4 Resize text | Layout funcional al 200% de zoom; unidades relativas en Care |
| 1.4.10 Reflow | App móvil adaptable desde 320 px sin scroll horizontal ni cortes de contenido |
| 1.4.12 Text spacing | Line-height ≥1.5 en cuerpo ([[Tipografía]]) |
| 2.1 Teclado | Toda la app operable con teclado externo cuando aplique (incluida la sidebar en vistas ampliadas); orden de foco = orden visual |
| 2.4.7 / 2.4.13 Focus | Anillo de foco 2 px `--focus-ring` + offset, nunca suprimido ([[Fundamentos Visuales]] §7) |
| 2.3.1 Destellos | Nada parpadea >3/s; las alertas críticas son estáticas (el pulso lento vive solo en el LED del dispositivo) |
| 2.5.8 Target size | Controles ≥44×44 px (por encima del mínimo 24×24 de WCAG) |
| 3.2.3 Navegación consistente | Tabs/sidebar idénticos en toda la app; mismos íconos = mismos significados |
| 3.3.1-3.3.4 Errores | Mensajes junto al campo, en lenguaje claro, con cómo corregir; confirmación antes de acciones con consecuencias |
| 4.1.2-4.1.3 Semántica/estados | Componentes con roles ARIA correctos; alertas nuevas anunciadas vía `aria-live` |
| 1.1.1 / 1.4.1 No solo color | Todo estado semántico = color + ícono + texto (regla dura de [[Color]] §3) |

## 2. Accesibilidad cognitiva — el paciente

La voz y las señales LED de Aurora Home se diseñan para una persona con GDS ≤5. Referencia adicional: [W3C Making Content Usable for People with Cognitive Disabilities](https://www.w3.org/TR/coga-usable/).

1. **Cero aprendizaje requerido** (RNF del Estudio Inicial): no hay menúes, gestos ni comandos que memorizar. Aurora inicia las interacciones; el único control físico es el botón SOS rojo.
2. **Lenguaje literal**: sin metáforas, ironía ni frases hechas — se interpretan mal con deterioro cognitivo. «Es la hora de tu pastilla», no «no te olvides de tus remediitos».
3. **Señalización multimodal disponible**: Aurora acompaña las interacciones por voz con LED no semántico; Care ofrece texto, ícono y estado al cuidador. La ausencia de pantalla limita la redundancia visual para el paciente y debe validarse en HIL con acompañamiento profesional.
4. **Orientación por voz**: Aurora responde de forma inmediata fecha, hora y próxima actividad cuando se consulta, y las mantiene en los recordatorios configurados ([[Investigacion sobre neurologia]]).
5. **Sin presión temporal**: los diálogos no castigan el silencio; el cierre del micrófono a los 10 s termina con despedida amable y Care conserva la configuración para el cuidador.
6. **Sin registro de fracaso frente al paciente**: los ejercicios no puntúan en voz alta ni muestran errores; las métricas van solo al historial del cuidador.
7. **El dispositivo no debe poder desconfigurarse por el paciente** ([[Investigacion sobre neurologia]], nota final): no hay controles de configuración locales; todo se administra desde Care.

**Celular del paciente (juegos en pantalla).** Además de lo anterior, rige lo siguiente (referencia visual: `Design/previews/screens-09-paciente.html`, P3 a P27, y frame 39):

8. **El sonido y la vibración no sorprenden**: empiezan **apagados** y los activa el cuidador administrador (Ajustes → Dispositivos). Un sonido inesperado puede sobresaltar a una persona con demencia, y el celular del paciente no tiene dónde configurarlo (regla 7). Cuando están activos: una nota corta al acertar, dos al terminar, volumen bajo, vibración leve; **nunca** suenan ni vibran al errar, y se mezclan con lo que esté sonando en vez de cortarlo. En Android no se puede detectar el modo silencio del timbre (el sonido sale por el volumen multimedia); en iOS se respeta. El interruptor del cuidador es el control.
9. **Movimiento lento y único**: la foto de reminiscencia y la tarjeta de fin aparecen con un fundido de 400 ms (`motion-slow`) y un ascenso de 8 px. Con la reducción de movimiento del sistema aparecen de una vez. Nada parpadea ni se repite ([[Fundamentos Visuales]] §6).
10. **El celular mide el juego, no observa a la persona**: ánimo y participación de una partida jugada solo quedan «Sin registrar». El cuidador puede completarlos después **solo si estuvo presente**; el formulario arranca vacío, sin valores por defecto (un «Media / Neutral» preseleccionado se leería como algo observado). Los números por juego (errores, tiempos, veces que paró antes) van al cuidador como registro, **sin sugerir subir ni bajar el nivel**: esa regla adaptativa está pendiente de validar con la psicopedagoga y el nivel lo elige el cuidador.
11. **Cada juego tiene un nombre para la persona, no el del catálogo clínico**: «¿Cuál no va?», no «Clasificar elementos según diferentes criterios». Una frase literal debajo, sin repetir el título, y un ícono propio. Las secciones de la lista dicen *qué se hace* («Con tus fotos y recuerdos», «Con palabras», «Con números, dinero y fechas», «Para ordenar y pensar»), no la categoría clínica (P12).
12. **Lo que hoy no se puede jugar se ve, y se explica**: un juego sin material aparece apagado, con borde punteado y el motivo en una frase («Usa fotos que carga tu cuidador»), siempre al final de su sección. Tocarlo abre un aviso corto que dice qué falta y quién lo resuelve (el cuidador) con un solo botón: nunca un toque que no hace nada, sin números ni la palabra «error» (P12 y P14). El cuidador ve el mismo dato con números en Care.
13. **El inicio dice una sola cosa a la vez, y pedir ayuda es lo primero de «Llamar»**: el Inicio se lee de arriba abajo en tres capas —cómo viene la ubicación (regla 19), un saludo con su nombre de pila («¡Hola, María Fernanda!») y lo que hay para hacer hoy (reglas 17 y 18)— y no repite lo que ya está en la barra. **«Necesito ayuda» es la primera opción de «Ayuda»** (el lugar de la barra, que no se llama «Llamar» para que quede claro que ahí se avisa a los cuidadores si la persona se siente mal o necesita asistencia), rojo, de 96 px y con la letra del título (28 px, no una letra chica en un botón grande); llamar a alguien queda debajo, como alternativa, y ayuda sigue a la vista aunque los contactos no carguen (P25). Al pedirla se pregunta antes de avisar, así que tocarla sin querer no asusta. *Cambio de 03/11/2026: antes «Ayuda» era un botón rojo anclado en la barra de todas las pantallas; ahora son dos toques (Ayuda → Necesito ayuda) más la confirmación. Se eligió un lugar con nombre claro, y desde el 03/11/2026 en rojo sólido con borde fijo en la barra para que se note; queda a validar con cuidadores y en el piloto.*
14. **Una respuesta no se distingue por tener foto**: en un juego de elegir, las opciones llevan foto todas o ninguna. Si sólo una la tiene, esa diferencia delata la respuesta sin que la persona piense (P13).
15. **La persona sólo ve los juegos que su cuidador eligió**: el celular ofrece únicamente los juegos que el cuidador administrador habilitó (Terapias → Celular, frame 42); con ninguno, la lista dice quién lo resuelve («Tu cuidador tiene que elegir los juegos que vas a ver acá», P15) y no promete que «pronto» habrá. Es distinto de un juego elegido al que le falta material (regla 12): ese se ve apagado y con su motivo. Un juego que no se eligió no aparece, ni apagado: la persona no tiene por qué saber qué más hay.
16. **Barra inferior con pocos lugares, siempre con texto**: Inicio, Jugar, Ayuda y Ajustes, en ese orden y con ícono y palabra (un ícono solo no alcanza). Blancos de 76 px o más y letra con tope de escala 1,3×. **«Ayuda» es el único rojo**: rojo sólido y con un borde fijo (más claro al estar en esa pantalla), para encontrarla de un vistazo y con nervios. Un contador sobre «Inicio» dice cuántas cosas son para ahora (en el color de la marca). **La letra del celular del paciente nunca baja del tamaño de diseño y sube hasta 1,3× con la letra del sistema**, aplicada a mano al tamaño y al interlineado juntos (con la escala del sistema, al achicarla el texto se medía con una escala y se dibujaba con otra, y las tarjetas quedaban con renglones vacíos). La barra **no se ve mientras se juega ni al pedir ayuda** (tienen su propia salida) y **no vibra al tocar**: la vibración es opt-in del cuidador (regla 8). Los lugares se abren reemplazando la pantalla, para que «atrás» no recorra una pila de pestañas (P12, P23, P25, P26).
17. **Un aviso de rutina o de medicación dice el tipo, nunca el nombre**: «Es la hora de tu pastilla», «Es la hora de comer». El nombre del remedio y la dosis se ven recién dentro de la app, con el celular desbloqueado, porque la pantalla bloqueada la lee cualquiera. Suena **a lo sumo dos veces** (a la hora y 10 minutos después, si cabe en el margen), sin tercer intento y sin reproches («Recordatorio: es la hora de tu pastilla», nunca «olvidaste»). Es una notificación local, que suena sin internet y no pasa por servidores de terceros. Los enciende el cuidador administrador; hasta entonces el celular no avisa nada (el Inicio lo dice: «Tu cuidador todavía no activó los recordatorios»). **Tocar el aviso abre el Inicio** (P23), donde se responde (P20 y P21 son del aviso y del permiso).
18. **Los recordatorios del Inicio se leen de a pocos, con dos botones que no se confunden, y sin culpa por lo que no se hizo**: lo que toca ahora son tarjetas con botones (se ven todas) y **lo que se pasó de hora, lo que viene y lo ya hecho van en una sola tarjeta «Agenda», como la del cuidador** (ícono, nombre con una línea debajo, hora a la derecha, «Hecho» en lo cumplido; sin frase de apoyo bajo el título), de a tres con «1–3 de 12» y Anterior / Siguiente. Ahora (el **nombre en grande**, arriba una línea chica con la hora y el tipo en presente —«13:00 · Pastilla», nunca «te tocaba»— y la dosis), después lo que falta del día (sin botón: todavía no es la hora) y al final lo ya hecho (con tilde). Cada recordatorio de ahora tiene **«Sí, ya lo hice»** —verde y sólido, el único verde sólido del celular— y **«Todavía no»** —de contorno neutro—, **del mismo tamaño y con la misma letra**: la elección es sí o no, no «el botón grande y el chico». «Sí, ya lo hice» registra el cumplimiento; **«Todavía no» sólo vuelve a avisar a los 10 minutos y no registra nada**: no existe un «No lo hice» que marque una omisión, porque sería un reproche (regla 6) y porque la persona puede no recordar si lo hizo. **Lo de hoy que se pasó de hora se ve primero en la Agenda**, con «Se pasó la hora» (nunca «atrasado», «perdido» ni rojo) y el mismo «Sí, ya lo hice», que queda como confirmación tardía; ahí no hay «Todavía no» ni «No lo hice». Lo de días anteriores no se muestra: a medianoche desaparece. El contador de la barra no usa rojo (P23 y P27).
19. **El chip de ubicación dice si se está enviando, con color, ícono y texto, y el rojo no es una alerta**: arriba de todo en el Inicio. Verde (se envió hace menos de 5 minutos; «Ubicación activa», fondo y borde verdosos, una sola línea), amarillo (con demoras o un problema que se arregla solo, como no tener internet) y rojo (**no está funcionando**: falta un permiso, pasaron 15 minutos sin enviar, el GPS no responde o el cuidador desvinculó el celular); gris («Ubicación no activa») si la persona no la activó, porque es opcional y no es una falla. El rojo **no avisa al cuidador ni culpa a la persona**: dice que algo hay que arreglar, y tocar el chip lleva a Ajustes. Durante los primeros 2 minutos de la app dice «Conectando…» antes de preocupar (P24).
20. **Ajustes tiene sólo lo básico y deja claro qué se comparte**: permiso para mostrar avisos, la tarjeta de ubicación abierta con el mensaje de que el cuidador puede ver dónde está la persona (y cómo retirarlo, tan fácil como darlo), claro/oscuro y la versión. Es una excepción acotada a la regla 7: no hay nada que desconfigure el uso; el nivel, el sonido, los juegos y los avisos se administran desde Care (P26).

## 3. Uso bajo estrés — el cuidador

Una alerta crítica se lee corriendo, con el corazón acelerado, quizá de noche.

1. **Pantallas de alerta autosuficientes**: qué pasó + cuándo + qué hizo el sistema + 2-3 acciones máximo, en botones grandes. Nada de información que obligue a navegar para decidir (RN14: el cuidador decide).
2. **Jerarquía de interrupción proporcional a severidad** (Baja acumula en resumen · Media push estándar · Alta sonido distintivo · Crítica sonido insistente + pantalla completa). Proporcionalidad = confianza; confianza = menos fatiga de alarmas (problema documentado en el Estudio Inicial).
3. **Una mano, un pulgar**: acciones críticas alcanzables en la zona inferior de la pantalla en mobile.
4. **Estados compartidos en tiempo real**: «Atendida por María 14:17» — reduce ansiedad y dobles llamadas ([[Proto-personas|Diego]]).
5. **Modo offline honesto**: dato + timestamp de última sincronización, nunca datos viejos presentados como actuales.

## 4. Checklist por pantalla (para la fase de diseño y QA)

- [ ] Contraste de todos los pares presentes verificado (tokens ya validados = gratis si no se inventan colores)
- [ ] Estados: ideal / vacío / cargando / error / offline diseñados
- [ ] Foco visible y orden lógico; operable por teclado
- [ ] Targets ≥44 px; acciones primarias en zona de pulgar (mobile)
- [ ] Estado semántico = color + ícono + texto
- [ ] Texto real (no imágenes de texto); `alt` en imágenes significativas
- [ ] `aria-live` en contenido que se actualiza solo (alertas, estado del paciente)
- [ ] Sin información crítica en `text-xs`
- [ ] Copy pasado por el filtro de tono ([[Identidad de Marca]] §3): claro, sin culpa, accionable

## 5. Validación con usuarios (plan para el piloto)

- **Cuidadores (5-8, 40-70 años)**: tareas — interpretar el dashboard en 5 s, crear una rutina, resolver una alerta simulada de punta a punta. Métrica: éxito sin ayuda + SUS.
- **Pacientes (con acompañamiento profesional y consentimiento, R1/R4 del [[Project Charter]])**: sesiones cortas observadas de interacción con Aurora Home — tasa de respuesta a recordatorios, señales de confusión o rechazo ante la voz.
- Los hallazgos actualizan este manual y las [[Proto-personas]].

## Documentos relacionados
- [[Color]] · [[Tipografía]] · [[Fundamentos Visuales]] · [[VUI — Diseño Conversacional]]
