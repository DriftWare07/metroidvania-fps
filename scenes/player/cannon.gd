extends Node3D

@export var weaponList : Array[weaponData]

var weapon : weaponData
var current_weapon = 0

var cooldown = 0

@export var muzzleFlash : GPUParticles3D
@export var animationPlayer : AnimationPlayer
@export var aimcast : RayCast3D
@export var cam : ShakeCamera
@export var ui_label : Label
@export var ui_icon : TextureRect

@export var grabcast : RayCast3D

var isGrabbing = false
var grabbedObject : RigidBody3D

@export var lerp_speed = 500

#weapon sway variables
var mouse_mov :Vector2
var sway_threshold = 1
var sway_lerp = 5

@export_group("sway settings")
@export var sway_left : Vector3
@export var sway_right : Vector3
@export var sway_up : Vector3
@export var sway_down : Vector3
@export var sway_normal : Vector3

func _ready() -> void:
	weapon = weaponList[current_weapon]

func _process(delta: float) -> void:
	#%subcamera.set_global_transform(cam.get_global_transform())
	
	grabObjects()
	sway(delta)
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
		
	
	if Input.is_action_just_released("weapon_up"): switchWeapon(1)
	if Input.is_action_just_released("weapon_down"): switchWeapon(-1)
	

func switchWeapon(to):
	if to + current_weapon > len(weaponList)-1:
		current_weapon = 0
	elif to - current_weapon < 0:
		current_weapon = len(weaponList) -1
	
	weapon = weaponList[current_weapon]
	ui_label.text = weapon.weapon_name
	cooldown = 0

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

#weapon sway
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: 
		mouse_mov.x = -event.relative.x
		mouse_mov.y = -event.relative.y

func sway(delta):
	if mouse_mov != null:
		if mouse_mov.x > sway_threshold:
			rotation = rotation.lerp(sway_left, sway_lerp*delta)
		elif mouse_mov.x < -sway_threshold:
			rotation = rotation.lerp(sway_right, sway_lerp*delta)
		else:
			rotation = rotation.lerp(sway_normal, sway_lerp*delta)
		
		if mouse_mov.y > sway_threshold:
			rotation = rotation.lerp(sway_up, sway_lerp*delta)
		elif mouse_mov.y < -sway_threshold:
			rotation = rotation.lerp(sway_down, sway_lerp*delta)
		else:
			rotation = rotation.lerp(sway_normal, sway_lerp*delta)
