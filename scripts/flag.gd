extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$sprite.animation = "on"
		get_parent().get_parent().get_node("respawn_point").position = position
