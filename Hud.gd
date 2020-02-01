extends CanvasLayer

var isPaused = false
var damage_done = 0

signal pause_game(isPaused)

func update_damage(damage):
	damage_done += damage
	$DamageLabel.text = str(damage_done)
	
func play_pause():
	if isPaused:
		$StartButton.text = "Pause"
	else:
		$StartButton.text = "Play"
	emit_signal("pause_game", !isPaused)
	isPaused = !isPaused


func _on_StartButton_pressed():
	play_pause()
