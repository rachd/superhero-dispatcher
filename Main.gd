extends Node

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_game():
	score = 0
#	$VillainTimer.start()



func _on_Villain_do_damage(damage):
	$HUD.update_damage(damage)


func _on_HUD_pause_game(isPaused):
	$Villain.pause(isPaused)
