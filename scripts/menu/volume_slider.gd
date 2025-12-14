extends HSlider

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export 
var bus_name: String

var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	# set the slider to the current set value
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))


func _on_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_drag_ended(_value_changed: bool) -> void:
	# play a sound effect when the user stops adjusting the slider if this is the sfx slider
	if(bus_name == "SFX"):
		match randi() % 3:
			2:
				audio_stream_player_2d.stream = preload("res://assets/grass-cave/sounds/Frog Sounds/Ribbit1.wav")
				# change volume to actual volume this sound plays at in it's home scene
				audio_stream_player_2d.volume_db = 3.0
			1:
				audio_stream_player_2d.stream = preload("res://assets/lava-cave/sounds/saw.wav")
				# change volume to actual volume this sound plays at in it's home scene
				audio_stream_player_2d.volume_db = -6.0
			_:
				audio_stream_player_2d.stream = preload("res://assets/lava-cave/sounds/Salamander_1.wav")
				audio_stream_player_2d.volume_db = 0
	audio_stream_player_2d.play()
