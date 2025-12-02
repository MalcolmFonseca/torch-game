extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 120;
var velocity = Vector2(-1, 0) * SPEED
var spawn_position : Vector2

func _ready():
	# spawn at the passed in location
	global_position = spawn_position

func _physics_process(delta: float) -> void:
	# move the arrow
	translate(velocity * delta)

func _on_body_entered(body: Node2D) -> void:
	# delete the ice arrow from the scene
	if(body.name == "Player"):
		# call the change_scene function after all logic is complete in the main game loop
		call_deferred("change_scene")
	else:
		# if hitting the rock, stop the projectile and play the destroy animation
		velocity = Vector2(0, 0)
		animation_player.play("destroy")

# separated to use call_deferred ensuring the frame can be completed before changing scene
func change_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# after the destroy animation finishes, remove this node from the scene
	if(anim_name == "destroy"):
		queue_free()
