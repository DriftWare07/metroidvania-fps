extends switch
class_name multiswitch



@export var switches : Array[switch]
@onready var panel = $Sprite3D/SubViewport/Control/Panel
@onready var radial = $Sprite3D/SubViewport/Control/Panel.material


func _ready():
	state = false
	radial.set_shader_parameter("value", 0)
	radial.set_shader_parameter("segments", len(switches))

func _process(delta: float) -> void:
	var confirms = 0.0
	for i in switches:
		if i.state: confirms += 1
	
	var param = lerpf(radial.get_shader_parameter("value"), confirms/float(len(switches)), delta*5)
	
	radial.set_shader_parameter("value", param)
	
	
	
	if confirms >= len(switches) and not state:
		state = true
		switched_on.emit()
		switched.emit()
	
	if confirms < len(switches) and state:
		state = false
		switched_off.emit()
		switched.emit()
	
