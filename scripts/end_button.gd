extends TextureButton

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.call_load_level("MainMenu")

func _on_pressed() -> void:
	Global.call_load_level("MainMenu")
