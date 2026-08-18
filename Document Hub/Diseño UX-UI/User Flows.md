---
base: "[[Document Hub.base]]"
Created time: 2026-07-08T21:50:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Diseño UX/UI
Last updated time: 2026-07-08T21:50:00
---
# User Flows

Capítulo 8 del [[Manual de UX-UI Aurora]]. Flujos MVP en detalle; los de visión, al final en baja fidelidad. Convención: rectángulo = pantalla/estado de UI · rombo = decisión · redondeado = acción del sistema.

## F1 · Registro y onboarding del hogar (MVP)

```mermaid
flowchart TD
    A[Descarga la app] --> B[Crear cuenta del hogar<br/>email + contraseña]
    B --> C{¿Dispositivo Aurora Home<br/>encendido?}
    C -- Sí --> D[Escanear QR público<br/>del dispositivo]
    C -- "Todavía no" --> C2[Guía de encendido<br/>con foto del dispositivo] --> D
    D --> E[Conectar al hotspot temporal<br/>y configurar Wi-Fi en el portal local]
    E --> F[Escuchar código temporal de Aurora<br/>e ingresarlo en Care]
    F --> G([Vinculación verificada<br/>con Aurora Core])
    G --> H[Paso 2 · Perfil del paciente<br/>nombre · fecha nac. · nivel GDS<br/>+ para qué se usa cada dato]
    H --> I[Paso 3 · Rutinas base<br/>plantillas: medicación / comidas / descanso]
    I -- "Omitir por ahora" --> J
    I --> J[Paso 4 · Primer recuerdo<br/>prompt guiado + foto opcional]
    J -- Omitir --> K
    J --> K[Paso 5 · Invitar cuidadores<br/>link por WhatsApp]
    K --> L[Prueba en vivo:<br/>«Escuchá cómo saluda Aurora»]
    L --> M[🏠 Inicio con checklist<br/>de pasos pendientes]
```

**Reglas**: el QR contiene sólo serial, identificador público y versión de provisioning; no lleva Wi-Fi, credenciales ni el código temporal. Aurora dicta un código de seis dígitos, de un uso, válido por dos minutos y con cinco intentos máximos; Care lo envía a Core, nunca directamente a Home. Sin el código no hay activación: una fotografía del QR no alcanza. Los pasos 3-5 son omitibles y quedan como checklist en Inicio · guardado automático por paso (si abandona, retoma donde estaba) · la cuenta es **única por hogar** (RN1); los cuidadores se asocian por **dispositivo**, sin cuentas propias.

## F2 · ABMC de rutina (MVP)

```mermaid
flowchart TD
    A[Tab Rutinas] --> B{Acción}
    B -- Nueva --> C[Editor: nombre · tipo<br/>horarios · frecuencia]
    B -- Editar --> C
    B -- Pausar --> P([Rutina pausada<br/>visible en gris en agenda])
    C --> D[Prioridad:<br/>Normal / Importante / Prioritaria<br/>→ define severidad de omisión]
    D --> E[Margen de confirmación<br/>10-60 min · RN7]
    E --> F[Mensaje de voz opcional<br/>preview TTS: «Escuchar»]
    F --> G{Validación<br/>campos mínimos}
    G -- Falta algo --> C
    G -- OK --> H([Guardada y sincronizada<br/>con Aurora Home])
    H --> I[Agenda actualizada<br/>con toast de confirmación]
```

**Regla de severidad por prioridad**: Normal → omisión = evento **Baja** (solo historial) · Importante → **Media** (push estándar) · Prioritaria → **Alta** (push sonora + escalado). Mapa completo de severidades en [[Arquitectura de Información — Aurora Care]].

## F3 · Recordatorio de medicación: confirmación / omisión (MVP — flujo del sistema)

```mermaid
flowchart TD
    A([⏰ Hora de la toma]) --> B[Aurora Home anuncia:<br/>«Ana, después del desayuno<br/>toca la pastilla de la presión»]
    B --> C{¿Respuesta de Ana?}
    C -- "«Ya la tomé» (voz)" --> D([Confirmación registrada RF-08])
    D --> E[Care: timeline ✓]
    C -- Sin respuesta --> F([Espera + reintento suave<br/>dentro del margen RN7])
    F --> G{¿Confirma en el margen?}
    G -- Sí --> D
    G -- No --> H([Omisión registrada RF-89])
    H --> I{Prioridad de la rutina}
    I -- Normal --> J([Evento Baja → historial])
    I -- Importante --> K([Alerta Media → push a cuidadores])
    I -- Prioritaria --> L([Alerta Alta → push sonora<br/>+ ciclo de escalado F5])
```

## F4 · Alta de recuerdo con validación (MVP)

```mermaid
flowchart TD
    A[Diego: Recuerdos → Nuevo] --> B[Prompts guiados:<br/>¿quién? ¿cuándo? ¿por qué importa?]
    B --> C[Adjunta foto o audio<br/>opcional]
    C --> D([Se guarda como<br/>«pendiente de validación» RN6])
    D --> E[María ve badge en Recuerdos<br/>→ Cola de validación]
    E --> F{María revisa}
    F -- Aprobar --> G([Se incorpora a la memoria<br/>de Aurora · RAG RF-50])
    F -- Editar y aprobar --> G
    F -- Rechazar con nota --> H([Vuelve a Diego con comentario])
    G --> I[Aurora puede usarlo en<br/>reminiscencia RF-09]
```

## F5 · Ciclo de vida de alerta con escalado (MVP)

```mermaid
flowchart TD
    A([Evento relevante detectado]) --> B([Alerta generada<br/>severidad: Baja/Media/Alta/Crítica])
    B --> C([Enviada por canales según<br/>reglas RF-45: push · WhatsApp])
    C --> D{¿Algún cuidador<br/>la atiende en la ventana?}
    D -- Sí --> E[Marca «atendida» + nota opcional<br/>visible para todos RF-72]
    D -- No --> F{¿Quedan contactos<br/>en el orden de escalado?}
    F -- Sí --> G([Escala al siguiente<br/>con contexto RF-41]) --> D
    F -- No --> H{Severidad}
    H -- Crítica --> I([Visión: llamada automática RF-42])
    H -- Otras --> J([Queda activa y visible<br/>en Inicio + Actividad])
    E --> K([Cerrada · trazabilidad completa<br/>generada→enviada→atendida→cerrada RF-44])
```

## F6 · Drop-in (MVP)

```mermaid
flowchart TD
    A[Inicio → «Hablar con Ana»] --> B{¿Dispositivo registrado<br/>y autorizado? RN15}
    B -- No --> X[Aviso: dispositivo no autorizado]
    B -- Sí --> C{¿Aurora Home online?}
    C -- No --> Y[«El dispositivo está sin conexión»<br/>+ última vez visto]
    C -- Sí --> D([Home anuncia: «Ana, Diego<br/>te va a decir algo» · 3 s])
    D --> E[Diego graba/habla<br/>máx 60 s · UI con onda de audio]
    E --> F([Reproducción en el parlante<br/>Aurora anuncia: «Mensaje de Diego»])
    F --> G{¿Ana quiere responder?<br/>Aurora pregunta}
    G -- Sí --> H([STT transcribe → llega a Diego<br/>como mensaje en la app])
    G -- No --> I([Fin · registrado en historial])
```

## F7 · Gestión de dispositivos (MVP)

```mermaid
flowchart TD
    A[Ajustes → Dispositivos] --> B[Aurora Home:<br/>estado · volumen · modo noche]
    B --> C{¿Conectado?}
    C -- Sí --> D[Config remota + test de sonido]
    C -- No --> E[Diagnóstico guiado:<br/>¿enchufado? ¿wifi? + última conexión<br/>RF-20/21]
    A --> F[Wearable — visión:<br/>batería · última sync]
    F -.-> G([Sin wearable → modo reducido RN10:<br/>la app lo dice sin tratarlo como error])
```

## F8 · Sesión guiada de terapia — cuidador + Aurora en dúo (MVP)

La app hace de **coach del cuidador no experto** mientras Aurora Home acompaña en vivo. El protagonista es el cuidador; Aurora aporta música y preguntas disparadoras, mientras las fotos se muestran en Care cuando el cuidador las utiliza.

```mermaid
flowchart TD
    A[Actividad → Terapias<br/>elige «Sesión de reminiscencia»] --> B[Pantalla previa:<br/>qué recuerdo usar · duración 10-15 min<br/>consejos: sin apuro, sin corregir]
    B --> C([Aurora Home se prepara:<br/>música del recuerdo lista])
    C --> D[Paso 1 · Preparación<br/>«Sentate frente a Ana, sin TV de fondo»]
    D --> E[Paso 2 · Apertura<br/>Aurora pone la música ·<br/>la app sugiere: «preguntale por la primera vez que la escuchó»]
    E --> F[Paso 3 · Exploración<br/>preguntas disparadoras y fotos en Care ·<br/>Aurora suma datos del recuerdo por voz]
    F --> G{¿Ana se angustia<br/>o se cansa?}
    G -- Sí --> H[Botón «Cerrar con calma»:<br/>Aurora baja la música,<br/>la app da el cierre sugerido]
    G -- No --> I[Paso 4 · Cierre<br/>«Agradecele que te haya contado»<br/>Aurora despide con calidez]
    H --> J([Registro de la sesión:<br/>duración · participación · ánimo])
    I --> J
    J --> K[Resultados + descubrimientos F9]
```

**Reglas**: cada paso muestra *qué decir*, *qué evitar* y *qué está haciendo Aurora* · el botón **Cerrar con calma** está siempre visible (salida airosa, principio 5 del [[VUI — Diseño Conversacional|VUI]]) · los pasos vienen de plantillas por tipo de terapia validables con especialistas (riesgo R1).

## F9 · Actividad autónoma de Aurora + descubrimientos (MVP)

```mermaid
flowchart TD
    A([Aurora propone o el cuidador programa<br/>trivia · juego de memoria · lógica simple RF-10/12]) --> B([Aurora Home ejecuta la actividad por voz<br/>≤15 min · dificultad adaptada al desempeño RF-52])
    B --> C([Registro: participación · aciertos<br/>· ánimo estimado · sin nota de «error» para Ana])
    C --> D{¿Ana mencionó algo nuevo?<br/>«mi primer trabajo fue en la farmacia»}
    D -- No --> E[Resumen en Actividad → Terapias<br/>y en el timeline]
    D -- Sí --> F([Se crea un «descubrimiento»<br/>pendiente de validación RN6])
    F --> G[María lo ve en la cola de validación<br/>de Recuerdos, marcado «lo contó Ana»]
    G -- Aprobar --> H([Entra a la memoria RAG RF-50<br/>y suma material para reminiscencia])
    G -- Descartar --> I([No se incorpora ·<br/>queda el registro de la sesión])
    E --> J([La dificultad del próximo juego<br/>se ajusta con este desempeño])
```

**Reglas**: los descubrimientos **nunca** entran directo a la memoria — mismo circuito de validación que los aportes de cuidadores (RN6) · ante señales de angustia, Aurora cambia de actividad y lo registra para el cuidador (guion G4 del VUI).

---

## Flujos de visión (lo-fi — detalle en [[Handoff y Backlog de Diseño]])

**F10 · Zonas seguras (geofencing)**: Ajustes → Zonas seguras → mapa con radio arrastrable → nombre + horarios de vigencia → guardar (RF-70). Salida de zona → evento Alta/Crítica según configuración (RN11) → alerta con mapa y última ubicación (US 3.2).

**F11 · Biometría**: dashboard con tendencias (FC, actividad, sueño); umbrales personalizados; anomalía → evento según reglas (RF-15–19, 24–26).

**F12 · Llamada automática de emergencia**: alerta Crítica sin atención en ventana → llamada TTS al primer contacto → sin respuesta → siguiente → registro completo (RF-42).

**F13 · Reporte médico**: Actividad → Exportar → rango de fechas + secciones (cumplimiento, eventos, interacciones) → PDF para el profesional de la salud (RNF Exportación).

## Documentos relacionados
- [[Journeys y Escenarios]] · [[Arquitectura de Información — Aurora Care]] · [[VUI — Diseño Conversacional]] (la mitad de F3 y F6 ocurre por voz)
