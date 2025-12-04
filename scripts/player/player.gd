extends CharacterBody2D


@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var game_time: Timer = $Timer
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
var isDead = false; 


const SPEED = 150.0
const ACCELERATION = SPEED;

func _ready() -> void:
	#so that other objects can kill player through signal bus
	SignalBus.kill_player.connect(_on_kill_player)

# default is 60 physics ticks / second
func _physics_process(_delta: float) -> void:
	
	# used to dim the light as time runs out, sets the light energy based on the remaining time
	var curr_time = game_time.time_left
	point_light_2d.energy = curr_time/25 + 0.2
	
	
	# want the modulate value to start around 0.5 and take 20 seconds to get to 1
	
	# reverse of the dim light, the self modulate should start dim and get brighter to not burn your eyes at the start of the scene
	var denominator = max(curr_time/10, 1) # don't want the denominator to fall below 1
	var modulate_value = 0.8/denominator
	
	# in progress.. idrk what this will be yet. Might be able to have the light not apply to the player sprite? Can test some options to see what looks right later
	if (curr_time > 10):
		player_sprite.self_modulate = Color(0.7, 0.7, 0.7)
	else:
		player_sprite.self_modulate = Color(modulate_value, modulate_value, modulate_value)
	
	# Get the horizontal input direction and handle the acceleration/deceleration.
	var x_direction := Input.get_axis("ui_left", "ui_right")
	if (x_direction && !isDead):
		velocity.x = move_toward(velocity.x, SPEED * x_direction, ACCELERATION)
		player_sprite.flip_h = x_direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		
	# Get the vertical input direction and handle the acceleration/deceleration.
	var	y_direction := Input.get_axis("ui_up", "ui_down")
	if (y_direction && !isDead):
		velocity.y = move_toward(velocity.y, SPEED * y_direction, ACCELERATION)
	else:
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)
		
	# normalize velocity to prevent speed inconsistency while traveling diagonally
	velocity = velocity.normalized() * SPEED

	# built in method to perform movement
	move_and_slide()
	
	# func uses time left and velocity to determine the correct animation to play 
	animation_selection()
	
	
func animation_selection():
	
	# Stop calling "player_sprite.play()" if isDead to prevent the death animation from looping
	if(isDead):
		return
	
	# current values:
		# if speed > 0 : walking animation
		# if time_left > 10 : bright
		# if 10 > time_left > 5 : medium
		# if 5 > time_left > 0 : dim
		# if time_left <= 0 : dead 
	
	var curr_time = game_time.time_left
	var result = ""
	
	# determine movement state
	if(velocity.length() != 0):
		result += "walk-"
	else:
		result += "idle-"
	
	# determine flame brightness state
	if(curr_time > 10):    # 10+ seconds remaining
		result += "bright"
	elif (curr_time > 5):  # 5-10 seconds remaining
		result += "medium"
	elif (curr_time > 0):  # 0-5 seconds remaining
		result += "dim"
	else:
		result = "dead"

	# set animation based on player velocity and time-left
	match result:
		"walk-bright":
			player_sprite.play("bright-walk")
		"idle-bright":
			player_sprite.play("idle")
		"walk-medium":
			player_sprite.play("medium-walk")
		"idle-medium":
			player_sprite.play("medium-idle")
		"walk-dim":
			player_sprite.play("dim-walk")
		"idle-dim":
			player_sprite.play("dim-idle")
		"dead":
			player_sprite.play("death")
			# set isDead to true to block this function execution, preventing death animation loop
			isDead = true
		_:
			player_sprite.play("idle")

# only runs on death animation as that's the only animation that doesn't loop for this sprite
func _on_animated_sprite_2d_animation_finished() -> void:
	# change scene to game over after the player dies
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_kill_player() -> void:
	#stop the timer, setting the time left to 0 and killing the player
	#using this system to prevent animation breaks
	game_time.stop()
