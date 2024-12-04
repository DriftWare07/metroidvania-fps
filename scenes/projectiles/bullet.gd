extends Node3D



@export var speed = 30
@export var gravity_decay = 0.0
@export var timeout = 30

var gv = 0



func _process(delta: float) -> void:
	global_position += -transform.basis.z*(speed*delta)
	global_position.y -= gv
	gv += gravity_decay*delta
	
	timeout -= delta
	if timeout < 0: queue_free()

func die_on_body(body):
	if body.is_in_group("player"): return
	queue_free()
