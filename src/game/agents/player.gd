class_name Player extends CharacterBody2D

signal caught

@export_range(0.0, 1000.0, 1.0) var speed: float = 100.0

var revealer_scene: PackedScene = preload("res://src/game/props/revealers/Revealer.tscn");


func _physics_process(_delta: float) -> void:
	if Utils.is_input_revealing_used():
		reveal_area()
	
	if not Utils.is_any_input_pressed(): return
	
	var direction: Vector2 = Utils.get_input_movement()
	velocity = direction * speed
	
	move_and_slide()


func reveal_area() -> void:
	var revealer: Light2D = revealer_scene.instantiate()
	Globals.current_level.add_child(revealer)
	
	revealer.global_position = global_position
	revealer.activate()
	Globals.monster.fade_in()


func _on_detection_area_area_entered(area: Area2D) -> void:
	if not area.owner.is_in_group("monster"): return
	
	caught.emit()
