class_name Monster extends CharacterBody2D

@export_range(0.0, 1000.0, 1.0) var min_speed: float = 50.0
@export_range(0.0, 1000.0, 1.0) var max_speed: float = 700.0
@export_range(0.0, 1000.0, 1.0) var speed_step: float = 15.0
@export_range(0.0, 1000.0, 1.0) var speed: float = min_speed
@export_range(0.0, 1000.0, 1.0) var waiting_timer: float = 3.0
@export var is_waiting: bool = true
@export var target: CharacterBody2D:
	set(new_target):
		target = new_target

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var fade_out_timer: Timer = $FadeOutTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var tween: Tween
var fade


func _ready() -> void:
	self.modulate.a = 0.0
	animation_player.play("Walk")
	
	if is_waiting: 
		set_physics_process(false)
		await get_tree().create_timer(waiting_timer).timeout
		
		set_physics_process(true)
	speed = min_speed
	follow_noise(Globals.player)


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
	speed += speed_step


func decrease_speed() -> void:
	if speed <= min_speed: return
	speed -= speed_step


func fade_in(has_to_fade_out: bool = true) -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	
	if has_to_fade_out:
		fade_out_timer.start(3.0)
		if not fade_out_timer.is_connected("timeout", fade_out): 
			fade_out_timer.connect("timeout", fade_out)


func fade_out() -> void:
	if fade_out_timer.is_connected("timeout", fade_out): 
		fade_out_timer.disconnect("timeout", fade_out)
	
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
