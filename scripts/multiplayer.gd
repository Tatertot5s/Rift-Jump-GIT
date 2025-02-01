extends Node

const SERVER_PORT = 8080
const SERVER_IP = "127.0.0.1"

var multiplayer_scene = preload("res://objects/multiplayer_player.tscn")

var _players_spawn_node 

func _on_host_pressed():
	_players_spawn_node = get_tree().get_current_scene().get_node("players")
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_del_player)

func _on_join_pressed():
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	
	multiplayer.multiplayer_peer = client_peer

func _add_player_to_game(id: int):
	var player_to_add = multiplayer_scene.instanciate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	_players_spawn_node.add_child(player_to_add, true)
	
func _del_player(id: int):
	pass
