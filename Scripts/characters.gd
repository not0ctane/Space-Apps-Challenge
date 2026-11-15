extends Node2D

@onready var main_monitor_label: Label = $"../GUI/labels/mainMonitorLabel"


#APOLLO FUNCTIONS -------------------------------------
func _on_apollo_area_mouse_entered() -> void:
	main_monitor_label.text = "APOLLO"
	
	pass # Replace with function body.
	
func _on_apollo_area_mouse_exited() -> void:
	main_monitor_label.text = "BEGIN YOUR DAY!"
	pass # Replace with function body.
	
#CHRISTINA FUNCTIONS -------------------------------------
func _on_chris_area_mouse_entered() -> void:
	main_monitor_label.text = "CHRISTINA"
	
	pass # Replace with function body.
	
func _on_chris_area_mouse_exited() -> void:
	main_monitor_label.text = "BEGIN YOUR DAY!"
	
	pass # Replace with function body.
	
#MERCURY FUNCTIONS -------------------------------------

func _on_mercury_area_mouse_entered() -> void:
	main_monitor_label.text = "MERCURY"
	
	pass # Replace with function body.
	
func _on_mercury_area_mouse_exited() -> void:
	main_monitor_label.text = "BEGIN YOUR DAY!"
	
	pass # Replace with function body.
	
#FRANK FUNCTIONS -------------------------------------

func _on_frank_area_mouse_entered() -> void:
	main_monitor_label.text = "FRANK"
	
	pass # Replace with function body.
	

func _on_frank_area_mouse_exited() -> void:
	main_monitor_label.text = "BEGIN YOUR DAY!"
	
	pass # Replace with function body.
