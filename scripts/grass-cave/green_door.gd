extends Area2D

var is_open: bool = false
@export_file("*.tscn") var next_scene

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
    self.body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
    if is_open:
        get_tree().change_scene_to_file(next_scene)
        SoundController.bg_music_play("frog-win")

func open() -> void:
    if (!is_open):
        animated_sprite_2d.play("opening")
        is_open = true