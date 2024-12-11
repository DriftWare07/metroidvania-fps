extends RigidBody3D

@export var velocity = 10
@export var damage = 50
@export var explosionforce = 50
# Called when the node enters the scene tree for the first time.
@onready var area = $Area3D


func chuck():
	apply_central_impulse(-global_transform.basis.z*velocity)


func explode():
	var areas = area.get_overlapping_areas()
	var bodies = area.get_overlapping_bodies()
	
	for i in areas:
		if i is hitbox:
			i.damage(damage)
		
	
	for i in bodies:
		if i is RigidBody3D:
			i.apply_impulse((i.global_position-global_position)*explosionforce,(i.global_position-global_position))
			
	
	queue_free()
