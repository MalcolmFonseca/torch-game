extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	match self.name:
        #use correct color frog
		"blue-frog":
			animated_sprite_2d.play("blue-idle")
		"red-frog":
			animated_sprite_2d.play("red-idle")
		"green-frog":
			animated_sprite_2d.play("green-idle")
		_:
			animated_sprite_2d.play("green-idle")

func _on_body_entered(body: Node2D) -> void:
	match self.name:
        #call the correct speech bubble
		"blue-frog":
			pass
		"red-frog":
			pass
		"green-frog":
			pass
		_:
			pass
