extends Label

func _ready():
	random_item()
	$AnimationPlayer.current_animation = "splash"

func random_item():
	var file = "res://splash.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var lines = []
	
	while not list.eof_reached():
		lines.append(list.get_line())
	
	if lines.size() > 0:
		var rng = RandomNumberGenerator.new()
		self.text = lines[rng.randi_range(0, lines.size() - 1)]
