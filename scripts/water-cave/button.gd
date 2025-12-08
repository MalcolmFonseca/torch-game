extends Area2D

@export var color: String

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var is_answer: bool = false

var rain_asset: PackedScene = preload("res://scenes/water-cave/rain.tscn")
var rain: Node = null

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

	if color == 'purple':
		animated_sprite_2d.play("purple_up")
	else:
		animated_sprite_2d.play("green_up")

func _on_body_entered(_body: Node2D) -> void:
	if color == 'purple':
		animated_sprite_2d.play("purple_down")
	else:
		animated_sprite_2d.play("green_down")
	
	audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/SwitchOn.wav")
	audio_stream_player_2d.play()

	if !is_answer:
		rain = rain_asset.instantiate()
		add_child(rain)
		SignalBus.kill_player.emit()