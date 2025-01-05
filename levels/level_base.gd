extends Node2D

var keglas_count := 0
@export var next_level :PackedScene

func _ready() -> void:
	
	for c in $keglas.get_children():
		keglas_count += 1
		c.connect("sbili", kegla_sbita)
		
	Globals.TriggerLose.connect(_on_recive_lose)

func _exit_tree() -> void:
	Globals.TriggerLose.disconnect(_on_recive_lose)

func kegla_sbita() -> void:
	keglas_count -= 1
	if keglas_count > 0: return
	$anim.play("fade_out_win")

func _on_recive_lose() -> void:
	if keglas_count == 0: return
	$anim.play("fade_out_reset")

func _on_win() -> void:
	get_tree().change_scene_to_packed(next_level)
func _on_reset() -> void:
	get_tree().reload_current_scene()
