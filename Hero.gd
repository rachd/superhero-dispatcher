extends KinematicBody2D

var direction : Vector2 = Vector2.ZERO
var speed = 25
var target_position: Vector2

var info_panel_scene = preload("res://HeroPanel.tscn")
var info_panel

signal hero_selected(hero)

func pause(isPaused):
	if isPaused:
		speed = 0
	else:
		speed = 25

func on_click():
	info_panel = info_panel_scene.instance()
	var panel_size = info_panel.get_size()
	if position.x < panel_size.x:
		info_panel.position.x = 20
	else:
		info_panel.position.x = position.x - 50
	if position.y < panel_size.y:
		info_panel.position.y = 20
	else:
		info_panel.position.y = position.y - 160
	info_panel.set_speed(speed)
	info_panel.set_health(100)
	info_panel.set_attack(5)
	info_panel.set_name("Superhero")
	add_child(info_panel)

func close_info_panel():
	remove_child(info_panel)
	
func on_attack_button_pressed():
	print("clicked")
	close_info_panel()
	emit_signal("hero_selected", self)
	
func _ready():
	target_position = position
	self.connect("hero_selected", get_node("/root/Main"), "_on_Hero_clicked")

func move_to_Villain(villain):
	var relative_position = villain.position - position
	if relative_position.length() <= 4:
		direction = Vector2.ZERO
		target_position = position
	else:
		direction = relative_position.normalized()
		target_position = villain.position
		
func _physics_process(delta):
	var relative_position = target_position - position
	if relative_position.length() > 4:
		var movement = direction * speed * delta
		move_and_collide(movement)
