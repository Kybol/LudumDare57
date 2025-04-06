class_name Player extends CharacterBody2D

signal caught

@onready var animations: Array[Node] = $Animations.get_children()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var current_scale: float = scale.x
@onready var idle_sprite: Sprite2D = $Animations/Idle
@onready var run_sprite: Sprite2D = $Animations/Run

@export_range(0.0, 1000.0, 1.0) var speed: float = 100.0

var revealer_scene: PackedScene = preload("res://src/game/props/revealers/Revealer.tscn");
var facing_direction_x: int = 1
var is_running: bool = false


func _physics_process(_delta: float) -> void:
	if Utils.is_input_revealing_used():
		reveal_area()
	
	if not Utils.is_any_input_pressed(): 
		idle()
		return
	
	var direction: Vector2 = Utils.get_input_movement()
	if direction.x != 0:
		facing_direction_x = direction.x
	velocity = direction * speed
	
	if not is_running:
		run()
	move_and_slide()


func reveal_area() -> void:
	var revealer: Light2D = revealer_scene.instantiate()
	Globals.current_level.add_child(revealer)
	
	revealer.global_position = global_position
	revealer.activate()
	
	if is_instance_valid(Globals.monster):
		Globals.monster.fade_in()


func _on_detection_area_area_entered(area: Area2D) -> void:
	if not area.owner.is_in_group("monster"): return
	
	caught.emit()



func idle() -> void:
	is_running = false
	play_animation("Idle")


func run() -> void:
	idle_sprite.flip_h = true if facing_direction_x > 0 else false
	run_sprite.flip_h = true if facing_direction_x > 0 else false
	is_running = true
	play_animation("Run")


func play_animation(animation_name: String = "Idle") -> void:
	animation_player.play(animation_name)
	
	for anim in animations:
		if anim.name != animation_name: 
			anim.hide()
		else:
			anim.show()
		
