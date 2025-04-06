extends Button

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var long: AnimatedSprite2D = $Long

func _ready() -> void:
	await get_tree().create_timer(randf_range(0.0, 0.3)).timeout
	animated_sprite_2d.play("default")
	long.play("default")
