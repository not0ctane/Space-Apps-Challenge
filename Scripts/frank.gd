extends AnimatedSprite2D

var drag = false
var off = Vector2.ZERO

@onready var frank_area: Area2D = $frankArea
@onready var spawn_frank: Node2D = $"../../spawns/spawnFrank"

#Movement variables
@export var speed = 90.0
var direction = -1

func _process(delta: float) -> void:
	if drag:
		global_position = get_global_mouse_position() - off
	elif GlobalScript.game_running and GlobalScript.character_slots.has(self):
		_patrol(delta)
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
	
#side to side patrol in the area
func _patrol(delta: float) -> void:
	var limits := _get_area_limits()
	global_position.x = clampf(global_position.x + direction * speed * delta, limits.x, limits.y)

	if global_position.x <= limits.x:
		direction = 1
	elif global_position.x >= limits.y:
		direction = -1

	flip_h = direction > 0  #flips the character

#Calculates the area where the astronaut is
func _get_area_limits() -> Vector2:
	var area = GlobalScript.character_slots[self].get_parent()
	for child in area.get_children():
		if child is CollisionShape2D and child.shape is RectangleShape2D:
			var half = child.shape.size.x * child.global_scale.x / 2.0
			return Vector2(child.global_position.x - half, child.global_position.x + half)
	return Vector2(global_position.x, global_position.x)  #this is if the game detects that there is no area
	pass # Replace with function body.
