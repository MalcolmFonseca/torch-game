extends Area2D

var key_door_controller : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get a reference to the controller
	key_door_controller = self.get_parent()

# when the player grabs the key, remove the key from the scene and allow the door to open
func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		key_door_controller.grab_key()
		queue_free()
