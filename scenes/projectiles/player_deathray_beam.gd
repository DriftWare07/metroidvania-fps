extends Node3D

var done = false
@export var charge_time = 5

@export var damage = 150
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
			var cast_point = to_local($RayCast3D.get_collision_point())
			var dist = $RayCast3D.get_collision_point().z - transform.origin.z
			
			
			
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


func adone(anim_name: StringName) -> void:
	queue_free()


func pdone() -> void:
	queue_free()
