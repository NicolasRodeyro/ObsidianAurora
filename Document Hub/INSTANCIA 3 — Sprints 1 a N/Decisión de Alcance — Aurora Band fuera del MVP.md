---
base: "[[Document Hub.base]]"
Created time: 2026-08-29T15:00:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Análisis
Last updated time: 2026-08-29T15:00:00
---
# Decisión de Alcance — Aurora Band fuera del MVP

**Fecha:** 2026-08-29 · **Motivo:** restricción presupuestaria · **Estado:** postergado, no cancelado

Se deja de lado el componente **Aurora Band** (pulsera biométrica comercial) para el MVP de la tesis. No se compra hardware ni se integra la API del fabricante en este ciclo. Afecta a la épica **AURA-19 — Monitoreo Biométrico**, reclasificada de `mvp` a `vision` y movida a PAUSED/BLOCKED junto con **AURA-64** (investigación de hardware).

## Por qué se posterga en lugar de eliminarse

La restricción es económica y temporal, no un cambio de visión del producto. Eliminar los requerimientos y el código tendría tres costos sin beneficio:

1. **Rompería la trazabilidad.** RF-15 a RF-23 están en [[Requerimientos]] (fuente autoritativa) y mapeados en [[Trazabilidad RF-Épicas]]. Los [[Informe Sprint 1|informes de Sprint 1]] y [[Informe Sprint 2|Sprint 2]] ya los referencian: son registros históricos y no se reescriben.
2. **`apps/biometrics` no es exclusiva de Band.** Ver el análisis técnico más abajo.
3. **No hay nada corriendo que cueste dinero.** El código de Band que existe está inerte sin dispositivo; conservarlo no tiene costo de infraestructura.

## Análisis técnico — qué es de Band y qué no

### AuroraCareBack — `apps/biometrics` se conserva

La app mezcla dos responsabilidades:

| Elemento | ¿Exclusivo de Band? | Decisión |
| --- | --- | --- |
| `PatientDevice`, `DeviceStatusLog` | **No** — `device_type` incluye `aurora_home` | Conservar |
| Ruta `/biometrics/devices/` | **No** — la consume Ajustes → Dispositivos y las etiquetas de dispositivo de Inicio | Conservar |
| `BiometricReading` | Sí | Conservar inerte |
| `BandBiometricIngestionView` y ruta `/band/biometrics/` | Sí | Conservar inerte |

Borrar la app rompería la vista de **Dispositivos** y el estado de **Aurora Home**, que no tienen relación con la pulsera. Si en el futuro se quiere separar, corresponde extraer los modelos de dispositivo a su propia app antes de tocar biometría — y eso implica migraciones sobre tablas en uso.

### AuroraCareFront — la cadena Bluetooth es código muerto

`src/services/bluetooth/` (incluido `bluetoothService.ts`) sólo lo consume `src/features/devices/hooks/useBluetooth.ts`, que **no tiene ningún consumidor** en `app/` ni en `src/`. Sumado a la dependencia nativa `@sfourdrinier/react-native-ble-plx`, es lo único removible sin efecto sobre ninguna pantalla. La feature ya estaba además gateada por `EXPO_PUBLIC_RUNTIME_PROFILE` en `src/shared/config/native-features.ts`.

El corte de MVP del frontend (`AuroraCareFront/Docs/MVP_FRONTEND_CLOSURE_PLAN.md`) **ya excluía** biometría y vinculación de pulsera, así que no hay trabajo de frontend que revertir.

### Diseño

Las pantallas **V4 (Dashboard biométrico)** y **V6** de `Design/previews/screens-07-vision.html` ya estaban clasificadas como `vision`, fuera del corte del MVP. No requieren cambios.

## Consecuencias a revisar

Sin Band no hay fuente de frecuencia cardíaca, movimiento, GPS ni temperatura corporal. Eso deja sin insumo:

- **Detección de eventos que dependa de biometría** — épica AURA-22, módulo 3. Hay que revisar qué historias asumían la pulsera como fuente y cuáles puede cubrir Aurora Home.
- **Geofencing por GPS de la pulsera** — el CRUD de zonas seguras (AURA-86) está terminado en backend, pero sin GPS no hay quién dispare la salida de zona.
- **Pantalla V1-V3** del diseño (zonas seguras, alerta crítica de salida de zona, escalado con llamada), que dependen de esa fuente.

## Para retomar

1. Reactivar AURA-19: label `vision` → `mvp`, sacar `descope-economico`, transicionar desde PAUSED/BLOCKED.
2. Retomar AURA-64 y cerrar la selección de hardware **antes** de comprar.
3. Reinstalar la dependencia BLE y restaurar `src/services/bluetooth/` desde el historial de git si se optó por removerla.
4. Revisar si el contrato de ingesta `/band/biometrics/` (con `X-Device-API-Key`) sigue siendo adecuado para la pulsera elegida.
