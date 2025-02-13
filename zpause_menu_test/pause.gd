extends Node

var on_button: int = 0

func _process(_delta):
	if $"..".on_menu == "pause":
		if Input.is_action_just_pressed("ui_up"):
			input_logic(-1)
		if Input.is_action_just_pressed("ui_down"):
			input_logic(1)
		if Input.is_action_just_pressed("ui_accept"):
			button_press()

func _on_resume_button_down():
	pause_game()
	$"..".on_menu = "none"
func _on_respawn_button_down():
	pause_game()
	Global.player.respawn(Global.player)
	$"..".on_menu = "none"
func _on_settings_button_down():
	$"..".on_menu = "options"
	on_button = 0
	$"../settings_sprite/selection".position.y = ((1 + on_button) * 54.564) - 194.872
func _on_quit_to_title_button_down():
	pause_game()
	Global.call_load_level("MainMenu")
func _on_quit_game_button_down():
	get_tree().quit()

func button_press():
	if on_button == 0:
		_on_resume_button_down()
	if on_button == 1:
		_on_respawn_button_down()
	if on_button == 2:
		_on_settings_button_down()
	if on_button == 3:
		_on_quit_to_title_button_down()
	if on_button == 4:
		_on_quit_game_button_down()

func input_logic(direction):
	on_button += direction
	if on_button >= 5:
		on_button = 0
	if on_button <= -1:
		on_button = 4
	$selection.position.y = ((on_button)* 55.38) - 89.5

func pause_game():
	if MultiplayerManager.multiplayer_mode_enabled == false:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = false
		$"../ColorRect".visible = false
