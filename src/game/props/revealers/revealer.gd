extends PointLight2D

@export_range(0.0, 10.0) var max_active_time = 3.0

@onready var dying_timer: Timer = $DyingTimer

var is_active: bool = false
var active_time: float = max_active_time


func activate() -> void:
	is_active = true
	
	dying_timer.connect("timeout", deactivate)
	dying_timer.start(active_time) 


func deactivate() -> void:
	dying_timer.stop()
	queue_free()
