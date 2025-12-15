extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

# the text bubble scene to be instantiated
var text_bubble_asset: PackedScene = preload("res://scenes/text_bubble.tscn")
var text_bubble: Node = null

# the Sprite2D node for the 
var key_symbol : Sprite2D = null
# the key.png to be used for the sprite texture
var key_texture = preload("res://assets/lava-cave/key.png")
# the offset required to move the key from the center of the door on top of the text bubble
var key_symbol_offset = Vector2(24, -24)

var parent : Node

# It should only be able to open when the player has the key and is colliding with the area
var interactable : bool = false
var isColliding : bool = false
var hasKey : bool = false

# once the door opens, it stays open
var isOpen : bool = false

var interact_hint_asset: PackedScene = preload("res://scenes/interact_hint.tscn")
var interact_hint: Node = null

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
		# this opens the fire_door through the controller within the lava_scene
		parent.open_gate()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	# if the player still needs to find the key, show a text bubble on the door displaying the key
	if(!hasKey):
		# load the text bubble asset
		text_bubble = text_bubble_asset.instantiate()
		# create a new sprite2D for the key
		key_symbol = Sprite2D.new()
		# add the key to the as the texture
		key_symbol.texture = key_texture
		# move the key sprite to place overtop of the text bubble
		key_symbol.offset = key_symbol_offset
		# add the key as a child to the speech bubble
		text_bubble.add_child(key_symbol)
		# add the text bubble with the key as a child to the scene
		add_child(text_bubble)
	else: #if has key, show button to press
		interact_hint = interact_hint_asset.instantiate()
		add_child(interact_hint)
	isColliding = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	# if the text bubble is visible, remove it from the scene
	if text_bubble:
		text_bubble.queue_free()
	text_bubble = null

	if interact_hint:
		interact_hint.queue_free()
	interact_hint = null
	
	isColliding = false
