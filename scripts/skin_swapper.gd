extends Control

var skin: Array = ["1", "2", "3"]
var skin_num = 0

func _on_apply_pressed() -> void:
	$player_sprite/sprite.animation = "%s_walk" % skin[skin_num]

func _on_left_pressed() -> void:
	skin_num =- 1
	if skin_num < -1:
		skin_num = int(skin.size()-1)
	$player_sprite/sprite.animation = "%s_walk" % skin[skin_num]
	print(skin_num)

func _on_right_pressed() -> void:
	skin_num =+ 1
	if skin_num > skin.size()+1:
		skin_num = 0
	$player_sprite/sprite.animation = "%s_walk" % skin[skin_num]
	print(skin_num)
