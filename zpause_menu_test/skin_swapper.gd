extends Node2D

var skin: Array = ["1", "2", "3", "gadgetman"]
var skin_num = 0

func _process(_delta):
	if self.visible == true:
		if Input.is_action_just_pressed("ui_left") && get_window().has_focus():
			change_skin(-1)
		if Input.is_action_just_pressed("ui_right") && get_window().has_focus():
			change_skin(1)
		if Input.is_action_just_pressed("ui_accept") && get_window().has_focus():
			_on_apply_pressed()
		if Input.is_action_just_pressed("ui_cancel") && get_window().has_focus():
			_on_cancel_pressed()

func _on_apply_pressed() -> void:
	if MultiplayerManager.multiplayer_mode_enabled == false:
		Global.player.skin = skin[skin_num]
	else:
		Global.skin = skin[skin_num]
	$"..".on_menu = "options"
	$"../settings_sprite/selection".position.y = ((1 + $"../settings_sprite".on_button) * 54.564) - 194.872

func change_skin(direction):
	skin_num += direction
	if skin_num < 0:
		skin_num = int(skin.size()-1)
	elif skin_num > skin.size()-1:
		skin_num = 0
	$sprite.animation = "%s_walk" % skin[skin_num]

func _on_cancel_pressed():
	$"..".on_menu = "options"
	$"../settings_sprite/selection".position.y = ((1 + $"..".on_button) * 54.564) - 194.872
