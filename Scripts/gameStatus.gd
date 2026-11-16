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

@onready var point_supp: Label = $GUI/labels/pointSupp
@onready var point_energy: Label = $GUI/labels/pointEnergy
@onready var point_science: Label = $GUI/labels/pointScience
@onready var point_shield: Label = $GUI/labels/pointShield


@onready var day_number: Label = $GUI/labels/dayNumber

@onready var event_label: Label = $GUI/labels/eventLabel

#MENUS
@onready var menu_rocket: ColorRect = $GUI/rocketMenu/menu
@onready var rocket_menu_position: Node2D = $GUI/rocketMenu/rocketMenuPosition

#MAIN LABELS
@onready var characters: Node2D = $Characters
@onready var main_monitor_label: Label = $GUI/labels/mainMonitorLabel
@onready var next_menu_button: Button = $GUI/buttons/nextMenuButton

var gameDurationTimer = false

var showingAstronauts = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GlobalScript.prodEnergy = 0
	GlobalScript.prodScience = 0
	GlobalScript.prodShield = 0
	GlobalScript.prodSupp = 0
	
	day_number.text = str(GlobalScript.day)
	science_label.text = str(GlobalScript.science)
	shields_label.text = str(GlobalScript.shield)
	energy_label.text = str(GlobalScript.energy)
	life_sup_label.text = str(GlobalScript.support)
	
	event_label.hide()
	menu_rocket.hide()
	
	point_energy.hide()
	point_science.hide()
	point_shield.hide()
	point_supp.hide()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	next_menu_button.show()
	
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
	
	GlobalScript.energy -= 1
	GlobalScript.support -= 4
	GlobalScript.shield -= 3
	
	day_number.text = str(GlobalScript.day)
	life_sup_label.text = str(GlobalScript.support)
	energy_label.text = str(GlobalScript.energy)
	shields_label.text = str(GlobalScript.shield)
	
	
	pass # Replace with function body.
	
#RESOURCES PRODUCTION ------------------------------------------------------
func _on_science_duration_timeout() -> void:
	print("science working")
	var cantidad = GlobalScript.area_counts.get("scienceArea", 0) #Nombre exácto del nodo NO OLVIDAR
	if cantidad == 0: # Si no hay nadie no produce nada
		return 
	point_science.show()
	GlobalScript.science += cantidad * 2 #Cambiar el numero por su producción real
	GlobalScript.prodScience += cantidad * 2 #Muestra la cantidad producida en el turno
	GlobalScript.energy -= 1
	print("science working: ", cantidad, " astronautas | total: ", GlobalScript.science)
	point_science.text = "+" + str(GlobalScript.prodScience)
	science_label.text = str(GlobalScript.science)
	energy_label.text = str(GlobalScript.energy)


func _on_energy_duration_timeout() -> void:
	print("energy working")
	point_energy.show()
	var cantidad = GlobalScript.area_counts.get("energyArea", 0)
	if cantidad == 0:
		return
		
	var produccion = roundi(cantidad * 4 * GlobalScript.get_energy_mult())  # 4 → 6 → 7
	GlobalScript.prodEnergy += produccion
	GlobalScript.energy += produccion
	point_energy.text = "+" + str(GlobalScript.prodEnergy)
	energy_label.text = str(GlobalScript.energy)


func _on_support_duration_timeout() -> void:
	print("support working")
	point_supp.show()
	var cantidad = GlobalScript.area_counts.get("supportArea", 0)
	if cantidad == 0:
		return
	GlobalScript.prodSupp += cantidad * 2 * GlobalScript.supportLevel
	GlobalScript.support += cantidad * 2 * GlobalScript.supportLevel
	GlobalScript.energy -= 1
	point_supp.text = "+" + str(GlobalScript.prodSupp)
	life_sup_label.text = str(GlobalScript.support)
	energy_label.text = str(GlobalScript.energy)
	pass # Replace with function body.


func _on_shield_duration_timeout() -> void:
	print("shields working")
	point_shield.show()
	var cantidad = GlobalScript.area_counts.get("shieldArea", 0)
	if cantidad == 0:
		return
		
	GlobalScript.shield += cantidad * 1 * GlobalScript.shieldLevel
	GlobalScript.prodShield += cantidad * 1 * GlobalScript.shieldLevel
	GlobalScript.energy -= 1
	point_shield.text = "+" + str(GlobalScript.prodShield)
	shields_label.text = str(GlobalScript.shield)
	energy_label.text = str(GlobalScript.energy)
	pass # Replace with function body.
	
#UPDATE MENUS
func _update_menus() -> void:
	characters.visible = showingAstronauts
	main_monitor_label.visible = showingAstronauts
	menu_rocket.visible = not showingAstronauts

#CHANGE MENUS
func _on_next_menu_button_button_down() -> void:
	showingAstronauts = not showingAstronauts
	_update_menus()
	pass # Replace with function body.

#UPGRADE SUPPORT
func _on_upgrade_support_button_button_down() -> void:
	if GlobalScript.supportLevel < GlobalScript.MAX_LEVEL:
		GlobalScript.supportLevel += 1
		print("Soporte nivel ", GlobalScript.supportLevel)
	pass # Replace with function body.

func _on_upgrade_energy_button_down() -> void:
	if GlobalScript.energyLevel < GlobalScript.MAX_LEVEL:
		GlobalScript.energyLevel += 1
		print("energy nivel ", GlobalScript.energyLevel)
	pass # Replace with function body.
	
func _on_upgrade_shield_button_down() -> void:
	if GlobalScript.shieldLevel < GlobalScript.MAX_LEVEL:
		GlobalScript.shieldLevel += 1
		print("shield nivel ", GlobalScript.shieldLevel)
	pass # Replace with function body.
