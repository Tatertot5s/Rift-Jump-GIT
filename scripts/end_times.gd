extends Label

var time = 0

@warning_ignore("integer_division")

func _ready():
	self.text = "Final Time: %d:%02d" % [Global.time_total / 60, Global.time_total % 60]
	self.text = self.text + "\n\nLevel 1 Time: %d:%02d" % [Global.level_1_time / 60, Global.level_1_time % 60]
	self.text = self.text + "\nLevel 2 Time: %d:%02d" % [Global.level_2_time / 60, Global.level_2_time % 60]
	self.text = self.text + "\nLevel 3 Time: %d:%02d" % [Global.level_3_time / 60, Global.level_3_time % 60]
	self.text = self.text + "\nLevel 4 Time: %d:%02d" % [Global.level_4_time / 60, Global.level_4_time % 60]
	self.text = self.text + "\n\nTotal Deaths: %d" % [Global.deaths]
