extends Area2D

var in_nether = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$"../../world".visible = !$"../../world".visible
		$"../../world2".visible = !$"../../world2".visible
		$"../../ParallaxBackground".visible = !$"../../ParallaxBackground".visible
		$"../../ColorRect".visible = !$"../../ColorRect".visible

		$"../moving_box3".visible = !$"../moving_box3"
		$"../moving_box6".visible = !$"../moving_box6"
		
		$"../house".visible = !$"../house".visible
		$"../house/StaticBody2D/collision".set_deferred("disabled", !$"../house/StaticBody2D/collision".disabled)
		$"../house/StaticBody2D/collision2".set_deferred("disabled", !$"../house/StaticBody2D/collision2".disabled)
		$"../house/end hitbox/collision".set_deferred("disabled", !$"../house/end hitbox/collision".disabled)
		
		if MultiplayerManager.multiplayer_mode_enabled:
			var tps = get_tree().get_nodes_in_group("Player")
			for running in tps:
				running.position = self.position + Vector2(100,0)
				await get_tree().create_timer(0.1).timeout
