extends Node3D



@export var timeout = 10
@export var animation : AnimationPlayer
@export var open_anim = ""
@export var collider : CollisionShape3D
var state = false

signal doorStateChanged
signal doorOpened
signal doorShut

func open():
	if state:return
	state = true
	animation.play(open_anim)
	collider.disabled = true
	doorStateChanged.emit()
	doorOpened.emit()

func close():
	if not state: return
	state = false
	animation.play_backwards(open_anim)
	collider.disabled = false
	doorStateChanged.emit()
	doorShut.emit()

func toggle():
	if state:
		close()
		return
	else:
		open()
		return
