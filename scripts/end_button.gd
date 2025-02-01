extends TextureButton

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://levels/MainMenu.tscn")

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/MainMenu.tscn")
