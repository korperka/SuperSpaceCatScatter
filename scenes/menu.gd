extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/start_button as Button
@onready var start_level = preload("res://main.tscn")
#@onready var start_level = preload()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.button_up.connect(on_start_button_up)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_start_button_up() -> void:
	get_tree().change_scene_to_packed(start_level)
	
