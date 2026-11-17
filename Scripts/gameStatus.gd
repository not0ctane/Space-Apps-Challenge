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

#BUTTON TO START THE GAME
@onready var start_button: Button = $GUI/buttons/startButton

@onready var day_number: Label = $GUI/labels/dayNumber

@onready var event_label: Label = $GUI/labels/eventLabel

#UPGRADE BUTTONS
@onready var upgrade_area_supp: Control = $GameAreas/supportArea/upgradeAreaSupp
@onready var upgrade_area_energy: Control = $GameAreas/energyArea/upgradeAreaEnergy
@onready var upgrade_area_shield: Control = $GameAreas/shieldArea/upgradeAreaShield

@onready var cost_label: Label = $GUI/rocketMenu/menu/selectUpgradeLabel/costLabel

#MENUS
@onready var menu_rocket: ColorRect = $GUI/rocketMenu/menu
@onready var rocket_menu_position: Node2D = $GUI/rocketMenu/rocketMenuPosition

#MAIN LABELS
@onready var characters: Node2D = $Characters
@onready var main_monitor_label: Label = $GUI/labels/mainMonitorLabel
@onready var next_menu_button: Button = $GUI/buttons/nextMenuButton

@onready var not_upgraded_label: Label = $GUI/rocketMenu/menu/notUpgradedLabel


#ROCKET MAIN
@onready var select_upgrade_label: Label = $GUI/rocketMenu/menu/selectUpgradeLabel

var gameDurationTimer = false

var showingAstronauts = true

var gameOver = false

#AUDIO
@onready var beep_1: AudioStreamPlayer = $audio/beep1
@onready var beep_2: AudioStreamPlayer = $audio/beep2
@onready var beep_3: AudioStreamPlayer = $audio/beep3
@onready var slam: AudioStreamPlayer = $audio/slam



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	slam.play()
	
	if not Music.playing:
		Music.play()
		
	select_upgrade_label.hide()
	
	if GlobalScript.allAreasMax:
		select_upgrade_label.show()
	_remove_maxed_buttons()
	
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
	
	if GlobalScript.pointsForRocket == 0:
		get_tree().change_scene_to_file("res://Scenes/end.tscn")
		
	if GlobalScript.energy <= 0 or GlobalScript.support <= 0 or GlobalScript.shield <= 0 and not gameOver:
		Music.stop()
		gameOver = true
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		
	
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
	GlobalScript.shield -= GlobalScript.get_shield_damage()  # 3 → 2 → 1
	GlobalScript.energy -= 1
	GlobalScript.support -= 4
	GlobalScript.start_new_day()  # al final, porque recarga la escena
	pass # Replace with function body.
	
#RESOURCES PRODUCTION ------------------------------------------------------
func _on_science_duration_timeout() -> void:
	print("science working")
	var cantidad = GlobalScript.area_counts.get("scienceArea", 0) #Nombre exácto del nodo NO OLVIDAR
	if cantidad == 0: # Si no hay nadie no produce nada
		return 
		
	beep_2.play()
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
	var cantidad = GlobalScript.area_counts.get("energyArea", 0)
	if cantidad == 0:
		return
		
	beep_2.play()
	point_energy.show()
	var produccion = roundi(cantidad * 2 * GlobalScript.get_energy_mult())  # 4 → 6 → 7
	GlobalScript.prodEnergy += produccion
	GlobalScript.energy += produccion
	point_energy.text = "+" + str(GlobalScript.prodEnergy)
	energy_label.text = str(GlobalScript.energy)


func _on_support_duration_timeout() -> void:
	print("support working")
	var cantidad = GlobalScript.area_counts.get("supportArea", 0)
	if cantidad == 0:
		return
	beep_2.play()
	point_supp.show()
	var produccion = roundi(cantidad * 1 * GlobalScript.get_support_mult())  # 1 → 2 → 3
	GlobalScript.prodSupp += produccion
	GlobalScript.support += produccion
	GlobalScript.energy -= 1
	point_supp.text = "+" + str(GlobalScript.prodSupp)
	life_sup_label.text = str(GlobalScript.support)
	energy_label.text = str(GlobalScript.energy)


func _on_shield_duration_timeout() -> void:
	print("shields working")
	var cantidad = GlobalScript.area_counts.get("shieldArea", 0)
	if cantidad == 0:
		return
		
	beep_2.play()
	point_shield.show()
	GlobalScript.shield += cantidad * 1      # ya no depende del nivel
	GlobalScript.prodShield += cantidad * 1
	GlobalScript.energy -= 1
	point_shield.text = "+" + str(GlobalScript.prodShield)
	shields_label.text = str(GlobalScript.shield)
	energy_label.text = str(GlobalScript.energy)
	
#UPDATE MENUS
func _update_menus() -> void:
	GlobalScript.inRocketMenu = not showingAstronauts
	characters.visible = showingAstronauts
	main_monitor_label.visible = showingAstronauts
	menu_rocket.visible = not showingAstronauts

	if GlobalScript.allAreasMax:
		select_upgrade_label.show()
		
	print("menu visible: ", menu_rocket.visible, " | label visible en árbol: ", select_upgrade_label.is_visible_in_tree(), " | allAreasMax: ", GlobalScript.allAreasMax)

#CHANGE MENUS
func _on_next_menu_button_button_down() -> void:
	showingAstronauts = not showingAstronauts
	_update_menus()
	pass # Replace with function body.

#U	UPGRADE SUPPORT
func _on_upgrade_support_button_button_down() -> void:
	if GlobalScript.try_upgrade(GlobalScript.supportLevel):
		beep_3.play()
		GlobalScript.supportLevel += 1
		science_label.text = str(GlobalScript.science)
		_remove_maxed_buttons()
		_check_all_maxed()


func _on_upgrade_energy_button_down() -> void:
	if GlobalScript.try_upgrade(GlobalScript.energyLevel):
		beep_3.play()
		GlobalScript.energyLevel += 1
		science_label.text = str(GlobalScript.science)
		_remove_maxed_buttons()
		_check_all_maxed()
	
func _on_upgrade_shield_button_down() -> void:
	if GlobalScript.try_upgrade(GlobalScript.shieldLevel):
		beep_3.play()
		GlobalScript.shieldLevel += 1
		science_label.text = str(GlobalScript.science)
		_remove_maxed_buttons()
		_check_all_maxed()
		
func _remove_maxed_buttons() -> void:
	if GlobalScript.supportLevel >= GlobalScript.MAX_LEVEL and is_instance_valid(upgrade_area_supp):
		upgrade_area_supp.queue_free()
	if GlobalScript.energyLevel >= GlobalScript.MAX_LEVEL and is_instance_valid(upgrade_area_energy):
		upgrade_area_energy.queue_free()
	if GlobalScript.shieldLevel >= GlobalScript.MAX_LEVEL and is_instance_valid(upgrade_area_shield):
		upgrade_area_shield.queue_free()
		
func _check_all_maxed() -> void:
	print("niveles: ", GlobalScript.supportLevel, GlobalScript.energyLevel, GlobalScript.shieldLevel)
	if GlobalScript.all_upgrades_maxed() and not GlobalScript.allAreasMax:
		GlobalScript.allAreasMax = true
		not_upgraded_label.hide()
		select_upgrade_label.show()


#ROCKET UPGRADES
func _on_upgrade_rocket_button_down() -> void:
	if GlobalScript.science >= 15:
		beep_2.play()
		GlobalScript.science -= 15
		GlobalScript.pointsForRocket -= 15
		science_label.text = str(GlobalScript.science)
		cost_label.text = str(GlobalScript.pointsForRocket)
	pass # Replace with function body.
