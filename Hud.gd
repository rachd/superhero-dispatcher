extends CanvasLayer

var remaining_budget = 0
var time = 900

var tiles = constants.getTiles()

signal pause_game()
signal end_of_day()

# public methods
func reset():
	time = 900
	
func update_damage(damage, cell_type_id):
	match(cell_type_id):
		tiles.office:
			remaining_budget -= damage * 3
		tiles.house:
			remaining_budget -= damage * 2
		tiles.park:
			remaining_budget -= damage
	get_parent().updateDamage(remaining_budget)
	$DamageLabel.text = str(remaining_budget)
	
func set_remaining_budget(budget):
	remaining_budget = budget
	$DamageLabel.text = str(remaining_budget)
	
func pause(isPaused):
	if isPaused:
		$StartButton.text = "Play"
		$ClockIncrement.stop()
	else:
		$StartButton.text = "Pause"
		$ClockIncrement.start()
		
# private methods
func _on_StartButton_pressed():
	_play_pause()
	
func _play_pause():
	emit_signal("pause_game")

func _formatTime():
	# convert to 12-hour time with am/pm
	var hours = time / 100
	var hoursString = str(12 if hours % 12 == 0 else hours % 12)
	var minutes = time % 100
	var minutesString = str(minutes)
	if minutes == 0:
		minutesString = "00"
	var amPm = "AM"
	if hours >= 12:
		amPm = "PM"
	return hoursString + ":" + minutesString + " " + amPm

func _on_ClockIncrement_timeout():
	if time % 100 == 50:
		time -= 50
		time += 100
	else:
		time += 10
	
	if time == 1700:
		emit_signal("end_of_day")
	else:
		$Clock.text = _formatTime()
	
func _ready():
	$Clock.text = _formatTime()
