extends Area3D
class_name Damage_Component

signal damageDelt

@export var damage = 10

@export var delete_host_on_dealing_damage = true
# Called when the node enters the scene tree for the first time.


func callback():
	print("callback")
	if delete_host_on_dealing_damage: get_parent().queue_free()