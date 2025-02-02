extends CharacterBody2D

const MAX_SPEED = 300.0*1.5
const JUMP_VELOCITY = -475.0*1.5
const ACCELERATION = 40.0*1.5

var jump_buffer = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if not is_on_floor():
		velocity += get_gravity() * 1.2 * delta
	
	if Input.is_action_just_pressed("ui_up") and $"../CreditsMenu".visible == false:
		jump_buffer = 5
	if jump_buffer > 0:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
	jump_buffer = move_toward(jump_buffer, 0, 1)
	
	velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
	
	if position.x >= 1240:
		position.x = -72
	
	move_and_slide()
