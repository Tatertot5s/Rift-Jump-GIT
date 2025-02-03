extends MultiplayerSynchronizer

@onready var player = $".."
var input_direction
var camera_limit

func _ready():
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
	else:
		input_direction = 0

	var camera_limit_node = get_tree().get_nodes_in_group("camera_limit")
	camera_limit = camera_limit_node[0].position.x

func _physics_process(_delta):
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		input_direction = -1
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		input_direction = 1
	else:
		input_direction = 0
	
	var camera_limit_node = get_tree().get_nodes_in_group("camera_limit")
	camera_limit = camera_limit_node[0].position.x
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		jump.rpc()
	
@rpc("call_local")
func jump():
	if multiplayer.is_server():
		player.do_jump = true
