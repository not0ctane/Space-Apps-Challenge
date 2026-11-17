extends Sprite2D

@onready var label_end: Label = $"../end/labelEnd"
@onready var rocket: AudioStreamPlayer = $"../rocket"
@onready var end_music: AudioStreamPlayer = $"../endMusic"
@onready var back: Button = $"../back"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.hide()
	label_end.hide()
	Music.stop()
	rocket.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= 200 * delta
	pass

func _on_timer_kill_timeout() -> void:
	back.show()
	end_music.play()
	label_end.show()
	rocket.stop()
	queue_free()
	pass # Replace with function body.
