extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 180;
var velocity = Vector2(1, 0) * SPEED
var spawn_position : Vector2
var hasMoved = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# spawn at the passed in location
	global_position = spawn_position
	audio_stream_player_2d.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# move the saw
	translate(velocity * delta)


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		# change scene to game over
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	elif (hasMoved):
		# destroy the saw if it hits the rock
		animated_sprite_2d.visible = false


func _on_body_exited(_body: Node2D) -> void:
	hasMoved = true


func _on_audio_stream_player_2d_finished() -> void:
	# delete the saw from the scene after the sound finishes
	queue_free()
