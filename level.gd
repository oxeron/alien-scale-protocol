extends Node2D

@onready var chrono: Label = $HUD/Chrono
@onready var retries: Label = $HUD/Retries
@onready var retry_button: TextureButton = $HUD/RetryButton
@onready var energy_progress_bar: TextureProgressBar = $HUD/EnergyProgressBar
@onready var end_game: NinePatchRect = $HUD/EndGame
@onready var end_game_label: Label = $HUD/EndGame/EndGameLabel
@onready var retry_marker: Marker2D = $RetryMarker
@onready var player: CharacterBody2D = $Player
@onready var animation_player: AnimationPlayer = $HUD/EnergyProgressBar/AnimationPlayer

var elapsed_time: float = 0.0
var is_chrono_running: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	elapsed_time = 0.0
	end_game.hide()
	update_retry_label()
	
	if not GameState.energy_changed.is_connected(_on_energy_changed):
		GameState.energy_changed.connect(_on_energy_changed)

	_on_energy_changed(GameState.energy)
	
	# Respawn at marker if not the first launch
	if GameState.retry_count > 0:
		player.global_position = retry_marker.global_position

func _physics_process(delta: float) -> void:
	if is_chrono_running:
		elapsed_time += delta
		update_time_label()

func update_time_label() -> void:
	@warning_ignore("integer_division")
	var minutes := int(elapsed_time) / 60
	var seconds := int(elapsed_time) % 60
	var milliseconds := int((elapsed_time - int(elapsed_time)) * 100)
	chrono.text = "%02d:%02d.%02d" % [minutes, seconds, milliseconds]

func update_engame_label() -> void:
	var minutes := int(elapsed_time) / 60
	var seconds := int(elapsed_time) % 60
	var milliseconds := int((elapsed_time - int(elapsed_time)) * 100)
	end_game_label.text = "TRAINING COMPLETED IN %02d:%02d.%02d 
 AND %s.
Excellent work, XR-01.
Access Key secured.
Exit reached.
Scale Protocol APPROVED." % [minutes, seconds, milliseconds, retries.text]

func _on_retry_button_pressed() -> void:
	GameState.register_retry()
	

func update_retry_label() -> void:
	retries.text = "%01d Retry" % [GameState.retry_count] if GameState.retry_count <= 1 else "%01d Retries" % [GameState.retry_count]

func _on_energy_changed(energy: int):
	energy_progress_bar.value = energy
	if energy == 0:
		animation_player.play("empty")
	else:
		animation_player.stop()

func _on_start_flag_body_entered(_body: Node2D) -> void:
	is_chrono_running = true


func _on_end_flag_body_entered(_body: Node2D) -> void:
	is_chrono_running = false
	end_game.show()
	get_tree().paused = true
	update_engame_label()
