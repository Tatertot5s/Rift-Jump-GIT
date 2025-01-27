extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func unload_leve():
	pass

func load_level(level_name):
	pass

func _on_button_2_pressed() -> void:
	load_level("Level1")
