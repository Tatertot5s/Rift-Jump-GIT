extends Node2D

var level_instance

func unload_level():
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name: String):
	unload_level()
	var level_path := "res://levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		$".".add_child(level_instance)

func _on_button_pressed() -> void:
	load_level("Level1")

func _on_button_2_pressed() -> void:
	load_level("Level2")

func _on_button_3_pressed() -> void:
	load_level("MainMenu")
