extends Node

func _on_host_button_down():
	$"..".on_menu = "none"
	pause_game()
	MultiplayerManager.become_host()
func _on_join_button_down():
	$"..".on_menu = "none"
	pause_game()
	MultiplayerManager.join_as_player_2()

func _on_cancel_pressed():
	$"..".on_menu = "options"
	$"../settings_sprite".visible = true
	self.visible = false
	$"../settings_sprite/selection".position.y = ((1 + $"../settings_sprite".on_button) * 54.564) - 194.872

func pause_game():
	if MultiplayerManager.multiplayer_mode_enabled == false:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = false
		$ColorRect.visible = false
