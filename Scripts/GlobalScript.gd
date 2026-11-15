extends Node

var apolloSelected = false
var chrisSelected = false
var frankSelected = false
var mercurySelected = false

var slot_owners = {}
var character_slots := {}

func get_free_slots(area: Area2D) -> Array:
	var libres := []
	for child in area.get_children():
		if child.is_in_group("slot") and not child in character_slots.values():
			libres.append(child)
	return libres

func claim_slot(slot: Node2D, character: Node) -> void:
	character_slots[character] = slot

func release_slot(character: Node) -> void:
	character_slots.erase(character)
