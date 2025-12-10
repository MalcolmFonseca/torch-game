extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func bg_music_play(song: String):
	match song:
		"frogpuzzle":
			audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/frog_puzzle.wav")
		"frog-win":
			audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/frog_win.wav")
		"water_cave_theme":
			audio_stream_player_2d.stream = preload("res://assets/water-cave/Sounds/water_cave_theme.wav")
		"water_win":
			audio_stream_player_2d.stream = preload("res://assets/water-cave/Sounds/water_win.wav")
		"menu-theme":
			audio_stream_player_2d.stream = preload("res://assets/menu/sounds/torch_menu.wav")
		"lava-puzzle":
			audio_stream_player_2d.stream = preload("res://assets/lava-cave/sounds/Lava_Cave_Music.wav")
		"lava-win":
			audio_stream_player_2d.stream = preload("res://assets/lava-cave/sounds/Lava_Win.wav")
		_:
			#default song is frog puzzle song, by virtue of it being created first and need for base case
			audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/frog_puzzle.wav")
	audio_stream_player_2d.play()
