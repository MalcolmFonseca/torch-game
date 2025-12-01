extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

var parent : Node

# This bool will essentially combines "hasKey" and "isCloseBy" essentially
# It should only be able to open when the player has the key and is in front of the door
var interactable : bool = false
var isColliding : bool = false
var hasKey : bool = false
var isOpen : bool = false

func _ready() -> void:
	parent = self.get_parent()

func _input(event):
	interactable = hasKey && isColliding
	if (event.is_action_pressed("Interact") && interactable):
		interact()


func interact():
	if(!isOpen):
		# Change sprite to open door
		animated_sprite_2d.play("open")
		# Disbale the collider if the door is open
		collision_shape_2d.disabled = true
		isOpen = true
		parent.open_gate()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	isColliding = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	isColliding = false
