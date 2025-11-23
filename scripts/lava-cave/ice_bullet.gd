extends Area2D

const SPEED = 100;
var velocity = Vector2(-1, 0) * SPEED
var spawn_position : Vector2 

# Can change to an animated_sprite_2d
# in _on_body_entered stop the translation, play the animation
# in _animation_finished call self.queue_free()

func _ready():
	# spawn at the passed in location
	global_position = spawn_position

func _physics_process(delta: float) -> void:
	# move the arrow
	translate(velocity * delta)

func _on_body_entered(body: Node2D) -> void:
	# delete the ice arrow from the scene
	queue_free()
	if(body.name == "Player"):
		# change scene to game over
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
