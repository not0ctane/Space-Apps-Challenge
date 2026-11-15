extends AnimatedSprite2D

var drag = false
var off = Vector2.ZERO

@onready var apollo_area: Area2D = $apolloArea
@onready var spawn_apollo: Node2D = $"../../spawns/spawnApollo"

func _ready() -> void:
	self.global_position = spawn_apollo.global_position

func _process(delta: float) -> void:
	if drag:
		position = get_global_mouse_position() - off
	pass
# DRAG AND DROP ---------------------------------
func _on_button_button_down() -> void:
	drag = true
	off = get_global_mouse_position() - global_position
	GlobalScript.release_slot(self)
	pass # Replace with function body.

func _on_button_button_up() -> void:
	drag = false
	for a in apollo_area.get_overlapping_areas():
		if a.is_in_group("outbound"):
			print("Back to the spawn")
			self.position = spawn_apollo.position
			break
			
		if a.is_in_group("zone"):
			var libres = GlobalScript.get_free_slots(a)
			if libres.is_empty():
				print("Area llena, back to the spawn")
				global_position = spawn_apollo.global_position
			else:
				var slot = libres.pick_random()
				GlobalScript.claim_slot(slot, self)
				global_position = slot.global_position
				print("dentro de un slot")
			return
			
		
	pass # Replace with function body.
