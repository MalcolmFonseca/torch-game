extends Area2D

var text_bubble_asset: PackedScene = preload("res://scenes/text_bubble.tscn")
var text_bubble: Node = null

# Will need a salamander sound effect -- maybe a hiss sound
#@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if (!text_bubble && body.name == "Player"):
		text_bubble = text_bubble_asset.instantiate()
		text_bubble.messageText = "A torch's glow brightens my day"
		add_child(text_bubble)

func _on_body_exited(body: Node2D) -> void:
	if (text_bubble):
		text_bubble.queue_free()
	text_bubble = null
