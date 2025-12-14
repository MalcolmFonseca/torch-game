extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func open_door():
	animated_sprite_2d.play("Opening")
	#audio_stream_player_2d.play()

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		# change scene to fire end screen
		get_tree().change_scene_to_file("res://scenes/lava-cave/lava_end_screen.tscn")
