extends Area3D
class_name hitbox

@export var healthcomp : Health_Component

func damage(dmg):
	healthcomp.damage(dmg)
