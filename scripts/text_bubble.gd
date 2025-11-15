extends Node2D

@export var messageText: String
@export var texture: Texture

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

func _process(delta: float) -> void:
    var marginSide = (margin_container.get_theme_constant("margin_left") 
    + margin_container.get_theme_constant("margin_right"))

    if messageText:
        $NinePatchRect.size.x = label.size.x + marginSide