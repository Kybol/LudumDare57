class_name Monster extends CharacterBody2D

@export_range(0.0, 1000.0, 1.0) var min_speed: float = 50.0
@export_range(0.0, 1000.0, 1.0) var max_speed: float = 700.0
@export_range(0.0, 1000.0, 1.0) var speed: float = min_speed
@export var target: CharacterBody2D:
	set(new_target):
		target = new_target

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var fade_out_timer: Timer = $FadeOutTimer

var tween: Tween


func _ready() -> void:
	self.modulate.a = 0.0


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
	speed += 15


func decrease_speed() -> void:
	if speed <= min_speed: return
	speed -= 20


func fade_in() -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	var err = tween.tween_property(self, "modulate:a", 1.0, 1.0)
	
	fade_out_timer.start(3.0)
	fade_out_timer.connect("timeout", fade_out)


func fade_out() -> void:
	if tween:
		tween.kill
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	var err = tween.tween_property(self, "modulate:a", 0.0, 1.0)
