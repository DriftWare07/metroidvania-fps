extends Node3D



@export var speed = 30
@export var turn_mult = 2
var targets = []
var target : Node3D
var rot = Vector3()

func _ready() -> void:
	get_targets()


#func _process(delta: float) -> void:
	#global_position += -transform.basis.z*(speed*delta)
	#
	#if target != null:
		#$guide.look_at(target.global_position)
		#global_rotation = lerp(global_rotation, $guide.global_rotation, delta*turn_mult)

func _physics_process(delta: float) -> void:
	if target != null:
		var direction = target.global_transform.origin - global_transform.origin
		
		direction = direction.normalized()
		
		var rotateAmount = direction.cross(global_transform.basis.z)
		rot.y = rotateAmount.y*turn_mult*delta
		rot.x = rotateAmount.x*turn_mult*delta
		
		rotate(Vector3.UP, rot.y)
		rotate(Vector3.RIGHT, rot.x)
		
		global_translate(-global_transform.basis.z*speed*delta)
	else:
		global_position += -transform.basis.z*(speed*delta)
		get_targets()

func die_on_body(body):
	if body.is_in_group("player"): return
	queue_free()



func get_targets():
	targets = get_tree().get_nodes_in_group("enemy")
	if targets.is_empty():return
	target = targets[0]
	for i in targets:
		if global_position.distance_to(i.global_position) < global_position.distance_to(target.global_position):
			target = i
