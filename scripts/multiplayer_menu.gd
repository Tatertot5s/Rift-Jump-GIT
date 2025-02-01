extends Node2D

func _on_host_pressed():
	Multiplayer._on_host_pressed()
	self.visible = !self.visible

func _on_join_pressed():
	Multiplayer._on_join_pressed()
	self.visible = !self.visible
