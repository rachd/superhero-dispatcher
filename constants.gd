extends Node

static func getTiles():
	return {
		"office": 0,
		"house": 1,
		"park": 2,
		"road": 3
	}

static func get_initial_budget():
	return 1000

static func get_cell_size():
	return 32

static func get_spawn_area():
	return Rect2(0, 0, 300, 300)
	
static func get_hero_stats():
	return {
		"Zeus": {
			"health": 100,
			"speed": 20,
			"attack": 60
		},
		"Hermes": {
			"health": 70,
			"speed": 40,
			"attack": 40
		},
		"Artemis": {
			"health": 80,
			"speed": 30,
			"attack": 50
		},
		"Poseidon": {
			"health": 90,
			"speed": 25,
			"attack": 50
		}
	}