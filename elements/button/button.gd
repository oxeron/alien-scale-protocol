@tool
extends Area2D

@export var off_state_texture : Texture2D
@export var on_state_texture : Texture2D
@export var target : Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = off_state_texture

func _on_body_entered(_body: Node2D) -> void:
	sprite_2d.texture = on_state_texture
	if target:
		if target.has_method("activate"):
			target.activate()

func _on_body_exited(_body: Node2D) -> void:
	sprite_2d.texture = off_state_texture
	if target:
		if target.has_method("deactivate"):
			target.deactivate()
