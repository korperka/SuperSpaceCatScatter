extends RigidBody2D

# Переменные для механики "Рогатки"
var drag_position := Vector2.ZERO
var is_dragging := false
var throw_power := 0.0
var max_pull_distance := 100.0
var spawn_position := Vector2.ZERO  # Точка спавна объекта
var trajectory_dots := []  # Линии полета
var max_trajectory_dots := 10  # Количество точек на траектории
var is_launched := false  # Если true, новый запуск невозможен

# Границы экрана
var screen_bounds := Rect2(Vector2.ZERO, Vector2.ZERO);

func _ready():
	# Настройка начального состояния
	spawn_position = global_position
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	screen_bounds = Rect2(Vector2.ZERO, get_viewport().get_visible_rect().size)
	
	# Создаём точки траектории
	_create_trajectory()

func _process(delta):
	if is_dragging:
		_handle_drag()

	_check_bounds()

	# Убираем траекторию, когда объект летит
	_set_trajectory_visibility(!is_launched and is_dragging)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and not is_launched:
				# Начать оттягивание
				is_dragging = true
				drag_position = get_global_mouse_position()
			elif is_dragging:
				# Завершить оттягивание
				is_dragging = false
				var release_position = get_global_mouse_position()
				var throw_vector = drag_position - release_position
								
				if throw_vector.length() > max_pull_distance * 0.2:
					is_launched = true
					_apply_force(throw_vector.normalized() * (throw_vector.length() / max_pull_distance) * 300)

func _create_trajectory():
	# Создаём точки для отображения траектории
	for i in range(max_trajectory_dots):
		var dot = Sprite2D.new()
		dot.texture = preload("res://dot.png")  # Убедитесь, что у вас есть файл dot.png
		dot.visible = false
		#dot.scale = Vector2(5, 5)
		add_child(dot)
		trajectory_dots.append(dot)

func _set_trajectory_visibility(visible: bool):
	for dot in trajectory_dots:
		dot.visible = visible

func _handle_drag():
	var mouse_position = get_global_mouse_position()
	var pull_vector = mouse_position - spawn_position
	if pull_vector.length() > max_pull_distance:
		pull_vector = pull_vector.normalized() * max_pull_distance
	global_position = spawn_position + pull_vector

	# Обновляем точки траектории
	_update_trajectory(pull_vector)

func _update_trajectory(pull_vector: Vector2):
	for i in range(max_trajectory_dots):
		var step = float(i) / max_trajectory_dots
		trajectory_dots[i].position = pull_vector * step * -2.5

func _apply_force(force: Vector2):
	# Применяем силу для запуска объекта
	linear_velocity = force
	angular_velocity = 0.0

func _check_bounds():
	if not screen_bounds.has_point(global_position):
		get_tree().reload_current_scene()
