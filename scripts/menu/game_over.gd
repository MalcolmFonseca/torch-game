extends Button


func _on_button_up() -> void:
	# load main menu screen (lava-cave.tscn as place holder)
	get_tree().change_scene_to_file("res://scenes/menu/start_screen.tscn")
