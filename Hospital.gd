extends Node2D

var hero_being_healed = null

signal hospital_selected(building)

func on_click():
	emit_signal("hospital_selected", self)

func start_heal(hero):
	hero_being_healed = hero
	$HealingTimer.start()
	
func stop_heal():
	hero_being_healed = null
	$HealingTimer.stop()
	
func pause(isPaused):
	$HealingTimer.set_paused(isPaused)
	
func _ready():
	self.connect("hospital_selected", get_node("/root/Main"), "_on_Hospital_clicked")

func _on_HealingTimer_timeout():
	hero_being_healed.heal(10)
