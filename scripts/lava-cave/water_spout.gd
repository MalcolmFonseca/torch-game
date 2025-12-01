extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# time between water spraying
const OFF_INTERVAL_SECONDS = 1.7
# duration of water spray
const ON_INTERVAL_SECONDS = 2
# slight hit box activation delay to match with animation timing
const HIT_BOX_DELAY_SECONDS = 0.3

# to track how much time has passed since the last operation
var time = 0
# prevents the animation from restarting on every loop
var animations_playing = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	time += delta
	
	# check if we should start to spray
	if(time > OFF_INTERVAL_SECONDS && !animations_playing):
		# play turn-on animation
		animation_player.play("spout-spray")
		# queue the looped spraying animation to play right after the turn-on animation finishes
		animation_player.queue("spray-loop")
		# prevent animation from restarting (blocks this conditional)
		animations_playing = true
		
	# Wait short delay before triggering the hit box because water animation needs to show the water first
	if(time > OFF_INTERVAL_SECONDS + HIT_BOX_DELAY_SECONDS):
		# activate collision
		collision_shape_2d.disabled = false
		
	# check if we should turn off the water spout
	if(time > OFF_INTERVAL_SECONDS + ON_INTERVAL_SECONDS):
		# stop the looping spray animation
		animation_player.stop()
		# play the turn-off animation
		animation_player.play("spray-off")
		# reset time so it can start after the OFF_INTERVAL_SECONDS duration again
		time = 0
		# allow entrance into the first conditional again
		animations_playing = false
		# deactivate collision
		collision_shape_2d.disabled = true

# triggers when the player enters the area, but ONLY when the water is visibly spraying
func _on_body_entered(body: Node2D) -> void:
	# if it's the player colliding -- game over
	if(body.name == "Player"):
		# change scene to game over
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
