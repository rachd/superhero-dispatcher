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