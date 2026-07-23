# Vistas DBML del DER de Aurora

Este paquete contiene una vista general resumida y siete vistas técnicas por dominio.

## Archivos

1. `01_Vista_General.dbml`
   - Vista ejecutiva del flujo completo.
   - Columnas reducidas para presentación.
   - 14 tablas representativas.

2. `02_Core_y_Cuidadores.dbml`
   - Hogar DOT, paciente, cuidadores, contactos, consentimientos y preferencias.

3. `03_Rutinas_y_Medicacion.dbml`
   - Rutinas, programaciones, medicaciones y cumplimiento.

4. `04_Voz_e_Interaccion.dbml`
   - Sesiones de voz, mensajes, grabaciones, recordatorios, actividades y drop-in.

5. `05_Biometria_y_Eventos.dbml`
   - Dispositivos, lecturas, criterios, geocercas y eventos detectados.

6. `06_Alertas_y_Escalamiento.dbml`
   - Alertas, reglas, escalamiento, notificaciones, llamadas y confirmaciones.

7. `07_Inteligencia_Artificial.dbml`
   - Memorias, embeddings, estado cognitivo, decisiones y logs del LLM.

8. `08_Orquestacion_y_Compliance.dbml`
   - Flujos automáticos, ejecuciones, auditoría, retención, accesos y claves.

## Criterio utilizado

- Las tablas principales de cada dominio conservan su definición completa.
- Las tablas pertenecientes a otros dominios se muestran de forma resumida y se agrupan como `external_context`.
- Los siete dominios cubren exactamente las 50 tablas del DER físico original.
- La vista general no reemplaza al DER físico: está pensada para exposición y documentación ejecutiva.

## Uso en dbdiagram.io

1. Crear un diagrama nuevo.
2. Importar o pegar el contenido de uno de los archivos `.dbml`.
3. Usar `01_Vista_General.dbml` para la presentación inicial.
4. Abrir la vista de dominio correspondiente cuando se necesite explicar una parte en detalle.
