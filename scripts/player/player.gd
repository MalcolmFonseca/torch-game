extends CharacterBody2D

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var game_time: Timer = $Timer
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
var isDead = false; 

const SPEED = 300.0
const ACCELERATION = 25;


# default is 60 physics ticks / second
func _physics_process(delta: float) -> void:
	
	var curr_time = game_time.time_left
	point_light_2d.energy = curr_time/20 + 0.5
	
	# Get the horizontal input direction and handle the acceleration/deceleration.
	var xDirection := Input.get_axis("ui_left", "ui_right")
	if (xDirection && !isDead):
		velocity.x = move_toward(velocity.x, SPEED * xDirection, ACCELERATION)
		player_sprite.flip_h = xDirection < 0
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		
	# Get the vertical input direction and handle the acceleration/deceleration.
	var	yDirection := Input.get_axis("ui_up", "ui_down")
	if (yDirection && !isDead):
		velocity.y = move_toward(velocity.y, SPEED * yDirection, ACCELERATION)
	else:
		velocity.y = move_toward(velocity.y, 0, ACCELERATION)

	move_and_slide()
	animation_selection()
	
	
func animation_selection():
	
	# Stop calling "play()" if isDead to prevent the death animation from looping
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
	
	# determine flame state
	if(curr_time > 10):
		result += "bright"
	elif (curr_time > 5):
		result += "medium"
	elif (curr_time > 0):
		result += "dim"
	else:
		result = "dead"

		
	# set animation based on player/time state
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
			isDead = true
		_:
			player_sprite.play("idle")
