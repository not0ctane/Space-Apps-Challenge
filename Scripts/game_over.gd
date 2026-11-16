extends Node

@onready var sound_game_over: AudioStreamPlayer = $soundGameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.stop()
	sound_game_over.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.


func _on_main_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	pass # Replace with function body.
