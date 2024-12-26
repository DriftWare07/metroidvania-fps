extends Area3D
class_name hitbox

signal damaged

@export var healthcomp : Health_Component
@export var damage_group = ""


func damage(dmg, group=""):
	if damage_group != "" and group != damage_group: return
	if healthcomp: healthcomp.damage(dmg)
	damaged.emit()
