extends CharacterBody2D

const MAX_SPEED = 320.0
const JUMP_VELOCITY = -475.0
const ACCELERATION = 40.0
const DECELERATION = 25.0

var coyote_time = 0
var jump_buffer = 0
var skin = "1"
var direction = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_time = move_toward(coyote_time, 0, 1)
	else:
		coyote_time = 9
	
	if Input.is_action_just_pressed("ui_up"):
		jump_buffer = 5
	if jump_buffer > 0:
		if is_on_floor() or coyote_time > 0:
			velocity.y = JUMP_VELOCITY
	jump_buffer = move_toward(jump_buffer, 0, 1)
	
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCELERATION)
		direction = -1
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
		direction = 1
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		direction = 0
	
	var camera_limits = get_tree().get_nodes_in_group("camera_limit")
	if camera_limits.size() > 0:
		var limit_node = camera_limits[0]
		if limit_node is Node2D:
			if $camera:
				$camera.limit_right = limit_node.position.x
	
	move_and_slide()
	apply_animations(delta)

func apply_animations(_delta):
	if direction < 0:
		$sprite.flip_h = true
		$sprite.animation = "%s_walk" % skin
	elif direction > 0:
		$sprite.flip_h = false
		$sprite.animation = "%s_walk" % skin
	else:
		$sprite.animation = "%s_idle" % skin
	if not is_on_floor():
		if velocity.y < 0:
			$sprite.animation = "%s_jump_start" % skin
		else:
			$sprite.animation = "%s_jump_fall" % skin
	
func _on_death_plane_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var respawn_points = get_tree().get_nodes_in_group("respawn_point")
		if respawn_points.size() > 0:
			self.position = respawn_points[0].position
		velocity = Vector2(0, 0)
		coyote_time = 0
		Global.deaths += 1

func respawn(body):
	await get_tree().process_frame
	$camera.position_smoothing_enabled = false
	self._on_death_plane_body_entered(body)
	Global.deaths -= 1
	await get_tree().process_frame
	$camera.position_smoothing_enabled = true
