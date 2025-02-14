extends Node2D

func _ready():
	if OS.has_feature("android"):
		self.visible = true
		$jump.position.x = get_viewport().get_visible_rect().size.x - 190
		$options.position.x = get_viewport().get_visible_rect().size.x - 90
