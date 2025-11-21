extends Node2D

func _on_start_button_button_up() -> void:
	await get_tree().create_timer(.5).timeout
	self.visible = true

func _on_water_button_button_up() -> void:
	pass # Replace with function body.

func _on_fire_button_button_up() -> void:
	pass # Replace with function body.

func _on_grass_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/grass-cave/grass-cave.tscn")
