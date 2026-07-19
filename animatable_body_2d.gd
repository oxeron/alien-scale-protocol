extends "res://elements/platforms/falling_platform/falling_platform.gd"


func _ready() -> void:

	sync_to_physics = true
	if marker_a:
		global_position = marker_a.global_position
		if auto_start:
			activate()

func activate() -> void:
	if is_active:
		return

	is_active = true

	_move_to_next()
	
func _move_to_next() -> void:
	if not is_active:
		return

	var target: Vector2 = marker_b.global_position if not is_at_b else marker_a.global_position

	current_tween = create_tween()
	# Or player will slide above platform
	current_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	current_tween.set_trans(trans_type)
	current_tween.set_ease(ease_type)

	if pause_at_ends > 0.0:
		current_tween.tween_interval(pause_at_ends)

	current_tween.tween_property(self, "global_position", target, move_duration)
	current_tween.finished.connect(_on_move_finished)

func _on_move_finished() -> void:
	is_at_b = not is_at_b

	if loop and is_active:
		_move_to_next()
	else:
		is_active = false
