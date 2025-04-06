class_name LightPuddle extends Node2D

signal animation_completed

@export var animate_puddle: bool = true
@export var frames: Array[Texture] = []

@onready var point_light: PointLight2D = $PointLight2D


func _ready() -> void:
	if animate_puddle:
		while(true):
			animate_frames()
			await animation_completed


func _on_reveal_area_area_entered(area: Area2D) -> void:
	if not area.owner.is_in_group("monster"): return
	
	if not is_instance_valid(Globals.monster): return
	Globals.monster.fade_in()


func _on_reveal_area_area_exited(area: Area2D) -> void:
	if not area.owner.is_in_group("monster"): return
	
	if not is_instance_valid(Globals.monster): return
	Globals.monster.fade_out()


func fade_in(fade_in:bool = true, time: float = 0.0) -> void:
	var fade_value: float = 1.0 if fade_in else 0.0
	create_tween().tween_property(point_light, "energy", fade_value, time)


func animate_frames() -> void:
	var waiting_time: float = 0.05

	var frame_size: int = frames.size()
	for i in range(0,frame_size):
		point_light.texture = frames[i]
		await get_tree().create_timer(waiting_time).timeout
	
	animation_completed.emit()
