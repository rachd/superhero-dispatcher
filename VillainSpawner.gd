extends Node2D

var tilemap

export var max_villains = 5
export var spawn_area : Rect2 = Rect2(50, 50, 700, 700)
var villain_count = 0
var villain_scene = preload("res://Villain.tscn")

var rng = RandomNumberGenerator.new()

func instance_villain():
	var villain = villain_scene.instance()
	add_child(villain)
	
	var valid_position = false
	while not valid_position:
		villain.position.x = spawn_area.position.x + rng.randf_range(0, spawn_area.size.x)
		villain.position.y = spawn_area.position.y + rng.randf_range(0, spawn_area.size.y)
		valid_position = test_position(villain.position)
	villain.spawn()
	
func test_position(position: Vector2):
	var cell_coord = tilemap.world_to_map(position)
	var cell_type_id = tilemap.get_cellv(cell_coord)
	var isRoad = false #(cell_type_id)
	return !isRoad
	
func _ready():
	tilemap = get_node("/root/Main/TownTileMap")
	rng.randomize()


func _on_Timer_timeout():
	if villain_count < max_villains:
		instance_villain()
		villain_count += 1
		$Timer.start(rng.randi_range(30, 180))
