extends Area2D

var in_nether = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$"../world".visible = !$"../world".visible
		$"../world2".visible = !$"../world2".visible
		$"../ParallaxBackground/Parallax2D/Sprite2D".visible = !$"../ParallaxBackground/Parallax2D/Sprite2D".visible
		$"../ColorRect".visible = !$"../ColorRect".visible
		
		$"../spike".visible = !$"../spike"
		$"../spike2".visible = !$"../spike2"
		$"../spike3".visible = !$"../spike3"
		$"../spike4".visible = !$"../spike4"
		$"../spike5".visible = !$"../spike5"
		$"../spike6".visible = !$"../spike6"
		
		$"../lavaBubble6".visible = !$"../lavaBubble6"
		$"../lavaBubble7".visible = !$"../lavaBubble7"
		$"../lavaBubble8".visible = !$"../lavaBubble8"
		
		$"../moving_box3".visible = !$"../moving_box3"
		$"../moving_box6".visible = !$"../moving_box6"
		
		$"../house".visible = !$"../house".visible
		$"../house/StaticBody2D/collision".set_deferred("disabled", !$"../house/StaticBody2D/collision".disabled)
		$"../house/StaticBody2D/collision2".set_deferred("disabled", !$"../house/StaticBody2D/collision2".disabled)
		$"../house/end hitbox/collision".set_deferred("disabled", !$"../house/end hitbox/collision".disabled)
