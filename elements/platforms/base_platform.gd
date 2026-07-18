class_name BasePlatform
extends AnimatableBody2D

## Max value of player scale before platform collapses
@export var player_maximal_scale : float = 1.0

var fall_velocity: float = 0.0
var is_falling: bool = false

func start_falling() -> void:
	is_falling = true

func _physics_process(delta: float) -> void:
	if is_falling:
		fall_velocity += get_gravity().y * delta
		position.y += fall_velocity * delta
