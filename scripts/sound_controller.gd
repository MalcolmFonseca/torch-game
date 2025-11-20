extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func bg_music_play(song: String):
	match song:
		"frogpuzzle":
			audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/frogpuzzle.wav")
		_:
			#default song is frog song, by virtue of it being created first and need for base case
			audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/frogpuzzle.wav")
	audio_stream_player_2d.play()