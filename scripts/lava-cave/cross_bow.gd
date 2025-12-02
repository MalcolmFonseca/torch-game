extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var main = self.get_parent()
@onready var projectile = load("res://scenes/lava-cave/lava_glob.tscn")

# add animation to shoot function
func shoot():
	# play animation
	animated_sprite_2d.play("shoot")
	# get an instance of the projectile scene
	var instance = projectile.instantiate()
	# set the spawn location of the projectile to be the position of the crossbow shooting
	instance.spawn_position = global_position
	# add the projectile to the scene
	main.add_child.call_deferred(instance)
