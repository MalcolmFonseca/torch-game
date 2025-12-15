extends Area2D

var flipped: bool = false
var interactable: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var level_controller: Node

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var interact_hint_asset: PackedScene = preload("res://scenes/interact_hint.tscn")
var interact_hint: Node = null

func _ready() -> void:
	#connect signal to function
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	
	level_controller = self.get_parent()

func _input(event):
	if event.is_action_pressed("Interact") && interactable:
		interact()

func interact() -> void:
	flipped = !flipped

	match flipped:
		true:
			animated_sprite_2d.play("down")
			audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/SwitchOn.wav")
			audio_stream_player_2d.play()
		false:
			animated_sprite_2d.play("up")
			audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/SwitchOff.wav")
			audio_stream_player_2d.play()
	
	level_controller.call("check")

func state() -> bool:
	return flipped

#keep track if player overlap
func _on_body_entered(_body: Node2D) -> void:
	interactable = true
	interact_hint = interact_hint_asset.instantiate()
	add_child(interact_hint)

func _on_body_exited(_body: Node2D) -> void:
	interactable = false
	if interact_hint:
		interact_hint.queue_free()
	interact_hint = null
