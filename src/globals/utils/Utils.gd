extends Node

func navigate_to(scene: String) -> void:
	var sceneToNavigateTo: PackedScene = load(scene)
	if sceneToNavigateTo == null: 
		print("Utils/navigate_to(scene) -> inexistant scene path")
		return
	
	get_tree().change_scene_to_packed(sceneToNavigateTo)


func is_any_input_pressed() -> bool:
	return Input.is_anything_pressed()


func get_input_movement() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


func is_input_revealing_used() -> bool:
	return Input.is_action_just_released("ui_reveal")
