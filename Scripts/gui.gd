extends Control

@onready var start_button: Button = $buttons/startButton


var button_pressed = false
var game_started = false

signal moving_characters

func _ready() -> void:
	start_button.hide()
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if GlobalScript.start_game and GlobalScript.character_slots.size() == 4 and not game_started:
		start_button.show()
	else:
		start_button.hide()
	pass
	
func _on_start_button_button_down() -> void:
	game_started = true
	moving_characters.emit()
	pass # Replace with function body.
