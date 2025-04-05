extends Node

var monster: Monster
var player: Player
var current_level: BaseLevel


func game_over() -> void:
	Globals.player.call_deferred("queue_free")
	Globals.monster.call_deferred("queue_free")
	
	Globals.player = null
	Globals.monster = null

	Utils.navigate_to("res://src/game/screens/ui/GameOverScreen.tscn")
