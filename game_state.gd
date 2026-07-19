extends Node

signal energy_changed(value: int)

var retry_count: int = 0
var elapsed_time: float = 0.0
var energy : int = 100:
	set(value):
		energy = clamp(value, 0, 100)
		energy_changed.emit(energy)
var player_scale: float = 1.0:
	set(value):
		var previous_value = player_scale
		player_scale = clamp(value, 0.5, 2.0)
		# Consume energy only if player scale changed
		if player_scale != previous_value:
			GameState.energy -= 1
var key_taken = false 
var door_is_open = false

func register_retry() -> void:
	energy = 100
	retry_count += 1
	
