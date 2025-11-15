extends Area2D

@export var frog_color: String

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var text_bubble_asset: Resource = preload("res://scenes/text_bubble.tscn")
var text_bubble: Node = null


func _ready() -> void:
	match frog_color:
		#use correct color frog
		"blue":
			animated_sprite_2d.play("blue-idle")
		"red":
			animated_sprite_2d.play("red-idle")
		"green":
			animated_sprite_2d.play("green-idle")
		_:
			animated_sprite_2d.play("green-idle")

func _on_body_entered(_body: Node2D) -> void:
	if !text_bubble:
		match self.name:
			#call the correct speech bubble
			"blue-frog":
				text_bubble = text_bubble_asset.instantiate()
				text_bubble.messageText = "blue"
			"red-frog":
				text_bubble = text_bubble_asset.instantiate()
				text_bubble.messageText = "red"
			"green-frog":
				text_bubble = text_bubble_asset.instantiate()
				text_bubble.messageText = "green"
			_:
				text_bubble = text_bubble_asset.instantiate()
				text_bubble.messageText = "green"

func _on_body_exited(_body: Node2D) -> void:
	if !text_bubble:
		text_bubble.queue_free()
	text_bubble = null