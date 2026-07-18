extends Node

signal energy_changed(value: int)

var retry_count: int = 0
var elapsed_time: float = 0.0
var energy : int = 0:
	set(value):
		energy = clamp(value, 0, 100)
		energy_changed.emit(energy)
var player_scale: float = 1.0:
	set(value):
		player_scale = clamp(value, 0.1, 2.0)


func register_retry() -> void:
	energy = 0
	retry_count += 1
