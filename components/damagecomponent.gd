extends Area3D
class_name Damage_Component

signal damageDelt

@export var damage = 10
@export var exclusion_group = ""

@export var delete_host_on_dealing_damage = true
# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	var areas = get_overlapping_areas()
	for i in areas:
		if i is hitbox:
			if i.is_in_group(exclusion_group): return
			i.damage(damage)
			if delete_host_on_dealing_damage: get_parent().queue_free()

func callback():
	print("callback")
	#if delete_host_on_dealing_damage: get_parent().queue_free()
