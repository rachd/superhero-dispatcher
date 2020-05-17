extends StaticBody2D

var dragging = false
var item = {}
var starting_x = 0
var starting_y = 0

signal dragsignal

func set_item(i):
	item = i

func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	
func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)

func _set_drag_pc():
	dragging=!dragging
	if (!dragging):
		var overlaps = $Area2D.get_overlapping_areas()
		if len(overlaps) > 0:
			var overlap = overlaps[0]
			if overlap.has_method("assign_item"):
				overlap.assign_item(item, self)
		else:
			position.x = starting_x
			position.y = starting_y

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			starting_x = position.x
			starting_y = position.y
			emit_signal("dragsignal")
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()
