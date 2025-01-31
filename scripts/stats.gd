extends RichTextLabel

var time = 0

func _process(delta: float) -> void:
	var minutes = Global.time_total / 60
	var seconds = Global.time_total % 60
	self.text = "Time: %d:%02d \nDeaths: %d" % [Global.time_total / 60, Global.time_total % 60, Global.deaths]

	if $"../../character".debug_mode:
		self.text = self.text + "\n\n"
		self.text = self.text + "debug_mode: " + str($"../../character".debug_mode)
		self.text = self.text + "\nposition.x: " + str($"../../character".position.x)
		self.text = self.text + "\nposition.y: " + str($"../../character".position.y)
		self.text = self.text + "\nvelocity.x: " + str($"../../character".velocity.x)
		self.text = self.text + "\nvelocity.y: " + str($"../../character".velocity.y)
		self.text = self.text + "\ncoyote_time: " + str($"../../character".coyote_time)
