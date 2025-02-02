extends Node

var level_instance: Node2D

@export var menu_scene: PackedScene
var menu_instance

@export var player_scene: PackedScene
var player_instance

func _ready():
	load_level("MainMenu")
	Global.connect("load_level", _on_load_level_signal)

func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name: String):
	unload_level()
	var level_path := "res://levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if (level_resource):
		await get_tree().process_frame
		level_instance = level_resource.instantiate()
		self.add_child(level_instance)
	
	#adds menus to levels with them
	var levels_with_menu = ["Level1","Level2","Level3","Level4"]
	if level_name in levels_with_menu:
		if not menu_instance:
			menu_instance = menu_scene.instantiate()
			add_child(menu_instance)
	else:
		if menu_instance:
			menu_instance.queue_free()
			menu_instance = null
	
	#adds characters to levels with them
	var levels_with_character = ["Level1","Level2","Level3","Level4", "house"]
	if level_name in levels_with_character:
		if not player_instance:
			player_instance = player_scene.instantiate()
			add_child(player_instance)
	else:
		if player_instance:
			player_instance.queue_free()
			player_instance = null
	Global.player = player_instance

func _on_load_level_signal(level_name):
	load_level(level_name)
