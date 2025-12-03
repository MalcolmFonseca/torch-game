extends Node2D

var text_bubble_asset: PackedScene = preload("res://scenes/text_bubble.tscn")
var text_bubble: Node = null

var speech_index: int = 0
var dialogue: Array[String] = ["Hurry up!","Come on slowpoke!","Faster!","With frogs hidden, new doors open..."]

@onready var timer: Timer = $Timer

func _ready():
	timer.timeout.connect(_on_timeout)

	#say opening line
	text_bubble = text_bubble_asset.instantiate()
	text_bubble.messageText = "Follow me!"
	add_child(text_bubble)

func speak() -> void:
	#only make the text bubble if it wont cause an array out of bounds error
	if speech_index < dialogue.size():
		text_bubble = text_bubble_asset.instantiate()
		text_bubble.messageText = dialogue[speech_index]
		add_child(text_bubble)
		speech_index += 1

func deleteBubble() -> void:
	if text_bubble:
		text_bubble.queue_free()
	text_bubble = null

func _on_timeout() -> void:
	#delete a text bubble if it exists
	deleteBubble()
	#say next line
	speak()
