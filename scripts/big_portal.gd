extends Area2D

var in_nether = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$"../../world".visible = !$"../../world".visible
		$"../../world2".visible = !$"../../world2".visible
		$"../../ParallaxBackground".visible = !$"../../ParallaxBackground".visible
		$"../../ColorRect".visible = !$"../../ColorRect".visible

		$"../../Enemies/spike".visible = !$"../../Enemies/spike"
		$"../../Enemies/spike2".visible = !$"../../Enemies/spike2"
		$"../../Enemies/spike3".visible = !$"../../Enemies/spike3"
		$"../../Enemies/spike4".visible = !$"../../Enemies/spike4"
		$"../../Enemies/spike5".visible = !$"../../Enemies/spike5"
		$"../../Enemies/spike6".visible = !$"../../Enemies/spike6"
		
		$"../../Enemies/lavaBubble6".visible = !$"../../Enemies/lavaBubble6"
		$"../../Enemies/lavaBubble7".visible = !$"../../Enemies/lavaBubble7"
		$"../../Enemies/lavaBubble8".visible = !$"../../Enemies/lavaBubble8"
		
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
