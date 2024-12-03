extends Node3D

@export var scene : PackedScene
@export var amount = 10
@export var spread = 0.5
# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	for i in range(amount):
		var p = scene.instantiate()
		
		get_tree().root.add_child(p)
		p.global_position = global_position
		p.global_rotation = global_rotation
		p.global_rotation += Vector3(randf_range(-spread,spread), randf_range(-spread,spread), 0)
	queue_free()
