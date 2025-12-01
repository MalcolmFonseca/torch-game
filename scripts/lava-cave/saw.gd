extends Area2D

const SPEED = 180;
var velocity = Vector2(1, 0) * SPEED
var spawn_position : Vector2
var hasMoved = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# spawn at the passed in location
	global_position = spawn_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# move the saw
	translate(velocity * delta)


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		# change scene to game over
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	elif (hasMoved):
		# destroy the saw if it hits the rock
		queue_free()


func _on_body_exited(_body: Node2D) -> void:
	hasMoved = true
