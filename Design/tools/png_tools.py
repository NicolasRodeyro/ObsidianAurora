#!/usr/bin/env python3
"""Herramientas PNG en stdlib puro (sin PIL): decodificar, recortar,
escalar (nearest), guardar y muestrear colores. Usado para extraer la
paleta del branding de Aurora desde las capturas de Figma."""
import struct
import sys
import zlib


def decode_png(path):
    """Devuelve (width, height, pixels) con pixels como lista de filas RGBA."""
    with open(path, "rb") as f:
        data = f.read()
    assert data[:8] == b"\x89PNG\r\n\x1a\n", "no es un PNG"
    pos = 8
    idat = b""
    width = height = bitdepth = colortype = None
    palette = []
    while pos < len(data):
        length = struct.unpack(">I", data[pos:pos + 4])[0]
        ctype = data[pos + 4:pos + 8]
        chunk = data[pos + 8:pos + 8 + length]
        if ctype == b"IHDR":
            width, height, bitdepth, colortype = struct.unpack(">IIBB", chunk[:10])
            assert bitdepth == 8, f"bitdepth {bitdepth} no soportado"
        elif ctype == b"PLTE":
            palette = [tuple(chunk[i:i + 3]) for i in range(0, len(chunk), 3)]
        elif ctype == b"IDAT":
            idat += chunk
        elif ctype == b"IEND":
            break
        pos += 12 + length
    raw = zlib.decompress(idat)
    channels = {0: 1, 2: 3, 3: 1, 4: 2, 6: 4}[colortype]
    stride = width * channels
    rows = []
    prev = bytearray(stride)
    off = 0
    for _ in range(height):
        ftype = raw[off]
        off += 1
        line = bytearray(raw[off:off + stride])
        off += stride
        if ftype == 1:  # Sub
            for i in range(channels, stride):
                line[i] = (line[i] + line[i - channels]) & 0xFF
        elif ftype == 2:  # Up
            for i in range(stride):
                line[i] = (line[i] + prev[i]) & 0xFF
        elif ftype == 3:  # Average
            for i in range(stride):
                a = line[i - channels] if i >= channels else 0
                line[i] = (line[i] + ((a + prev[i]) >> 1)) & 0xFF
        elif ftype == 4:  # Paeth
            for i in range(stride):
                a = line[i - channels] if i >= channels else 0
                b = prev[i]
                c = prev[i - channels] if i >= channels else 0
                p = a + b - c
                pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
                pr = a if (pa <= pb and pa <= pc) else (b if pb <= pc else c)
                line[i] = (line[i] + pr) & 0xFF
        prev = line
        # normalizar a RGBA
        if colortype == 6:
            row = [tuple(line[i:i + 4]) for i in range(0, stride, 4)]
        elif colortype == 2:
            row = [(line[i], line[i + 1], line[i + 2], 255) for i in range(0, stride, 3)]
        elif colortype == 0:
            row = [(v, v, v, 255) for v in line]
        elif colortype == 3:
            row = [(*palette[v], 255) for v in line]
        elif colortype == 4:
            row = [(line[i], line[i], line[i], line[i + 1]) for i in range(0, stride, 2)]
        rows.append(row)
    return width, height, rows


def encode_png(path, rows):
    """Guarda filas RGBA como PNG (sin filtros)."""
    height = len(rows)
    width = len(rows[0])
    raw = bytearray()
    for row in rows:
        raw.append(0)
        for px in row:
            raw.extend(px[:4])

    def chunk(ctype, payload):
        c = ctype + payload
        return struct.pack(">I", len(payload)) + c + struct.pack(">I", zlib.crc32(c))

    ihdr = struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0)
    with open(path, "wb") as f:
        f.write(b"\x89PNG\r\n\x1a\n")
        f.write(chunk(b"IHDR", ihdr))
        f.write(chunk(b"IDAT", zlib.compress(bytes(raw), 6)))
        f.write(chunk(b"IEND", b""))


def crop_scale(rows, x0, y0, x1, y1, factor=1):
    """Recorta [x0:x1, y0:y1] y escala por entero (nearest)."""
    out = []
    for y in range(y0, y1):
        src = rows[y][x0:x1]
        line = []
        for px in src:
            line.extend([px] * factor)
        for _ in range(factor):
            out.append(line)
    return out


def sample(rows, x, y, box=3):
    """Color promedio en una caja box×box centrada en (x, y)."""
    n = r = g = b = 0
    for yy in range(y - box // 2, y + box // 2 + 1):
        for xx in range(x - box // 2, x + box // 2 + 1):
            px = rows[yy][xx]
            r += px[0]
            g += px[1]
            b += px[2]
            n += 1
    return "#{:02X}{:02X}{:02X}".format(round(r / n), round(g / n), round(b / n))


if __name__ == "__main__":
    cmd = sys.argv[1]
    if cmd == "crop":
        # png_tools.py crop in.png out.png x0 y0 x1 y1 [factor]
        w, h, rows = decode_png(sys.argv[2])
        x0, y0, x1, y1 = map(int, sys.argv[4:8])
        factor = int(sys.argv[8]) if len(sys.argv) > 8 else 1
        encode_png(sys.argv[3], crop_scale(rows, x0, y0, x1, y1, factor))
        print(f"ok {sys.argv[3]} ({(x1-x0)*factor}x{(y1-y0)*factor})")
    elif cmd == "size":
        w, h, _ = decode_png(sys.argv[2])
        print(w, h)
    elif cmd == "sample":
        # png_tools.py sample in.png x,y x,y ...
        w, h, rows = decode_png(sys.argv[2])
        for coord in sys.argv[3:]:
            x, y = map(int, coord.split(","))
            print(coord, sample(rows, x, y))
