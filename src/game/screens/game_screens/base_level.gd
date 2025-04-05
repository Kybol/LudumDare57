class_name BaseLevel extends Control

@onready var player_start_marker: Marker2D = $AlwaysVisibleLayer/PlayerStartMarker
@onready var monster_start_marker: Marker2D = $MonsterStartMarker
@onready var always_visible_layer: CanvasLayer = $AlwaysVisibleLayer

var player_scene: PackedScene = preload("res://src/game/agents/Player.tscn")
var monster_scene: PackedScene = preload("res://src/game/agents/Monster.tscn")


func _ready() -> void:
	spawn_agents()
	Globals.current_level = self


func spawn_agents() -> void:
	var player: Player = player_scene.instantiate()
	var monster: Monster = monster_scene.instantiate()
	always_visible_layer.add_child(player)
	always_visible_layer.add_child(monster)
	
	player.global_position = player_start_marker.global_position
	monster.global_position = monster_start_marker.global_position

	monster.follow_noise(player)
	player.connect("caught", on_player_caught)
	
	Globals.monster = monster
	Globals.player = player
	

func on_player_caught() -> void:
	Globals.game_over()
