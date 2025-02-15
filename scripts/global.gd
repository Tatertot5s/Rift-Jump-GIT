extends Node

signal load_level(level_name)

var is_dev = true
var fullscreen = false
var deaths: int = 0
var is_paused = false
var on_menu = "none"

var player
var skin = "1"
var skin_num
var username
var multiplayer_respawn = false

var timer : float = 0.0
var wait_time : float = 1
var time_total : int = 0
var timer_paused = false

var level_1_time = 0
var level_2_time = 0
var level_3_time = 0
var level_4_time = 0

func _process(delta: float) -> void:
	if on_menu != "skin":
		if Input.is_action_just_pressed("fullscreen") && get_window().has_focus():
			if !fullscreen:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
				fullscreen = !fullscreen
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				fullscreen = !fullscreen
		if Input.is_action_just_pressed("exit") && get_window().has_focus() and OS.has_feature("windows"):
			get_tree().quit()
	
	var username_edit_node = get_tree().get_nodes_in_group("username_input")
	if username_edit_node:
		username = str(username_edit_node[0].text)
	
	if timer_paused == false:
		timer += delta
		if timer >= wait_time:
			timer = 0.0
			time_total += 1
			
func call_load_level(level_name):
	load_level.emit(level_name)
