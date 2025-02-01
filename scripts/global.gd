extends Node

var is_dev = false

var fullscreen = false
var deaths: int = 0

#timer
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
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullscreen = !fullscreen
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = !fullscreen
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("1"):
		get_tree().change_scene_to_file("res://levels/Level1.tscn")
	if Input.is_action_just_pressed("2"):
		get_tree().change_scene_to_file("res://levels/Level2.tscn")
	if Input.is_action_just_pressed("3"):
		get_tree().change_scene_to_file("res://levels/Level3.tscn")
	if Input.is_action_just_pressed("4"):
		get_tree().change_scene_to_file("res://levels/Level4.tscn")
	if Input.is_action_just_pressed("5"):
		get_tree().change_scene_to_file("res://levels/house.tscn")
	if Input.is_action_just_pressed("`"):
		get_tree().change_scene_to_file("res://levels/MainMenu.tscn")
	
	if timer_paused == false:
		timer += delta
		if timer >= wait_time:
			timer = 0.0
			time_total += 1
