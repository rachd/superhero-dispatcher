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
	self._set_selected_items()
		


func _set_selected_items():
	$HeroList.unselect_all()
	for hero in selected_heros:
		$HeroList.select(hero, false)