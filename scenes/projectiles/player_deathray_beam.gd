extends Node3D

var done = false
@export var charge_time = 5
@onready var raycast = $RayCast3D
@export var damage = 150
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if done: return
	
	if Global.deathrayCharged:
		show()
		$AnimationPlayer.play("fire")
		
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var c = raycast.get_collider()
			var cast_point = to_local(raycast.get_collision_point())
			var dist = raycast.get_collision_point().z - transform.origin.z
			
			print(c)
			
			$laser_inner.position.z = cast_point.z/2
			$laser_outer.position.z = cast_point.z/2
			
			$laser_inner.mesh.height = cast_point.z
			$laser_outer.mesh.height = cast_point.z
			
			
		else:
			var cast_point = Vector3(0,0,-100)
			
			$laser_inner.position.z = cast_point.z/2
			$laser_outer.position.z = cast_point.z/2
			
			$laser_inner.mesh.height = cast_point.z
			$laser_outer.mesh.height = cast_point.z
		
		
		
		
		Global.deathRayCooldown = charge_time
		Global.deathrayCharged = false
	else:
		$GPUParticles3D.restart()
	done = true

func deal():
	if raycast.is_colliding():
		var c = raycast.get_collider()
		if c is hitbox and !c.is_in_group("player"):
			c.damage(damage)

func adone(anim_name: StringName) -> void:
	
	
	queue_free()


func pdone() -> void:
	queue_free()
