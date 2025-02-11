extends Control

func _ready():
	if !OS.has_feature("windows"):
		$multiplayer.visible = !$multiplayer.visible

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel") or !OS.has_feature("windows") and Input.is_action_just_pressed("exit"):
		pause_game()
		self.visible = !self.visible

func _on_button_pressed() -> void:
	pause_game()
	self.visible = !self.visible

func _on_button_2_pressed() -> void:
	pause_game()
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
	pause_game()
	Global.call_load_level("MainMenu")

func _on_texture_button_5_pressed():
	get_tree().quit()
	
func _on_host_pressed():
	self.visible = !self.visible
	pause_game()
	MultiplayerManager.become_host()

func _on_join_pressed():
	self.visible = !self.visible
	pause_game()
	MultiplayerManager.join_as_player_2()

func pause_game():
	if MultiplayerManager.multiplayer_mode_enabled == false:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = false
		$ColorRect.visible = false
