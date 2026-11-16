extends Node2D

#Labels
@onready var main_monitor_label: Label = $"../GUI/labels/mainMonitorLabel"

#Characters
@onready var apollo: AnimatedSprite2D = $Apollo
@onready var christina: AnimatedSprite2D = $Christina
@onready var mercury: AnimatedSprite2D = $Mercury
@onready var frank: AnimatedSprite2D = $Frank

@onready var button_apollo: Button = $Apollo/Button
@onready var chris_button: Button = $Christina/chrisButton
@onready var mercury_button: Button = $Mercury/mercuryButton
@onready var frank_button: Button = $Frank/frankButton



#dragCharacter
var drag = false
var offset = Vector2.ZERO

var moving_charactersAnim = false

func _process(delta: float) -> void:
	
	apollo.scale = Vector2(6, 6) if GlobalScript.apolloSelected else Vector2(4, 4)
	christina.scale = Vector2(6, 6) if GlobalScript.chrisSelected else Vector2(4, 4)
	mercury.scale = Vector2(6, 6) if GlobalScript.mercurySelected else Vector2(4, 4)
	frank.scale = Vector2(6, 6) if GlobalScript.frankSelected else Vector2(4, 4)

	if GlobalScript.apolloSelected:
		main_monitor_label.text = "APOLLO"
	elif GlobalScript.chrisSelected:
		main_monitor_label.text = "CHRISTINA"
	elif GlobalScript.mercurySelected:
		main_monitor_label.text = "MERCURY"
	elif GlobalScript.frankSelected:
		main_monitor_label.text = "FRANK"
	else:
		main_monitor_label.text = "BEGIN YOUR DAY!"
		
	#ANIMATIONS
	if moving_charactersAnim:
		for c in [apollo, mercury, christina, frank]:
			c.play("movingLeft")
	else:
		apollo.play("moving" if GlobalScript.apolloSelected else "idle")
		christina.play("moving" if GlobalScript.chrisSelected else "idle")
		mercury.play("moving" if GlobalScript.mercurySelected else "idle")
		frank.play("moving" if GlobalScript.frankSelected else "idle")
	

#APOLLO FUNCTIONS -------------------------------------
func _on_apollo_area_mouse_entered() -> void:
	GlobalScript.apolloSelected = true
	pass # Replace with function body.
	
func _on_apollo_area_mouse_exited() -> void:
	GlobalScript.apolloSelected = false
	pass # Replace with function body.
	
#CHRISTINA FUNCTIONS -------------------------------------
func _on_chris_area_mouse_entered() -> void:
	GlobalScript.chrisSelected = true
	pass # Replace with function body.
	
func _on_chris_area_mouse_exited() -> void:
	GlobalScript.chrisSelected = false
	pass # Replace with function body.
	
#MERCURY FUNCTIONS -------------------------------------

func _on_mercury_area_mouse_entered() -> void:
	GlobalScript.mercurySelected = true
	pass # Replace with function body.
	
func _on_mercury_area_mouse_exited() -> void:
	GlobalScript.mercurySelected = false
	pass # Replace with function body.
	
#FRANK FUNCTIONS -------------------------------------

func _on_frank_area_mouse_entered() -> void:
	GlobalScript.frankSelected = true
	pass # Replace with function body.
	

func _on_frank_area_mouse_exited() -> void:
	GlobalScript.frankSelected = false
	pass # Replace with function body.

func _on_gui_moving_characters() -> void:
	moving_charactersAnim = true
	GlobalScript.game_running = true #INICIA EL JUEGO COMO TAL
	button_apollo.disabled = true
	chris_button.disabled = true
	mercury_button.disabled = true
	frank_button.disabled = true
	pass # Replace with function body.
