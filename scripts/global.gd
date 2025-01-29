extends Node

var fullscreen = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if !fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	print("FIX GLOBAL FULLSCREEN")
