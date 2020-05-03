extends Control

var hero_count = 0
var selected_heros = []

func _on_HeroList_multi_selected(index, selected):
	var selected_index = selected_heros.find(index)
	if selected_index > -1:
		selected_heros.remove(selected_index)
	else:
		if selected_heros.size() < 3:
			selected_heros.append(index)
			selected_heros.sort()
	self._set_selected_items()
		
func _set_selected_items():
	$MarginContainer/VBoxContainer/HBoxContainer/HeroList.unselect_all()
	for hero_index in range(0, selected_heros.size()):
		var hero = selected_heros[hero_index]
		$MarginContainer/VBoxContainer/HBoxContainer/HeroList.select(hero, false)

	var hero_1 = $MarginContainer/VBoxContainer/HBoxContainer/HeroList.get_item_text(selected_heros[0]) if selected_heros.size() > 0 else ""
	$MarginContainer/VBoxContainer/HBoxContainer/HeroCard.set_data(hero_1)
	var hero_2 = $MarginContainer/VBoxContainer/HBoxContainer/HeroList.get_item_text(selected_heros[1]) if selected_heros.size() > 1 else ""
	$MarginContainer/VBoxContainer/HBoxContainer/HeroCard2.set_data(hero_2)
	var hero_3 = $MarginContainer/VBoxContainer/HBoxContainer/HeroList.get_item_text(selected_heros[2]) if selected_heros.size() > 2 else ""
	$MarginContainer/VBoxContainer/HBoxContainer/HeroCard3.set_data(hero_3)
	
	if selected_heros.size() == 3:
		$MarginContainer/VBoxContainer/StartButton.disabled = false

func _on_StartButton_pressed():
	GameVariables.selected_heros = selected_heros
	get_tree().change_scene("res://Main.tscn")
