extends RichTextLabel

var time = 0

var coyote_time = 0
var jump_buffer = 0
var debug_mode = false
var debug_fly_speed = 15
var deaths = 0

func _process(delta: float) -> void:
	var minutes = Global.time_total / 60
	var seconds = Global.time_total % 60
	self.text = "Time: %d:%02d \nDeaths: %d" % [Global.time_total / 60, Global.time_total % 60, Global.deaths]

	if $"../../character".debug_mode:
		self.text = "debug_mode: " + str($"../../character".debug_mode) + "\nposition.x: " + str($"../../character".position.x) + "\nposition.y: " + str($"../../character".position.y) + "\nvelocity.x: " + str($"../../character".velocity.x) + "\nvelocity.y: " + str($"../../character".velocity.y) + "\ncoyote_time: " + str($"../../character".coyote_time)
