extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if not area.owner.is_in_group("player"): return
	
	Utils.navigate_to("res://src/game/screens/game_screens/WinningCinematik.tscn")
