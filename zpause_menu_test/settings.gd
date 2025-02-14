extends Node

var on_button: int = 0

func _process(_delta):
	if $"..".on_menu == "options":
		if Input.is_action_just_pressed("ui_up"):
			input_logic(-1)
		if Input.is_action_just_pressed("ui_down"):
			input_logic(1)
		if Input.is_action_just_pressed("ui_accept"):
			button_press()

func _on_controls_button_down():
	pass
func _on_sound_button_down():
	pass
func _on_multiplayer_button_down():
	on_button = 0
	$"..".on_menu = "multiplayer"
func _on_skins_button_down():
	on_button = 0
	$"..".on_menu = "skins"
func _on_fullscreen_button_down():
	if !Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen = !Global.fullscreen
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Global.fullscreen = !Global.fullscreen
func _on_done_button_down():
	on_button = 0
	$"..".on_menu = "pause"
	$"../menu_sprite/selection".position.y = ((1+on_button)*53)-140


	if on_button == 0:
		_on_controls_button_down()
	if on_button == 1:
		_on_sound_button_down()
	if on_button == 2:
		_on_multiplayer_button_down()
	if on_button == 3:
		_on_skins_button_down()
	if on_button == 4:
		_on_fullscreen_button_down()
	if on_button == 5:
		_on_done_button_down()

func button_press():
	if on_button == 0:
		_on_controls_button_down()
	if on_button == 1:
		_on_sound_button_down()
	if on_button == 2:
		_on_multiplayer_button_down()
	if on_button == 3:
		_on_skins_button_down()
	if on_button == 4:
		_on_fullscreen_button_down()
	if on_button == 5:
		_on_done_button_down()

func input_logic(direction):
	on_button += direction
	if on_button >= 6:
		on_button = 0
	if on_button <= -1:
		on_button = 5
	$selection.position.y = ((1 + on_button) * 54.564) - 194.872
