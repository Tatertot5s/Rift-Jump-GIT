extends Node

var fullscreen = false
var timer : float = 0.0
var wait_time : float = 1
var time_total : int = 0

var deaths: int = 0

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
	
	
	timer += delta
	if timer >= wait_time:
		timer = 0.0
		time_total += 1
		
