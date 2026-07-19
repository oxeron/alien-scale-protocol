extends BasePlatform

var activated: bool = false
var _is_player_on_top: bool = false

func _ready() -> void:
	activated = false
	_is_player_on_top = false

# Check if player is bigger than limit if alreay on top
func _physics_process(_delta: float) -> void:
	if not is_falling and _is_player_on_top:
		if GameState.player_scale > player_maximal_scale:
			is_falling = true
		
	super(_delta)
	
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	_is_player_on_top = true
	if GameState.player_scale > player_maximal_scale:
		is_falling = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	if not is_falling:
		_is_player_on_top = false
