extends CanvasLayer

var isPaused = false
var damage_done = 0

const constants = preload("constants.gd")
var tiles = constants.getTiles()

signal pause_game(isPaused)

# public methods
func update_damage(damage, cell_type_id):
	match(cell_type_id):
		tiles.office:
			damage_done += damage * 3
		tiles.house:
			damage_done += damage * 2
		tiles.park:
			damage_done += damage
	$DamageLabel.text = str(damage_done)

# private methods
func _on_StartButton_pressed():
	_play_pause()
	
func _play_pause():
	if isPaused:
		$StartButton.text = "Pause"
	else:
		$StartButton.text = "Play"
	emit_signal("pause_game", !isPaused)
	isPaused = !isPaused
