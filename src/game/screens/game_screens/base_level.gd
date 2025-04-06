class_name BaseLevel extends Control

@export var fade_in_elements: Array[Node2D]

@onready var player_start_marker: Marker2D = $AlwaysVisibleLayer/PlayerStartMarker
@onready var monster_start_marker: Marker2D = $MonsterStartMarker
@onready var always_visible_layer: CanvasLayer = $AlwaysVisibleLayer

var player_scene: PackedScene = preload("res://src/game/agents/Player.tscn")
var monster_scene: PackedScene = preload("res://src/game/agents/Monster.tscn")


func _ready() -> void:
	spawn_agents()
	Globals.current_level = self
	
	fade_in_all(false, 0.0)
	fade_in_all()
	


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
	
	fade_in_elements.append(player)
	


func fade_in_all(fade_in: bool = true, fade_time: float = 3.0) -> void:
	var fade_value: float = 1.0 if fade_in else 0.0
	for element in fade_in_elements:
		if element is LightPuddle:
			element.fade_in(fade_in, fade_time)
		else:
			create_tween().tween_property(element, "modulate:a", fade_value, fade_time)


func on_player_caught() -> void:
	Globals.game_over()
