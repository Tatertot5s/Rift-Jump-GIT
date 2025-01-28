extends AnimatableBody2D

## The max amount that the platform is allowed to travel
@export var MAX_TRAVEL = 100
## The speed the platform travels at
@export var TRAVEL_SPEED = 3

var running = false
var travel = 0
var paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if running and not paused:
		if travel < MAX_TRAVEL:
			position.y -= TRAVEL_SPEED
			travel += 1
	else:
		if travel > 0 and not paused:
			position.y += TRAVEL_SPEED
			travel -= 1

func _on_top_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		running = true

func _on_top_player_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		running = false

func _on_bottom_squish_protection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		paused = true

func _on_bottom_squish_protection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		paused = false
