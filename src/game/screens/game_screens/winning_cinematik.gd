extends Control

func _ready() -> void:
	GlobalSound.stop_audio()
	await get_tree().create_timer(10).timeout
	
	Utils.navigate_to("res://src/game/screens/ui/WinnningScreen.tscn")
