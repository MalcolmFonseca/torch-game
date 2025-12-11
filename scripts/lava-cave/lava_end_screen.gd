extends Node2D


func _ready():
	# set main menu completion indicator
	CompletionTracker.red_cave_is_completed = true
	# play red victory music
	SoundController.bg_music_play("lava-win")
