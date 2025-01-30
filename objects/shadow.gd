extends Sprite2D

@onready var raycast = $"../raycast"
var ray_collision_point: float = 0.0

func _process(delta):
	raycast.force_raycast_update()
	if raycast.is_colliding():
		ray_collision_point = raycast.get_collision_point().y
	else:
		ray_collision_point = raycast.global_position.y + raycast.target_position.y
	self.global_position.y = ray_collision_point
