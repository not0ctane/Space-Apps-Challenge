extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.stop()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_down() -> void:
	GlobalScript.reset_game()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	get_tree().quit()
	pass # Replace with function body.
