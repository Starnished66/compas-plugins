from pathlib import Path
from PIL import Image, ImageDraw
import argparse

OUT = Path(__file__).resolve().parents[1] / 'plugins' / 'Podcasts'
ICON_DIR = OUT / 'icons'
SIZE, SCALE = 96, 4
S = SIZE * SCALE

# Restrained neon palette, matched to the purple/cyan microphone in the player theme.
PALETTE = {
    'show':    ('#211A35', '#B47CFF', '#55E7F0'),
    'download':('#142A32', '#42D9E8', '#8CF4F5'),
    'search':  ('#30291D', '#FFD166', '#FFE6A3'),
    'manage':  ('#252536', '#B6A7E8', '#D3D0E1'),
    'play':    ('#1C3028', '#66E29A', '#A0F2BD'),
    'refresh': ('#142A32', '#42D9E8', '#8CF4F5'),
    'remove':  ('#321F28', '#FF778A', '#FFB0B9'),
    'check':   ('#1C3028', '#66E29A', '#A0F2BD'),
    'link':    ('#292039', '#BE91FF', '#E0C8FF'),
}

def xy(v): return round(v * SCALE)
def box(x0, y0, x1, y1): return (xy(x0), xy(y0), xy(x1), xy(y1))
def line(d, pts, color, width=5, joint='curve'):
    d.line([(xy(x), xy(y)) for x, y in pts], fill=color, width=xy(width), joint=joint)
def ellipse(d, rect, outline, width=5, fill=None):
    d.ellipse(box(*rect), outline=outline, width=xy(width), fill=fill)
def arc(d, rect, start, end, color, width=5):
    d.arc(box(*rect), start=start, end=end, fill=color, width=xy(width))

def make_icon(name):
    bg, primary, secondary = PALETTE[name]
    im = Image.new('RGBA', (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    # A faint tinted rim and compact dark disc leave fully transparent corners.
    d.ellipse(box(5.5, 5.5, 90.5, 90.5), fill=bg, outline=tuple(bytes.fromhex(bg[1:])) + (255,), width=xy(1))
    # Add a soft inner tint ring, intentionally subtle at 44px UI scale.
    rim = tuple(max(0, min(255, int(v * 1.18))) for v in bytes.fromhex(bg[1:])) + (255,)
    d.ellipse(box(6, 6, 90, 90), outline=rim, width=xy(1))

    if name == 'show':
        # Classic studio microphone: grille, yoke, stem and a small wave pair.
        d.rounded_rectangle(box(39, 20, 57, 59), radius=xy(8), fill=primary,
                            outline=secondary, width=xy(2))
        for y in (30, 37, 44, 51):
            line(d, [(43, y), (53, y)], '#E8D8FF', 2)
        # Short broadcast parentheses sit beside the capsule, never above it.
        arc(d, (29, 29, 39, 49), 225, 135, secondary, 3.5)
        arc(d, (57, 29, 67, 49), 45, 315, secondary, 3.5)
        # Open U cradle hugs the lower capsule, followed by a slim stand and foot.
        line(d, [(35, 46), (35, 53), (38, 59), (43, 62), (48, 63),
                 (53, 62), (58, 59), (61, 53), (61, 46)], secondary, 4)
        line(d, [(48, 63), (48, 72)], secondary, 4)
        line(d, [(39, 74), (57, 74)], secondary, 4)
    elif name == 'download':
        line(d, [(48, 23), (48, 57)], primary, 6)
        line(d, [(36, 46), (48, 58), (60, 46)], primary, 6)
        line(d, [(27, 57), (27, 68), (69, 68), (69, 57)], secondary, 5)
    elif name == 'search':
        ellipse(d, (26, 24, 57, 55), primary, 5)
        line(d, [(50, 50), (69, 69)], primary, 6)
        # Tiny gleam keeps the lens from reading as a plain ring.
        line(d, [(34, 31), (39, 28)], secondary, 2.5)
    elif name == 'manage':
        for y, knobx in ((31, 39), (48, 58), (65, 34)):
            line(d, [(25, y), (71, y)], secondary, 4)
            ellipse(d, (knobx-5, y-5, knobx+5, y+5), primary, 3.5, fill=bg)
    elif name == 'play':
        # Broad, softly rounded triangular silhouette.
        d.polygon([(xy(39), xy(27)), (xy(39), xy(69)), (xy(69), xy(48))], fill=primary)
        # Tiny inset cut gives the face definition while preserving solid silhouette.
        # No outline: it remains clear at small scale.
    elif name == 'refresh':
        # One bold clockwise arrow, with an open gap and a large arrowhead.
        arc(d, (25, 25, 71, 71), 45, 315, primary, 6)
        d.polygon([(xy(74), xy(42)), (xy(57), xy(42)), (xy(74), xy(25))], fill=primary)
    elif name == 'remove':
        line(d, [(30, 32), (66, 32)], primary, 5)
        line(d, [(39, 27), (42, 23), (54, 23), (57, 27)], primary, 4)
        line(d, [(34, 36), (37, 67), (59, 67), (62, 36)], primary, 5)
        line(d, [(44, 42), (45, 60)], secondary, 3.5)
        line(d, [(52, 42), (51, 60)], secondary, 3.5)
    elif name == 'check':
        line(d, [(27, 49), (42, 63), (69, 34)], primary, 7)
        # Preserve a crisp clean tick with no extra ornament.
    elif name == 'link':
        # Two offset capsule loops, rotated together to read as an interlocked chain.
        layer = Image.new('RGBA', (S, S), (0, 0, 0, 0))
        ld = ImageDraw.Draw(layer)
        for rect in ((xy(30), xy(39), xy(59), xy(57)), (xy(39), xy(33), xy(68), xy(51))):
            ld.rounded_rectangle(rect, radius=xy(9), outline=primary, width=xy(5))
        layer = layer.rotate(38, resample=Image.Resampling.BICUBIC, center=(S//2, S//2))
        im.alpha_composite(layer)

    return im.resize((SIZE, SIZE), Image.Resampling.LANCZOS)

def main():
    global OUT, ICON_DIR
    parser = argparse.ArgumentParser(description='Generate the Podcasts plugin UI icons (requires Pillow).')
    parser.add_argument('--output-dir', type=Path, default=OUT)
    OUT = parser.parse_args().output_dir
    ICON_DIR = OUT / 'icons'
    ICON_DIR.mkdir(parents=True, exist_ok=True)
    names = ['show', 'download', 'search', 'manage', 'play', 'refresh', 'remove', 'check', 'link']
    icons = []
    for name in names:
        icon = make_icon(name)
        icon.save(ICON_DIR / f'{name}.png', optimize=True)
        icons.append((name, icon))
    # Dark preview board approximates the plugin's dark UI while preserving icon transparency.
    tile, gap, margin = 132, 12, 20
    preview = Image.new('RGBA', (margin*2 + tile*3 + gap*2, margin*2 + tile*3 + gap*2), '#10131B')
    pd = ImageDraw.Draw(preview)
    for i, (name, icon) in enumerate(icons):
        col, row = i % 3, i // 3
        x, y = margin + col*(tile+gap), margin + row*(tile+gap)
        # Subtle rounded tile and centered 96px icon at 1:1.
        pd.rounded_rectangle((x, y, x+tile, y+tile), radius=18, fill='#171B25', outline='#242A38', width=1)
        preview.alpha_composite(icon, (x+(tile-SIZE)//2, y+8))
        pd.text((x+tile//2, y+111), name, fill='#D9DEEA', anchor='mm')
    preview.convert('RGB').save(OUT / 'preview.png', optimize=True)
    small_tile, small_gap, small_margin = 84, 10, 12
    small = Image.new('RGBA', (small_margin*2 + small_tile*3 + small_gap*2,
                               small_margin*2 + small_tile*3 + small_gap*2), '#10131B')
    sd = ImageDraw.Draw(small)
    for i, (name, icon) in enumerate(icons):
        col, row = i % 3, i // 3
        x, y = small_margin + col*(small_tile+small_gap), small_margin + row*(small_tile+small_gap)
        sd.rounded_rectangle((x, y, x+small_tile, y+small_tile), radius=12,
                             fill='#171B25', outline='#242A38', width=1)
        rendered = icon.resize((44, 44), Image.Resampling.LANCZOS)
        small.alpha_composite(rendered, (x+(small_tile-44)//2, y+4))
        sd.text((x+small_tile//2, y+65), name, fill='#D9DEEA', anchor='mm')
    small.convert('RGB').save(OUT / 'preview_44.png', optimize=True)

if __name__ == '__main__':
    main()
