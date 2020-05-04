extends KinematicBody2D

var hero_name = ""
var speed = 0
var attack = 0
var health = 0

var current_speed = 0
var target_position: Vector2
var target_villain = null
var attack_in_progress = false
var current_health = health
var target_type = null
var heal_in_progress = false
var target_hospital = null

var spawn_area = constants.get_spawn_area()
var cell_size = constants.get_cell_size()
var path
var rng = RandomNumberGenerator.new()

signal hero_selected(hero)
signal hero_dead(hero, villain)
signal find_path(start, end, target)

# public methods
func spawn():
	current_health = health
	current_speed = speed

func on_right_click():
	var info_panel = $HeroPanel
	info_panel.set_speed(speed)
	info_panel.set_health(health)
	info_panel.set_attack(attack)
	info_panel.set_name(hero_name)
	info_panel.visible = true
	
func on_click():
	emit_signal("hero_selected", self)
	_close_info_panel()
	
func stop_attack():
	attack_in_progress = false
	$AttackTimer.stop()
	target_villain = null
			
func pause(isPaused):
	$AttackTimer.set_paused(isPaused)
	if isPaused:
		current_speed = 0
	else:
		current_speed = speed
		
func reset():
	_on_move()
	current_health = health
	$Label.text = str(current_health)
	_set_initial_position()
		
func take_damage(damage):
	current_health -= damage
	$Label.text = str(current_health)
	if (current_health <= 0):
		_die()
		
func move_to_point(target_position):
	_on_move()
	var relative_position = target_position - position
	if relative_position.length() <= 8:
		target_position = position
	else:
		emit_signal("find_path", position, target_position, self)
		
func heal(amount):
	current_health += amount
	if current_health > health:
		current_health = health
	$Label.text = str(current_health)
	
func start_attack(villain):
	target_villain = villain
	attack_in_progress = true
	$AttackTimer.start()
		
# private methods
func _on_move():
	$AttackTimer.stop()
	if target_villain:
		target_villain.stop_attack()
	if target_hospital:
		target_hospital.stop_heal()
	stop_attack()
	
func _close_info_panel():
	$HeroPanel.visible = false
	
func _set_initial_position():
	position.x = spawn_area.position.x + rng.randi_range(0, spawn_area.size.x / cell_size) * cell_size
	position.y = spawn_area.position.y + rng.randi_range(0, spawn_area.size.y / cell_size) * cell_size
	target_position = position
	path = []
	
func _ready():
	rng.randomize()
	_set_initial_position()
	$Label.text = str(current_health)
	self.connect("hero_selected", get_node("/root/Main"), "_on_Hero_clicked")
	self.connect("hero_dead", get_node("/root/Main"), "_on_Hero_dead")
	self.connect("find_path", get_node("/root/Main"), "_calculate_new_path")
	
func _on_AttackTimer_timeout():
	target_villain.take_damage(attack)

func _die():
	$AttackTimer.stop()
	emit_signal("hero_dead", self, target_villain)
		
func _process(delta):
	if path:
		var target = path[0]
		var direction = (target - position).normalized()
		position += direction * current_speed * delta
		var current = position
		var dist = position.distance_to(target)
		if position.distance_to(target) < 1:
			path.remove(0)
			if path.size() == 0:
				position = target
				path = null
				var overlaps = $Area2D.get_overlapping_areas()
				for overlap in overlaps: 
					if overlap.has_method("start_hero_interaction"):
						overlap.start_hero_interaction(self)
			
