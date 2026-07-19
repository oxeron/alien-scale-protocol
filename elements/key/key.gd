extends Area2D
@onready var key: Area2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var keytaken = false 

func _on_body_entered(body: PhysicsBody2D) -> void:
	if keytaken ==false : 
		keytaken = true 
		GameState.key_taken = true 
		print ("cles récupérée")
		animated_sprite_2d.queue_free()
		collision_shape_2d.queue_free()
		
