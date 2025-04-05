class_name Monster extends CharacterBody2D

@export_range(0.0, 1000.0, 1.0) var min_speed: float = 50.0
@export_range(0.0, 1000.0, 1.0) var max_speed: float = 1000.0
@export_range(0.0, 1000.0, 1.0) var speed: float = min_speed
@export var target: CharacterBody2D:
	set(new_target):
		target = new_target

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _physics_process(_delta: float) -> void:
	if not target: return
	navigation_agent.target_position = target.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * speed
	
	move_and_slide()


func follow_noise(noise_source: Node2D) -> void:
	target = noise_source
	set_physics_process(true)


func increase_speed() -> void:
	if speed >= max_speed: return
	speed += 20


func decrease_speed() -> void:
	if speed <= min_speed: return
	speed -= 20
