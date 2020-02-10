extends Node2D

func set_name(name):
	$NameValue.text = name

func set_attack(attack):
	$AttackValue.text = str(attack)
	
func set_health(health):
	$HealthValue.text = str(health)

func set_speed(speed):
	$SpeedValue.text = str(speed)
	
func get_size():
	return $ColorRect.get_rect().size
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var click_position = event.position
		var panel_size = $ColorRect.get_rect().size
		if not (click_position.x >= position.x and click_position.x <= (position.x + panel_size.x) and click_position.y >= position.y and click_position.y <= (position.y + panel_size.y)):
			get_parent().close_info_panel()

func _on_AttackButton_pressed():
	get_parent().on_attack_button_pressed()
