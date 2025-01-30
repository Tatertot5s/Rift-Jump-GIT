extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -475.0
const ACCELERATION = 40.0

var coyote_time = 0
var jump_buffer = 0
var debug_mode = false
var debug_fly_speed = 15

func _ready() -> void:
	$camera.limit_right = get_parent().get_node("camera_limit").position.x

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_mode"):
		debug_mode = !debug_mode

	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_time = move_toward(coyote_time, 0, 1)
	else:
		coyote_time = 9
	
	#Jump
	if Input.is_action_just_pressed("ui_up"):
		jump_buffer = 5
	if jump_buffer > 0:
		if is_on_floor() or coyote_time > 0:
			velocity.y = JUMP_VELOCITY
	jump_buffer = move_toward(jump_buffer, 0, 1)

	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCELERATION)
		$sprite.flip_h = true
		$sprite.animation = "walk"
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
		$sprite.flip_h = false
		$sprite.animation = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, 40)
		$sprite.animation = "idle"
			
	#debug movment
	if Input.is_action_pressed("shift"):
		if Input.is_action_pressed("ui_left"):
			position.x -= debug_fly_speed
		if Input.is_action_pressed("ui_right"):
			position.x += debug_fly_speed
		if Input.is_action_pressed("ui_up"):
			position.y -= debug_fly_speed
		if Input.is_action_pressed("ui_down"):
			position.y += debug_fly_speed
	else:
		move_and_slide()

	#debug, to test variables & timings.
	if false:
		$sprite.modulate = "4880ff"
	else:
		$sprite.modulate = "ffffff"

func _on_death_plane_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		self.position = $"../respawn_point".position
		velocity = Vector2(0, 0)
		coyote_time = 9
		Global.deaths += 1
