"""Layout contract checks for Hiby's Graph Player's supported screen sizes."""
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
LAYOUTS = {
    "hibys_graph_player.xml": (800, 548, 30, True),
    "hibys_graph_player_480x720.xml": (720, 532, 30, False),
    "hibys_graph_player_320x480.xml": (480, 318, 30, False),
}
LINE_HEIGHT = 22
GAP = 2

for filename, (screen_height, codec_y, transport_bottom_margin, has_album) in LAYOUTS.items():
    path = ROOT / "plugins/HibysGraphPlayer/player_layouts" / filename
    root = ET.parse(path).getroot()
    view = root.find("view")
    assert view is not None, f"{filename}: missing view"
    widgets = {node.get("name"): node for node in view.iter() if node.get("name")}
    assert "song_count" in widgets, f"{filename}: missing native song_count binder"
    count = widgets["song_count"]
    count_y = int(count.get("y"))
    assert count_y >= codec_y + LINE_HEIGHT + GAP, f"{filename}: queue position overlaps codec info"
    assert count.get("style_text_align") == "right", f"{filename}: queue position must align right"
    assert count.get("style_text_font") == "font_16", f"{filename}: queue position font changed"
    favorite = widgets["favorite_circle"]
    assert int(favorite.get("y")) + int(favorite.get("height")) <= codec_y + 6, \
        f"{filename}: favorite control overlaps codec information"
    slider = widgets["progress_slider"]
    slider_y = int(slider.get("y"))
    assert slider_y >= count_y + LINE_HEIGHT + GAP, f"{filename}: queue position overlaps seek bar"
    assert slider_y + int(slider.get("height")) < screen_height
    if has_album:
        album = widgets["album"]
        assert int(album.get("y")) == count_y, f"{filename}: album should share the queue row"
        assert int(album.get("x")) + int(album.get("width")) < int(count.get("x")), \
            f"{filename}: album and queue position overlap"
    controls = [widgets[name] for name in ("order_btn", "prev_btn", "play_circle", "next_btn", "more_btn")]
    controls_bottom = max(int(widget.get("y")) + int(widget.get("height")) for widget in controls)
    assert screen_height - controls_bottom >= transport_bottom_margin, \
        f"{filename}: transport row is too close to the bottom edge"
    for timeline in root.findall("./animations/timeline"):
        targets = {animation.get("target") for animation in timeline.findall("animation")}
        assert "song_count" in targets, f"{filename}: queue position missing {timeline.get('name')} fade"

print("Hiby's Graph Player layout checks passed")
