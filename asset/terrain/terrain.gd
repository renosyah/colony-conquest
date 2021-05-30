extends TileMap

onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_world_to_map(pos : Vector2):
	return world_to_map(pos)

func clear_tilemap():
	clear()

func set_cell_at(x,y, tile_id):
	set_cell(x,y, tile_id)
	
func generate_battlefield(biom : int, topleft, bottomright : Vector2):
	rng.randomize()
	var simplex = OpenSimplexNoise.new()
	simplex.seed = rng.randi()
	
	simplex.octaves = 4
	simplex.period = 15
	simplex.lacunarity = 1.5
	simplex.persistence = 0.75
	
	for x in range(topleft.x - 20, bottomright.x + 30):
		for y in range(topleft.y - 20, bottomright.y + 30):
			var pos = Vector2(x,y)
			set_cellv(pos,_get_tile_index(biom, simplex.get_noise_2d(float(x),float(y))))
			
	update_bitmask_region()
	
func generate_tilemap_at(_at, _tile_size: Vector2, _biom : int):
	rng.randomize()
	var simplex = OpenSimplexNoise.new()
	simplex.seed = rng.randi()
	
	simplex.octaves = 4
	simplex.period = 15
	simplex.lacunarity = 1.5
	simplex.persistence = 0.75

	for x in range(0, (_tile_size.x * 2) - 2):
		for y in range(0, (_tile_size.y * 2) - 2):
			var pos = Vector2(_at.x + x, _at.y + y)
			set_cellv(pos ,_get_tile_index(_biom, simplex.get_noise_2d(float(x),float(y))))
			
	update_bitmask_region()
	
	
func _get_tile_index(_biom, _noice_sample):
	if _biom == Biom.GRASS_LAND:
			if _noice_sample < 0.0:
				return Biom.TILE_ID.grass
			elif _noice_sample > 1.0 and _noice_sample < 0.2:
				return Biom.TILE_ID.sand
			elif _noice_sample > 0.2 and _noice_sample < 0.3:
				return Biom.TILE_ID.grass
			elif _noice_sample > 0.3 and _noice_sample < 0.6:
				return Biom.TILE_ID.mud
				
	elif _biom == Biom.WET_LAND:
			if _noice_sample < 0.0:
				return Biom.TILE_ID.water
			elif _noice_sample > 1.0 and _noice_sample < 0.2:
				return Biom.TILE_ID.grass
			elif _noice_sample > 0.2 and _noice_sample < 0.3:
				return Biom.TILE_ID.sand
			elif _noice_sample > 0.3 and _noice_sample < 0.6:
				return Biom.TILE_ID.mud
				
	elif _biom == Biom.MUD_LAND:
			if _noice_sample < 0.0:
				return Biom.TILE_ID.mud
			elif _noice_sample > 1.0 and _noice_sample < 0.2:
				return Biom.TILE_ID.grass
			elif _noice_sample > 0.2 and _noice_sample < 0.3:
				return Biom.TILE_ID.sand
			elif _noice_sample > 0.3 and _noice_sample < 0.6:
				return Biom.TILE_ID.grass

	elif _biom == Biom.URBAN_LAND:
			if _noice_sample < 0.0:
				return Biom.TILE_ID.grass
			elif _noice_sample > 1.0 and _noice_sample < 0.2:
				return Biom.TILE_ID.grass
			elif _noice_sample > 0.2 and _noice_sample < 0.3:
				return Biom.TILE_ID.sand
			elif _noice_sample > 0.3 and _noice_sample < 0.6:
				return Biom.TILE_ID.dirt
				
	elif _biom == Biom.SAND_LAND:
			if _noice_sample < 0.0:
				return Biom.TILE_ID.sand
			elif _noice_sample > 1.0 and _noice_sample < 0.2:
				return Biom.TILE_ID.grass
			elif _noice_sample > 0.2 and _noice_sample < 0.3:
				return Biom.TILE_ID.sand
			elif _noice_sample > 0.3 and _noice_sample < 0.6:
				return Biom.TILE_ID.sand
				
	return Biom.TILE_ID.grass

func spawn_tree(pos):
	var tree = preload("res://asset/terrain/tree/tree.tscn").instance()
	tree.position = pos
	add_child(tree)
	
func spawn_bush(pos):
	var tree = preload("res://asset/terrain/bush/bush.tscn").instance()
	tree.position = pos
	add_child(tree)
