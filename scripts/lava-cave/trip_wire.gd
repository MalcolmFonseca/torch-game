extends Area2D

@onready var main = self.get_parent()
@onready var projectile = load("res://scenes/lava-cave/saw.tscn")


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		# spawn saw
		spawn_saw()
		# play snap sound
		print("Snap sound!")
		# destroy the trip-wire
		queue_free()
		
# add animation to shoot function
func spawn_saw():
	# get an instance of the projectile scene
	var instance = projectile.instantiate()
	# set the spawn location of the projectile to be the position of the crossbow shooting
	instance.spawn_position = Vector2(global_position.x - 40, global_position.y - 35) 
	# add the projectile to the scene
	main.add_child.call_deferred(instance)
