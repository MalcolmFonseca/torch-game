extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func open_door():
	animated_sprite_2d.play("Opening")

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		print("Winner, Gagnant")
