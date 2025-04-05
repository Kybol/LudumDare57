extends Node2D


func _on_reveal_area_area_entered(area: Area2D) -> void:
	if not area.owner.is_in_group("monster"): return
	
	if not is_instance_valid(Globals.monster): return
	Globals.monster.fade_in()


func _on_reveal_area_area_exited(area: Area2D) -> void:
	if not area.owner.is_in_group("monster"): return
	
	if not is_instance_valid(Globals.monster): return
	Globals.monster.fade_out()
