extends BasePlatform

@export var extensible_multiplicator : int = 2

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var activated: bool = false
var _is_player_on_top: bool = false

func _ready() -> void:
	activated = false
	_is_player_on_top = false
	collision_shape_2d.shape = collision_shape_2d.shape.duplicate()

# Check if player is bigger than limit if alreay on top
func _physics_process(_delta: float) -> void:
	if not is_falling and _is_player_on_top:
		if GameState.player_scale > player_maximal_scale:
			is_falling = true
		
	super(_delta)
	
# Called when platform should extend
func activate() -> void:
	if activated:
		return
	
	activated = true
	
	sprite_2d.scale.x = extensible_multiplicator
	collision_shape_2d.shape.size.x *= extensible_multiplicator
	collision_shape_2d.position.x = collision_shape_2d.shape.size.x / extensible_multiplicator

	area_collision_shape_2d.shape.size.x *= extensible_multiplicator
	area_collision_shape_2d.position.x = collision_shape_2d.shape.size.x / extensible_multiplicator

func deactivate() -> void:
	if not activated:
		return
	
	activated = false
	
	sprite_2d.scale.x = 1
	collision_shape_2d.shape.size.x /= extensible_multiplicator
	collision_shape_2d.position.x = collision_shape_2d.shape.size.x / extensible_multiplicator

	area_collision_shape_2d.shape.size.x /= extensible_multiplicator
	area_collision_shape_2d.position.x = collision_shape_2d.shape.size.x / extensible_multiplicator
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	_is_player_on_top = true
	if GameState.player_scale > player_maximal_scale:
		is_falling = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	if not is_falling:
		_is_player_on_top = false
