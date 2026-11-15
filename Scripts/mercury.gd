extends AnimatedSprite2D

var drag = false
var off = Vector2.ZERO

@onready var spawn_mercury: Node2D = $"../../spawns/spawnMercury"
@onready var mercury_area: Area2D = $mercuryArea


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drag:
		global_position = get_global_mouse_position() - off
	pass

func _on_mercury_button_button_down() -> void:
	drag = true
	off = get_global_mouse_position() - global_position
	GlobalScript.release_slot(self)
	
func _on_mercury_button_button_up() -> void:
	drag = false
	for a in mercury_area.get_overlapping_areas():
		if a.is_in_group("outbound"):
			print("Back to the spawn")
			global_position = spawn_mercury.global_position
			return

		if a.is_in_group("zone"):
			var libres = GlobalScript.get_free_slots(a)
			if libres.is_empty():
				print("Area full, back to the spawn")
				global_position = spawn_mercury.global_position
				
			#Aquí se agregan los astronautas al slot
			else:
				var slot = libres.pick_random()
				GlobalScript.claim_slot(slot, self)
				global_position = slot.global_position
			return
	pass # Replace with function body.
