extends Node2D

var skin: Array = ["1", "2", "3", "gadgetman"]
var skin_num = 0

func _input(_event):
	if self.visible == true:
		if Input.is_action_just_pressed("ui_left"):
			_on_left_pressed()
		if Input.is_action_just_pressed("ui_right"):
			_on_right_pressed()
		if Input.is_action_just_pressed("ui_down"):
			_on_apply_pressed()

func _on_apply_pressed() -> void:
	if MultiplayerManager.multiplayer_mode_enabled == false:
		Global.player.skin = skin[skin_num]
	else:
		Global.skin = skin[skin_num]
	self.visible = false
	$"../settings_sprite".visible = true
	$"..".on_button = 0
	$"..".on_menu = 1

func _on_left_pressed() -> void:
	skin_num -= 1
	if skin_num < -1:
		skin_num = int(skin.size()-1)
	$sprite.animation = "%s_walk" % skin[skin_num]

func _on_right_pressed() -> void:
	skin_num += 1
	if skin_num > skin.size() - 1:
		skin_num = 0
	$sprite.animation = "%s_walk" % skin[skin_num]
