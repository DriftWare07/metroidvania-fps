extends Node3D
class_name switch

@export var state = false

signal switched_off
signal switched_on

signal switched

@export var cooldown_max = 1
var cooldown = 1



func _process(delta: float) -> void:
	cooldown -= delta

func toggle():
	
	if cooldown > 0: return
	if state:
		state = false
		switched_off.emit()
	else:
		state = true
		switched_on.emit()
	
	switched.emit()
	cooldown = cooldown_max

func on():
	if cooldown > 0: return
	state = true
	switched_on.emit()
	switched.emit()
	cooldown = cooldown_max

func off():
	if cooldown > 0: return
	state = false
	switched_off.emit()
	switched.emit()
	cooldown = cooldown_max
