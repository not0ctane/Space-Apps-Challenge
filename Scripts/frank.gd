extends AnimatedSprite2D

var drag = false
var off = Vector2.ZERO

@onready var frank_area: Area2D = $frankArea
@onready var spawn_frank: Node2D = $"../../spawns/spawnFrank"

func _process(delta: float) -> void:
	if drag:
		global_position = get_global_mouse_position() - off
	pass


func _on_frank_button_button_down() -> void:
	drag = true
	off = get_global_mouse_position() - global_position
	GlobalScript.release_slot(self)
	pass # Replace with function body.


func _on_frank_button_button_up() -> void:
	drag = false
	for a in frank_area.get_overlapping_areas():
		if a.is_in_group("outbound"):
			print("Back to the spawn")
			global_position = spawn_frank.global_position
			return

		if a.is_in_group("zone"):
			var libres = GlobalScript.get_free_slots(a)
			if libres.is_empty():
				print("Area full, back to the spawn")
				global_position = spawn_frank.global_position
			else:
				var slot = libres.pick_random()
				GlobalScript.claim_slot(slot, self)
				global_position = slot.global_position
			return
	pass # Replace with function body.
