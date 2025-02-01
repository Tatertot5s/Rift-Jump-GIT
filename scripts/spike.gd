extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.player._on_death_plane_body_entered(body)
