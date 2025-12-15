extends Node2D

@onready var cave_background: AnimatedSprite2D = $CaveBackground
@onready var screen_1: Node2D = $Screen1
@onready var screen_2: Node2D = $Screen2

# Used to control if the player should land on Screen1 vs Screen2 (after game over, auto load to Screen2)
func _ready():
	SoundController.bg_music_play("menu-theme")
	if(CompletionTracker.has_passed_menu):
		screen_1.visible = false
		screen_2.visible = true
		cave_background.visible = false

# transition to cave selection
func _on_start_button_button_up() -> void:
	cave_background.play("into_cave")
	ButtonSfxTrigger.play();
	CompletionTracker.has_passed_menu = true

# Tied to the back button on Screen2 -- switch back to main menu
func _on_back_button_button_up() -> void:
	screen_1.visible = true
	screen_2.visible = false
	# Reset the cave sprite, as after it's played initially the cave is left on it's last (blank) frame
	cave_background.play("default")
	cave_background.visible = true
