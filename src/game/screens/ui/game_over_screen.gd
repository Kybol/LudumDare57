extends Control

@onready var _replay_button: Button = $VBoxContainer/ReplayButton
@onready var _back_to_main: Button = $VBoxContainer/Container/BackToMain
@onready var _quit_button: Button = $VBoxContainer/Container/QuitButton

func _ready() -> void:
	_replay_button.connect("pressed", on_replay_button_pressed)
	_quit_button.connect("pressed", on_quit_button_pressed)
	_back_to_main.connect("pressed", on_back_to_main_pressed)


func on_replay_button_pressed() -> void:
	Utils.navigate_to("res://src/game/screens/test/lvl_monster.tscn")


func on_quit_button_pressed() -> void:
	get_tree().quit()


func on_back_to_main_pressed() -> void:
	Utils.navigate_to("res://src/game/screens/ui/menus/MainMenu.tscn")
