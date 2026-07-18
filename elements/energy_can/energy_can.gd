extends Area2D

@export var energy : int = 10

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		GameState.energy += energy
		queue_free()
