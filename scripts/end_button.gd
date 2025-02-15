extends TextureButton

func _ready() -> void:
	if OS.has_feature("android"):
		self.position.x = get_viewport().get_visible_rect().size.x/2 - self.size.x/2
		$"../room".position.x = get_viewport().get_visible_rect().size.x/2
		$"../thank".size.x = get_viewport().get_visible_rect().size.x
		$"../camera_limit".position.x = get_viewport().get_visible_rect().size.x
		$"../respawn_point".position = $"../room".position + Vector2(-248, 70)

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause") && get_window().has_focus():
		Global.timer_paused = true
		Global.call_load_level("MainMenu")

func _on_pressed() -> void:
	Global.call_load_level("MainMenu")
