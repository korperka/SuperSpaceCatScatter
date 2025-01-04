shader_type canvas_item;

uniform float lifetime : hint_range(0.0, 10.0);

void fragment() {
    // Fade alpha based on the particle's lifetime
    float alpha = 1.0 - (TIME / lifetime);  // Linear fade effect
    
    // Set the color to white and apply fading alpha
    COLOR = vec4(1.0, 1.0, 1.0, alpha);
}