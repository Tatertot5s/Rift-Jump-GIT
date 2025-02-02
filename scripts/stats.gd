extends RichTextLabel

var time = 0
@warning_ignore("integer_division")

func _process(_delta: float) -> void:
	self.text = "Time: %d:%02d \nDeaths: %d" % [Global.time_total / 60, Global.time_total % 60, Global.deaths]

	if Global.player and Global.player.debug_mode:
		self.text = self.text + "\n"
		self.text = self.text + "\ndebug_mode: " + str(Global.player.debug_mode)
		self.text = self.text + "\nposition.x: " + str(Global.player.position.x)
		self.text = self.text + "\nposition.y: " + str(Global.player.position.y)
		self.text = self.text + "\nvelocity.x: " + str(Global.player.velocity.x)
		self.text = self.text + "\nvelocity.y: " + str(Global.player.velocity.y)
		self.text = self.text + "\ncoyote_time: " + str(Global.player.coyote_time)
		self.text = self.text + "\n"
		self.text = self.text + "\nLevel 1 Time: %d:%02d" % [Global.level_1_time / 60, Global.level_1_time % 60]
		self.text = self.text + "\nLevel 2 Time: %d:%02d" % [Global.level_2_time / 60, Global.level_2_time % 60]
		self.text = self.text + "\nLevel 3 Time: %d:%02d" % [Global.level_3_time / 60, Global.level_3_time % 60]
		self.text = self.text + "\nLevel 4 Time: %d:%02d" % [Global.level_4_time / 60, Global.level_4_time % 60]
