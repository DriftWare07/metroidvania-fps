extends Node3D



@export var weapon : weaponData
var cooldown = 0

@export var muzzleFlash : GPUParticles3D
@export var animationPlayer : AnimationPlayer
@export var aimcast : RayCast3D
@export var cam : ShakeCamera

@export var grabcast : RayCast3D

var isGrabbing = false
var grabbedObject : RigidBody3D

@export var lerp_speed = 500

func _process(delta: float) -> void:
	#%subcamera.set_global_transform(cam.get_global_transform())
	
	grabObjects()
	if !weapon: return
	cooldown -= delta
	if Input.is_action_pressed("shoot") and cooldown < 0 and not isGrabbing:
		cooldown = weapon.cooldown
		var p = weapon.projectile_scene.instantiate()
		
		get_tree().root.add_child(p)
		p.global_position = global_position
		
		if aimcast.is_colliding():
			p.look_at(aimcast.get_collision_point())
		else:
			p.global_rotation = global_rotation
		
		
		cooldown = weapon.cooldown
		muzzleFlash.restart()
		animationPlayer.play("standard_recoil")
		cam._camera_shake()
		
	
	

func grabObjects():
	#print(grabbedObject)
	var target_position = $holdpoint.global_transform.origin
	
	#if not isGrabbing: grabbedObject = null
	#if isGrabbing and grabbedObject == null: isGrabbing = false
	
	
	if isGrabbing and Input.is_action_just_pressed("grab"):
		grabbedObject = null
		isGrabbing = false
		
		return
	
	if !isGrabbing:
		if grabcast.is_colliding() and Input.is_action_just_pressed("grab"):
			if  grabcast.get_collider().is_in_group("grab") and !isGrabbing:
				grabbedObject = aimcast.get_collider()
				isGrabbing = true
				
	
	
	
	
	if isGrabbing:
		
		var speed = lerp_speed*grabbedObject.global_transform.origin.distance_to(target_position)
		
		var dir = grabbedObject.global_transform.origin.direction_to(target_position)
		
		grabbedObject.linear_velocity = Vector3.ZERO
		grabbedObject.apply_central_force(dir*speed)
