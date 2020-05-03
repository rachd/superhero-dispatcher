extends Control

func set_data(hero_name):
	if (hero_name == ""):
		$VBoxContainer/Name.text = ""
		$VBoxContainer/Health.text = ""
		$VBoxContainer/Speed.text = ""
		$VBoxContainer/Attack.text = ""
	else:
		var hero_data = constants.get_hero_stats()
		var selected_hero = hero_data.get(hero_name)
		$VBoxContainer/Name.text = hero_name
		$VBoxContainer/Health.text = "Health: " + str(selected_hero.get("health"))
		$VBoxContainer/Speed.text = "Speed " + str(selected_hero.get("speed"))
		$VBoxContainer/Attack.text = "Attack: " + str(selected_hero.get("attack"))
	