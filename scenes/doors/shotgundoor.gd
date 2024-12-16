extends Node3D

var explosion = load("res://scenes/projectiles/explosionvfx.tscn")
var opened = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	if opened: return
	if area.is_in_group("pellet"):
		
		var e = explosion.instantiate()
		add_child(e)
		
		$StaticBody3D/CollisionShape3D.disabled = true
		$spiraldoor/Circle.queue_free()
		$shatter.play()
		opened = true
