class_name Player extends CharacterBody2D

@export_range(0.0, 1000.0, 1.0) var speed: float = 200.0

var revealer_scene: PackedScene = preload("res://src/game/props/revealers/Revealer.tscn");

func _process(delta: float) -> void:
	if Utils.is_input_revealing_used():
		reveal_area()
	
	if not Utils.is_any_input_pressed(): return
	
	var direction: Vector2 = Utils.get_input_movement()
	velocity = direction * speed
	
	move_and_slide()


func reveal_area() -> void:
	var revealer: Light2D = revealer_scene.instantiate()
	var root: Window = get_tree().root
	root.add_child(revealer)
	
	revealer.global_position = global_position
	revealer.activate()
