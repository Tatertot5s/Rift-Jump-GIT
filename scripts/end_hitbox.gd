extends Area2D

##What scene the portal opens. Must be inside "res://levels/", don't include ".tscn" after the level name.
@export var LevelName: String = "MainMenu"

func _on_portal_area_body_entered(body):
	if body.is_in_group("Player"):
		var compiled_level_name: String = "res://levels/" + LevelName + ".tscn"
		get_tree().change_scene_to_file(compiled_level_name)
	if LevelName == "house":
		Global.level_4_time = Global.time_total - (Global.level_1_time + Global.level_2_time + Global.level_3_time)
		Global.timer_paused = true
