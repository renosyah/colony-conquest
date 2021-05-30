extends Node2D

signal on_regions_generated(regions)

onready var _region = preload("res://asset/region/region.tscn")
onready var _world_map = $terrain
onready var _region_holder = $region_holder

var path
var room_positions = []
var tile_size = 32
var min_size = 14
var max_size = 18
var hspread = 650
var vspread = 350

var region_owners = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_region_owners(_region_owners):
	region_owners = null
	region_owners = _region_owners

func make_regions():
	for child in _region_holder.get_children():
		_region_holder.remove_child(child)
	
	for region_owner in region_owners:
		randomize()
		var pos = Vector2(rand_range(-hspread, hspread), rand_range(-vspread, vspread))
		var r = _region.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		_region_holder.add_child(r)
		r.make_region(region_owner.owner_id, region_owner.color,region_owner.logo, pos, Vector2(w, h) * tile_size)

	# wait for movement to stop
	yield(get_tree().create_timer(1.1), 'timeout')
	
	# cull rooms
	for room in _region_holder.get_children():
		room.mode = RigidBody2D.MODE_STATIC
		room_positions.append(Vector3(room.position.x,room.position.y, 0))
		
	# generate a minimum spanning tree connecting the rooms
	path = find_mst(room_positions)
	make_map()
	
	yield(get_tree(), 'idle_frame')
	
	emit_signal("on_regions_generated", _region_holder.get_children())
	

func make_map():
	
	_world_map.clear_tilemap()
	
	# Fill TileMap with walls, then carve empty rooms
	var full_rect = Rect2()
	for room in _region_holder.get_children():
		var r = Rect2(room.position - room.size, room.get_shape().shape.extents * 2)
		full_rect = full_rect.merge(r)
		
	var topleft = _world_map.get_world_to_map(full_rect.position)
	var bottomright = _world_map.get_world_to_map(full_rect.end)

	# fill with dirt/grass/etc
	var filled_tile = Biom.SOLID_TILE_ID.values()[rand_range(0,Biom.SOLID_TILE_ID.size())]
	for x in range(topleft.x - 20, bottomright.x + 30):
		for y in range(topleft.y - 20, bottomright.y + 30):
			_world_map.set_cell_at(x, y, filled_tile)
	
#	_world_map.generate_battlefield(Biom.BIOMS[rand_range(0, Biom.BIOMS.size())].id,topleft,bottomright)
	
	# fill with terrain
	var corridors = []  # One corridor per connection
	for room in _region_holder.get_children():
		var s = (room.size / tile_size).floor()
		var pos = _world_map.get_world_to_map(room.position)
		var ul = (room.position / tile_size).floor() - s
		var room_size = room.get_shape().shape.extents / 24
		_world_map.generate_tilemap_at(ul, room_size, Biom.BIOMS[rand_range(0, Biom.BIOMS.size())].id)
		
		# Carve connecting corridor
		var p = path.get_closest_point(Vector3(room.position.x,  room.position.y, 0))
		for conn in path.get_point_connections(p):
			if not conn in corridors:
				var start = _world_map.get_world_to_map(Vector2(path.get_point_position(p).x,
													path.get_point_position(p).y))
				var end = _world_map.get_world_to_map(Vector2(path.get_point_position(conn).x,
													path.get_point_position(conn).y))									
				carve_path(_world_map, start, end)
		corridors.append(p)
		
		
func find_mst(nodes):
	# Prim's algorithm
	# Given an array of positions (nodes), generates a minimum
	# spanning tree
	# Returns an AStar object
	
	# Initialize the AStar and add the first point
	var path = AStar.new()
	path.add_point(path.get_available_point_id(), nodes.pop_front())
	
	# Repeat until no more nodes remain
	while nodes:
		var min_dist = INF  # Minimum distance so far
		var min_p = null  # Position of that node
		var p = null  # Current position
		# Loop through points in path
		for p1 in path.get_points():
			p1 = path.get_point_position(p1)
			# Loop through the remaining nodes
			for p2 in nodes:
				# If the node is closer, make it the closest
				if p1.distance_to(p2) < min_dist:
					min_dist = p1.distance_to(p2)
					min_p = p2
					p = p1
		# Insert the resulting node into the path and add
		# its connection
		var n = path.get_available_point_id()
		path.add_point(n, min_p)
		path.connect_points(path.get_closest_point(p), n)
		# Remove the node from the array so it isn't visited again
		nodes.erase(min_p)
	return path
		
	
func carve_path(_map, pos1, pos2):
	# Carve a path between two points
	var x_diff = sign(pos2.x - pos1.x)
	var y_diff = sign(pos2.y - pos1.y)
	if x_diff == 0: x_diff = pow(-1.0, randi() % 2)
	if y_diff == 0: y_diff = pow(-1.0, randi() % 2)
	# choose either x/y or y/x
	var x_y = pos1
	var y_x = pos2
	if (randi() % 2) > 0:
		x_y = pos2
		y_x = pos1
	for x in range(pos1.x, pos2.x, x_diff):
		_map.set_cell_at(x, x_y.y,  Biom.TILE_ID.dirt)
		_map.set_cell_at(x, x_y.y + y_diff, Biom.TILE_ID.dirt)  # widen the corridor
	for y in range(pos1.y, pos2.y, y_diff):
		_map.set_cell_at(y_x.x, y, Biom.TILE_ID.dirt)
		_map.set_cell_at(y_x.x + x_diff, y, Biom.TILE_ID.dirt)
		
