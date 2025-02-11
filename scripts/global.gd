extends Node

signal load_level(level_name)

var is_dev = true
var fullscreen = false
var deaths: int = 0

var player

var timer : float = 0.0
var wait_time : float = 1
var time_total : int = 0
var timer_paused = false

var level_1_time = 0
var level_2_time = 0
var level_3_time = 0
var level_4_time = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if !fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			fullscreen = !fullscreen
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = !fullscreen
	if Input.is_action_just_pressed("exit") and OS.has_feature("windows"):
		get_tree().quit()
	
	if false: #is_dev == true:
		if Input.is_action_just_pressed("1"):
			Global.call_load_level("Level1")
			await get_tree().process_frame
			Global.player.respawn(Global.player)
		if Input.is_action_just_pressed("2"):
			Global.call_load_level("Level2")
			await get_tree().process_frame
			Global.player.respawn(Global.player)
		if Input.is_action_just_pressed("3"):
			Global.call_load_level("Level3")
			await get_tree().process_frame
			Global.player.respawn(Global.player)
		if Input.is_action_just_pressed("4"):
			Global.call_load_level("Level4")
			await get_tree().process_frame
			Global.player.respawn(Global.player)
		if Input.is_action_just_pressed("5"):
			Global.call_load_level("house")
			await get_tree().process_frame
			Global.player.respawn(Global.player)
		if Input.is_action_just_pressed("`"):
			Global.call_load_level("MainMenu")
	
	if timer_paused == false:
		timer += delta
		if timer >= wait_time:
			timer = 0.0
			time_total += 1
			
func call_load_level(level_name):
	load_level.emit(level_name)
