extends Area3D
class_name hitbox

signal damaged

@export var healthcomp : Health_Component

func damage(dmg):
	if healthcomp: healthcomp.damage(dmg)
	damaged.emit()
