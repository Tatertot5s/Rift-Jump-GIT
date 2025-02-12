extends RichTextLabel

var time = 0
@warning_ignore("integer_division")

func _process(_delta: float) -> void:
	self.text = "Time: %d:%02d \nDeaths: %d" % [Global.time_total / 60, Global.time_total % 60, Global.deaths]
