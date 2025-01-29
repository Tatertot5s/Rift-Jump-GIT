extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().get_node("character")._on_death_plane_body_entered(body)
