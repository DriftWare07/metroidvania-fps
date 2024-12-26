extends Node3D
class_name bullet


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

func die_on_body():
	
	spawn_sparks()
	queue_free()

func spawn_sparks():
	
	var particles = load("res://scenes/projectiles/hitSparks.tscn")
	var p = particles.instantiate()
	get_tree().root.add_child(p)
	p.position = global_position
	p.rotation = global_rotation
	p.restart()
