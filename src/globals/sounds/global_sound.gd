extends Node2D

@onready var main_theme: AudioStreamPlayer2D = $MainTheme
@onready var menu_theme: AudioStreamPlayer2D = $MenuTheme
@onready var death: AudioStreamPlayer2D = $Death

enum THEMES {
	MAIN,
	MENU,
	DEATH
}

func _ready() -> void:
	stop_audio()


func play_audio(theme: int = THEMES.MAIN) -> void:
	match theme:
		THEMES.MAIN:
			main_theme.play()
		THEMES.MENU:
			menu_theme.play()
		THEMES.DEATH:
			death.play()
	


func stop_audio() -> void:
	main_theme.stop()
	menu_theme.stop()
	death.stop()
