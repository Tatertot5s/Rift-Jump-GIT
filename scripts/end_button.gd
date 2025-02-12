extends TextureButton

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause") && get_window().has_focus():
		Global.timer_paused = true
		Global.call_load_level("MainMenu")

func _on_pressed() -> void:
	Global.call_load_level("MainMenu")
