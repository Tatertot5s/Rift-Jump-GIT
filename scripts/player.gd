extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -475.0
const ACCELERATION = 40.0

var coyote_time = 0
var jump_buffer = 0
var debug_mode = false
var debug_fly_speed = 15

func _ready() -> void:
	$Camera2D.limit_right = get_parent().get_node("exit_portal").position.x + 40

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
		velocity.x = 0
		velocity.y = 0
		$Camera2D/Label.visible = !$Camera2D/Label.visible
	
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
		if Input.is_action_just_pressed("1"):
			get_tree().change_scene_to_file("res://levels/Level1.tscn")
		if Input.is_action_just_pressed("2"):
			get_tree().change_scene_to_file("res://levels/Level2.tscn")
		if Input.is_action_just_pressed("3"):
			get_tree().change_scene_to_file("res://levels/Level3.tscn")
		if Input.is_action_just_pressed("4"):
			get_tree().change_scene_to_file("res://levels/Level4.tscn")
		if Input.is_action_just_pressed("`"):
			get_tree().change_scene_to_file("res://levels/MainMenu.tscn")

	#debug, to test variables & timings.
	if false:
		$AnimatedSprite2D.modulate = "4880ff"
	else:
		$AnimatedSprite2D.modulate = "ffffff"

func _on_death_plane_body_entered(body: Node2D) -> void:
	if is_in_group("Player"):
		self.position = $"../respawn_point".position
