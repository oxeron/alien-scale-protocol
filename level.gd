extends Node2D

@onready var chrono: Label = $HUD/Chrono
@onready var retries: Label = $HUD/Retries
@onready var retry_button: TextureButton = $HUD/RetryButton

var elapsed_time: float = 0.0
var is_chrono_running: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	elapsed_time = 0.0
	update_retry_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
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


func _on_retry_button_pressed() -> void:
	print(GameState.retry_count)
	GameState.register_retry()
	get_tree().reload_current_scene()
	print(GameState.retry_count)
	

func update_retry_label() -> void:
	retries.text = "%02d Retry" % [GameState.retry_count] if GameState.retry_count <= 1 else "%02d Retries" % [GameState.retry_count]
