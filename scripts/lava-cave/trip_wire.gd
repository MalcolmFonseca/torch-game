extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var main = self.get_parent()
@onready var projectile = load("res://scenes/lava-cave/saw.tscn")

var hasSoundPlayed : bool = false

func _on_body_entered(body: Node2D) -> void:
	# Don't react to the signal if the wire has already snapped
	# (prevents double saw/sound when player doubles back as the wire cannot be deleted from the scene until the sound finishes
	if(body.name == "Player" && !hasSoundPlayed):
		# spawn saw
		spawn_saw()
		# play snap sound
		audio_stream_player_2d.play()
		# hide tripwire
		sprite_2d.visible = false
		# prevent the sound from playing again if the player doubles back before the tripwire leaves the scene
		hasSoundPlayed = true
	# trip wire get's deleted from sound player listener on_finished() below


# add animation to shoot function
func spawn_saw():
	# get an instance of the projectile scene
	var instance = projectile.instantiate()
	# set the spawn location of the projectile to be the position of the crossbow shooting
	instance.spawn_position = Vector2(global_position.x - 40, global_position.y - 35) 
	# add the projectile to the scene
	main.add_child.call_deferred(instance)


func _on_audio_stream_player_2d_finished() -> void:
	# destroy the trip-wire after the sound plays
	queue_free()
