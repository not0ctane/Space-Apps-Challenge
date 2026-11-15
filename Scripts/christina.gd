extends AnimatedSprite2D

@onready var chris_area: Area2D = $chrisArea
@onready var spawn_christina: Node2D = $"../../spawns/spawnChristina"

var drag = false
var off = Vector2.ZERO

func _ready() -> void:
	global_position = spawn_christina.global_position

func _process(_delta: float) -> void:
	if drag:
		global_position = get_global_mouse_position() - off

func _on_chris_button_button_down() -> void:
	drag = true
	off = get_global_mouse_position() - global_position
	GlobalScript.release_slot(self)

func _on_chris_button_button_up() -> void:
	drag = false
	for a in chris_area.get_overlapping_areas():
		if a.is_in_group("outbound"):
			print("Back to the spawn")
			global_position = spawn_christina.global_position
			return

		if a.is_in_group("zone"):
			var libres = GlobalScript.get_free_slots(a)
			if libres.is_empty():
				print("Area full, back to the spawn")
				global_position = spawn_christina.global_position
			else:
				var slot = libres.pick_random()
				GlobalScript.claim_slot(slot, self)
				global_position = slot.global_position
			return
