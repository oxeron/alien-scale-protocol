extends Area2D
@onready var up_door: AnimatedSprite2D = $up_door
@onready var down_door: AnimatedSprite2D = $down_door
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(_body: PhysicsBody2D) -> void:
	if GameState.key_taken == true : 
		up_door.play("open")
		down_door.play("open")
		GameState.door_is_open = true 
		
