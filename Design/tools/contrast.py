#!/usr/bin/env python3
"""Verificador de contraste WCAG 2.x para los tokens de Aurora.
Imprime el ratio de cada par uso/fondo y si cumple AA / AAA.
Fórmula: https://www.w3.org/TR/WCAG22/#dfn-contrast-ratio
"""
import json
import sys
from pathlib import Path

TOKENS = Path(__file__).resolve().parent.parent / "tokens" / "tokens.json"


def srgb_to_lin(c):
    c = c / 255
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4


def luminance(hexcolor):
    hexcolor = hexcolor.lstrip("#")
    r, g, b = (int(hexcolor[i:i + 2], 16) for i in (0, 2, 4))
    return 0.2126 * srgb_to_lin(r) + 0.7152 * srgb_to_lin(g) + 0.0722 * srgb_to_lin(b)


def ratio(fg, bg):
    l1, l2 = sorted((luminance(fg), luminance(bg)), reverse=True)
    return (l1 + 0.05) / (l2 + 0.05)


def check(pairs, colors):
    """pairs: lista de dicts {fg, bg, uso, nivel} con nombres de token."""
    failures = 0
    print(f"{'uso':<52} {'fg':<26} {'bg':<26} {'ratio':>6}  req  ok")
    print("-" * 130)
    for p in pairs:
        fg, bg = colors[p["fg"]], colors[p["bg"]]
        r = ratio(fg, bg)
        req = {"AA": 4.5, "AA-large": 3.0, "AAA": 7.0, "UI": 3.0}[p["nivel"]]
        ok = r >= req
        failures += 0 if ok else 1
        print(f"{p['uso']:<52} {p['fg']+' '+fg:<26} {p['bg']+' '+bg:<26} {r:>6.2f}  {p['nivel']:<8} {'✓' if ok else '✗ FALLA'}")
    print("-" * 130)
    print("TODOS LOS PARES CUMPLEN" if failures == 0 else f"{failures} PARES FALLAN")
    return failures


if __name__ == "__main__":
    data = json.loads(TOKENS.read_text())
    colors = {}
    for group, items in data["primitivos"]["color"].items():
        for name, value in items.items():
            colors[f"{group}-{name}"] = value
    pairs = data["verificacion"]["pares"]
    sys.exit(1 if check(pairs, colors) else 0)
