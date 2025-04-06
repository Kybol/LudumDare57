extends Control

@onready var _replay_button: Button = $ReplayButton
@onready var _back_to_main: Button = $VBoxContainer/BackToMain
@onready var _quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	GlobalSound.stop_audio()
	GlobalSound.play_audio(GlobalSound.THEMES.DEATH)
	GlobalSound.play_audio(GlobalSound.THEMES.MENU)
	_replay_button.connect("pressed", on_replay_button_pressed)
	_quit_button.connect("pressed", on_quit_button_pressed)
	_back_to_main.connect("pressed", on_back_to_main_pressed)


func on_replay_button_pressed() -> void:
	GlobalSound.stop_audio()
	
	if not Globals.is_nightmare:
		Utils.navigate_to("res://src/game/screens/test/lvl_monster.tscn")
	else:
		Utils.navigate_to("res://src/game/screens/test/lvl_nightmare.tscn")


func on_quit_button_pressed() -> void:
	get_tree().quit()


func on_back_to_main_pressed() -> void:
	GlobalSound.stop_audio()
	
	Utils.navigate_to("res://src/game/screens/ui/menus/MainMenu.tscn")
