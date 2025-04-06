class_name LightPuddle extends Node2D

@onready var point_light: PointLight2D = $PointLight2D

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
