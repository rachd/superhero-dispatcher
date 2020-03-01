extends TileMap

onready var astar = AStar.new()
onready var half_cell_size = cell_size / 2

# The bounds of the rectangle containing all used tiles on this tilemap
onready var used_rect = get_used_rect()


func _ready():
	_add_traversable_tiles()

## Private functions


func _add_traversable_tiles():
	var all_tiles = get_used_cells()
	var traversable_tiles = []
	for cell in all_tiles:
		var cell_id = _get_id_for_point(cell)
		var cell_name = tile_set.tile_get_name(get_cellv(cell))
		if cell_name == "road":
			traversable_tiles.append(cell)
			astar.add_point(cell_id, Vector3(cell.x, cell.y, 0))
			var top = cell + Vector2(0, -1)
			var left = cell + Vector2(-1, 0)
			var bottom = cell + Vector2(0, 1)
			var right = cell + Vector2(1, 0)
			_connect_traversable_tiles(cell_id, top)
			_connect_traversable_tiles(cell_id, left)
			_connect_traversable_tiles(cell_id, bottom)
			_connect_traversable_tiles(cell_id, right)


func _connect_traversable_tiles(tile_id, target):
	var target_id = _get_id_for_point(target)
	if astar.has_point(target_id):
		astar.connect_points(tile_id, target_id, true)
		

func _get_id_for_point(point):

	# Offset position of tile with the bounds of the tilemap
	# This prevents ID's of less than 0, if points are behind (0, 0)
	var x = point.x - used_rect.position.x
	var y = point.y - used_rect.position.y

	# Returns the unique ID for the point on the map
	return x + y * used_rect.size.x
				

func calculate_path(start, end):
	# Convert positions to cell coordinates
	var start_tile = world_to_map(start)
	var end_tile = world_to_map(end)

	# Determines IDs
	var start_id = _get_id_for_point(start_tile)
	var end_id = _get_id_for_point(end_tile)
	
	var has_start = astar.has_point(start_id)
	var has_end = astar.has_point(end_id)

	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return null

	# Otherwise, find the map
	var path_map = astar.get_point_path(start_id, end_id)

	# Convert Vector3 array (remember, AStar is 3D) to real world points
	var path_world = []
	for point in path_map:
		var point_world = map_to_world(Vector2(point.x, point.y))
		path_world.append(point_world)
	return path_world

func is_road(tile):
	var cell_type_id = get_cellv(tile)
	return cell_type_id == tile_set.find_tile_by_name("road")

func closest_road(start):
	var start_tile = world_to_map(start)
	var top_dist = 0
	var left_dist = 0
	var right_dist = 0
	var bottom_dist = 0
	while true:
		if is_road(start_tile + Vector2(0, -1 * top_dist)):
			return map_to_world(start_tile + Vector2(0, -1 * top_dist))
		elif is_road(start_tile + Vector2(-1 * left_dist, 0)):
			return map_to_world(start_tile + Vector2(-1 * left_dist, 0))
		elif is_road(start_tile + Vector2(0, 1 * bottom_dist)):
			return map_to_world(start_tile + Vector2(0, 1 * bottom_dist))
		elif is_road(start_tile + Vector2(1 * right_dist, 0)):
			return map_to_world(start_tile + Vector2(1 * right_dist, 0))
		else:
			top_dist += 1
			bottom_dist += 1
			left_dist += 1
			right_dist += 1
		
