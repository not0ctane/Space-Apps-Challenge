extends AnimatedSprite2D

var drag = false
var off = Vector2.ZERO

func _process(delta: float) -> void:
	if drag:
		position = get_global_mouse_position() - off
	pass

func _on_chris_button_button_down() -> void:
	drag = true
	off = get_global_mouse_position() - global_position
	pass # Replace with function body.
	
func _on_chris_button_button_up() -> void:
	drag = false
	pass # Replace with function body.
