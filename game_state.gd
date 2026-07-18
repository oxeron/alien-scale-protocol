extends Node

var retry_count: int = 0
var elapsed_time: float = 0.0

func register_retry() -> void:
	retry_count += 1
