---
base: "[[Document Hub.base]]"
Category:
  - Documentación Académica
Created by: Equipo Aurora
Last updated time: 2026-11-14
---

# Análisis de Impacto Ambiental Aurora

## Introducción

Este documento es el análisis de impacto ambiental del proyecto Aurora, entregable de la Instancia 5 de la guía de la cátedra (ticket AURA-190). Estima cuánta energía consume la solución y qué huella de carbono aproximada genera, compara las alternativas de diseño que el equipo evaluó según su impacto ambiental, describe las prácticas adoptadas para reducirlo y los beneficios esperables de su implementación.

**Todas las cifras son estimaciones, no mediciones.** El equipo no midió el consumo eléctrico de Aurora Home ni del servidor. Cada valor se construye con potencias típicas publicadas, factores de emisión oficiales y supuestos de uso declarados como tales. La tabla de la sección 2.1 indica el origen de cada cifra, y el cálculo se puede reproducir con el script de la sección 7.

## Audiencia

Está dirigido al docente y a la comunidad académica. Se asume conocimiento de la arquitectura de Aurora (ver [[Arquitectura y Stack Tecnológico]], en particular los ADR-007, ADR-008 y ADR-011) y de nociones básicas de energía (W, kWh) y de huella de carbono (kg de CO₂ equivalente, kg CO₂e).

## 1. Alcance y criterio de la estimación

**Escenario de referencia.** Se usa el del Plan de Proyecto (sección 6.2): **10 hogares activos** que usan Aurora todos los días. Se calcula la huella por hogar y por año en tres escenarios (bajo, típico y alto) y el total de los 10 hogares.

**Qué incluye:**

- La operación de **Aurora Home** (Raspberry Pi 5 con el ReSpeaker 2-Mics Pi HAT y el parlante), encendida las 24 horas como servicio del sistema. Tiene que estar siempre encendida para que los recordatorios funcionen sin conexión (ADR-008).
- La parte proporcional (1/10) de la **infraestructura compartida**: el VPS de Hostinger (Aurora Core, Worker IA, n8n y Redis) y Supabase.
- Los **servicios en la nube que se pagan por uso**: voz (Azure Speech) y modelo de lenguaje (Gemini).
- La **transferencia de datos** por la red.
- La **fabricación del hardware** de Aurora Home (huella embebida), repartida en su vida útil.

**Qué no incluye, y por qué:**

- Los celulares de los cuidadores y del paciente con Aurora Care: son dispositivos que el hogar ya tiene, y el consumo atribuible a la app es marginal y no se puede estimar con fundamento.
- El Drop-in (LiveKit Cloud), la integración continua (GitHub Actions) y los builds de EAS: uso ocasional y sin datos.
- Las computadoras del equipo y los traslados durante el desarrollo.
- El entrenamiento de los modelos de terceros, el agua de refrigeración y la fabricación de los servidores de los proveedores: los proveedores no publican esos datos por cliente.

**Criterio de cálculo.** Energía (kWh/año) = potencia media (W) × horas de uso / 1.000. Emisiones (kg CO₂e/año) = energía × factor de emisión de la red eléctrica del lugar donde se consume (criterio *location-based*). Para los servidores en la nube se usa la metodología abierta de Cloud Carbon Footprint (CCF): potencia por vCPU según su utilización, más potencia por GB de memoria, multiplicada por el PUE del centro de datos.

## 2. Estimación del consumo energético y de la huella de carbono

### 2.1 Supuestos y fuentes de cada cifra

El origen de cada cifra se indica así: **[P]** dato publicado (con la fuente de la lista final), **[D]** dato del proyecto y **[S]** supuesto del equipo.

| # | Parámetro | Bajo | Típico | Alto | Origen |
| --- | --- | --- | --- | --- | --- |
| 1 | Potencia media de Aurora Home, medida en el tomacorriente | 3,0 W | 4,5 W | 6,0 W | [P]+[S] Raspberry Pi indica 2 a 3 W en reposo y menos de 10 W a plena carga [F1]. Mediciones independientes dan 3,0 W en reposo con Wi-Fi y unos 0,5 W más con el ventilador activo [F2], y entre 1,8 y 3 W según la fuente de alimentación [F15]. El white paper térmico de Raspberry Pi indica 4 a 5 W de consumo mínimo para la Pi 5 [F3]. El típico suma el reposo (3,0 W), el ventilador (0,5 W) y 1,0 W supuesto para el HAT de audio, el parlante y los servicios de Aurora Home. |
| 2 | Horas de funcionamiento de Aurora Home | 8.760 h/año | 8.760 h/año | 8.760 h/año | [D] Servicio `aurora-home.service` que corre siempre (ADR-008). |
| 3 | VPS: vCPU y memoria | 1 vCPU · 4 GB | 1 vCPU · 4 GB | 2 vCPU · 8 GB | [D] El VPS actual tiene 1 vCPU (ADR-015 de Aurora Core); el plan de 1 vCPU de Hostinger trae 4 GB (Anexo C). El alto usa el plan KVM 2 recomendado en el Anexo D. |
| 4 | Potencia por vCPU (mínima y máxima) y por GB de memoria | 0,74 y 3,5 W · 0,392 W/GB | ídem | ídem | [P] CCF, promedio de AWS [F6]. Se usa como aproximación porque Hostinger no publica su hardware. |
| 5 | Utilización media de la CPU del VPS | 10 % | 25 % | 50 % | [S] Todavía no hay monitoreo (AURA-147). El 50 % es el valor por defecto de CCF [F6]. |
| 6 | PUE (energía total del centro de datos sobre energía de los equipos) | 1,20 | 1,56 | 1,56 | [P] 1,56 es el promedio mundial de 2024 (Uptime Institute) [F7]; 1,20 es un supuesto para un centro de datos eficiente. Para Supabase (AWS) se usa 1,135 [F6]. |
| 7 | Supabase: parte de una instancia compartida | 0,25 vCPU · 0,5 GB · 10 % | 0,5 vCPU · 1 GB · 25 % | 1 vCPU · 1 GB · 50 % | [S] Hoy se usa el plan Free, que es compartido (Plan de Proyecto, sección 6.2). |
| 8 | Hogares que comparten la infraestructura | 10 | 10 | 10 | [D] Plan de Proyecto, sección 6.2. |
| 9 | Minutos de voz en la nube por hogar y por día | 10 | 20 | 40 | [S] Ventanas de escucha de los recordatorios y de la sesión diaria. Sin usuarios reales no hay dato. |
| 10 | Energía por minuto de voz en la nube | 0,05 Wh | 0,2 Wh | 0,5 Wh | [S] Microsoft no publica la energía de Azure Speech. Se acota con el orden de magnitud de una consulta a un modelo de IA (0,24 Wh [F8]). |
| 11 | Consultas al modelo de lenguaje por hogar y por día | 5 | 20 | 60 | [S] Plan diario de sesiones, consultas a la memoria del paciente y actividades. |
| 12 | Energía por consulta al modelo de lenguaje | 0,10 Wh | 0,24 Wh | 0,50 Wh | [P]+[S] Google midió 0,24 Wh para la consulta mediana de Gemini Apps y 0,10 Wh si se cuentan solo los aceleradores [F8]. Aurora usa Gemini Flash Lite por API, que no está medido por separado; el alto cubre consultas con más contexto (RAG). |
| 13 | Datos transferidos | 2,4 MB por minuto de voz + 5 MB/día | ídem | 2,4 MB por minuto de voz + 10 MB/día | [S] Subida de audio PCM de 16 kHz y 16 bits (256 kbit/s, es decir 1,92 MB por minuto), unos 0,48 MB por minuto de síntesis, y un monto fijo diario de heartbeat, sincronización y eventos. |
| 14 | Energía de la red por GB transferido | 0,059 kWh/GB | ídem | ídem | [P] Sustainable Web Design, versión 4 [F9]. |
| 15 | Factor de emisión de la red argentina (Aurora Home) | 0,292 kg CO₂e/kWh | ídem | ídem | [P] CAMMESA 2024, promedio nacional [F4]. Sensibilidad: región Centro (Córdoba y San Luis), 0,202. |
| 16 | Factor de emisión de Boston (VPS de Hostinger) | 0,246 | ídem | ídem | [P] eGRID2023, subregión NEWE: 543,2 lb CO₂e/MWh [F5]. La ubicación es dato del proyecto (Arquitectura, sección 6.6). |
| 17 | Factor de emisión de Virginia (Supabase us-east-1 y Azure eastus) | 0,270 | ídem | ídem | [P] eGRID2023, subregión SRVC: 596,3 lb CO₂e/MWh [F5]. |
| 18 | Factor de emisión para el modelo de lenguaje | 0,350 | ídem | ídem | [P] eGRID2023, promedio de EE. UU.: 770,9 lb CO₂e/MWh [F5]. Google no publica dónde se atiende cada consulta. |
| 19 | Factor de emisión de la red de datos | 0,473 | ídem | ídem | [P] Promedio mundial de 2024 según Ember [F10]: los datos cruzan varios países. |
| 20 | Huella de fabricación de la placa Raspberry Pi | 6,5 kg CO₂e | ídem | ídem | [P] Evaluación independiente encargada por Raspberry Pi: fabricar, enviar y desechar una Pi 4 o 5 [F1]. |
| 21 | Huella de fabricación de los accesorios | +50 % de la placa | +75 % | +100 % | [S] La fuente, el ventilador, el HAT, el parlante, el gabinete impreso, la microSD y los cables no tienen dato publicado. |
| 22 | Vida útil de Aurora Home | 6 años | 5 años | 4 años | [S] |

### 2.2 Resultado por hogar y por año

Los totales se calculan sin redondear; por eso la suma de las filas redondeadas puede diferir en un decimal.

| Componente | Bajo: kWh | Bajo: kg CO₂e | Típico: kWh | Típico: kg CO₂e | Alto: kWh | Alto: kg CO₂e |
| --- | --- | --- | --- | --- | --- | --- |
| Aurora Home (Raspberry Pi 5, 24 h) | 26,3 | 7,7 | 39,4 | 11,5 | 52,6 | 15,3 |
| VPS de Hostinger (1/10) | 2,7 | 0,7 | 4,1 | 1,0 | 10,1 | 2,5 |
| Supabase (1/10) | 0,4 | 0,1 | 1,1 | 0,3 | 2,5 | 0,7 |
| Voz en la nube (Azure Speech) | 0,2 | 0,05 | 1,5 | 0,4 | 7,3 | 2,0 |
| Modelo de lenguaje (Gemini) | 0,2 | 0,06 | 1,8 | 0,6 | 11,0 | 3,8 |
| Transferencia de datos | 0,6 | 0,3 | 1,1 | 0,5 | 2,3 | 1,1 |
| **Total de operación** | **30,4** | **8,9** | **49,0** | **14,4** | **85,7** | **25,4** |
| Fabricación de Aurora Home, por año de vida útil | — | 1,6 | — | 2,3 | — | 3,3 |
| **Total por hogar** | **30,4 kWh** | **10,5** | **49,0 kWh** | **16,6** | **85,7 kWh** | **28,6** |

La fabricación de un equipo Aurora Home completo se estima en 9,8 kg CO₂e (bajo), 11,4 kg (típico) y 13,0 kg (alto).

### 2.3 Escenario de 10 hogares y estado actual del MVP

| Escenario | Energía (kWh/año) | Huella (kg CO₂e/año) |
| --- | --- | --- |
| 10 hogares, bajo | 304 | 105 |
| 10 hogares, típico | 490 | 166 |
| 10 hogares, alto | 857 | 286 |

Para dar escala: la huella típica de un hogar (16,6 kg CO₂e por año) equivale a recorrer unos **94 km en un auto promedio** (0,177 kg CO₂e/km [F13]). Aurora Home por sí sola consume en un año (39,4 kWh, típico) lo mismo que una lámpara LED de 9 W encendida 12 horas por día.

**MVP actual (septiembre a noviembre de 2026).** Hoy hay un solo Aurora Home y un VPS con el entorno de staging, sin pacientes reales. En esos tres meses, con el escenario típico, la Raspberry Pi encendida todo el día consumiría unos 9,9 kWh y el VPS unos 10,2 kWh: alrededor de **5,4 kg CO₂e de operación**, más unos 11,4 kg de fabricación del prototipo. Es un valor máximo, porque la Raspberry Pi no estuvo encendida todo el período. El consumo de Gemini registrado hasta el 15/10/2026 fue de USD 0,39 (Plan de Proyecto, sección 6.2); no se convierte a energía porque no se tiene el conteo de tokens.

### 2.4 Lectura de los resultados

- **El dispositivo del hogar pesa más que toda la nube.** Aurora Home explica entre el 60 % y el 86 % de las emisiones de operación (80 % en el escenario típico), porque está encendido las 24 horas en cada hogar. La palanca principal para reducir el impacto es su consumo en reposo.
- **La nube compartida es chica por hogar.** El VPS y Supabase, repartidos entre 10 hogares, suman alrededor de 1,3 kg CO₂e por hogar y por año en el escenario típico.
- **La mayor incertidumbre está en la voz y en la IA.** Azure no publica datos de energía y los minutos y consultas por día son supuestos sin usuarios reales. En el escenario alto, voz e IA llegan al 23 % de la huella de operación.
- **El factor de emisión importa.** Con el factor de la región Centro (0,202 en lugar de 0,292), la huella de Aurora Home en el escenario típico baja de 11,5 a 8,0 kg CO₂e por año.
- **La fabricación no es despreciable.** Representa entre el 11 % y el 15 % de la huella total por hogar, así que alargar la vida útil del equipo reduce el impacto.

## 3. Alternativas de diseño evaluadas por impacto ambiental

La mayoría de estas decisiones se tomaron por otros motivos (latencia, privacidad, costo o cuestiones legales) y están registradas en los ADR. Aquí se vuelven a evaluar por su impacto ambiental con el mismo método de la sección 2. Cuando la opción ambientalmente mejor no fue la elegida, se dice y se explica por qué.

| Decisión | Opción adoptada | Alternativa evaluada | Impacto ambiental estimado | Qué se decidió y por qué |
| --- | --- | --- | --- | --- |
| Equipo de procesamiento en el hogar (ADR-007 y ADR-008; Anexo D, sección 6) | Raspberry Pi 5: 3 a 6 W, 26 a 53 kWh/año, 7,7 a 15,3 kg CO₂e/año | Mini PC x86: 10 a 12 W en reposo [F14], 88 a 105 kWh/año. PC de escritorio con GPU para correr la IA en el hogar (Anexo D, caso 2): 30 a 50 W solo en reposo [F2], 263 a 438 kWh/año | La Raspberry Pi consume entre 1,7 y 4 veces menos que un mini PC y entre 5 y 17 veces menos que una PC de escritorio | Se adoptó la Raspberry Pi también por costo y tamaño. Coincide con la opción de menor impacto. |
| Dónde corre el modelo de lenguaje (Anexo D, secciones 5 y 6) | API gestionada y compartida (Gemini): 1,8 kWh por hogar y por año (típico) | GPU dedicada encendida las 24 horas (NVIDIA L4, potencia máxima de 72 W [F12]) | Entre 33 y 98 kWh por hogar y por año (de un tercio de la potencia máxima a la potencia máxima, con PUE 1,56, repartido entre 10 hogares y sin contar el servidor que la aloja): entre 19 y 56 veces más | Se adoptó la API: no hay GPU en la arquitectura base. La inferencia sin servidor que se apaga sin uso (Anexo D, caso 1) quedó como evolución y no se cuantifica. |
| Cuándo se escucha al paciente (ADR-011) | Solo durante las ventanas abiertas por un recordatorio o una actividad (10 a 40 min/día) | Escucha continua en la nube (1.440 min/día) | Por hogar, el procesamiento de voz pasaría de 1,5 a 105 kWh/año y los datos transferidos, de 19 a unos 1.263 GB/año: la huella de operación se multiplicaría por 5,4 (típico) | Se adoptaron las ventanas por privacidad. Es también la opción de menor impacto. |
| Dónde se reconoce la voz (ADR-006, reemplazado por ADR-011) | Azure Speech en la nube, con respaldo local | Reconocimiento y síntesis 100 % locales (Whisper.cpp y Piper) | La opción local ahorraría unos 0,8 kg CO₂e por hogar y por año (sin voz en la nube ni subida de audio, con 2 W supuestos de consumo extra en la Raspberry Pi durante las ventanas): alrededor del 5 % de la huella típica | Ambientalmente, la opción local era un poco mejor. Se descartó por usabilidad: en las pruebas del 24 y 25/09/2026, la voz local tuvo un p95 de 8,02 s y fallas de reconocimiento. El costo ambiental de esa decisión es chico. |
| Servidores (ADR-007) | Un solo VPS para staging y producción | Un VPS por entorno, o una plataforma con un servicio por componente (Render, Anexo D) | Cada servidor adicional encendido las 24 horas suma entre 27 y 101 kWh/año (entre 6,7 y 24,8 kg CO₂e/año) | Se adoptó un VPS por costo; también es la opción de menor impacto. La contracara es que una falla del servidor afecta a los dos entornos. |
| Región de la nube (Arquitectura, sección 6.6) | Estados Unidos: Hostinger en Boston, Supabase y Azure en Virginia (0,246 a 0,270 kg CO₂e/kWh) | São Paulo (red de Brasil, 0,103 kg CO₂e/kWh [F11]) | El VPS, Supabase y la voz bajarían de 1,7 a 0,7 kg CO₂e por hogar y por año (−60 %) | Se mantuvo Estados Unidos por una decisión del 13/10/2026 tomada en el marco del análisis legal. Ambientalmente, São Paulo sería mejor, aunque el efecto absoluto es de alrededor de 1 kg por hogar y por año. |
| Pulsera biométrica (Decisión de Alcance del 29/08/2026) | Sin pulsera en el MVP | Aurora Band (AmazFit Bip 5 o similar) en cada hogar | Se evita fabricar y cargar un dispositivo más con batería por hogar. No se cuantifica porque no hay dato publicado de la huella de esa pulsera. | Se decidió por presupuesto (ver [[Decisión de Alcance — Aurora Band fuera del MVP]]); el efecto ambiental es favorable. |

## 4. Prácticas para reducir el impacto

### 4.1 Prácticas adoptadas

1. **Procesamiento en el borde con respaldo en la nube.** Lo que se repite todos los días y no necesita un modelo grande corre en la Raspberry Pi: los recordatorios programados, la detección de la palabra de activación, la clasificación de la respuesta (CONFIRMÓ, RECHAZO o NINGUNA) y la cola de eventos en SQLite. La nube se usa solo donde aporta calidad: la voz y la IA (ADR-008 y ADR-011).
2. **Audio solo en ventanas de escucha, nunca de forma continua** (ADR-011; Arquitectura, sección 6.4). Reduce el procesamiento en la nube y los datos transferidos, como muestra la sección 3.
3. **Hardware de bajo consumo y sin pantalla.** Aurora Home es una Raspberry Pi 5 sin monitor; la interfaz del cuidador está en el celular que ya tiene.
4. **Infraestructura compartida y sin GPU propia.** Un solo VPS para los dos entornos, una base de datos gestionada y APIs de voz e IA compartidas, en lugar de máquinas dedicadas que estarían ociosas la mayor parte del día (Anexo D).
5. **Un modelo de lenguaje de la línea liviana** (Gemini 3.5 Flash Lite, configurable). Los modelos más chicos suelen requerir menos cómputo por consulta; el proveedor no publica la energía por modelo, así que no se cuantifica.
6. **Menos dispositivos por hogar.** La pulsera quedó fuera del MVP, y la visión futura es integrar un wearable comercial en lugar de fabricar uno propio (Estudio Inicial, Fuera del alcance).
7. **Notificaciones push** para las alertas (AURA-106): la app no necesita consultar al servidor periódicamente, lo que ahorra batería en los celulares, en línea con el requerimiento no funcional de eficiencia energética.
8. **Minimización y retención acotada de los datos** (Arquitectura, sección 6.3). El motivo principal es la privacidad, pero también reduce el almacenamiento y las copias de respaldo.

### 4.2 Prácticas recomendadas (pendientes)

1. **Medir en lugar de estimar.** Medir la potencia de Aurora Home con un medidor USB-C (cuesta entre USD 15 y 25 [F2]), con el benchmark HOME-0608 del repositorio de Aurora Home, que ya prevé registrar la potencia (`--power-watts`). Con ese valor se reemplaza la fila 1 de la tabla 2.1 y se recalcula.
2. **Bajar el consumo en reposo de la Raspberry Pi** desactivando lo que no se usa (por ejemplo, HDMI y Bluetooth) y ajustando la frecuencia mínima. Las mediciones publicadas reportan entre 0,3 y 0,8 W menos [F2]: entre 26 y 70 kWh/año menos para 10 hogares.
3. **Monitorear el VPS** (AURA-147) para conocer la utilización real y dimensionar el plan.
4. **Revisar la región al pasar a producción.** Si el análisis legal lo permite, São Paulo reduce la huella de la nube a menos de la mitad.
5. **Planificar el fin de vida de Aurora Home.** La placa es de propósito general y se puede reutilizar; si no, debe ir a un circuito de reciclaje de residuos electrónicos. Alargar la vida útil reduce la parte de fabricación.

## 5. Beneficios a partir de la implementación

**Aclaración.** Aurora todavía no se implementó con pacientes reales: el MVP corre en el entorno de staging (ver [[Estado consolidado y tendencias]]). Por eso los beneficios de esta sección son esperados o estimados; ninguno fue medido.

### 5.1 Beneficios que ya aportan las decisiones de diseño

- **Bajo consumo por hogar:** unos 49 kWh por año en el escenario típico, toda la solución incluida.
- **Frente a las alternativas evaluadas:** el equipo del hogar consume entre 1,7 y 17 veces menos que un mini PC o una PC de escritorio; la IA compartida, entre 19 y 56 veces menos que una GPU dedicada; y escuchar solo en ventanas evita multiplicar por 5,4 la huella de operación.
- **Reutilización de dispositivos existentes:** Aurora Care corre en los celulares de los cuidadores, y Aurora Home no suma pantallas ni pulseras al hogar.

### 5.2 Beneficios ambientales esperados de la operación (no medidos)

- **Traslados evitados.** Uno de los valores esperados de Aurora es que el cuidador deje de verificar todo de manera presencial (Estudio Inicial, Valor esperado). Si Aurora evitara apenas unos 94 km de viajes en auto por año en un hogar (unos 1,8 km por semana), compensaría toda su huella típica. Como ilustración, evitar un viaje de ida y vuelta de 10 km por semana ahorraría unos 92 kg CO₂e por año, unas 5,5 veces la huella típica del hogar. **No está validado:** habría que medir los traslados del cuidador antes y después con usuarios reales, y Aurora no busca reemplazar la presencia del cuidador (Estudio Inicial, Fuera del alcance).
- **Menos papel y registros dispersos:** el historial digital reemplaza cuadernos, planillas y notas sueltas. El efecto ambiental es chico y no se cuantifica.

### 5.3 Beneficios no ambientales

Los beneficios principales de Aurora son sociales y de salud: continuidad de las rutinas, menor carga para el cuidador y trazabilidad del cumplimiento. Están descritos en el Estudio Inicial (Valor esperado) y se miden con los indicadores del Plan de Proyecto (sección 3.1).

## 6. Limitaciones

- Nada se midió: las cifras dependen de potencias típicas y de supuestos de uso sin usuarios reales.
- La energía de Azure Speech no es pública; el valor por minuto es un supuesto de orden de magnitud.
- Los 0,24 Wh por consulta corresponden a la consulta mediana de Gemini Apps, no a Gemini Flash Lite por API.
- Se usan factores *location-based*. Los proveedores informan cifras *market-based* más bajas (por ejemplo, Google informa 0,03 g CO₂e por consulta, porque compra energía limpia [F8]); no se usan para no mezclar criterios.
- Los coeficientes de CCF son de AWS y se usan como aproximación para Hostinger.
- El factor de energía por GB transferido es un promedio: sirve para dar escala, pero sobreestima el efecto de agregar unos pocos datos a una red que ya está encendida.
- No se incluyen los celulares, el desarrollo, la fabricación de los servidores de los proveedores ni el agua.

## 7. Cómo se recalcula

El cálculo está en el script `calculo_impacto_ambiental.py`, en esta misma carpeta. Se ejecuta con `python calculo_impacto_ambiental.py` y no tiene dependencias externas. Para reemplazar un supuesto por una medición, se cambia el parámetro correspondiente (cada uno indica si es [P], [D] o [S]) y se vuelve a ejecutar.

## Fuentes

**Datos publicados** (consultados el 14/11/2026):

- **[F1]** Raspberry Pi Ltd. «16GB Raspberry Pi 5 on sale now at $120». Consumo en reposo de 2 a 3 W, menos de 10 W a plena carga, y 6,5 kg CO₂e para fabricar, enviar y desechar una Pi 4 o 5 (evaluación de Inhabit). <https://www.raspberrypi.com/news/16gb-raspberry-pi-5/>
- **[F2]** raspberry.tips. «Raspberry Pi Power Consumption (Update 2026): All Models Compared». Pi 5: 3,0 W en reposo con Wi-Fi, unos 0,5 W extra del ventilador activo, ajustes que ahorran entre 0,3 y 0,8 W, PC de escritorio típica de 30 a 50 W en reposo, y medidor USB-C de USD 15 a 25. <https://raspberry.tips/en/faq/raspberry-pi-power-consumption-update-2026-all-models-compared-2>
- **[F3]** Raspberry Pi Ltd. White paper «Use-case-specific thermal performance of Raspberry Pi SBCs» (RP-010139-WP). Consumo mínimo de la Pi 5: 4 a 5 W. <https://pip-assets.raspberrypi.com/categories/685-app-notes-guides-whitepapers/documents/RP-010139-WP-1-Use-case-specific%20thermal%20performance%20of%20Raspberry%20Pi%20SBCs.pdf>
- **[F4]** PtX Hub y GIZ, con datos de CAMMESA. «Criterios de la UE para certificación de H2 y PtX — Edición Argentina» (2025), Tabla 5: intensidad de emisiones de la red en 2024, 292 kg CO₂/MWh en el promedio nacional y 202 kg CO₂/MWh en la región Centro. <https://ptx-hub.org/wp-content/uploads/2025/11/Criterios-de-la-UE-para-certificacion-de-H2-y-PtX-Edicion-Argentina.pdf>
- **[F5]** US EPA. eGRID2023 (revisión 2, junio de 2025), «Summary Data»: tasas de emisión por subregión (NEWE 543,178; SRVC 596,326; promedio de EE. UU. 770,884 lb CO₂e/MWh). <https://www.epa.gov/egrid/summary-data>
- **[F6]** Cloud Carbon Footprint. «Methodology»: 0,74 y 3,5 W por vCPU (promedio de AWS), 0,392 W por GB de memoria, utilización por defecto del 50 % y PUE de AWS de 1,135. <https://www.cloudcarbonfootprint.org/docs/methodology/>
- **[F7]** Uptime Institute. «Global Data Center Survey 2024: regional view»: PUE promedio mundial de 1,56. <https://intelligence.uptimeinstitute.com/sites/default/files/2024-09/UI%20Field%20report%20154_Annual%20survey%20-%20regional%20view.pdf>
- **[F8]** Elsworth y otros (Google). «Measuring the environmental impact of delivering AI at Google Scale» (2025): 0,24 Wh y 0,03 g CO₂e (*market-based*) por consulta mediana de Gemini Apps, y 0,10 Wh contando solo los aceleradores. <https://arxiv.org/abs/2508.15734> · <https://cloud.google.com/blog/products/infrastructure/measuring-the-environmental-impact-of-ai-inference>
- **[F9]** Sustainable Web Design. «Estimating Digital Emissions» (modelo versión 4): 0,059 kWh por GB para las redes. <https://sustainablewebdesign.org/estimating-digital-emissions/>
- **[F10]** Ember. «Global Electricity Review 2025»: intensidad de carbono promedio mundial de 473 g CO₂/kWh en 2024. <https://ember-energy.org/latest-insights/global-electricity-review-2025/major-countries-and-regions/>
- **[F11]** GreentechLead, con datos de Ember: intensidad de carbono de la electricidad de Brasil de 103 g CO₂/kWh en 2024. <https://greentechlead.com/?p=49381>
- **[F12]** NVIDIA. «L4 Tensor Core GPU»: potencia máxima (TDP) de 72 W. <https://www.nvidia.com/en-us/data-center/l4/>
- **[F13]** Energy Saving Trust, con los factores de conversión 2025 de DESNZ (Reino Unido): auto promedio, 0,1771 kg CO₂e/km. <https://fleetdecarbonisationtoolkit.energysavingtrust.org.uk/?p=1719>
- **[F14]** Evetech. «Raspberry Pi 5 vs a mini PC for a home server»: mini PC x86 de 10 a 12 W en reposo con un servidor liviano. <https://evezone.evetech.co.za/deep-dives/raspberry-pi-5-vs-a-mini-pc-for-a-home-server-which-wins-on-power-draw>
- **[F15]** Jeff Geerling. «Answering some questions about the Raspberry Pi 5»: consumo en reposo en el tomacorriente de 1,8 a 3 W según la fuente. <https://www.jeffgeerling.com/blog/2023/answering-some-questions-about-raspberry-pi-5/>

**Datos del proyecto:**

- Documento «Proyecto Aurora 2026»: Plan de Proyecto (secciones 6.1 y 6.2), Estudio Inicial (Valor esperado y Fuera del alcance), Arquitectura y Stack Tecnológico (sección 2.3, ADR-006, ADR-007, ADR-008, ADR-011 y secciones 6.3 y 6.6), Estado consolidado y tendencias, y Anexos C y D.
- Repositorio Aurora Core: `docs/adr/ADR-015-livekit-media-dropin.md` (VPS de 1 vCPU).
- Repositorio Aurora Home: `deploy/systemd/aurora-home.service` (servicio permanente) y `Docs/08-hil-respeaker-v2.md` (benchmark HOME-0608 con registro de potencia).

Ver también: [[Investigación — Despliegue e Infraestructura]] · [[Project Charter]] · [[Índice Aurora]].
