class_name BaseLevel extends Control

@export var fade_in_elements: Array[Node2D]
@export var spawn_monster: bool = true
@export var is_nightmare: bool = false

@onready var player_start_marker: Marker2D = $AlwaysVisibleLayer/PlayerStartMarker
@onready var monster_start_marker: Marker2D = $MonsterStartMarker
@onready var always_visible_layer: CanvasLayer = $AlwaysVisibleLayer

var player_scene: PackedScene = preload("res://src/game/agents/Player.tscn")
var monster_scene: PackedScene = preload("res://src/game/agents/Monster.tscn")


func _ready() -> void:
	GlobalSound.play_audio()
	spawn_agents()
	Globals.current_level = self
	Globals.is_nightmare = is_nightmare
	
	if is_nightmare: 
		setup_nightmare()
	
	fade_in_all(false, 0.0)
	fade_in_all()


func spawn_agents() -> void:
	var player: Player = player_scene.instantiate()
	always_visible_layer.add_child(player)
	
	player.global_position = player_start_marker.global_position
	player.connect("caught", on_player_caught)
	Globals.player = player
	
	fade_in_elements.append(player)
	
	if not spawn_monster: return
	var monster: Monster = monster_scene.instantiate()
	always_visible_layer.add_child(monster)
	
	monster.global_position = monster_start_marker.global_position
	Globals.monster = monster
	


func fade_in_all(fade_in: bool = true, fade_time: float = 3.0) -> void:
	var fade_value: float = 1.0 if fade_in else 0.0
	for element in fade_in_elements:
		if element is LightPuddle:
			element.fade_in(fade_in, fade_time)
		else:
			create_tween().tween_property(element, "modulate:a", fade_value, fade_time)


func on_player_caught() -> void:
	Globals.game_over()


func setup_nightmare() -> void:
	Globals.monster.min_speed = 50.0
	Globals.monster.max_speed = 1000.0 
	Globals.monster.speed_step = 30.0
