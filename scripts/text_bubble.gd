extends Node2D

@export var messageText: String
@export var texture: Texture
#option to flip text bubble in case it would flow out of view
@export var flipped: bool = false

@onready var margin_container: MarginContainer = $NinePatchRect/MarginContainer
@onready var label: Label = $NinePatchRect/MarginContainer/Label
@onready var texture_rect: TextureRect = $NinePatchRect/MarginContainer/TextureRect


func _ready() -> void:
	if messageText:
		label.visible = true
		label.text = messageText
	else:
		texture_rect.visible = true
		texture_rect.texture = texture

	if flipped:
		self.scale.x *= -1
		margin_container.scale.x *= -1
		margin_container.position.x += label.get_minimum_size().x + 10

func _process(_delta: float) -> void:
	var marginSide = (margin_container.get_theme_constant("margin_left") 
	+ margin_container.get_theme_constant("margin_right"))

	if messageText:
		$NinePatchRect.size.x = label.size.x + marginSide
