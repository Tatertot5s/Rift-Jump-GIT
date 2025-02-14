extends CharacterBody2D

const MAX_SPEED = 320.0
const JUMP_VELOCITY = -475.0
const ACCELERATION = 40.0
const DECELERATION = 25.0

var coyote_time = 0
var jump_buffer = 0
var debug_mode = false
var debug_fly_speed = 15

var direction = 1
var do_jump = false
var _is_on_floor = true
var skin = "1"
var username = ""

@export var camera_limit : float = 0.0

@export var player_id := 1:
	set(id):
		player_id = id
		$InputSynchronizer.set_multiplayer_authority(id)

func _ready():
	if multiplayer.get_unique_id() == player_id:
		$camera.make_current()

func apply_animations(_delta):
	skin = $InputSynchronizer.skin
	username = $InputSynchronizer.username
	if username:
		$username.text = username
	else:
		$username.text = ""

	if direction < 0:
		$sprite.flip_h = true
		$sprite.animation = "%s_walk" % skin
	elif direction > 0:
		$sprite.flip_h = false
		$sprite.animation = "%s_walk" % skin
	else:
		$sprite.animation = "%s_idle" % skin
	if not _is_on_floor:
		if velocity.y < 0:
			$sprite.animation = "%s_jump_start" % skin
		else:
			$sprite.animation = "%s_jump_fall" % skin
	

func _apply_movment_from_input(delta):
	direction = $InputSynchronizer.input_direction
	camera_limit = $InputSynchronizer.camera_limit
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_time = move_toward(coyote_time, 0, 1)
	else:
		coyote_time = 9
	
	if do_jump:
		jump_buffer = 5
		do_jump = false
	if jump_buffer > 0:
		if is_on_floor() or coyote_time > 0:
			velocity.y = JUMP_VELOCITY
	jump_buffer = move_toward(jump_buffer, 0, 1)
	
	if direction < 0:
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCELERATION)
	elif direction > 0:
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	
	$camera.limit_right = camera_limit
	
	move_and_slide()

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

func respawn_all():
	await get_tree().process_frame
	$camera.position_smoothing_enabled = false
	var respawn_points = get_tree().get_nodes_in_group("respawn_point")
	var tps = get_tree().get_nodes_in_group("Player")
	for running in tps:
		running.position = respawn_points[0].position
		await get_tree().create_timer(0.1).timeout
	velocity = Vector2(0, 0)
	await get_tree().process_frame
	$camera.position_smoothing_enabled = true

func _physics_process(delta):
	if multiplayer.is_server():
		_is_on_floor = is_on_floor()
		_apply_movment_from_input(delta)
	if not multiplayer.is_server() || MultiplayerManager.host_mode_enabled == true:
		apply_animations(delta)
	
