extends Area3D

var grenade_target = null
var speed = 50
var lerp_speed = 50

func _physics_process(delta: float) -> void:
	if !grenade_target:return
	
	
	var speed = lerp_speed*grenade_target.global_transform.origin.distance_to(global_position)
	
	var dir = grenade_target.global_transform.origin.direction_to(global_position)
	
	grenade_target.linear_velocity = Vector3.ZERO
	grenade_target.apply_central_force(dir*speed)

func _on_body_entered(body: Node3D) -> void:
	if body is grenade:
		grenade_target = body
		
