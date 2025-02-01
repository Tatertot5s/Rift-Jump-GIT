extends StaticBody2D

@export var LevelName: String = "MainMenu"

func _on_portal_area_body_entered(body):
	if LevelName == "Level2":
		Global.level_1_time = Global.time_total
	if LevelName == "Level3":
		Global.level_2_time = Global.time_total - (Global.level_1_time)
	if LevelName == "Level4":
		Global.level_3_time = Global.time_total - (Global.level_1_time + Global.level_2_time)
	if body.is_in_group("Player"):
		Global.call_load_level(LevelName)
		Global.player.respawn(Global.player)
