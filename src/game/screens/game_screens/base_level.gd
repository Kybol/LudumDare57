extends Control

@onready var start_marker: Marker2D = $AlwaysVisibleLayer/StartMarker
@onready var always_visible_layer: CanvasLayer = $AlwaysVisibleLayer

var player_scene: PackedScene = preload("res://src/game/agents/Player.tscn")


func _ready() -> void:
	spawn_player()


func spawn_player() -> void:
	var player: Player = player_scene.instantiate()
	always_visible_layer.add_child(player)
	
	player.global_position = start_marker.position
