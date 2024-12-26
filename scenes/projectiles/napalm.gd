extends bullet
class_name napalm

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var pitch = randf_range(0.01,1.0)
	if pitch == 0.0: pitch += 0.1
	$firesound.pitch_scale = pitch
