extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !MultiplayerManager.multiplayer_mode_enabled:
			Global.player._on_death_plane_body_entered(body)
		else:
			_multiplayer_dead(body)

func _multiplayer_dead(body):
	if multiplayer.is_server():
		body._on_death_plane_body_entered(body)
