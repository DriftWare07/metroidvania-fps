extends PathFollow3D
class_name pathFollowParent

# Called when the node enters the scene tree for the first time.
@export var speed = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed*delta
