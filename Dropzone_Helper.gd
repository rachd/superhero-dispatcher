extends Area2D

func assign_item(item, item_icon):
	var parent = get_parent()
	if parent.has_method("assign_item"):
		get_parent().assign_item(item)
		get_parent().position_item_icon(item_icon)