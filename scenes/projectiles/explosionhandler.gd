extends Area3D


@export var emitters : Array[Node3D]

var active = 1

var areas = []
var bodies = []

func _ready() -> void:
	active = len(emitters)
	for i in emitters:
		i.finished.connect(done)
		if i is GPUParticles3D: i.restart()
		if i is AudioStreamPlayer3D: i.play()
	




func done():
	active -= 1
	if active < 1:
		queue_free()
