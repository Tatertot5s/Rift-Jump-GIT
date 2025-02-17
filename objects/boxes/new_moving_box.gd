@tool
extends AnimatableBody2D

@export var MAX_TRAVEL: int = 100
@export var TRAVEL_SPEED: int = 3

@export var num_platforms: int = 1

var travel: int = 0
var running: bool = false
var paused: bool = false

func _physics_process(_delta: float) -> void:
	if running and not paused:
		if travel < MAX_TRAVEL:
			travel = move_toward(travel, MAX_TRAVEL, 1)
			position.y -= TRAVEL_SPEED
	elif travel > 0 and not paused:
		travel = move_toward(travel, 0, 1)
		position.y += TRAVEL_SPEED

func interact(body: Node2D, on_top:bool, enter_area:bool):
	if body.is_in_group("Player"):
		if on_top:
			if enter_area:
				running = true
			else:
				running = false
		else:
			if enter_area:
				paused = true
			else:
				paused = false
