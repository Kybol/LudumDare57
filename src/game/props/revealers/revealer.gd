extends PointLight2D

signal animation_completed

@export var can_die: bool = true
@export var show_ambient_light: bool = true
@export var frames_idle: Array[Texture] = []
@export var frames_dying: Array[Texture] = []
@export_range(0.0, 10.0) var max_active_time = 1.2

@onready var dying_timer: Timer = $DyingTimer
@onready var point_light: PointLight2D = $PointLight2D
@onready var sfx_sonar: AudioStreamPlayer2D = $sfx_sonar

var is_active: bool = false
var active_time: float = max_active_time


func _ready() -> void:
	if show_ambient_light:
		point_light.show()
	else:
		point_light.hide()
	
	if can_die: return
	is_active = true
	
	while true:
		animate_frames()
		await animation_completed


func activate() -> void:
	is_active = true
	sfx_sonar.play()
	
	dying_timer.connect("timeout", deactivate)
	dying_timer.start(active_time)
	
	animate_frames()
	
	if not Globals.monster: return
	Globals.monster.increase_speed()


func deactivate() -> void:
	dying_timer.stop()
	animate_frames("dying")
	await animation_completed
	
	queue_free()
	
	if not Globals.monster: return
	Globals.monster.decrease_speed()


func animate_frames(animation_name: String = "idle"):
	var frames: Array[Texture] = frames_idle
	var waiting_time: float = 0.1
	
	if animation_name != "idle":
		frames = frames_dying
		waiting_time = 0.05

	var frame_size: int = frames.size()
	for i in range(0,frame_size):
		self.texture = frames[i]
		await get_tree().create_timer(waiting_time).timeout
	
	animation_completed.emit()
