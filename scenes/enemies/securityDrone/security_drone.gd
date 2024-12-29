extends CharacterBody3D

var alerted = false



@onready var target : Node3D
@onready var groundcast = $groundcast
@onready var ceilingcast = $ceilingcast

@export var speed = 50
@export var path_speed = 1
@export var path_follower : PathFollow3D
@export var path_follow_offset = 5

func _ready() -> void:
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
		
		pass
		
	follow_path(delta)
	
	if alerted:
		pass
	#follow_patrol_route(delta)
	
	#for i in patrol_points:
		#var trans : Transform3D
		#trans.origin = i+patrol_path.position
		#
		#DebugDraw3D.draw_arrowhead(transform,Color.RED,10)
		#print("point")
	
	

func follow_path(delta):
	if !path_follower: return
	
	velocity = (path_follower.global_position - global_position)*speed*delta
	path_follower.progress += path_speed*delta
	look_at(global_position+velocity)
	move_and_slide()

func _on_detection_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		alerted = true
		


func _on_detection_range_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		alerted = false


func explode():
	
	var explosion = load("res://scenes/projectiles/explosionvfx.tscn")
	var e = explosion.instantiate()
	get_tree().root.add_child(e)
	e.position = global_position
	#e.explode()
	
	queue_free()
