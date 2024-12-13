extends Node3D
class_name switch

@export var state = false

signal switched_off
signal switched_on

signal switched





func toggle():
	if state:
		state = false
		switched_off.emit()
	else:
		state = true
		switched_on.emit()
	
	switched.emit()
	

func on():
	state = true
	switched_on.emit()
	switched.emit()
	

func off():
	state = false
	switched_off.emit()
	switched.emit()
