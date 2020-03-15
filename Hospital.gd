extends Node2D

var hero_being_healed = null

signal hospital_selected(building)

func start_hero_interaction(hero):
	hero_being_healed = hero
	$HealingTimer.start()
	
func stop_heal():
	hero_being_healed = null
	$HealingTimer.stop()
	
func pause(isPaused):
	$HealingTimer.set_paused(isPaused)

func _on_HealingTimer_timeout():
	hero_being_healed.heal(10)
