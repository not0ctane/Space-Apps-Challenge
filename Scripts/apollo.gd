extends AnimatedSprite2D

var drag = false
var off = Vector2.ZERO
@onready var apollo_area: Area2D = $apolloArea
@onready var spawn_apollo: Node2D = $"../../spawns/spawnApollo"



func _process(delta: float) -> void:
	if drag:
		position = get_global_mouse_position() - off
	pass
# DRAG AND DROP ---------------------------------
func _on_button_button_down() -> void:
	print("works")
	drag = true
	off = get_global_mouse_position() - global_position
	pass # Replace with function body.

func _on_button_button_up() -> void:
	drag = false
	for a in apollo_area.get_overlapping_areas():
		if a.is_in_group("outbound"):
			print("Back to the spawn")
			self.position = spawn_apollo.position
			break
	pass # Replace with function body.
