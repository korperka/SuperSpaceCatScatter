extends Node2D

var blackhole_scene = preload("res://blackhole.tscn")

func _ready() -> void:
	randomize()  
	var count = randi_range(1, 2) 
	
	var center = get_viewport().size / 2
	var spawn_area = Vector2(center.x * 0.5, center.y * 0.5)
	
	for i in range(count):
		var random_scale = randf_range(1, 2)
		var random_rotation = randi_range(0, 1);
		var blackhole = blackhole_scene.instantiate()
		blackhole.position = Vector2(
			randf_range(center.x - spawn_area.x, center.x + spawn_area.x),  # По оси X ближе к центру
			randf_range(center.y - spawn_area.y, center.y + spawn_area.y + 10)   # По оси Y ближе к центру
		)
		blackhole.find_child("AnimatedSprite2D").rotation = random_rotation
		blackhole.find_child("AnimatedSprite2D").scale = Vector2(random_scale, random_scale)
		blackhole.find_child("CollisionShape2D").scale = Vector2(random_scale, random_scale)
		add_child(blackhole)

func _process(delta: float) -> void:
	pass
