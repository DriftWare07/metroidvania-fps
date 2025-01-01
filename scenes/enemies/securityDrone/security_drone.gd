extends CharacterBody3D

var alerted = false



@onready var target : Node3D
@onready var groundcast = $groundcast
@onready var ceilingcast = $ceilingcast
@onready var lineOfSight = $detectionRange/lineOfSight
@onready var alert_falloff = $alert_falloff

@export var speed = 50
@export var path_speed = 1
@export var path_follower : PathFollow3D
@export var path_follow_offset = 5

@export var alarm_sound : AudioStreamPlayer3D

var bullet_scene = load("res://scenes/enemies/enemy_bullet.tscn")

var detected = false

func _ready() -> void:
	alarm_sound.volume_db = -60
	if path_follower:
		path_follower.progress += path_follow_offset

func _physics_process(delta: float) -> void:
	
	#if groundcast.is_colliding():
			#velocity.y += delta
	#elif ceilingcast.is_colliding():
		#velocity.y -= delta
	#else:
		#velocity.y = lerp(velocity.y, 0.0, 0.3)
	#
	if not alerted: 
		$securityDrone/flash.hide()
		alarm_sound.volume_db = lerp(alarm_sound.volume_db, -60.0, delta)
		follow_path(delta)
	
	
	if alerted:
		$securityDrone/flash.show()
		alarm_sound.volume_db = lerp(alarm_sound.volume_db, 0.0, delta*10)
		alert_mode(delta)
	#follow_patrol_route(delta)
	
	#for i in patrol_points:
		#var trans : Transform3D
		#trans.origin = i+patrol_path.position
		#
		#DebugDraw3D.draw_arrowhead(transform,Color.RED,10)
		#print("point")
	
	if target:
		lineOfSight.look_at(target.global_position)
		if lineOfSight.is_colliding():
			if lineOfSight.get_collider().is_in_group("player"):
				detected = true
				
			else:
				detected = false
			

func alert_mode(delta):
	var look_target = global_transform.looking_at(target.global_transform.origin)
	
	global_transform.basis.y = lerp(global_transform.basis.y, look_target.basis.y, delta)
	global_transform.basis.x = lerp(global_transform.basis.x, look_target.basis.x, delta)
	global_transform.basis.z = lerp(global_transform.basis.z, look_target.basis.z, delta)
	
	

func shoot(target):
	if not lineOfSight.is_colliding(): return
	
	if not lineOfSight.get_collider().is_in_group("player"): return
	
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.global_position = $securityDrone/gun/muzzle.global_position
	b.look_at(target.global_position)
	$firesound.play()

func follow_path(delta):
	if !path_follower: return
	
	velocity = (path_follower.global_position - global_position)*speed*delta
	path_follower.progress += path_speed*delta
	look_at(global_position+velocity)
	move_and_slide()

func _on_detection_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		target = body
		alerted = true
		
		alert_falloff.stop()
		


func _on_detection_range_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		alert_falloff.start()
		


func explode():
	
	var explosion = load("res://scenes/projectiles/explosionvfx.tscn")
	var e = explosion.instantiate()
	get_tree().root.add_child(e)
	e.position = global_position
	#e.explode()
	
	queue_free()


func de_aggro() -> void:
	if detected:
		alert_falloff.start()
		return
	
	alerted = false
	alert_falloff.stop()


func _on_shoot_delay_timeout() -> void:
	if not alerted: return
	if target:
		shoot(target)
		
