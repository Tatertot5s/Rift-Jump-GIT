extends Control

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible

func _on_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
	self.visible = !self.visible

func _on_button_2_pressed() -> void:
	get_tree().paused = !get_tree().paused
	Global.player.respawn(Global.player)
	self.visible = !self.visible

func _on_button_3_pressed() -> void:
	if !Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen = !Global.fullscreen
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Global.fullscreen = !Global.fullscreen

func _on_texture_button_4_pressed():
	get_tree().paused = !get_tree().paused
	Global.call_load_level("MainMenu")

func _on_texture_button_5_pressed():
	get_tree().quit()
