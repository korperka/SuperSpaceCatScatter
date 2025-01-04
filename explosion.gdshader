shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.0);
uniform float time : hint_range(0.0, 5.0);
uniform float center_x : hint_range(0.0, 1.0);  // x-компонента центра
uniform float center_y : hint_range(0.0, 1.0);  // y-компонента центра
uniform float chromatic_intensity : hint_range(0.0, 1.0);

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    vec2 center = vec2(center_x, center_y); // Собираем center из двух компонентов

    vec2 uv_centered = uv - center; // Смещение UV к центру эффекта

    // Создание эффекта implosion, сжимая текстурные координаты
    float dist = length(uv_centered);
    float factor = pow(1.0 - dist / radius, 3.0) * time; // Эффект имплозии

    uv = uv_centered * (1.0 - factor) + center;

    // Применение хроматической аберрации - незначительное смещение по RGB
    vec3 color;
    color.r = texture(TEXTURE, uv + vec2(chromatic_intensity * 0.003, 0)).r;
    color.g = texture(TEXTURE, uv).g;
    color.b = texture(TEXTURE, uv - vec2(chromatic_intensity * 0.003, 0)).b;

    COLOR = vec4(color, 1.0);
}
