extends PanelContainer

func set_name(name):
	$MarginContainer/VBoxContainer/GridContainer/NameValue.text = name

func set_attack(attack):
	$MarginContainer/VBoxContainer/GridContainer/AttackValue.text = str(attack)
	
func set_health(health):
	$MarginContainer/VBoxContainer/GridContainer/HealthValue.text = str(health)

func set_speed(speed):
	$MarginContainer/VBoxContainer/GridContainer/SpeedValue.text = str(speed)
	
func get_size():
	return rect_size
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var click_position = event.position
		if not (click_position.x >= rect_position.x and click_position.x <= (rect_position.x + rect_size.x) and click_position.y >= rect_position.y and click_position.y <= (rect_position.y + rect_size.y)):
			get_parent().close_info_panel()

func _on_AttackButton_pressed():
	get_parent().on_attack_button_pressed()
	
func _ready():
	hide()