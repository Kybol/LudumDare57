extends Control

@onready var black_screen: ColorRect = $CanvasLayer/BlackScreen

func _ready() -> void:
	play_cinematik()


func play_cinematik() -> void:
	await get_tree().create_timer(24.0).timeout
	
	var tween: Tween = create_tween()
	tween.tween_property(black_screen, "modulate:a", 1.0, 1.0)
	tween.tween_callback(play_game)


func play_game() -> void:
	await get_tree().create_timer(1.0).timeout
	
	Utils.navigate_to("res://src/game/screens/test/lvl_monster.tscn")
