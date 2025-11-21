extends Button

func _on_button_up() -> void:
	#switch to main menu music
	#SoundController.bg_music_play()
	get_tree().change_scene_to_file("res://scenes/menu/start_screen.tscn")
