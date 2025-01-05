extends Node2D

var keglas_count := 0
@export var next_level :PackedScene

func _ready() -> void:
	
	for c in $keglas.get_children():
		keglas_count += 1
		c.connect("sbili", kegla_sbita)


func kegla_sbita() -> void:
	keglas_count -= 1
	if keglas_count > 0: return
	
	get_tree().change_scene_to_packed(next_level)
	
	print("УРАА")
