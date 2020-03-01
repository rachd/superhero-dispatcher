extends Node2D

var tilemap

const cell_size = 16

export var max_villains = 5
var spawn_area : Rect2 = Rect2(0, 0, 256, 240)
var villain_count = 0
var villain_scene = preload("res://Villain.tscn")
var spawned_villains = []

var rng = RandomNumberGenerator.new()

func instance_villain():
	var villain = villain_scene.instance()
	add_child(villain)
	spawned_villains.append(villain)
	
	var valid_position = false
	while not valid_position:
		villain.position.x = spawn_area.position.x + rng.randi_range(0, spawn_area.size.x / cell_size) * cell_size
		villain.position.y = spawn_area.position.y + rng.randi_range(0, spawn_area.size.y / cell_size) * cell_size
		valid_position = test_position(villain.position)
	villain.spawn()
	
func test_position(position: Vector2):
	var cell_coord = tilemap.world_to_map(position)
	var cell_type_id = tilemap.get_cellv(cell_coord)
	var isRoad = cell_type_id == tilemap.tile_set.find_tile_by_name("road")
	return !isRoad
	
func _ready():
	tilemap = get_node("/root/Main/TownTileMap")
	rng.randomize()

func _on_Timer_timeout():
	if villain_count < max_villains:
		instance_villain()
		villain_count += 1
	$Timer.start(rng.randi_range(5, 10))

func pause(isPaused):
	$Timer.set_paused(isPaused)
	for spawned_villain in spawned_villains:
			spawned_villain.pause(isPaused)
			
func on_villain_died():
	villain_count -= 1
	
