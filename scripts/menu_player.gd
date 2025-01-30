extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -475.0
const ACCELERATION = 40.0

var jump_buffer = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_up"):
		jump_buffer = 5
	if jump_buffer > 0:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
	jump_buffer = move_toward(jump_buffer, 0, 1)
	
	velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
	
	if position.x >= 1240:
		position.x = -72
	
	move_and_slide()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://levels/Level1.tscn")
