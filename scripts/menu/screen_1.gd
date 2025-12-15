extends Node2D

@onready var settings: Node2D = $"../Settings"

func _on_start_button_button_up() -> void:
	self.visible = false
	ButtonSfxTrigger.play();


func _on_options_button_button_up() -> void:
	self.visible = false
	settings.visible = true
	ButtonSfxTrigger.play();
