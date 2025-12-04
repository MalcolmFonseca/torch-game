extends Node2D

signal open_trapdoor

func _on_levercontroller_secret_entered() -> void:
	#check if all frogs hidden
	var children:Array = self.get_children()
	for child in children:
		if !child.covered:
			return
	
	#open trapdoor
	open_trapdoor.emit()