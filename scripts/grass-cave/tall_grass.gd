extends Area2D

@export var grass_type: int
var burned: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
    match grass_type:
        1:
            animated_sprite_2d.play("grass1")
        _:
            animated_sprite_2d.play("grass0")

func _on_body_entered(_body: Node2D) -> void:
    if !burned:
        #play burn animation
        animated_sprite_2d.play("burn0")
        #make sure you cant burn grass twice
        burned = true