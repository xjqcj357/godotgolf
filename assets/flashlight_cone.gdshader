shader_type canvas_item;

uniform float cone_angle = 0.5;

void fragment() {
    vec2 pos = UV - vec2(0.5);
    float angle = atan(pos.y, pos.x);
    float mask = step(abs(angle), cone_angle);
    vec4 tex = texture(TEXTURE, UV);
    COLOR = vec4(tex.rgb, tex.a * mask);
}
