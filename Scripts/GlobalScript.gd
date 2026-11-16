extends Node

var apolloSelected = false
var chrisSelected = false
var frankSelected = false
var mercurySelected = false

var character_slots := {}
var start_game = false
var game_running = false

const maxDays = 25

var day = 1

#Cantidad de recursos
var support = 8
var energy = 6
var shield = 10
var science = 0

var maxSupport = 8
var maxEnergy = 6
var maxShield = 10

var prodScience = 0
var prodSupp = 0
var prodEnergy = 0
var prodShield = 0

var multSupp = 1
var multEnergy = 1
var multShield = 1

#Nivel actual de cada mejora
var supportLevel = 1
var energyLevel = 1
var shieldLevel = 1

var area_counts := {}  # {"nombreDelArea": cantidad}

const MAX_LEVEL := 3

# Índice 0 = nivel 1, índice 1 = nivel 2, índice 2 = nivel 3
const ENERGY_MULT  := [1.0, 1.5, 1.75]   # producción de paneles
const SUPPORT_MULT := [1.0, 2.0, 3.0]    # reciclaje de soporte vital
const SHIELD_DAMAGE := [3, 2, 1]         # daño máximo de radiación

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	#This part starts the game
	if character_slots.size() == 4 and not start_game:
		print("game can start now!")
		start_game = true
		
	if character_slots.size() < 4:
		start_game = false
		
func start_new_day() -> void:

# 2. Avanza el día
	day += 1
	if day > maxDays:
		_end_game()
		return

	# 3. Reinicia el estado del turno
	character_slots.clear()
	_update_area_counts()
	start_game = false
	game_running = false
	apolloSelected = false
	chrisSelected = false
	frankSelected = false
	mercurySelected = false

	# 4. Recarga la escena
	get_tree().reload_current_scene()
	
func _end_game() -> void:
	print("Game over, 25 days completed")
	# aquí puedes cargar una escena de resultados


func get_free_slots(area: Area2D) -> Array:
	var libres := []
	for child in area.get_children():
		if child.is_in_group("slot") and not child in character_slots.values():
			libres.append(child)
	return libres

func claim_slot(slot: Node2D, character: Node) -> void:
	character_slots[character] = slot
	_update_area_counts()

func release_slot(character: Node) -> void:
	character_slots.erase(character)
	_update_area_counts()
	
# HOW MANY ASTRONAUTS ARE PER AREA
func _update_area_counts() -> void:
	area_counts.clear()
	
	for area in get_tree().get_nodes_in_group("zone"):
		area_counts[area.name] = 0
	
	for slot in character_slots.values():
		var area_name = slot.get_parent().name
		area_counts[area_name] += 1
		
		
#UPGRADE LEVELS (UPDATED)
func get_energy_mult() -> float:
	return ENERGY_MULT[energyLevel - 1]

func get_support_mult() -> float:
	return SUPPORT_MULT[supportLevel - 1]

func get_shield_damage() -> int:
	return SHIELD_DAMAGE[shieldLevel - 1]
