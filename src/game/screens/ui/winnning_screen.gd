extends Control

@onready var _next_button: Button = $VContainer/NextButton
@onready var _back_to_main: Button = $VContainer/Container/BackToMain
@onready var _quit_button: Button = $VContainer/Container/QuitButton

func _ready() -> void:
	GlobalSound.play_audio(GlobalSound.THEMES.MENU)
	_next_button.connect("pressed", on_next_button_pressed)
	_quit_button.connect("pressed", on_quit_button_pressed)
	_back_to_main.connect("pressed", on_back_to_main_pressed)


func on_next_button_pressed() -> void:
	GlobalSound.stop_audio()

	Utils.navigate_to("res://src/game/screens/test/lvl_nightmare.tscn")


func on_quit_button_pressed() -> void:
	get_tree().quit()


func on_back_to_main_pressed() -> void:
	GlobalSound.stop_audio()

	Utils.navigate_to("res://src/game/screens/ui/menus/MainMenu.tscn")
