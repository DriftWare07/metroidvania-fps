extends Node3D



@export var timeout = 10
@export var close_on_timeout = false
@export var animation : AnimationPlayer
@export var open_anim = ""
@export var collider : CollisionShape3D
var state = false

signal doorStateChanged
signal doorOpened
signal doorShut

var t = 0

func _ready() -> void:
	t = timeout

func _process(delta: float) -> void:
	if not close_on_timeout: return
	t -= delta
	
	if state and t < 0:
		close()
		
		

func open():
	if state:return
	state = true
	animation.play(open_anim)
	collider.disabled = true
	t = timeout
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
