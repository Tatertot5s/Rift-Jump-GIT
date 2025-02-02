extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$buttons/start_button/AnimationPlayer.play("menu_start")

func start_button():
	Global.call_load_level("Level1")
	Global.time_total = 0
	Global.deaths = 0
	Global.timer_paused = false

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

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		$CreditsMenu.visible = !$CreditsMenu.visible
