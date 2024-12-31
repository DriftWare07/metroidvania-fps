extends Area3D
class_name Damage_Component

signal damageDelt

@export var damage = 10
@export var exclusion_group = ""
@export var damage_group = ""

@export var delete_host_on_dealing_damage = true
@export var die_on_body = true
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	body_entered.connect(on_body)
	pass

func _physics_process(delta: float) -> void:
	var areas = get_overlapping_areas()
	var bodies = get_overlapping_bodies()
	
	for i in areas:
		if i is hitbox:
			if i.is_in_group(exclusion_group): return
			i.damage(damage, damage_group)
			damageDelt.emit()
			if delete_host_on_dealing_damage: get_parent().queue_free()
	
	#print(bodies)
	

func callback():
	print("callback")
	#if delete_host_on_dealing_damage: get_parent().queue_free()

func on_body(body):
	if body.is_in_group(exclusion_group): return
	damageDelt.emit()
