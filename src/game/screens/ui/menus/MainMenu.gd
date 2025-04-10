extends Control

@onready var _playButton: Button = $Container/PlayButton
@onready var _quitButton: Button = $Container/QuitButton

func _ready() -> void:
	_playButton.connect("pressed", on_play_button_pressed)
	_quitButton.connect("pressed", on_quit_button_pressed)
	GlobalSound.play_audio(GlobalSound.THEMES.MENU)
	

func on_play_button_pressed() -> void:
	Utils.navigate_to("res://src/game/screens/game_screens/Cinematik.tscn")


func on_quit_button_pressed() -> void:
	get_tree().quit()
