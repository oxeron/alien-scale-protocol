extends "res://elements/platforms/falling_platform/falling_platform.gd"

@export var marker_a: Marker2D
@export var marker_b: Marker2D
#@export var move_duration: float = 1.5
@export var speed: float = 100.0  # pixels/seconde, remplace move_duration
@export var trans_type: Tween.TransitionType = Tween.TRANS_SINE
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT
# Should platform loop or only one travel ?
@export var loop: bool = true
# pause at each marker
@export var pause_at_ends: float = 0.0  
# activate without button
@export var auto_start: bool = true

var is_at_b: bool = false
var is_active: bool = false
var current_tween: Tween
var pause_timer: float = 0.0
var target_position: Vector2

func _ready() -> void:
	super()
	
	sync_to_physics = true
	
	global_position = marker_a.global_position
	if auto_start:
		activate()
		
	

func activate() -> void:
	if is_active:
		return

	is_active = true
	
	target_position = marker_b.global_position if not is_at_b else marker_a.global_position
	
	#_move_to_next()

func deactivate() -> void:
	is_active = false
	if current_tween:
		current_tween.kill()

func _physics_process(delta: float) -> void:
	super(delta)
	
	if not is_active:
		return

	if pause_timer > 0.0:
		pause_timer -= delta
		return

	global_position = global_position.move_toward(target_position, speed * delta)

	if global_position.distance_to(target_position) < 0.5:
		is_at_b = not is_at_b
		if loop:
			pause_timer = pause_at_ends
			target_position = marker_b.global_position if is_at_b else marker_a.global_position
		else:
			is_active = false
			
#func _move_to_next() -> void:
	#if not is_active:
		#return
#
	#var target: Vector2 = marker_b.global_position if not is_at_b else marker_a.global_position
#
	#current_tween = create_tween()
	## Or player will slide above platform
	#current_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	#current_tween.set_trans(trans_type)
	#current_tween.set_ease(ease_type)
#
	#if pause_at_ends > 0.0:
		#current_tween.tween_interval(pause_at_ends)
#
	#current_tween.tween_property(self, "global_position", target, move_duration)
	#current_tween.finished.connect(_on_move_finished)
#
#func _on_move_finished() -> void:
	#is_at_b = not is_at_b
#
	#if loop and is_active:
		#_move_to_next()
	#else:
		#is_active = false
