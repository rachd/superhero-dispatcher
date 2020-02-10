extends KinematicBody2D

var direction : Vector2 = Vector2.ZERO
var speed = 25
var target_position: Vector2

signal hero_selected(hero)

func pause(isPaused):
	if isPaused:
		speed = 0
	else:
		speed = 25

func on_click():
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
