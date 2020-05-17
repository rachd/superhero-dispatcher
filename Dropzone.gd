extends StaticBody2D

var hero = ""

func set_hero(h):
	hero = h
	$Label.text = hero
	
func assign_item(item):
	GameVariables.unassigned_items.erase(item)
	GameVariables.assigned_items[hero] = item
	
func position_item_icon(item_icon):
	item_icon.position.x = self.position.x
	item_icon.position.y = self.position.y