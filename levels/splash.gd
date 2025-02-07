extends Label

func _ready():
	random_item()

func random_item():    
	var file = "res://splash.txt"
	var list = FileAccess.open(file, FileAccess.READ)
	var rng = RandomNumberGenerator.new()
	
	while not list.eof_reached():
		self.text = list.get_line()
		if rng.randi() % 10 == 0:
			return
