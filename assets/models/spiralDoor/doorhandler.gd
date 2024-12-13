extends Node3D



@export var timeout = 10
@export var animation : AnimationPlayer
@export var open_anim = ""
@export var collider : CollisionShape3D


func open():
	animation.play(open_anim)
	collider.disabled = true

func close():
	animation.play_backwards(open_anim)
	collider.disabled = false
