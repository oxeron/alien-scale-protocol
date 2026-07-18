@tool
extends Area2D

@export var off_state_texture : Texture2D
@export var on_state_texture : Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = off_state_texture

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		sprite_2d.texture = on_state_texture


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		sprite_2d.texture = off_state_texture
