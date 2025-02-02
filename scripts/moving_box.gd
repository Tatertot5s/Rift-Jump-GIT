extends AnimatableBody2D

## The max amount that the platform is allowed to travel
@export var MAX_TRAVEL = 100
## The speed the platform travels at
@export var TRAVEL_SPEED = 3

var travel = 0
var running = false
var paused = false

func _physics_process(_delta) -> void:
	if running and not paused:
		if travel < MAX_TRAVEL:
			travel = move_toward(travel, MAX_TRAVEL, 1)
			position.y -= TRAVEL_SPEED
	elif travel > 0 and not paused:
		travel = move_toward(travel, 0, 1)
		position.y += TRAVEL_SPEED

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		running = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		running = false

func _on_bottom_squish_protection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		paused = true

func _on_bottom_squish_protection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		paused = false
