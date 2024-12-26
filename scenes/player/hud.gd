extends Node3D


#weapon sway variables
var mouse_mov :Vector2
var sway_threshold = 3
var sway_lerp = 5

@export_group("sway settings")
@export var sway_left : Vector3
@export var sway_right : Vector3
@export var sway_up : Vector3
@export var sway_down : Vector3
@export var sway_normal : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sway(delta)
	print(position.z)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: 
		mouse_mov.x = -event.relative.x
		mouse_mov.y = -event.relative.y

func sway(delta):
	if mouse_mov != null:
		if mouse_mov.x > sway_threshold:
			rotation = rotation.lerp(sway_left, sway_lerp*delta)
		elif mouse_mov.x < -sway_threshold:
			rotation = rotation.lerp(sway_right, sway_lerp*delta)
		else:
			rotation = rotation.lerp(sway_normal, sway_lerp*delta)
		
		if mouse_mov.y > sway_threshold:
			rotation = rotation.lerp(sway_up, sway_lerp*delta)
		elif mouse_mov.y < -sway_threshold:
			rotation = rotation.lerp(sway_down, sway_lerp*delta)
		else:
			rotation = rotation.lerp(sway_normal, sway_lerp*delta)
