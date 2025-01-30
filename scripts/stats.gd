extends RichTextLabel

var time = 0

func _process(delta: float) -> void:
	self.text = "Time:" + str(Global.time_total) + "\nDeaths: " + str($"../../character".deaths)
	
	if $"../../character".debug_mode:
		self.text = "Coyote Time: " + str($"../../character".coyote_time)
