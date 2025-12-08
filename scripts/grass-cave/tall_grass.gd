extends Area2D

var grass_type: int
var burned: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var fire_light_asset: PackedScene = preload("res://scenes/grass-cave/firelight.tscn")
var fire_light: Node = null

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
        #create light along with the flame
        fire_light = fire_light_asset.instantiate()
        self.add_child(fire_light)
        #play burn animation
        animated_sprite_2d.play("burn0")
        #tuck burnt grass behind other objects
        self.z_index = 0
        #make sure you cant burn grass twice
        burned = true

        await get_tree().create_timer(.5).timeout
        fire_light.queue_free()