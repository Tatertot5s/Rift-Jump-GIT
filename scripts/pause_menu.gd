extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		self.visible = !self.visible

func _on_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
	self.visible = !self.visible

func _on_button_2_pressed() -> void:
	print("coming soon!")

func _on_button_3_pressed() -> void:
	get_tree().quit()
