extends Node
class_name Health_Component

signal damaged
signal dead

@export var host : Node
@export var delete_host_on_death = true
@export var areas : Array[Area3D]

@export var max_health = 100
@export var health = 100
@export var iframes = 0.4

@export var damage_group = ""

@export var reload_scene_on_death = false
@export var go_to_scene_on_death : PackedScene

var invframes = 0



func _process(delta: float):
	
	if invframes > 0:
		invframes -= delta
		return
	for x in areas:
		var list = x.get_overlapping_areas()
		for y in list:
			if y is Damage_Component and y.is_in_group(damage_group):
				damage(y.damage)
				y.callback()

func damage(dmg):
	
	invframes = iframes
	health -= dmg
	damaged.emit()
	print(health)
	if  health < 1:
		if reload_scene_on_death: get_tree().reload_current_scene()
		if go_to_scene_on_death != null: get_tree().change_scene_to_packed(go_to_scene_on_death)
		if delete_host_on_death: host.queue_free()
		dead.emit()
