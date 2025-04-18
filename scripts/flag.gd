extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var respawn_point = get_parent().get_parent().get_node("respawn_point")

		# Convert checkpoint's position to global before assigning it
		respawn_point.position = global_position

		# Update the last checkpoint
		if respawn_point.has_meta("last_checkpoint"):
			var last_checkpoint = respawn_point.get_meta("last_checkpoint")
			if is_instance_valid(last_checkpoint):
				last_checkpoint.turn_off()

		respawn_point.set_meta("last_checkpoint", self)
		turn_on()


func turn_on():
	$sprite.animation = "on"

func turn_off():
	$sprite.animation = "off"
