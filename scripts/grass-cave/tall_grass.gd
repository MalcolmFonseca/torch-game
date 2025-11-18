extends Area2D

var grass_type: int
var burned: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
    self.body_entered.connect(_on_body_entered)

    #generate the grass with random animations
    grass_type = randi() % 2

    match grass_type:
        1:
            animated_sprite_2d.play("grass1")
        _:
            animated_sprite_2d.play("grass0")

func _on_body_entered(_body: Node2D) -> void:
    if !burned:
        #play burn animation
        animated_sprite_2d.play("burn0")
        #tuck burnt grass behind other objects
        self.z_index = 0
        #make sure you cant burn grass twice
        burned = true