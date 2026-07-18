@tool
extends Area2D

@export var off_state_texture : Texture2D
@export var on_state_texture : Texture2D
@export var target : Node2D

@export var keep_pressed : bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D

var _is_pressed : bool = false

func _ready() -> void:
	sprite_2d.texture = off_state_texture

func _on_body_entered(_body: Node2D) -> void:
	if not keep_pressed and _is_pressed:
		return
		
	sprite_2d.texture = on_state_texture
	if target:
		if target.has_method("activate"):
			target.activate()
			_is_pressed = true
			
func _on_body_exited(_body: Node2D) -> void:
	if not keep_pressed and _is_pressed:
		return
	
	sprite_2d.texture = off_state_texture
	
	if target:
		if target.has_method("deactivate"):
			target.deactivate()
