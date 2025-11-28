extends Area2D

@export var color:String

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

	if color == 'purple':
		animated_sprite_2d.play("purple_up")
	else:
		animated_sprite_2d.play("green_up")

func _on_body_entered(_body: Node2D) -> void:
	if color == 'purple':
		animated_sprite_2d.play("purple_down")
	else:
		animated_sprite_2d.play("green_down")