extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -475.0
const ACCELERATION = 40.0

var coyote_time = 0
var jump_buffer = 0
var debug_mode = false
var debug_fly_speed = 20

func _physics_process(delta: float) -> void:
	#Game Settings
	if Input.is_action_just_pressed("fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if Input.is_action_just_pressed("unfullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("debug_mode"):
		debug_mode = !debug_mode
	
	if not is_on_floor():
		if !debug_mode:
			velocity += get_gravity() * delta
		coyote_time += 1
	else:
		coyote_time = 0
	
	#Jump
	if Input.is_action_just_pressed("ui_up"):
		jump_buffer = 5
	if jump_buffer > 0:
		if is_on_floor() or coyote_time <= 8:
			velocity.y = JUMP_VELOCITY
	jump_buffer = move_toward(jump_buffer, 0, 1)

	#Walking
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCELERATION)
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.animation = "walk"
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.animation = "walk"
	else:
		velocity.x = move_toward(velocity.x, 0, 40)
		$AnimatedSprite2D.animation = "idle"
	
	if !debug_mode:
		move_and_slide()
	
	#debug movment
	if debug_mode:
		if Input.is_action_pressed("ui_left"):
			position.x -= debug_fly_speed
		if Input.is_action_pressed("ui_right"):
			position.x += debug_fly_speed
		if Input.is_action_pressed("ui_up"):
			position.y -= debug_fly_speed
		if Input.is_action_pressed("ui_down"):
			position.y += debug_fly_speed

	#debug, to test variables & timings.
	if false:
		$AnimatedSprite2D.modulate = "4880ff"
	else:
		$AnimatedSprite2D.modulate = "ffffff"
