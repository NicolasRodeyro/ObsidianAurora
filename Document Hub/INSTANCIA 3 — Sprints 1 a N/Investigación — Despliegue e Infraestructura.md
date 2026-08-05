---
base: "[[Document Hub.base]]"
Created time: 2026-08-02T12:00:00
Last edited by: Jeremías Maldonado Gómez
Created by: Jeremías Maldonado Gómez
Category:
  - Análisis
Last updated time: 2026-08-02T12:00:00
---
# Investigación — Despliegue e Infraestructura

Análisis de dónde desplegar cada componente del ecosistema Aurora y con qué dimensionamiento (CPU/RAM/GPU/modelos), refinando **ADR-007 (Hostinger VPS + AWS)** de [[Arquitectura y Stack Tecnológico]]. Complementa [[Investigación — Almacenamiento de Datos y Ley 25.326]] (residencia de datos) y cubre RNF de infraestructura/rendimiento del [[Requerimientos|módulo correspondiente]].

> **Estado de verificación.** Precios y límites relevados por búsqueda web dirigida el **02/08/2026**; cada número lleva su fuente. Los precios cloud cambian seguido: revalidar antes de comprometer presupuesto. Marcas: ✅ verificado contra fuente · 🔶 interpretación del equipo · ⚠️ a revalidar. No es asesoramiento legal ni contractual.

---

## 1. Hallazgos principales

1. **Ya existe una estrategia de despliegue** (ADR-007: híbrido Hostinger VPS + AWS Free Tier + Supabase Free). Este documento la presiona y le agrega dimensionamiento, no la reemplaza.
2. **Con la arquitectura actual NO se necesita GPU en la nube.** STT corre en la CPU de la Raspberry Pi (Whisper.cpp); LLM y TTS son APIs gestionadas; los embeddings los generará el Worker IA (aún no implementado) vía API o modelo CPU. La GPU solo aparece si se decide *self-hostear* los modelos — y esa es una decisión de **Ley 25.326 / residencia**, no de costo (ver §6 y [[Investigación — Almacenamiento de Datos y Ley 25.326]]).
3. **El discriminador de plataforma no es vCPU/RAM, es "siempre encendido + WebSocket persistente"** (Aurora Core usa Django Channels; n8n corre schedulers). Eso descarta serverless con *scale-to-zero* como opción cómoda.

---

## 2. Qué hay que desplegar

| Unidad | Stack | Perfil de recursos | Restricción clave |
|---|---|---|---|
| **Aurora Core** | Django 6 + DRF + Channels (ASGI/WebSocket), gunicorn/uvicorn | ~0.5–1 vCPU · 512 MB–1 GB | Siempre encendido + WebSocket |
| **Worker IA** | FastAPI, LLM+RAG (orquesta APIs) — *no implementado aún* | ~0.25–0.5 vCPU · 256–512 MB | I/O-bound (espera APIs) |
| **n8n** | Node, self-hosted | ~0.5 vCPU · 512 MB–1 GB | Siempre encendido |
| **Redis** | cache + pub/sub | ~128–256 MB | — |
| **PostgreSQL 16 + pgvector** | Supabase Cloud | Free: 500 MB DB | Pausa a los 7 días sin queries ⚠️ |
| **Aurora Care** (web) | Expo web export (estático) | CDN estática | — |
| **Aurora Care** (móvil) | Expo → EAS Build | build service | 30 builds/mes gratis |
| **Aurora Home** | Python + Whisper.cpp | RPi 5 8 GB (edge) | No es deploy de nube: vive en el hogar |

**El discriminador real** es "siempre encendido + WebSocket". Cloud Run soporta WebSocket pero con timeout de request de **máx. 60 min (default 5 min)** y al escalar a cero corta conexiones — [Cloud Run WebSockets](https://docs.cloud.google.com/run/docs/triggering/websockets). Por eso conviene un **host always-on de contenedores** (VPS, Lightsail, Railway, Render, Fargate) y no serverless.

---

## 3. Opciones para el bloque always-on (Core + Worker IA + n8n + Redis)

Sumar Supabase Free ($0) para la base. Precios a 02/08/2026.

| Opción | Specs / precio | Por qué / cuándo | Fuente |
|---|---|---|---|
| **OCI Always Free (ARM Ampere A1)** | 2 OCPU · 12 GB ARM · **$0 para siempre** | Única opción gratis-para-siempre con recursos suficientes. ⚠️ Oracle recorta límites sin aviso (halved 15-jun-2026, de 4/24 a 2/12) y reclama instancias idle | [InfoQ](https://www.infoq.com/news/2026/07/oracle-cloud-free-tier-limits/) · [OCI free tier](https://fullmetalbrackets.com/blog/oci-free-tier-breakdown) |
| **Hostinger VPS KVM2** *(baseline ADR-007)* | 2 vCPU · 8 GB · 100 GB NVMe · **$6.99/mo** | Más RAM por dólar; mismo Docker Compose que en local. Renovación sube ~100% | [Hostinger](https://propicked.com/hosting/hostinger-vps/pricing) |
| **AWS Lightsail** | 2 vCPU · 2 GB · **$12/mo** (4 GB · $24) | Análogo AWS a un VPS, precio fijo. Región `sa-east-1` (São Paulo) | [Lightsail](https://www.cloudzero.com/blog/amazon-lightsail-pricing/) |
| **AWS Free Tier (nuevo)** | $100–200 en créditos, **vence a 6 meses** | ⚠️ Ya no es 12 meses (cambió 15-jul-2025). Sirve para demo acotado, no para algo que quede corriendo | [AWS](https://aws.amazon.com/about-aws/whats-new/2025/07/aws-free-tier-credits-month-free-plan/) |
| **Railway** | Hobby $5/mo (+ uso); real ~$6–12 | Buen DX, WebSocket OK; sube con varios servicios | [Railway](https://docs.railway.com/pricing/plans) |
| **Render** | Web service Starter $7/mo por servicio | Free se duerme a 15 min (malo p/WebSocket); con 3 servicios ~$21+ | [Render](https://kuberns.com/blogs/render-pricing/) |
| **Fly.io** | pay-as-you-go desde ~$2/mo/máquina; real ~$8–25 | Sin free tier desde oct-2024; over-kill p/tesis | [Fly.io](https://fly.io/docs/about/pricing/) |

**Mejoras de calidad (independientes del proveedor):** [Coolify](https://coolify.io) (OSS, gratis) como PaaS sobre cualquier VPS (deploy desde Git, TLS, rollbacks); **Hetzner** (CX/CAX ARM) suele ganar en precio/calidad a Hostinger pero sus regiones son UE/EEUU (latencia y residencia — ver §6).

### Recomendación de despliegue

> **Primario: Hostinger KVM2 ($6.99/mo) — o Lightsail $12 en `sa-east-1` — con Docker Compose. Alternativa $0 evaluada: OCI Always Free ARM.**

Fundamento: **predecibilidad para la defensa**. OCI a $0 es tentador, pero Oracle apaga instancias idle y recorta límites sin aviso (ya pasó en 2026); $7/mo compra tranquilidad para el día del tribunal. Se documenta OCI como el camino a $0.

**Dos ⚠️ a mitigar:**
- **Supabase Free pausa a los 7 días sin queries** — [límites](https://uibakery.io/blog/supabase-pricing). Mitigar con un ping por cron/n8n, o Pro ($25/mo) la semana de defensa. (Riesgo bajo si los biométricos escriben continuamente.)
- **Renovación Hostinger** sube ~100%: contratar el término que cubra la tesis.

---

## 4. Frontend y edge

- **Aurora Care web**: `expo export` → estático en **Cloudflare Pages / Vercel (free)**.
- **Aurora Care móvil**: **EAS Build free = 30 builds/mes** (15 Android + 15 iOS) — [EAS](https://www.metacto.com/blogs/the-true-cost-of-expo-app-development-a-comprehensive-guide). iOS a device físico requiere Apple Developer ($99/año).
- **Aurora Home**: RPi 5 8 GB en el hogar (no es deploy). Whisper.cpp `base`: 30–60% CPU y ~1–2 GB RAM extra (ADR-006). Sin GPU.

---

## 5. Dimensionamiento de modelos (por qué no hay GPU en el baseline)

| Etapa | Dónde corre | Recurso | GPU |
|---|---|---|---|
| Wake word + VAD | RPi (edge) | CPU baja | No |
| STT (Whisper.cpp `base`) | RPi (edge) | 30–60% CPU, 200–500 ms | No |
| LLM (respuesta conversacional) | API gestionada (OpenAI/Anthropic/Groq) | — | No (fuera de tu infra) |
| Embeddings (RAG) | Worker IA — API o `sentence-transformers` en CPU | CPU | No |
| TTS | API gestionada (ElevenLabs/Polly); Piper local como fallback | CPU en el fallback | No |

---

## 6. Rama alternativa: self-hosting (la única que trae GPU)

Decisión gobernada por **residencia de datos / Ley 25.326**, no por costo. Separar dos motivaciones porque llevan a infra distinta:

### Caso 1 — self-host por control/costo del modelo (los datos pueden salir del país)

Inferencia **serverless scale-to-zero**, no GPU 24/7 (el paciente habla pocas veces al día).
- **Modelo:** Qwen2.5-7B-Instruct (fuerte en español) o Llama 3.1 8B, cuantizado **Q4_K_M → 6–8 GB VRAM** — [VRAM guide](https://localllm.in/blog/ollama-vram-requirements-for-local-llms). Entra en una GPU chica (L4 24 GB / A5000).
- **Serving:** Ollama (simple) o vLLM (throughput).
- **Plataforma:** **RunPod Serverless** (FlashBoot, cold start <200 ms en ~48% de requests) o **Modal** (por-segundo más barato, créditos gratis) — [comparativa 2026](https://blog.premai.io/serverless-llm-deployment-runpod-vs-modal-vs-lambda-2026/) · [RunPod](https://www.runpod.io/product/cloud-gpus). Cold starts de 2–8 s tolerables (la VUI ya pausa ≥2 s). **A volumen de tesis: unidades de dólares/mes.**
- **Embeddings:** `bge-m3` / `multilingual-e5-large` en CPU (sin GPU).
- **TTS:** Piper en CPU; XTTS-v2/Coqui (~4–6 GB) en la misma GPU si se quiere voz neuronal.

### Caso 2 — self-host por residencia (la inferencia NO puede salir del país)

El serverless de RunPod/Modal **son GPUs en EEUU** → mismo problema de transferencia internacional que OpenAI. Como **no hay región cloud en Argentina**, la única respuesta real es:
- **Hardware propio / on-prem:** workstation con **RTX 3060 12 GB o 4060 Ti 16 GB** corre 8B Q4 + embeddings + XTTS con holgura. Capex, pero mantiene los datos bajo jurisdicción y control físico. Para la tesis puede ser la propia máquina de desarrollo actuando de "servidor de inferencia del hogar".
- Alternativa sin capex: proveedor regional con DPA (São Paulo lo más cerca), que **debe validar** [[Investigación — Almacenamiento de Datos y Ley 25.326]].

---

## 7. Recomendación neta (para el ADR)

> **Baseline: APIs gestionadas (sin GPU), minimizando PII enviada** (seudonimizar antes de mandar al LLM — coincide con el "punto ciego de Groq" de la investigación de 25.326 §3).
> **Evolución documentada:** self-hosting con **Qwen2.5-7B Q4 sobre serverless scale-to-zero** si la motivación es control/costo; o **on-prem con GPU de 12–16 GB** si la investigación de 25.326 concluye que la inferencia no puede salir del país.

Así se planta una decisión defendible hoy, con su condición de cambio explícita — que es lo que la cátedra pide.

---

## 8. Fuentes

- [Cloud Run WebSockets](https://docs.cloud.google.com/run/docs/triggering/websockets) · [OCI free tier — InfoQ](https://www.infoq.com/news/2026/07/oracle-cloud-free-tier-limits/) · [OCI breakdown](https://fullmetalbrackets.com/blog/oci-free-tier-breakdown) · [Hostinger VPS](https://propicked.com/hosting/hostinger-vps/pricing) · [Lightsail](https://www.cloudzero.com/blog/amazon-lightsail-pricing/) · [AWS Free Tier nuevo](https://aws.amazon.com/about-aws/whats-new/2025/07/aws-free-tier-credits-month-free-plan/) · [Railway](https://docs.railway.com/pricing/plans) · [Render](https://kuberns.com/blogs/render-pricing/) · [Fly.io](https://fly.io/docs/about/pricing/) · [Supabase límites](https://uibakery.io/blog/supabase-pricing) · [EAS](https://www.metacto.com/blogs/the-true-cost-of-expo-app-development-a-comprehensive-guide) · [VRAM guide](https://localllm.in/blog/ollama-vram-requirements-for-local-llms) · [Serverless GPU 2026](https://blog.premai.io/serverless-llm-deployment-runpod-vs-modal-vs-lambda-2026/) · [RunPod](https://www.runpod.io/product/cloud-gpus)
