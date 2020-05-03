extends ItemList

func _ready():
	var heros = constants.get_hero_stats()
	for hero in heros.keys():
		self.add_item(hero)
	
	