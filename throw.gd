extends RigidBody2D

# Variables to handle the dragging and slingshot mechanics
var drag_position := Vector2.ZERO
var is_dragging := false
var throw_power := 0.0
var max_pull_distance := 100.0  # Maximum distance user can pull the object

func _ready():
	# Ensure the body starts at rest when the game begins
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0

func _process(delta):
	# Handle drag actions
	if is_dragging:
		# Calculate the pulling direction and distance
		var mouse_position = get_global_mouse_position()
		var pull_vector = mouse_position - drag_position
		# Limit the maximum distance
		if pull_vector.length() > max_pull_distance:
			pull_vector = pull_vector.normalized() * max_pull_distance
		
		# Update the position based on the mouse
		global_position = drag_position + pull_vector
#
	#else:
		## Reset to idle if not dragging
		#if linear_velocity.length() < 1.0:
			#linear_velocity = Vector2.ZERO 

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start dragging
				is_dragging = true
				drag_position = get_global_mouse_position()
			else:
				is_dragging = false
				var mouse_release_position = get_global_mouse_position()
				var throw_vector = drag_position - mouse_release_position
				apply_force(throw_vector / randf_range(3,  5), Vector2.ZERO)
