# Script reproducible del Análisis de Impacto Ambiental (Document Hub/INSTANCIA 5 — Fin de proyecto).
# Uso: python calculo_impacto_ambiental.py
"""Estimación de consumo energético y huella de carbono de Aurora (AURA-190).

Todas las cifras son ESTIMACIONES, no mediciones. Cada parámetro indica su origen:
  [P] dato publicado (fuente citada en el entregable)
  [D] dato del proyecto (Doc «Proyecto Aurora 2026» o repositorios)
  [S] supuesto del equipo
Escenarios: bajo / típico / alto.
"""


H_ANIO = 8760  # horas por año (servicio 24/7)
ESC = ("bajo", "tipico", "alto")

# ---------------------------------------------------------------- factores de emisión (kgCO2e/kWh)
FE = {
    "AR_nacional_2024": 0.292,   # [P] CAMMESA 2024 vía PtX Hub/GIZ, Tabla 5 (292 kgCO2/MWh)
    "AR_centro_2024": 0.202,     # [P] ídem, región Centro (Córdoba y San Luis)
    "US_NEWE": 543.178 * 0.45359237 / 1000,  # [P] eGRID2023 (rev. 2) NEWE 543,178 lb CO2e/MWh (Hostinger, Boston)
    "US_SRVC": 596.326 * 0.45359237 / 1000,  # [P] eGRID2023 (rev. 2) SRVC 596,326 lb CO2e/MWh (Supabase us-east-1, Azure eastus)
    "US_promedio": 770.884 * 0.45359237 / 1000,  # [P] eGRID2023 (rev. 2) U.S. 770,884 lb CO2e/MWh (Gemini, ubicación no publicada)
    "mundo_2024": 0.473,         # [P] Ember GER 2025, promedio mundial 473 gCO2/kWh (redes de datos)
    "BR_2024": 0.103,            # [P] Ember 2024 Brasil 103 gCO2/kWh (alternativa São Paulo)
}

# ---------------------------------------------------------------- Aurora Home (Raspberry Pi 5 + ReSpeaker + parlante)
P_HOME_W = {"bajo": 3.0, "tipico": 4.5, "alto": 6.0}  # [P]+[S] potencia media en el tomacorriente

# ---------------------------------------------------------------- VPS Hostinger (modelo Cloud Carbon Footprint)
CCF_MIN_W, CCF_MAX_W = 0.74, 3.5   # [P] CCF, promedio AWS por vCPU (proxy: Hostinger no publica su hardware)
CCF_MEM_W_GB = 0.392               # [P] CCF, W por GB de memoria
VPS = {  # vCPU, GB, utilización media, PUE
    "bajo":   dict(vcpu=1, gb=4, util=0.10, pue=1.20),   # [D] VPS de 1 vCPU (ADR-015) · [S] util · PUE eficiente
    "tipico": dict(vcpu=1, gb=4, util=0.25, pue=1.56),   # [D] 1 vCPU · [S] util · [P] PUE promedio Uptime 2024
    "alto":   dict(vcpu=2, gb=8, util=0.50, pue=1.56),   # [D] KVM 2 recomendado (Anexo D) · [P] util por defecto CCF 50 %
}
# ---------------------------------------------------------------- Supabase (AWS us-east-1), instancia compartida
SUPA = {
    "bajo":   dict(vcpu=0.25, gb=0.5, util=0.10, pue=1.135),  # [S] fracción de instancia Free · [P] PUE AWS (CCF)
    "tipico": dict(vcpu=0.5,  gb=1.0, util=0.25, pue=1.135),
    "alto":   dict(vcpu=1.0,  gb=1.0, util=0.50, pue=1.135),
}
N_HOGARES = 10  # [D] escenario OPEX del Plan de Proyecto, sección 6.2

# ---------------------------------------------------------------- uso por hogar y por día
MIN_VOZ_DIA = {"bajo": 10, "tipico": 20, "alto": 40}         # [S] minutos de ventanas de escucha + síntesis
WH_POR_MIN_VOZ = {"bajo": 0.05, "tipico": 0.2, "alto": 0.5}   # [S] sin dato público de Azure; acotado con 0,24 Wh/consulta (Google)
CONSULTAS_LLM_DIA = {"bajo": 5, "tipico": 20, "alto": 60}     # [S] plan diario, memoria, sesiones
WH_POR_CONSULTA = {"bajo": 0.10, "tipico": 0.24, "alto": 0.50}  # [P] Google 2025: 0,24 Wh mediana; 0,10 Wh solo acelerador
MB_POR_MIN_VOZ = 1.92 + 0.48   # [S] subida PCM 16 kHz/16 bit (256 kbit/s = 1,92 MB/min) + bajada TTS ~64 kbit/s
MB_FIJO_DIA = {"bajo": 5, "tipico": 5, "alto": 10}  # [S] heartbeat, sincronización, eventos
KWH_POR_GB_RED = 0.059          # [P] Sustainable Web Design v4, redes (operativo)

# ---------------------------------------------------------------- fabricación (embebida)
KG_PLACA = 6.5                   # [P] Raspberry Pi (evaluación de Inhabit): fabricar, enviar y desechar una Pi 4 o 5
ACCESORIOS_FRAC = {"bajo": 0.5, "tipico": 0.75, "alto": 1.0}  # [S] accesorios sin dato publicado: +50 % a +100 %
VIDA_UTIL_ANIOS = {"bajo": 6, "tipico": 5, "alto": 4}  # [S]

# ---------------------------------------------------------------- comparaciones
KG_POR_KM_AUTO = 0.1771          # [P] DESNZ 2025 vía Energy Saving Trust, auto promedio
GPU_L4_W = 72                    # [P] NVIDIA L4, TDP máx.
PC_ESCRITORIO_W = (30, 50)       # [P] PC de escritorio típica en reposo
MINI_PC_W = (10, 12)             # [P] mini PC x86 en reposo con un servidor liviano


def vm_w(c):
    return (c["vcpu"] * (CCF_MIN_W + c["util"] * (CCF_MAX_W - CCF_MIN_W)) + c["gb"] * CCF_MEM_W_GB) * c["pue"]


def calc():
    r = {}
    for e in ESC:
        home_kwh = P_HOME_W[e] * H_ANIO / 1000
        vps_kwh_total = vm_w(VPS[e]) * H_ANIO / 1000
        supa_kwh_total = vm_w(SUPA[e]) * H_ANIO / 1000
        voz_kwh = MIN_VOZ_DIA[e] * 365 * WH_POR_MIN_VOZ[e] / 1000
        llm_kwh = CONSULTAS_LLM_DIA[e] * 365 * WH_POR_CONSULTA[e] / 1000
        gb_anio = (MIN_VOZ_DIA[e] * MB_POR_MIN_VOZ + MB_FIJO_DIA[e]) * 365 / 1000
        red_kwh = gb_anio * KWH_POR_GB_RED

        comp = {
            "Aurora Home (Raspberry Pi 5, 24/7)": (home_kwh, FE["AR_nacional_2024"]),
            "VPS Hostinger (parte de 1 hogar sobre 10)": (vps_kwh_total / N_HOGARES, FE["US_NEWE"]),
            "Supabase (parte de 1 hogar sobre 10)": (supa_kwh_total / N_HOGARES, FE["US_SRVC"]),
            "Voz en la nube (Azure Speech)": (voz_kwh, FE["US_SRVC"]),
            "Modelo de lenguaje (Gemini)": (llm_kwh, FE["US_promedio"]),
            "Transferencia de datos (redes)": (red_kwh, FE["mundo_2024"]),
        }
        filas = {k: {"kwh": kwh, "kg": kwh * fe, "fe": fe} for k, (kwh, fe) in comp.items()}
        tot_kwh = sum(f["kwh"] for f in filas.values())
        tot_kg = sum(f["kg"] for f in filas.values())
        emb_total = KG_PLACA * (1 + ACCESORIOS_FRAC[e])
        emb_anual = emb_total / VIDA_UTIL_ANIOS[e]
        r[e] = {
            "filas": filas,
            "total_kwh": tot_kwh,
            "total_kg_operacion": tot_kg,
            "embebido_total_kg": emb_total,
            "embebido_anual_kg": emb_anual,
            "total_kg_con_embebido": tot_kg + emb_anual,
            "vps_w": vm_w(VPS[e]),
            "vps_kwh_total": vps_kwh_total,
            "supa_w": vm_w(SUPA[e]),
            "supa_kwh_total": supa_kwh_total,
            "gb_anio": gb_anio,
            "home_share_kg": filas["Aurora Home (Raspberry Pi 5, 24/7)"]["kg"] / tot_kg,
            "km_auto_equiv": (tot_kg + emb_anual) / KG_POR_KM_AUTO,
            "diez_hogares_kg": N_HOGARES * (tot_kg + emb_anual),
            "diez_hogares_kwh": N_HOGARES * tot_kwh,
        }
        # sensibilidad: red de la región Centro para Aurora Home
        r[e]["home_kg_centro"] = home_kwh * FE["AR_centro_2024"]
    return r


def alternativas(r):
    t = r["tipico"]
    out = {}
    # A. dispositivo del hogar
    out["rpi_kwh"] = (P_HOME_W["bajo"] * 8.76, P_HOME_W["alto"] * 8.76)
    out["minipc_kwh"] = tuple(w * 8.76 for w in MINI_PC_W)
    out["pc_kwh"] = tuple(w * 8.76 for w in PC_ESCRITORIO_W)
    for k in ("rpi_kwh", "minipc_kwh", "pc_kwh"):
        out[k.replace("kwh", "kg")] = tuple(x * FE["AR_nacional_2024"] for x in out[k])
    # B. GPU dedicada 24/7 vs API compartida
    gpu_kwh = GPU_L4_W * H_ANIO / 1000
    out["gpu_kwh_solo_placa"] = gpu_kwh
    out["gpu_kwh_con_pue"] = gpu_kwh * 1.56
    out["gpu_kwh_por_hogar_10"] = gpu_kwh * 1.56 / N_HOGARES
    out["gpu_tercio_kwh_por_hogar_10"] = gpu_kwh / 3 * 1.56 / N_HOGARES  # [S] promedio a 1/3 del TDP
    out["llm_api_kwh_por_hogar"] = t["filas"]["Modelo de lenguaje (Gemini)"]["kwh"]
    out["gpu_vs_api_veces"] = (out["gpu_tercio_kwh_por_hogar_10"] / out["llm_api_kwh_por_hogar"],
                               out["gpu_kwh_por_hogar_10"] / out["llm_api_kwh_por_hogar"])
    # Equivalencias y ahorro por ajustes de reposo de la Raspberry Pi (0,3 a 0,8 W, publicado)
    out["led_9w_12h_kwh"] = 9 * 12 * 365 / 1000
    out["ahorro_reposo_10_hogares_kwh"] = (0.3 * H_ANIO / 1000 * N_HOGARES, 0.8 * H_ANIO / 1000 * N_HOGARES)
    out["ratio_home_vs_minipc"] = (MINI_PC_W[0] / P_HOME_W["alto"], MINI_PC_W[1] / P_HOME_W["bajo"])
    out["ratio_home_vs_pc"] = (PC_ESCRITORIO_W[0] / P_HOME_W["alto"], PC_ESCRITORIO_W[1] / P_HOME_W["bajo"])
    # C. escucha continua vs ventanas (típico)
    min_cont = 1440
    voz_cont_kwh = min_cont * 365 * WH_POR_MIN_VOZ["tipico"] / 1000
    gb_cont = (min_cont * MB_POR_MIN_VOZ + MB_FIJO_DIA["tipico"]) * 365 / 1000
    red_cont_kwh = gb_cont * KWH_POR_GB_RED
    out["continua_voz_kwh"] = voz_cont_kwh
    out["continua_gb"] = gb_cont
    out["continua_red_kwh"] = red_cont_kwh
    out["continua_kg_extra"] = (voz_cont_kwh - t["filas"]["Voz en la nube (Azure Speech)"]["kwh"]) * FE["US_SRVC"] + \
        (red_cont_kwh - t["filas"]["Transferencia de datos (redes)"]["kwh"]) * FE["mundo_2024"]
    out["continua_factor_total"] = (t["total_kg_operacion"] + out["continua_kg_extra"]) / t["total_kg_operacion"]
    # C2. voz 100 % local (ADR-006): sin nube de voz; +2 W en la RPi durante las ventanas (supuesto)
    extra_rpi_kwh = 2.0 * MIN_VOZ_DIA["tipico"] / 60 * 365 / 1000
    ahorro_kg = t["filas"]["Voz en la nube (Azure Speech)"]["kg"] + \
        (MIN_VOZ_DIA["tipico"] * MB_POR_MIN_VOZ * 365 / 1000) * KWH_POR_GB_RED * FE["mundo_2024"] - \
        extra_rpi_kwh * FE["AR_nacional_2024"]
    out["local_extra_rpi_kwh"] = extra_rpi_kwh
    out["local_ahorro_kg"] = ahorro_kg
    # D. un VPS compartido vs dos VPS
    out["vps_extra_kwh"] = (r["bajo"]["vps_kwh_total"], r["alto"]["vps_kwh_total"])
    out["vps_extra_kg"] = tuple(x * FE["US_NEWE"] for x in out["vps_extra_kwh"])
    # E. región São Paulo para la nube (típico, por hogar)
    nube = ["VPS Hostinger (parte de 1 hogar sobre 10)", "Supabase (parte de 1 hogar sobre 10)", "Voz en la nube (Azure Speech)"]
    kg_us = sum(t["filas"][k]["kg"] for k in nube)
    kg_br = sum(t["filas"][k]["kwh"] for k in nube) * FE["BR_2024"]
    out["region_us_kg"] = kg_us
    out["region_br_kg"] = kg_br
    # Beneficio ilustrativo: viaje en auto evitado
    out["km_semana_ilustrativo"] = 10
    out["kg_viaje_evitado_anual"] = 10 * 52 * KG_POR_KM_AUTO
    out["km_punto_equilibrio_anual"] = t["total_kg_con_embebido"] / KG_POR_KM_AUTO
    out["km_punto_equilibrio_semanal"] = out["km_punto_equilibrio_anual"] / 52
    out["viaje_vs_huella_veces"] = out["kg_viaje_evitado_anual"] / t["total_kg_con_embebido"]
    out["local_ahorro_pct_huella"] = ahorro_kg / t["total_kg_con_embebido"]
    # MVP sep-nov 2026 (3 meses): 1 RPi 24/7 + 1 VPS entero + embebido total
    out["mvp_rpi_kwh"] = P_HOME_W["tipico"] * H_ANIO / 1000 / 4
    out["mvp_vps_kwh"] = r["tipico"]["vps_kwh_total"] / 4
    out["mvp_kg_oper"] = out["mvp_rpi_kwh"] * FE["AR_nacional_2024"] + out["mvp_vps_kwh"] * FE["US_NEWE"]
    out["mvp_kg_embebido"] = r["tipico"]["embebido_total_kg"]
    return out


if __name__ == "__main__":
    r = calc()
    a = alternativas(r)
    print("Factores de emisión (kg/kWh):", {k: round(v, 4) for k, v in FE.items()})
    for e in ESC:
        x = r[e]
        print(f"\n=== Escenario {e} ===")
        for k, f in x["filas"].items():
            print(f"  {k:48s} {f['kwh']:8.2f} kWh/año  {f['kg']:7.2f} kgCO2e/año  (FE {f['fe']:.3f})")
        print(f"  TOTAL operación: {x['total_kwh']:.1f} kWh/año · {x['total_kg_operacion']:.1f} kgCO2e/año")
        print(f"  Embebido: {x['embebido_total_kg']:.2f} kg total · {x['embebido_anual_kg']:.2f} kg/año")
        print(f"  TOTAL con embebido: {x['total_kg_con_embebido']:.1f} kgCO2e/año · equivale a {x['km_auto_equiv']:.0f} km en auto")
        print(f"  Aurora Home / operación: {x['home_share_kg']*100:.0f} % · Home con red Centro: {x['home_kg_centro']:.2f} kg")
        print(f"  VPS: {x['vps_w']:.2f} W -> {x['vps_kwh_total']:.1f} kWh/año · Supabase: {x['supa_w']:.2f} W -> {x['supa_kwh_total']:.1f} kWh/año · datos {x['gb_anio']:.1f} GB/año")
        print(f"  10 hogares: {x['diez_hogares_kwh']:.0f} kWh/año · {x['diez_hogares_kg']:.0f} kgCO2e/año")
    print("\n=== Alternativas ===")
    for k, v in a.items():
        print(f"  {k}: {v if not isinstance(v, float) else round(v, 2)}")
