extends Node3D



@export var speed = 30
@export var turn_mult = 2
var targets = []
var target : Node3D

func _ready() -> void:
	targets = get_tree().get_nodes_in_group("enemy")
	if targets.is_empty():return
	target = targets[0]
	for i in targets:
		if global_position.distance_to(i.global_position) < global_position.distance_to(target.global_position):
			target = i


func _process(delta: float) -> void:
	global_position += -transform.basis.z*(speed*delta)
	
	if target != null:
		$guide.look_at(target.global_position)
		global_rotation = lerp(global_rotation, $guide.global_rotation, delta*turn_mult)

func die_on_body(body):
	if body.is_in_group("player"): return
	queue_free()
