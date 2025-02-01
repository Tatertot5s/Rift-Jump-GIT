extends Area2D

@export var LevelName: String = "MainMenu"

func _on_portal_area_body_entered(body):
	if LevelName == "house":
		Global.level_4_time = Global.time_total - (Global.level_1_time + Global.level_2_time + Global.level_3_time)
		Global.timer_paused = true
	if body.is_in_group("Player"):
		Global.call_load_level(LevelName)
		Global.player.respawn(Global.player)
