extends Area2D

var is_open: bool = false
@export_file("*.tscn") var next_scene

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	if is_open:
		SoundController.bg_music_play("water_win")
		get_tree().change_scene_to_file(next_scene)

func open() -> void:
	if (!is_open):
		animated_sprite_2d.play("opening")
		is_open = true

func _on_button_body_entered(body: Node2D) -> void:
	open()
