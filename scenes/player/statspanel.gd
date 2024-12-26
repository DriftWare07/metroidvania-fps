extends Control


@export var healthcomp : Health_Component
@export var hpbar : ProgressBar
@export var hpbar2 : ProgressBar
@export var hplabel : Label
@export var grenade_label : Label

func _ready() -> void:
	healthcomp.health_changed.connect(update_hpbar)
	update_hpbar()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hplabel.text = "Energy: "+str(healthcomp.health)
	grenade_label.text = "Grenades: "+str(Global.grenadeCount)
	
	
	
	

func update_hpbar():
	var tween = get_tree().create_tween()
	tween.tween_property(hpbar,"value", healthcomp.health,1).set_trans(Tween.TRANS_QUART)
	tween.tween_property(hpbar2,"value", healthcomp.health,3).set_trans(Tween.TRANS_QUART)
