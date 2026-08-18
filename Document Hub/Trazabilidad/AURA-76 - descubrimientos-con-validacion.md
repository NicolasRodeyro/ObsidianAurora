---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
historia: "AURA-76"
epica: "AURA-15"
Last updated time: "2026-07-28T00:00:00"
---

# Artefacto de Trazabilidad — AURA-76 Descubrimientos con validación

## 1. Descripción de la Historia

| Campo | Valor |
| --- | --- |
| **Clave** | AURA-76 |
| **Tipo** | Historia de Usuario (US-D3) |
| **Épica** | [AURA-15] Motor de IA y Memoria del Paciente (Aurora Core) |
| **Estado** | Tareas por hacer |
| **Scope** | MVP |
| **Labels** | `aurora-core`, `derivada-de-diseno`, `mvp` |

### Enunciado de usuario

**Como** cuidador principal, **quiero** revisar y aprobar la información nueva que Aurora capta del paciente durante las actividades, **para** que su memoria solo incorpore datos verificados.

### Criterios de aceptación

* Todo hallazgo queda en estado `pendiente` hasta su validación (RN6).
* Aurora no menciona el hallazgo en futuras interacciones hasta que se aprueba.
* Los hallazgos forman una cola compartida con los aportes directos del cuidador.
* Existe trazabilidad de quién aprobó cada dato y cuándo.

### Notas

- Origen: backlog de diseño (_Handoff_ §3)
- Diseño relacionado: **AURA-59** (Recuerdos y validación, `screens-03-recuerdos-actividad.html`)
- Parte del **flujo de memoria** del motor de IA: después de RF-50 (incorporar información), viene la validación

---

## 2. Requerimientos Funcionales Mapeados

| RF | Descripción | Módulo | Estado en proyecto |
| --- | --- | --- | --- |
| **RF-49** | Recuperar recuerdos, rutinas, preferencias y vínculos familiares desde la memoria del paciente. | Motor de IA | ✅ Mapeado en AURA-15 |
| **RF-50** | Incorporar nueva información relevante a la memoria del paciente. | Motor de IA | ✅ Mapeado en AURA-15 |

**Observación:** AURA-76 define el **control de calidad** de RF-50. La historia no introduce nuevos RFs, sino que establece el contrato de validación previa al ingreso a memoria.

---

## 3. Architecture Decision Records (ADRs) Relevantes

### ADR-003: Base de Datos (Relacional y Vectorial)

**Relevancia:** Define la persistencia de memoria del paciente en **Supabase (PostgreSQL + pgvector)**.

**Decisión clave para AURA-76:**
- Tabla `ai.patient_memories` (estado `pendiente` hasta validación RN6)
- Tabla `ai.memory_embeddings` (solo se genera después de validación)
- Row Level Security (RLS) garantiza que cada cuidador/paciente ve solo sus datos

**Implicación:** El estado `pendiente` requiere un campo adicional en `ai.patient_memories` (ej. `validation_status enum`).

### ADR-004: Patrón Arquitectónico (Microservicios)

**Relevancia:** La validación de hallazgos ocurre en **Aurora Care (frontend React/Next.js)** ↔ **Aurora Core (API Django/DRF)**.

**Flujo:**
1. Worker IA detecta hallazgo y lo envía a Aurora Core con estado `pending_validation`
2. Aurora Core lo persiste en `ai.patient_memories` (estado `pending`)
3. Aurora Care lo expone en la cola de validación (pantalla en screens-03)
4. Cuidador lo aprueba/rechaza → mutación en Aurora Core
5. Si aprobado → se genera embedding y se linkea a `llm_interaction_logs` para trazabilidad

---

## 4. Diagrama de Entidad-Relación (Subsistema IA)

```
erDiagram
    PATIENTS ||--o{ PATIENT_MEMORIES : "has"
    PATIENTS ||--o{ COGNITIVE_STATE : "generates"
    PATIENTS ||--o{ AI_DECISIONS : "involves"
    
    PATIENT_MEMORIES {
        uuid id PK
        uuid patient_id FK
        string category
        text content
        jsonb metadata
        string validation_status "pending|approved|rejected"
        uuid validated_by_caregiver FK "nullable"
        timestamp validated_at
        timestamp created_at
        timestamp updated_at
    }
    
    MEMORY_EMBEDDINGS {
        uuid id PK
        uuid memory_id FK "only if validated"
        int chunk_index
        vector embedding
        string model_name
        string model_version
        string content_hash
        timestamp generated_at
    }
    
    AI_DECISIONS {
        uuid id PK
        uuid patient_id FK
        string decision_type
        string related_entity_type
        string related_entity_id
        string model_used
        jsonb input_refs
        jsonb output
        text reasoning
        numeric confidence
        timestamp decided_at
    }
    
    COGNITIVE_STATE {
        uuid id PK
        uuid patient_id FK
        uuid session_id FK
        string state_type
        numeric confidence
        jsonb multimodal_signals
        timestamp estimated_at
    }
```

**Notas sobre el diagrama:**
- `PATIENT_MEMORIES.validation_status` es el campo clave: `pending → approved → embedding_generated`.
- `PATIENT_MEMORIES.validated_by_caregiver` y `validated_at` brindan trazabilidad (RN6).
- `MEMORY_EMBEDDINGS` solo se crea si `validation_status = 'approved'`.

---

## 5. Diagramas de Flujo

### 5.1 Secuencia: Detección y Validación de Hallazgo

```
sequenceDiagram
    participant Patient as 👤 Paciente
    participant AuroraHome as 🏠 Aurora Home
    participant Core as 🌐 Aurora Core<br/>(Django DRF)
    participant WorkerIA as 🤖 Worker IA<br/>(FastAPI)
    participant DB as 💾 Supabase<br/>(PostgreSQL)
    participant Care as 💻 Aurora Care<br/>(React/Next.js)
    participant Caregiver as 👩‍⚕️ Cuidador

    Patient ->> AuroraHome: Interacción (voz)
    AuroraHome ->> Core: POST /interactions (audio transcripto)
    Core ->> WorkerIA: Inferir estado cognitivo + detectar hallazgo
    WorkerIA ->> Core: Hallazgo: {contenido, confianza, contexto}
    Core ->> DB: INSERT ai.patient_memories<br/>(validation_status='pending')
    Core ->> Care: WebSocket: nuevo hallazgo pendiente
    Care ->> Caregiver: Notificación + cola de validación
    Caregiver ->> Care: Toca: Aprobar / Rechazar
    Care ->> Core: PATCH /memories/{id}<br/>(validation_status='approved')
    Core ->> DB: UPDATE validation_status<br/>+ UPDATE validated_by_caregiver<br/>+ INSERT memory_embeddings
    Core ->> WorkerIA: Hallazgo validado: generar embedding
    WorkerIA ->> DB: UPDATE memory_embeddings (embedding vector)
    Core ->> AuroraHome: Hallazgo disponible para futuras interacciones
    AuroraHome ->> Patient: Próxima interacción usa memoria validada
```

### 5.2 Máquina de Estados: Ciclo de vida de un hallazgo

```
stateDiagram-v2
    [*] --> DetectedByIA: Worker IA detecta<br/>confianza > threshold
    
    DetectedByIA --> PendingValidation: Persistido en BD<br/>estado='pending'
    
    PendingValidation --> ApprovedByCaregiver: Cuidador aprueba<br/>en Aurora Care
    PendingValidation --> RejectedByCaregiver: Cuidador rechaza
    PendingValidation --> Timeout: 30 días sin validar
    
    ApprovedByCaregiver --> EmbeddingGenerated: Worker IA genera<br/>vector pgvector
    EmbeddingGenerated --> AvailableForRAG: Listo para<br/>futuras interacciones
    
    RejectedByCaregiver --> Discarded: Marcado como rechazado
    Timeout --> Discarded: Expiró sin validar
    
    AvailableForRAG --> [*]
    Discarded --> [*]
```

---

## 6. Código y Componentes

### 6.1 Backend (Aurora Core — Django/DRF)

> [!todo] Pendiente implementación

**Modelos esperados** (`core/models.py` o `ai/models.py`):

```python
# Pseudo-código; implementación real requiere validación
class PatientMemory(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    category = models.CharField(max_length=50)  # "recuerdo", "preferencia", "rutina", etc.
    content = models.TextField()
    metadata = models.JSONField(default=dict, blank=True)
    validation_status = models.CharField(
        max_length=20,
        choices=[('pending', 'Pendiente'), ('approved', 'Aprobado'), ('rejected', 'Rechazado')],
        default='pending'
    )
    validated_by = models.ForeignKey(User, null=True, blank=True, on_delete=models.SET_NULL)
    validated_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['-created_at']
        indexes = [models.Index(fields=['patient', 'validation_status'])]

class MemoryEmbedding(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4)
    memory = models.OneToOneField(PatientMemory, on_delete=models.CASCADE)
    chunk_index = models.IntegerField()
    embedding = models.VectorField(dimensions=1536)  # pgvector
    model_name = models.CharField(max_length=100)
    model_version = models.CharField(max_length=50)
    content_hash = models.CharField(max_length=64, unique=True)
    generated_at = models.DateTimeField(auto_now_add=True)
```

**Endpoints esperados**:

- `GET /api/v1/patients/{patient_id}/memories/pending` — Lista hallazgos pendientes
- `PATCH /api/v1/memories/{memory_id}` — Validar (approve/reject)
- `GET /api/v1/memories/{memory_id}` — Detalle con trazabilidad
- WebSocket: `ws://core/ws/patients/{patient_id}/memories` — Notificaciones en tiempo real

**Tests esperados**:

- [ ] POST hallazgo → estado `pending`
- [ ] PATCH → aprobación → genera embedding
- [ ] PATCH → rechazo → marca `rejected`, sin embedding
- [ ] RLS: cuidador solo ve sus propios pacientes
- [ ] Trazabilidad: `validated_by` y `validated_at` actualizados correctamente

### 6.2 Frontend (Aurora Care — React/Next.js)

> [!todo] Pendiente implementación

**Componente esperado**: `features/discoveries/` (nuevo)

```
src/features/discoveries/
├── api/
│   └── useDiscoveriesApi.ts          # CRUD para hallazgos pendientes
├── hooks/
│   ├── useDiscoveriesList.ts         # Listar pendientes (polling + WebSocket)
│   └── useDiscoveryValidation.ts     # Aprobar/rechazar
├── components/
│   ├── DiscoveriesQueue.tsx          # Lista de hallazgos pendientes
│   ├── DiscoveryCard.tsx             # Tarjeta individual (contenido + acciones)
│   ├── DiscoveryDetail.tsx           # Detalle + historial (quién, cuándo aprobó)
│   └── DiscoveryEmptyState.tsx       # Estado vacío
├── pages/
│   └── DiscoveriesPage.tsx           # Ruta /memories/discoveries
└── types.ts                          # TypeScript: Discovery, ValidationAction
```

**Pantallas de referencia**: `Design/previews/screens-03-recuerdos-actividad.html` (AURA-59)

- Sección "Validar descubrimientos": formulario con (contenido, categoría, contexto, botones Aprobar/Rechazar)
- Historial: quién aprobó, cuándo, estado actual

**Tests esperados**:

- [ ] Carga lista de hallazgos pendientes
- [ ] Botón Aprobar → PATCH con validation_status='approved' + feedback visual
- [ ] Botón Rechazar → PATCH con validation_status='rejected' + feedback visual
- [ ] Historial: muestra caregiver que validó + timestamp
- [ ] Modo offline: caché de pendientes vía Service Worker
- [ ] Notificaciones push: nuevo hallazgo detectado

---

## 7. Casos de Prueba

### 7.1 Prueba E2E: Flujo completo

**Caso:** Hallazgo detectado → Validado → Usado en interacción siguiente

```gherkin
Escenario: Cuidador aprueba hallazgo → Aurora lo usa en próxima interacción

  Dado un paciente con interacciones previas
  Y un Worker IA configurado con detección de hallazgos
  
  Cuando el paciente interactúa con Aurora Home
  Y Aurora detecta un hallazgo (ej. "le gusta el tango")
  
  Entonces el hallazgo aparece en Aurora Care con estado PENDIENTE
  Y el hallazgo no es mencionado por Aurora Home
  
  Cuando el cuidador aprueba el hallazgo en Aurora Care
  
  Entonces el estado cambia a APROBADO
  Y se genera embedding en pgvector
  Y el hallazgo está disponible para futuras interacciones
  
  Cuando el paciente interactúa nuevamente
  
  Entonces Aurora Home puede hacer referencia al hallazgo en su respuesta
```

### 7.2 Prueba unitaria: Modelo PatientMemory

```python
def test_patient_memory_pending_to_approved():
    memory = PatientMemory.objects.create(
        patient=patient,
        content="Le gusta el tango",
        validation_status='pending'
    )
    assert memory.validation_status == 'pending'
    assert memory.validated_at is None
    
    # Validar
    memory.validation_status = 'approved'
    memory.validated_by = caregiver_user
    memory.validated_at = now()
    memory.save()
    
    assert memory.validation_status == 'approved'
    assert memory.validated_by == caregiver_user
    assert memory.validated_at is not None
    
    # Verificar que el embedding solo se generó para aprobados
    assert MemoryEmbedding.objects.filter(memory=memory).exists()
```

---

## 8. Checklist de Completitud

- [ ] **Diseño**: Aprobado en screens-03 (AURA-59)
- [ ] **Base de datos**: Tabla `ai.patient_memories` con `validation_status` + RLS
- [ ] **Backend API**: Endpoints de CRUD + validación de transición de estado
- [ ] **Frontend UI**: Componente DiscoveriesQueue + integración con notificaciones
- [ ] **Worker IA**: Envía hallazgos a Aurora Core con `validation_status='pending'`
- [ ] **Tests**: E2E + unitarios + integración
- [ ] **Documentación**: Actualizar ADRs con detalles de validación
- [ ] **Validación con especialista**: Plantillas de contenido de hallazgos (R1)

---

## 9. Observaciones y Riesgos

### Riesgos identificados

1. **RN6 (Validación obligatoria)**: La arquitectura requiere sincronización entre Worker IA y Aurora Core; retraso en validación puede afectar experiencia del cuidador.
   - *Mitigación*: Caché en Aurora Home; hallazgo no se menciona hasta validación, sin degradación de UX.

2. **Embeddings duplicados**: Si un hallazgo se rechaza y después se readmite, podría haber embeddings duplicados.
   - *Mitigación*: Hash de contenido + índice único en `MemoryEmbedding` previene duplicados.

3. **Privacidad (Ley 25.326)**: Los hallazgos validados se almacenan en pgvector y se envían al LLM para RAG.
   - *Mitigación*: RLS + encriptación en tránsito; validación explícita del cuidador es consentimiento implícito.

### Dependencias externas

- **Worker IA** (AURA-15): Debe estar configurado para detectar hallazgos antes de AURA-76.
- **AURA-59** (Diseño): Pantalla de validación debe estar aprobada.
- **AURA-53** (DER): Tablas de BD deben existir.

---

## 10. Referencias

| Documento | Enlace | Relevancia |
| --- | --- | --- |
| Épica AURA-15 | `https://project-aurora-alz.atlassian.net/browse/AURA-15` | Contexto: Motor de IA |
| AURA-59 (Diseño) | `https://project-aurora-alz.atlassian.net/browse/AURA-59` | screens-03 |
| AURA-53 (BD) | `https://project-aurora-alz.atlassian.net/browse/AURA-53` | DER + tablas `ai.*` |
| Handoff de Diseño | `Document Hub/Diseño UX-UI/Handoff y Backlog de Diseño.md` | §3: US-D3 |
| Ley 25.326 | `Document Hub/INSTANCIA 3 — Sprints 1 a N/Investigación — Almacenamiento de Datos y Ley 25.326.md` | Privacidad |
| ADR-003 | `Document Hub/INSTANCIA 2 — Sprint 0/Arquitectura y Stack Tecnológico.md` | Base de datos |
| ADR-004 | Mismo documento | Patrón de microservicios |

