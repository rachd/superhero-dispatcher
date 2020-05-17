extends Control

var dropzone_scene = preload("res://Dropzone.tscn")
var item_icon_scene = preload("res://ItemIcon.tscn")

func _ready():
	self.add_dropzones()
	self.add_items()

func add_dropzones():
	var heros = ["Zeus", "Artemis"]#GameVariables.selected_heros
	var index = 1
	for hero in heros:
		var dropzone = dropzone_scene.instance()
		dropzone.set_hero(hero)
		dropzone.position.x = (150 * index)
		dropzone.position.y = 500
		add_child(dropzone)
		index += 1
		
func add_items():
	var items = [{
		"id": 0,
		"title": "really nice running sneakers",
		"type": "foot",
		"price": 80
	}]#GameVariables.unassigned_items	
	var index = 1
	for item in items:
		var item_icon = item_icon_scene.instance()
		item_icon.set_item(item)
		item_icon.position.x = (50 * index)
		item_icon.position.y = 50
		add_child(item_icon)
		index += 1
	