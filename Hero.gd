extends KinematicBody2D

var speed = 25
var attack = 50
var health = 100

var target_position: Vector2
var target_villain = null
var attack_in_progress = false
var current_health = health

var path

signal hero_selected(hero)
signal hero_dead(hero, villain)
signal find_path(start, end, target)

# public methods
func on_click():
	var info_panel = $HeroPanel
#	var panel_size = info_panel.get_size()
#	if position.x < panel_size.x:
#		info_panel.rect_position.x = 20
#	else:
#		info_panel.rect_position.x = position.x
#	if position.y < panel_size.y:
#		info_panel.rect_position.y = 20
#	else:
#		info_panel.rect_position.y = position.y
	info_panel.set_speed(speed)
	info_panel.set_health(health)
	info_panel.set_attack(attack)
	info_panel.set_name("Superhero")
	info_panel.visible = true
	
func on_attack_button_pressed():
	emit_signal("hero_selected", self)
	_close_info_panel()
	
func stop_attack():
	attack_in_progress = false
	$AttackTimer.stop()
	target_villain = null
			
func pause(isPaused):
	if isPaused:
		speed = 0
	else:
		speed = 25
		
func take_damage(damage):
	current_health -= damage
	$Label.text = str(current_health)
	if (current_health <= 0):
		_die()
		
func move_to_Villain(villain):
	$AttackTimer.stop()
	if target_villain:
		target_villain.stop_attack()
	stop_attack()
	var relative_position = villain.position - position
	target_villain = villain
	if relative_position.length() <= 4:
		target_position = position
	else:
		target_position = villain.position
		emit_signal("find_path", position, target_position, self)
		
# private methods
func _close_info_panel():
	$HeroPanel.visible = false
	
func _start_attack():
	attack_in_progress = true
	target_villain.start_attack(self)
	$AttackTimer.start()
	
func _ready():
	target_position = position
	$Label.text = str(current_health)
	self.connect("hero_selected", get_node("/root/Main"), "_on_Hero_clicked")
	self.connect("hero_dead", get_node("/root/Main"), "_on_Hero_dead")
	self.connect("find_path", get_node("/root/Main"), "_calculate_new_path")
	
func _on_AttackTimer_timeout():
	target_villain.take_damage(attack)

func _die():
	$AttackTimer.stop()
	emit_signal("hero_dead", self, target_villain)
		
func _check_if_attack():
	if !attack_in_progress:
		var overlaps = $Area2D.get_overlapping_areas()
		for overlap in overlaps:
			if overlap.get_parent() == target_villain:
				_start_attack()
		
func _process(delta):
	if path:
		var target = path[0]
		var direction = (target - position).normalized()
		position += direction * speed * delta
		var current = position
		var dist = position.distance_to(target)
		if position.distance_to(target) < 1:
			path.remove(0)
			if path.size() == 0:
				path = null
				_check_if_attack()
			
