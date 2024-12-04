extends Node


var deathRayCooldown = 0
var deathrayCharged = false
var chargeSound = AudioStreamPlayer.new()
#spoonsandlessspoons made the death ray chargeup sound
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	call_deferred("add_child", chargeSound)

func _process(delta: float) -> void:
	
	
	deathRayCooldown -= delta
	
	if deathRayCooldown < 0 and deathrayCharged == false:
		deathrayCharged = true
		chargeSound.stream = load("res://assets/sounds/361334__spoonsandlessspoons__charge-up-shot.wav")
		chargeSound.bus = &"player_fx"
		chargeSound.play()
