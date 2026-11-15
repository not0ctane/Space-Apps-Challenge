extends AnimatedSprite2D

var drag = false
var off = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drag:
		position = get_global_mouse_position() - off
	pass

func _on_mercury_button_button_down() -> void:
	drag = true
	off = get_global_mouse_position() - global_position
	
func _on_mercury_button_button_up() -> void:
	drag = false
	pass # Replace with function body.
