extends Node2D

@onready var screen_1: Node2D = $"../Screen1"

func _on_back_button_button_up() -> void:
	self.visible = false
	screen_1.visible = true
