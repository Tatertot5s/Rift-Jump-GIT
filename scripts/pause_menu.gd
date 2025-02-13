extends Node2D

var on_button: int = 0
var on_menu: int = 0

func _ready():
	self.visible = false
	$skin_swapper.position = get_viewport().get_visible_rect().size / 2
	$settings_sprite.position = get_viewport().get_visible_rect().size / 2
	$multiplayer_menu.position = get_viewport().get_visible_rect().size / 2
	$menu_sprite.position = get_viewport().get_visible_rect().size / 2

func _input(_event):
	if Input.is_action_just_pressed("pause") && get_window().has_focus() or !OS.has_feature("windows") and Input.is_action_just_pressed("exit"):
		pause_game()
		self.visible = !self.visible
		on_button = 0
		on_menu = 0
		$menu_sprite.visible = true
		$settings_sprite.visible = false
		$skin_swapper.visible = false
		$menu_sprite/selection.position.y = ((on_button)* 55.38) - 89.5
	
	if self.visible == true:
		if Input.is_action_just_pressed("ui_down") && get_window().has_focus():
			input_logic(1)
		if Input.is_action_just_pressed("ui_up") && get_window().has_focus():
			input_logic(-1)
		if Input.is_action_just_pressed("ui_accept") && get_window().has_focus():
			button_pressed()
		if Input.is_action_just_pressed("ui_cancel") && get_window().has_focus():
			if on_menu == 0:
				_on_resume_button_down()
			if on_menu == 1:
				_on_done_button_down()

func _process(_delta):
	if self.visible == true:
		Global.is_paused = true
	else:
		Global.is_paused = false

func _on_resume_button_down():
	pause_game()
	self.visible = !self.visible
func _on_respawn_button_down():
	pause_game()
	Global.player.respawn(Global.player)
	self.visible = !self.visible
func _on_setting_button_down():
	on_menu = 1
	on_button = 0
	$menu_sprite.visible = false
	$settings_sprite.visible = true
	$settings_sprite/selection.position.y = ((1 + on_button) * 54.564) - 194.872
func _on_quit_to_title_button_down():
	pause_game()
	Global.call_load_level("MainMenu")
func _on_quit_game_button_down():
	get_tree().quit()

#Options
func _on_controls_button_down():
	pass
func _on_sound_button_down():
	pass
func _on_multiplayer_button_down():
	on_button = 0
	on_menu = 3
	$settings_sprite.visible = false
	$multiplayer_menu.visible = true
func _on_skins_button_down():
	on_button = 0
	on_menu = 2
	await get_tree().process_frame
	await get_tree().process_frame
	$settings_sprite.visible = false
	$skin_swapper.visible = true
func _on_fullscreen_button_down():
	if !Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen = !Global.fullscreen
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Global.fullscreen = !Global.fullscreen
func _on_done_button_down():
	on_button = 0
	on_menu = 0
	$menu_sprite.visible = true
	$settings_sprite.visible = false
	$menu_sprite/selection.position.y = ((1+on_button)*53)-140

#Other Logic
func pause_game():
	if MultiplayerManager.multiplayer_mode_enabled == false:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = false
		$ColorRect.visible = false
func input_logic(direction):
	on_button += direction
	if on_menu == 0:
		if on_button >= 5:
			on_button = 0
		if on_button <= -1:
			on_button = 4
		$menu_sprite/selection.position.y = ((on_button)* 55.38) - 89.5
	if on_menu == 1:
		if on_button >= 6:
			on_button = 0
		if on_button <= -1:
			on_button = 5
		$settings_sprite/selection.position.y = ((1 + on_button) * 54.564) - 194.872
func button_pressed():
	if on_menu == 0:
		if on_button == 0:
			_on_resume_button_down()
		if on_button == 1:
			_on_respawn_button_down()
		if on_button == 2:
			_on_setting_button_down()
		if on_button == 3:
			_on_quit_to_title_button_down()
		if on_button == 4:
			_on_quit_game_button_down()
	if on_menu == 1:
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

#Multiplayer
func _on_host_pressed():
	self.visible = !self.visible
	pause_game()
	MultiplayerManager.become_host()
func _on_join_pressed():
	self.visible = !self.visible
	pause_game()
	MultiplayerManager.join_as_player_2()
