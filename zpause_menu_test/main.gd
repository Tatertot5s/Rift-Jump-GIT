extends Node2D

var on_menu: String = "none"

func _ready():
	self.visible = false
	$menu_sprite.position = get_viewport().get_visible_rect().size / 2
	$settings_sprite.position = get_viewport().get_visible_rect().size / 2
	$multiplayer_menu.position = get_viewport().get_visible_rect().size / 2
	$skin_swapper.position = get_viewport().get_visible_rect().size / 2

func _input(_event):
	if Input.is_action_just_pressed("pause") && get_window().has_focus() or !OS.has_feature("windows") and Input.is_action_just_pressed("exit"):
		pause_game()
		if on_menu == "none":
			on_menu = "pause"
		else:
			on_menu = "none"

		$menu_sprite/selection.position.y = (($menu_sprite.on_button)* 55.38) - 89.5

func _process(_delta: float) -> void:
	match on_menu:
		"pause":
			$menu_sprite.visible = true
			$settings_sprite.visible = false
			$skin_swapper.visible = false
			$multiplayer_menu.visible = false
			self.visible = true
			Global.is_paused = true
		"options":
			$menu_sprite.visible = false
			$settings_sprite.visible = true
			$skin_swapper.visible = false
			$multiplayer_menu.visible = false
			self.visible = true
			Global.is_paused = true
		"multiplayer":
			$menu_sprite.visible = false
			$settings_sprite.visible = false
			$skin_swapper.visible = false
			$multiplayer_menu.visible = true
			self.visible = true
			Global.is_paused = true
		"skins":
			$menu_sprite.visible = false
			$settings_sprite.visible = false
			$skin_swapper.visible = true
			$multiplayer_menu.visible = false
			self.visible = true
			Global.is_paused = true
		"none":
			$menu_sprite.visible = false
			$settings_sprite.visible = false
			$skin_swapper.visible = false
			$multiplayer_menu.visible = false
			self.visible = false
			Global.is_paused = false
			get_tree().paused = false
	Global.on_menu = on_menu

func pause_game():
	if MultiplayerManager.multiplayer_mode_enabled == false:
		get_tree().paused = !get_tree().paused
	else:
		get_tree().paused = false
		$ColorRect.visible = false
