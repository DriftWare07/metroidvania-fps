extends Node3D

var done = false
@export var charge_time = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if done: return
	
	if Global.deathrayCharged:
		show()
		$AnimationPlayer.play("fire")
		
		$RayCast3D.force_raycast_update()
		if $RayCast3D.is_colliding():
			var dist = $RayCast3D.get_collision_point().z - transform.origin.z
			
			
			
			$laser_inner.position.z -= dist/2
			$laser_outer.position.z -= dist/2
			
			$laser_inner.mesh.height = -dist
			$laser_outer.mesh.height = -dist
		else:
			var dist = 100
			
			
			
			$laser_inner.position.z -= dist/2
			$laser_outer.position.z -= dist/2
			
			$laser_inner.mesh.height = -dist
			$laser_outer.mesh.height = -dist
		
		Global.deathRayCooldown = charge_time
		Global.deathrayCharged = false
	else:
		$GPUParticles3D.restart()
	done = true


func adone(anim_name: StringName) -> void:
	queue_free()


func pdone() -> void:
	queue_free()
