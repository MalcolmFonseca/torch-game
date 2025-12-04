extends Area2D

@export var frog_color: String
var covered: bool = true #start covered by default

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var text_bubble_asset: PackedScene = preload("res://scenes/text_bubble.tscn")
var text_bubble: Node = null


func _ready() -> void:
	#connect signal to function
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

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
	#uncover frog
	covered = false
	if !text_bubble:
		match frog_color:
			#call the correct speech bubble
			"blue":
				text_bubble = text_bubble_asset.instantiate()
				text_bubble.messageText = "Don't touch the third lever..."
				add_child(text_bubble)
			"red":
				text_bubble = text_bubble_asset.instantiate()
				text_bubble.messageText = "The first lever is different from the last..."
				add_child(text_bubble)
			"green":
				text_bubble = text_bubble_asset.instantiate()
				text_bubble.messageText = "Flip as many levers as there are frogs..."
				#regular bubble spills out of frame
				text_bubble.flipped = true
				add_child(text_bubble)
			_:
				print("no matching color")

func _on_body_exited(_body: Node2D) -> void:
	if text_bubble:
		text_bubble.queue_free()
	text_bubble = null