extends Area3D
class_name hitbox

signal damaged

@export var healthcomp : Health_Component

func damage(dmg, group=""):
	if healthcomp: healthcomp.damage(dmg,group)
	damaged.emit()
