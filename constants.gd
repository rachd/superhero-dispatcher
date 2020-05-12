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
	
static func get_items():
	return [
	{
		"id": 0,
		"title": "really nice running sneakers",
		"type": "foot",
		"price": 80
	},
	{
		"id": 1,
		"title": "hoverboots",
		"type": "foot",
		"price": 5000
	},
	{
		"id": 2,
		"title": "test 1",
		"type": "foot",
		"price": 200
	},
	{
		"id": 3,
		"title": "test 2",
		"type": "foot",
		"price": 1000
	},
	{
		"id": 4,
		"title": "test3",
		"type": "foot",
		"price": 600
	},
	{
		"id": 5,
		"title": "test4",
		"type": "foot",
		"price": 1400
	},
	{
		"id": 6,
		"title": "test5",
		"type": "foot",
		"price": 1400
	},
	{
		"id": 7,
		"title": "test6",
		"type": "foot",
		"price": 1400
	},
	{
		"id": 8,
		"title": "test7",
		"type": "foot",
		"price": 1400
	},
	{
		"id": 9,
		"title": "test8",
		"type": "foot",
		"price": 1400
	},
	{
		"id": 10,
		"title": "test9",
		"type": "foot",
		"price": 1400
	},
	{
		"id": 11,
		"title": "test10",
		"type": "foot",
		"price": 1400
	}
	]