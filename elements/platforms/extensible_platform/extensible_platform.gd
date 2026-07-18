extends AnimatableBody2D


@export var extensible_length : int 

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when platform should extend
func activate() -> void:
	sprite_2d.scale.x = 2

func deactivate() -> void:
	sprite_2d.scale.x = 1
