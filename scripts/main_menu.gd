extends Node2D

var player_to_remove

func _ready():
	$buttons/exit_button.position.x = get_viewport().get_visible_rect().size.x - 65
	$buttons/fullscreen_button.position.x = get_viewport().get_visible_rect().size.x - 65
	$buttons/credits_button.position.x = get_viewport().get_visible_rect().size.x - 65
	if OS.has_feature("android"):
		$buttons/fullscreen_button.visible = false
	
	$logo.position.x = get_viewport().get_visible_rect().size.x/2
	$buttons/start_button.position.x = (get_viewport().get_visible_rect().size.x/2) - 115
	$splash.position.x = (get_viewport().get_visible_rect().size.x/2) - 432
	$CreditsMenu.position.x = (get_viewport().get_visible_rect().size.x/2)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		credits_button()
	
	#player_to_remove = get_tree().get_nodes_in_group("Player")
	#if player_to_remove:
	#	player_to_remove[0].queue_free()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("menu_player"):
		$buttons/start_button/AnimationPlayer.play("menu_start")

func start_button():
	Global.call_load_level("Level1")
	Global.time_total = 0
	Global.deaths = 0
	Global.timer_paused = false
	if MultiplayerManager.multiplayer_mode_enabled == true:
		MultiplayerManager._add_player_to_game(1)

func exit_button():
	get_tree().quit()

func fullscreen_button():
	if !Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen = !Global.fullscreen
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Global.fullscreen = !Global.fullscreen

func credits_button():
	$CreditsMenu.visible = !$CreditsMenu.visible
