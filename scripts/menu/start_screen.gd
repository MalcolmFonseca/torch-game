extends Node2D

@onready var cave_background: AnimatedSprite2D = $CaveBackground


func _on_start_button_button_up() -> void:
	cave_background.play("into_cave")
