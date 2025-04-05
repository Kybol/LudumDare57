extends Control

@onready var _playButton: Button = $Container/PlayButton
@onready var _optionButton: Button = $Container/OptionButton
@onready var _quitButton: Button = $Container/QuitButton

func _ready() -> void:
	_playButton.connect("pressed", on_play_button_pressed)
	_quitButton.connect("pressed", on_quit_button_pressed)
	_optionButton.connect("pressed", on_option_button_pressed)


func on_play_button_pressed() -> void:
	Utils.navigate_to("res://src/game/screens/game_screens/BaseLevel.tscn")


func on_quit_button_pressed() -> void:
	get_tree().quit()


func on_option_button_pressed() -> void:
	pass
