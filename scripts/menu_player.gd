extends CharacterBody2D

const MAX_SPEED = 300.0 * 1.5
const JUMP_VELOCITY = -475.0 * 1.5
const ACCELERATION = 40.0 * 1.5

var jump_buffer = 0

var skin: Array = ["1", "2", "3", "4", "gadgetman"]
var skin_num = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("exit") && get_window().has_focus():
		get_tree().quit()
	
	#Movement
	if not is_on_floor():
		velocity += get_gravity() * 1.2 * delta
		
	if Input.is_action_just_pressed("jump") && get_window().has_focus() and $"../CreditsMenu".visible == false:
		jump_buffer = 5
	if jump_buffer > 0:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
	jump_buffer = move_toward(jump_buffer, 0, 1)
	
	velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
	
	if position.x >= (get_viewport().get_visible_rect().size.x + 50):
		position.x = -72
	
	move_and_slide()
	
	#Animations
	if Global.skin_num:
		skin_num = Global.skin_num
	if not is_on_floor():
		if velocity.y < 0:
			$sprite.animation = "%s_jump_start" % skin[skin_num]
		else:
			$sprite.animation = "%s_jump_fall" % skin[skin_num]
	else:
		$sprite.animation = "%s_walk" % skin[skin_num]


func _on_texture_button_button_down():
	jump_buffer = 5
