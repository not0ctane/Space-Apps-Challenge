extends Node

@onready var game_duration: Timer = $timers/gameDuration

@onready var science_duration: Timer = $timers/scienceDuration
@onready var energy_duration: Timer = $timers/energyDuration
@onready var support_duration: Timer = $timers/supportDuration
@onready var shield_duration: Timer = $timers/shieldDuration

#LABELS
@onready var life_sup_label: Label = $GUI/stats/resources/lifeSupLabel
@onready var energy_label: Label = $GUI/stats/resources/energyLabel
@onready var shields_label: Label = $GUI/stats/resources/shieldsLabel
@onready var science_label: Label = $GUI/stats/resources/scienceLabel

@onready var event_label: Label = $GUI/labels/eventLabel


var gameDurationTimer = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	science_label.text = str(GlobalScript.science)
	shields_label.text = str(GlobalScript.shield)
	energy_label.text = str(GlobalScript.energy)
	life_sup_label.text = str(GlobalScript.support)
	
	event_label.hide()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if GlobalScript.game_running and not gameDurationTimer:
		gameDurationTimer = true
		science_duration.start()
		energy_duration.start()
		support_duration.start()
		shield_duration.start()
		game_duration.start()
	pass
	

#DAY DURATION
func _on_game_duration_timeout() -> void:
	print("signal timeout")
	GlobalScript.start_new_day()
	pass # Replace with function body.
	
#RESOURCES PRODUCTION ------------------------------------------------------
func _on_science_duration_timeout() -> void:
	print("science working")
	var cantidad = GlobalScript.area_counts.get("scienceArea", 0) #Nombre exácto del nodo NO OLVIDAR
	if cantidad == 0: # Si no hay nadie no produce nada
		return 
	GlobalScript.science += cantidad * 2  #Cambiar el numero por su producción real
	GlobalScript.energy -= 1
	print("science working: ", cantidad, " astronautas | total: ", GlobalScript.science)
	science_label.text = str(GlobalScript.science)
	energy_label.text = str(GlobalScript.energy)


func _on_energy_duration_timeout() -> void:
	print("energy working")
	var cantidad = GlobalScript.area_counts.get("energyArea", 0)
	if cantidad == 0:
		return
	GlobalScript.energy += cantidad * 1
	energy_label.text = str(GlobalScript.energy)
	pass # Replace with function body.


func _on_support_duration_timeout() -> void:
	print("support working")
	var cantidad = GlobalScript.area_counts.get("supportArea", 0)
	if cantidad == 0:
		return
	GlobalScript.support += cantidad * 2
	GlobalScript.energy -= 1
	life_sup_label.text = str(GlobalScript.support)
	pass # Replace with function body.


func _on_shield_duration_timeout() -> void:
	print("shields working")
	var cantidad = GlobalScript.area_counts.get("shieldArea", 0)
	if cantidad == 0:
		return
	GlobalScript.shield += cantidad * 1
	GlobalScript.energy -= 1
	shields_label.text = str(GlobalScript.shield)
	pass # Replace with function body.
