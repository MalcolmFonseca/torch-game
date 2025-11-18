extends Area2D

var is_open: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(_body: Node2D) -> void:
    if is_open:
        #send player to end screen
        pass

func open() -> void:
    if (!is_open):
        animated_sprite_2d.play("opening")
        is_open = true