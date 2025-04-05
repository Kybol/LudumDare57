extends PointLight2D

signal animation_completed

@export var frames_idle: Array[Texture] = []
@export var frames_dying: Array[Texture] = []
@export_range(0.0, 10.0) var max_active_time = 2.4

@onready var dying_timer: Timer = $DyingTimer

var is_active: bool = false
var active_time: float = max_active_time


func activate() -> void:
	is_active = true
	
	dying_timer.connect("timeout", deactivate)
	dying_timer.start(active_time)
	
	animate_frames()
	
	if not Globals.monster: return
	Globals.monster.increase_speed()
	
	await animation_completed
	animate_frames()


func deactivate() -> void:
	dying_timer.stop()
	animate_frames("dying")
	await animation_completed
	
	queue_free()
	
	if not Globals.monster: return
	Globals.monster.decrease_speed()


func animate_frames(animation_name: String = "idle"):
	var frames: Array[Texture] = frames_idle
	if animation_name != "idle":
		frames = frames_dying
		
	var frame_size: int = frames.size()
	for i in range(0,frame_size):
		self.texture = frames[i]
		await get_tree().create_timer(0.1).timeout
	
	animation_completed.emit()
