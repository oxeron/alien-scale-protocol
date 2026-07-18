extends Node

signal energy_changed(value: int)

var retry_count: int = 0
var elapsed_time: float = 0.0
var energy : int = 0:
	set(value):
		energy = clamp(value, 0, 100)
		energy_changed.emit(energy)
	
func register_retry() -> void:
	energy = 0
	retry_count += 1
