extends Node

signal energy_changed(value: int)

var retry_count: int = 0
var elapsed_time: float = 0.0
var energy : int = 0:
	set(value):
		var previous_energy = energy
		energy = clamp(value, 0, 100)

		if energy != previous_energy:
			energy_changed.emit(energy)
		
		if energy > previous_energy:
			audiostream_player.stream = preload("res://assets/Sounds/sfx_gem.ogg")
			audiostream_player.play()
			
var player_scale: float = 1.0:
	set(value):
		var previous_value = player_scale
		player_scale = clamp(value, 0.5, 2.0)
		# Consume energy only if player scale changed
		if player_scale != previous_value:
			GameState.energy -= 1
var key_taken = false:
	set(value):
		if value:
			audiostream_player.stream = preload("res://assets/Sounds/sfx_coin.ogg")
			audiostream_player.play()

var door_is_open = false

var audiostream_player = AudioStreamPlayer.new()

func register_retry() -> void:
	energy = 0
	retry_count += 1
	player_scale = 1.0
	
	audiostream_player.stream = preload("res://assets/Sounds/sfx_disappear.ogg")
	audiostream_player.play()
	
	get_tree().reload_current_scene()

func _ready() -> void:
	add_child(audiostream_player)
