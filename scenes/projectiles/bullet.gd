extends Node3D



@export var speed = 30




func _process(delta: float) -> void:
	global_position += -transform.basis.z*(speed*delta)

func die_on_body(body):
	if body.is_in_group("player"): return
	queue_free()
