extends CanvasLayer

var damage_done = 0
var time = 900

const constants = preload("constants.gd")
var tiles = constants.getTiles()

signal pause_game()
signal end_of_day()

# public methods
func update_damage(damage, cell_type_id):
	match(cell_type_id):
		tiles.office:
			damage_done += damage * 3
		tiles.house:
			damage_done += damage * 2
		tiles.park:
			damage_done += damage
	get_parent().updateDamage(damage_done)
	$DamageLabel.text = str(damage_done)

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
