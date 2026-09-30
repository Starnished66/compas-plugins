#!/usr/bin/env python3
"""Generate original dark-theme book plugin icons.

Aesthetic reference: compas-plugins/tools/generate_podcast_icons.py (96px,
transparent backgrounds, optional dark tinted badges, bright glyphs). All artwork
below is original Pillow vector geometry; no external images or font assets.
Requires Pillow. Example: python generate_book_icons.py --output-dir /tmp/book-plugin-assets
"""
from pathlib import Path
import argparse
import math
from PIL import Image, ImageDraw

SIZE, SCALE = 96, 4
S = SIZE * SCALE
WHITE = '#F4F1E8'
GOLD = '#FFD166'
CYAN = '#55E7F0'
PURPLE = '#C08BFF'

# name: (badge, main, highlight)
AUDIO = {
    'audiobooks': ('#29271D', GOLD, CYAN),
    'play': ('#1C3028', '#66E29A', '#A0F2BD'),
    'chapters': ('#202B38', '#79C8FF', '#C3E9FF'),
    'bookmark': ('#30291D', GOLD, '#FFE6A3'),
    'bookmarks': ('#30291D', GOLD, '#FFE6A3'),
    'rewind': ('#202B38', '#79C8FF', '#C3E9FF'),
    'forward': ('#202B38', '#79C8FF', '#C3E9FF'),
    'history': ('#292039', PURPLE, '#E0C8FF'),
    'settings': ('#202B38', '#79C8FF', '#C3E9FF'),
    'sleep': ('#202B38', '#79C8FF', '#C3E9FF'),
    'finished': ('#1C3028', '#66E29A', '#A0F2BD'),
    'refresh': ('#142A32', CYAN, '#A6F5F7'),
    'library': ('#30291D', GOLD, '#FFE6A3'),
    'new': ('#292039', PURPLE, '#E0C8FF'),
    'in_progress': ('#202B38', '#79C8FF', '#C3E9FF'),
}
EPUB = {'epub': ('#292039', PURPLE, '#E7D7FF')}

def q(v): return round(v * SCALE)
def rect(a,b,c,d): return (q(a),q(b),q(c),q(d))
def line(draw, points, color, width=4):
    draw.line([(q(x),q(y)) for x,y in points], fill=color, width=q(width), joint='curve')
def ellipse(draw, coords, fill=None, outline=None, width=3):
    draw.ellipse(rect(*coords), fill=fill, outline=outline, width=q(width))
def arc(draw, coords, start, end, color, width=4):
    draw.arc(rect(*coords), start, end, fill=color, width=q(width))

def badge(name, colors):
    bg, primary, accent = colors
    im=Image.new('RGBA',(S,S),(0,0,0,0)); d=ImageDraw.Draw(im)
    d.ellipse(rect(5.5,5.5,90.5,90.5),fill=bg,outline=bg,width=q(1))
    tint=tuple(min(255,int(v*1.18)) for v in bytes.fromhex(bg[1:]))+(255,)
    d.ellipse(rect(6,6,90,90),outline=tint,width=q(1))
    if name=='audiobooks':
        # Full-size transparent glyph: headphones above the book, with a
        # visible gap between them even at the native 44px row size.
        im=Image.new('RGBA',(S,S),(0,0,0,0)); d=ImageDraw.Draw(im)
        arc(d,(18,5,78,65),180,360,CYAN,6)
        line(d,[(18,34),(18,42)],CYAN,6)
        line(d,[(78,34),(78,42)],CYAN,6)
        d.rounded_rectangle(rect(13,28,24,44),radius=q(3),fill=CYAN)
        d.rounded_rectangle(rect(72,28,83,44),radius=q(3),fill=CYAN)
        line(d,[(48,60),(38,54),(20,53),(6,56),(6,86),(22,83),(37,85),(48,91)],GOLD,5)
        line(d,[(48,60),(58,54),(76,53),(90,56),(90,86),(74,83),(59,85),(48,91)],GOLD,5)
        line(d,[(48,60),(48,89)],GOLD,4)
        for y in (65,73):
            line(d,[(16,y),(28,y-1),(38,y+2)],GOLD,3)
            line(d,[(80,y),(68,y-1),(58,y+2)],GOLD,3)
    elif name=='epub':
        # Full-size open book with a contrasting ribbon on the right page.
        im=Image.new('RGBA',(S,S),(0,0,0,0)); d=ImageDraw.Draw(im)
        line(d,[(48,25),(37,18),(21,16),(6,20),(6,76),(22,72),(36,75),(48,83)],PURPLE,5)
        line(d,[(48,25),(59,18),(75,16),(90,20),(90,76),(74,72),(60,75),(48,83)],PURPLE,5)
        line(d,[(48,25),(48,81)],PURPLE,4)
        for y in (35,47,59):
            line(d,[(16,y),(28,y-1),(38,y+3)],PURPLE,3)
        for y in (57,65):
            line(d,[(80,y),(68,y-1),(58,y+3)],PURPLE,3)
        d.polygon([(q(65),q(18)),(q(78),q(18)),(q(78),q(49)),(q(71.5),q(42)),(q(65),q(49))],fill='#E7D7FF')
    elif name=='play':
        d.polygon([(q(37),q(27)),(q(37),q(69)),(q(69),q(48))],fill=primary)
    elif name=='chapters':
        # Spine with three numbered-style chapter rows and clear markers.
        line(d,[(31,26),(31,70)],primary,4)
        for y in (32,46,60):
            ellipse(d,(39,y-3,45,y+3),fill=accent)
            line(d,[(50,y),(68,y)],primary,4)
    elif name in ('bookmark','bookmarks'):
        for x in ((48,) if name=='bookmark' else (31,47,63)):
            if name=='bookmark':
                # Broad conventional ribbon with a deep, unmistakable V notch.
                d.polygon([(q(x-11),q(25)),(q(x+11),q(25)),(q(x+11),q(68)),(q(x),q(59)),(q(x-11),q(68))],fill=primary)
            else:
                d.polygon([(q(x-6),q(25)),(q(x+6),q(25)),(q(x+6),q(68)),(q(x),q(61)),(q(x-6),q(68))],fill=primary)
        if name=='bookmarks':
            line(d,[(31,31),(31,56)],accent,1.5); line(d,[(47,31),(47,56)],accent,1.5); line(d,[(63,31),(63,56)],accent,1.5)
    elif name in ('rewind','forward'):
        # Two bold skip chevrons, matching the familiar player transport symbol.
        if name=='rewind':
            d.polygon([(q(25),q(48)),(q(43),q(32)),(q(43),q(64))],fill=primary)
            d.polygon([(q(43),q(48)),(q(63),q(32)),(q(63),q(64))],fill=primary)
            line(d,[(69,32),(69,64)],accent,3)
        else:
            d.polygon([(q(71),q(48)),(q(53),q(32)),(q(53),q(64))],fill=primary)
            d.polygon([(q(53),q(48)),(q(33),q(32)),(q(33),q(64))],fill=primary)
            line(d,[(27,32),(27,64)],accent,3)
    elif name=='history':
        # Simple return arrow: a clear hooked shaft and large left-facing head.
        line(d,[(66,28),(66,39),(61,46),(43,46)],primary,6)
        d.polygon([(q(26),q(46)),(q(44),q(32)),(q(44),q(60))],fill=primary)
    elif name=='settings':
        # Eight broad teeth and a generous center opening stay legible at 44px.
        points=[]
        for i in range(8):
            angle=i*45
            for offset,radius in ((-12,20),(-12,27),(12,27),(12,20)):
                a=math.radians(angle+offset)
                points.append((q(48+radius*math.cos(a)),q(48+radius*math.sin(a))))
        d.polygon(points,fill=primary)
        ellipse(d,(39,39,57,57),fill=bg)
    elif name=='sleep':
        # Crescent cutout uses badge color for a crisp silhouette at 44px.
        ellipse(d,(29,25,67,65),fill=primary)
        ellipse(d,(41,18,72,53),fill=bg)
        for x,y in ((30,67),(70,31),(65,70)):
            line(d,[(x-2,y),(x+2,y)],accent,1.5); line(d,[(x,y-2),(x,y+2)],accent,1.5)
    elif name=='finished':
        ellipse(d,(25,25,71,71),outline=primary,width=4)
        line(d,[(35,48),(45,58),(63,38)],primary,6)
    elif name=='refresh':
        # Single clockwise arrow with a large head and unmistakable open gap.
        arc(d,(26,26,70,70),42,316,primary,6)
        d.polygon([(q(73),q(42)),(q(56),q(42)),(q(73),q(25))],fill=primary)
    elif name=='library':
        # Three upright books with separate heights and bright page tops.
        for x,w,h,c in ((28,12,33,'#E5A93F'),(42,14,43,primary),(58,12,37,'#F2C45D')):
            d.rounded_rectangle(rect(x,68-h,x+w,68),radius=q(2),fill=c)
            line(d,[(x+3,68-h+6),(x+w-3,68-h+6)],accent,1.5)
            line(d,[(x+3,61),(x+w-3,61)],'#FFF0C6',1.5)
    elif name=='new':
        # Fresh volume plus corner sparkle.
        d.rounded_rectangle(rect(29,30,62,68),radius=q(3),outline=primary,width=q(4))
        line(d,[(37,41),(54,41)],accent,2); line(d,[(37,49),(51,49)],accent,2)
        line(d,[(68,24),(68,37)],accent,3); line(d,[(62,30),(74,30)],accent,3)
    elif name=='in_progress':
        # Open volume with a progress arc over the pages.
        line(d,[(48,40),(48,68)],primary,3)
        line(d,[(47,43),(40,39),(30,39),(27,41),(27,64),(37,62),(48,68)],primary,4)
        line(d,[(49,43),(56,39),(66,39),(69,41),(69,64),(59,62),(48,68)],primary,4)
        arc(d,(30,20,66,56),205,335,accent,4)
        d.polygon([(q(31),q(24)),(q(42),q(24)),(q(34),q(34))],fill=accent)
    return im.resize((SIZE,SIZE),Image.Resampling.LANCZOS)

def make_preview(root, items):
    tile,gap,margin=132,12,20
    cols=4; rows=(len(items)+cols-1)//cols
    p=Image.new('RGBA',(margin*2+cols*tile+(cols-1)*gap,margin*2+rows*tile+(rows-1)*gap),'#10131B')
    d=ImageDraw.Draw(p)
    for i,(label,icon) in enumerate(items):
        x=margin+(i%cols)*(tile+gap); y=margin+(i//cols)*(tile+gap)
        d.rounded_rectangle((x,y,x+tile,y+tile),radius=18,fill='#171B25',outline='#242A38',width=1)
        p.alpha_composite(icon,(x+(tile-SIZE)//2,y+5))
        d.text((x+tile//2,y+112),label,fill='#D9DEEA',anchor='mm')
    p.convert('RGB').save(root/'preview.png',optimize=True)

def main():
    parser=argparse.ArgumentParser(description='Generate original Audiobooks and EpubReader plugin icons (requires Pillow).')
    parser.add_argument('--output-dir',type=Path,required=True,help='Root output directory; writes Audiobooks/ and EpubReader/')
    root=parser.parse_args().output_dir
    all_items=[]
    for folder,palette in (('Audiobooks',AUDIO),('EpubReader',EPUB)):
        icon_dir=root/folder/'icons'; icon_dir.mkdir(parents=True,exist_ok=True)
        items=[]
        for name,colors in palette.items():
            icon=badge(name,colors); icon.save(icon_dir/f'{name}.png',optimize=True)
            items.append((name,icon)); all_items.append((name if folder=='Audiobooks' else 'epub',icon))
        make_preview(root/folder,items)
    # Combined 44px board supports quick inspection at native UI scale.
    tile,gap,margin=100,8,16; cols=5; rows=(len(all_items)+cols-1)//cols
    board=Image.new('RGBA',(margin*2+cols*tile+(cols-1)*gap,margin*2+rows*tile+(rows-1)*gap),'#10131B')
    d=ImageDraw.Draw(board)
    for i,(label,icon) in enumerate(all_items):
        x=margin+(i%cols)*(tile+gap); y=margin+(i//cols)*(tile+gap)
        d.rounded_rectangle((x,y,x+tile,y+tile),radius=14,fill='#171B25',outline='#242A38',width=1)
        board.alpha_composite(icon.resize((44,44),Image.Resampling.LANCZOS),(x+(tile-44)//2,y+5))
        d.text((x+tile//2,y+72),label,fill='#D9DEEA',anchor='mm')
    board.convert('RGB').save(root/'preview.png',optimize=True)

if __name__=='__main__': main()
