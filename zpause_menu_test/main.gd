extends Node2D

var on_menu: int = 0

func _ready():
	self.visible = false
	$skin_swapper.position = get_viewport().get_visible_rect().size / 2
	$settings_sprite.position = get_viewport().get_visible_rect().size / 2
	$multiplayer_menu.position = get_viewport().get_visible_rect().size / 2
	$menu_sprite.position = get_viewport().get_visible_rect().size / 2

func _input(_event):
	if Input.is_action_just_pressed("pause") && get_window().has_focus() or !OS.has_feature("windows") and Input.is_action_just_pressed("exit"):
		pause_game()
		self.visible = !self.visible
		on_menu = 0
		$menu_sprite.visible = true
		$settings_sprite.visible = false
		$skin_swapper.visible = false
		$multiplayer_menu.visible = false

		$menu_sprite/selection.position.y = (($menu_sprite.on_button)* 55.38) - 89.5

func pause_game():
	if MultiplayerManager.multiplayer_mode_enabled == false:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = false
		$ColorRect.visible = false
