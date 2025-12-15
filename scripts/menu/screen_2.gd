extends Node2D

# cave completion indicator sprite references
@onready var water_indicator_sprite_2d: Sprite2D = $WaterButton/Sprite2D
@onready var grass_indicator_sprite_2d: Sprite2D = $GrassButton/Sprite2D
@onready var fire_indicator_sprite_2d: Sprite2D = $FireButton/Sprite2D

func _ready() -> void:
	# set cave completion indicators
	water_indicator_sprite_2d.visible = CompletionTracker.blue_cave_is_completed	
	grass_indicator_sprite_2d.visible = CompletionTracker.green_cave_is_completed
	fire_indicator_sprite_2d.visible = CompletionTracker.red_cave_is_completed

func _on_start_button_button_up() -> void:
	ButtonSfxTrigger.play();
	await get_tree().create_timer(.5).timeout
	self.visible = true
	
	

func _on_water_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/water-cave/water-cave.tscn")

func _on_fire_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/lava-cave/lava-cave.tscn")

func _on_grass_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/grass-cave/grass-cave.tscn")
