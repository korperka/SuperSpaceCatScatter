extends Area2D

# Константы
const MAGNET_FORCE: float = 15000
var stop_distance := 50
var update_radius = false
var radius = 0
var shader: ShaderMaterial = null
var rect: ColorRect = null
#var shader_material := preload("res://shockwave.gdshader")

func _ready() -> void:
	rect = get_parent().get_parent().get_parent().get_node("ColorRect")
	shader = rect.material
	stop_distance = $CollisionShape2D.shape.radius / 5

func _process(delta: float) -> void:
	if update_radius:
		radius += delta
		update_shockwave()
	
	for body in get_overlapping_bodies():
		if body is RigidBody2D:
			# Вычисляем направление от тела к центру
			var direction: Vector2 = global_position - body.global_position
			var distance: float = direction.length()
			
			if distance > stop_distance:
				# Вычисляем силу притяжения и применяем её к телу
				var force: Vector2 = direction.normalized() * MAGNET_FORCE * delta
				body.apply_force(force)
				
			else:
				var timer = Timer.new()
				add_child(timer)
				timer.wait_time = 1
				timer.connect("timeout", timeout)
				timer.start()
				body.queue_free()
				spawn_shockwave(position)
				
func timeout() -> void:
	get_tree().reload_current_scene()

func spawn_shockwave(position: Vector2):
	var local_position = rect.get_canvas_transform().affine_inverse().basis_xform(global_position - rect.global_position)
	var normalized_position = local_position / rect.size
	shader.set_shader_parameter("center", normalized_position)
	update_radius = true
	
func update_shockwave() -> void:
	shader.set_shader_parameter("radius", radius)
