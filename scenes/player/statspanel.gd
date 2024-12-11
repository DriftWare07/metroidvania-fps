extends Panel


@export var healthcomp : Health_Component


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = "Energy: "+str(healthcomp.health)
