extends Node

var puzzle_answer:Array = [true, true, false, true, false]

func check() -> void:
	#grab levers + door
	var children:Array = self.get_children()

	var player_attempt: Array = []

	for child in children:
		if (child.name != "green-door"):
			player_attempt.append(child.call("state"))
	
	if (player_attempt == puzzle_answer):
		open_door()

func open_door() -> void:
	var door:Area2D = self.get_child(0)

	door.call("open")
