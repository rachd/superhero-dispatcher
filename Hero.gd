extends KinematicBody2D

var speed = 25
var attack = 50
var health = 100

var direction : Vector2 = Vector2.ZERO
var target_position: Vector2
var target_villain = null
var attack_in_progress = false
var current_health = health

signal hero_selected(hero)
signal hero_dead(hero, villain)

func pause(isPaused):
	if isPaused:
		speed = 0
	else:
		speed = 25

func on_click():
	var info_panel = $HeroPanel
	var panel_size = info_panel.get_size()
	if position.x < panel_size.x:
		info_panel.rect_position.x = 20
	else:
		info_panel.rect_position.x = position.x - 50
	if position.y < panel_size.y:
		info_panel.rect_position.y = 20
	else:
		info_panel.rect_position.y = position.y - 160
	info_panel.set_speed(speed)
	info_panel.set_health(health)
	info_panel.set_attack(attack)
	info_panel.set_name("Superhero")
	info_panel.visible = true

func close_info_panel():
	$HeroPanel.visible = false
	
func on_attack_button_pressed():
	close_info_panel()
	emit_signal("hero_selected", self)
	
func _ready():
	target_position = position
	$Label.text = str(current_health)
	self.connect("hero_selected", get_node("/root/Main"), "_on_Hero_clicked")
	self.connect("hero_dead", get_node("/root/Main"), "_on_Hero_dead")
	
func start_attack():
	attack_in_progress = true
	target_villain.start_attack(self)
	$AttackTimer.start()
	
func stop_attack():
	attack_in_progress = false
	$AttackTimer.stop()
	target_villain = null
	
func _on_AttackTimer_timeout():
	target_villain.take_damage(attack)
	
func take_damage(damage):
	current_health -= damage
	$Label.text = str(current_health)
	if (current_health <= 0):
		die()
				
func die():
	$AttackTimer.stop()
	emit_signal("hero_dead", self, target_villain)

func move_to_Villain(villain):
	$AttackTimer.stop()
	var relative_position = villain.position - position
	target_villain = villain
	if relative_position.length() <= 4:
		direction = Vector2.ZERO
		target_position = position
	else:
		direction = relative_position.normalized()
		target_position = villain.position
		
func check_if_attack():
	if !attack_in_progress:
		var overlaps = $Area2D.get_overlapping_areas()
		for overlap in overlaps:
			if overlap.get_parent() == target_villain:
				start_attack()
		
func _physics_process(delta):
	var relative_position = target_position - position
	if relative_position.length() > 4:
		var movement = direction * speed * delta
		move_and_collide(movement)
	else:
		check_if_attack()
