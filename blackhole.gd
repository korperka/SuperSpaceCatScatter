extends Area2D

# Константы
@export var MAGNET_FORCE: float = 18000
var stop_distance := 50
var update_radius = false
var radius = 0

func _ready() -> void:
	stop_distance = $CollisionShape2D.shape.radius / 5

func _process(delta: float) -> void:
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
				GlobalAudioStream.playBackHole()
				Globals.ShockWave.emit(global_position)
				Globals.TriggerLose.emit()
				body.queue_free()
