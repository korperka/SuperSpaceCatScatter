extends AudioStreamPlayer

func playBackHole() -> void:
	stream = preload("res://sounds/Super Mario Galaxy - Black Hole Sound Effect.mp3")
	play()

func playScreenOff() -> void:
	stream = preload("res://sounds/Arcade Retro Game Over - Sound Effect (Final Cut).mp3")
	play()
