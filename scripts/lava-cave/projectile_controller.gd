extends Node

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const SHOOTING_INTERVAL_SECONDS = 1.6

var time = 0
var crossbows = []
var current_crossbow_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get a reference to all crossbows
	for crossbow in self.get_children():
		# don't append the audio stream player, only crossbow scenes
		if(crossbow.name.begins_with("CrossBow")):
			crossbows.append(crossbow)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	time += delta
	
	# wait INTERVAL_SECONDS before shooting next crossbow
	if(time > SHOOTING_INTERVAL_SECONDS):
		
		# pew sfx
		audio_stream_player_2d.play()
		
		# fire all crossbows at once
		while(current_crossbow_index != crossbows.size()):
			# get the current crossbow and shoot
			var crossbow = crossbows[current_crossbow_index]
			crossbow.shoot()
			# increment for next crossbow
			current_crossbow_index += 1
			
		current_crossbow_index = 0
		time = 0
		
		
		## get the current crossbow and shoot
		#var crossbow = crossbows[current_crossbow_index]
		#crossbow.shoot()
		## select next crossbow to shoot
		#if(current_crossbow_index != crossbows.size() - 1):
			#current_crossbow_index += 1
		#else:
			#current_crossbow_index = 0
		#
		## reset time to 0 for next interval
		#time = 0
