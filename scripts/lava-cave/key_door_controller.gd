extends Node

var children = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get a reference to all crossbows
	for child in self.get_children():
		children.append(child)

# called from key.gd on key collision
func grab_key() -> void:
	for child in children:
		if(child.name == "BlockingGate"):
			child.hasKey = true

func open_gate() -> void:
	for child in children:
		if(child && child.name == "FireDoor"):
			child.open_door()
