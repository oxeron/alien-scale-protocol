extends BasePlatform


@export var extensible_length : int 

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var activated: bool = false

func _ready() -> void:
	collision_shape_2d.shape = collision_shape_2d.shape.duplicate()
	
# Called when platform should extend
func activate() -> void:
	if activated:
		return
	
	activated = true
	sprite_2d.scale.x = 2
	collision_shape_2d.shape.size.x *= 2
	collision_shape_2d.position.x = collision_shape_2d.shape.size.x / 2

func deactivate() -> void:
	if not activated:
		return
		
	sprite_2d.scale.x = 1
	collision_shape_2d.shape.size.x /= 2
	collision_shape_2d.position.x = collision_shape_2d.shape.size.x * 2


func _on_area_2d_body_entered(body: Node2D) -> void:
	if GameState.player_scale > player_maximal_scale:
		is_falling = true
