extends Node

var SERVER_IP = "127.0.0.1"
var SERVER_PORT = 8080

#"taterserver.ddns.net"

var host_mode_enabled = false
var multiplayer_mode_enabled = false

var multiplayer_scene = preload("res://objects/multiplayer_player.tscn")

var _players_spawn_node

func become_host():
	_players_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	host_mode_enabled = true
	multiplayer_mode_enabled = true
	
	var server_peer = ENetMultiplayerPeer.new()
	
	var port_edit_node = get_tree().get_nodes_in_group("server_port_input")
	if port_edit_node[0].text != "":
		SERVER_PORT = int(port_edit_node[0].text)

	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_del_player)
	
	_remove_single_player()
	_add_player_to_game(1)
	
func join_as_player_2():
	multiplayer_mode_enabled = true
	var client_peer = ENetMultiplayerPeer.new()
	
	var server_edit_node = get_tree().get_nodes_in_group("server_IP_input")
	if server_edit_node[0].text != "":
		SERVER_IP = server_edit_node[0].text
	
	var port_edit_node = get_tree().get_nodes_in_group("server_port_input")
	if port_edit_node[0].text != "":
		SERVER_PORT = int(port_edit_node[0].text)
	
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	
	multiplayer.multiplayer_peer = client_peer
	
	_remove_single_player()
	
func _add_player_to_game(id: int):
	var player_to_add = multiplayer_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	_players_spawn_node.add_child(player_to_add, true)
	
func _del_player(id: int):
	if not _players_spawn_node.has_node(str(id)):
		return
	_players_spawn_node.get_node(str(id)).queue_free()

func _remove_single_player():
	var player_to_remove = get_tree().get_current_scene().get_node("player")
	player_to_remove.queue_free()
