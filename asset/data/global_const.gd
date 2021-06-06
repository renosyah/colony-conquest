extends Node
class_name GlobalConst

# difficulty
const DIFFICULTY_NORMAL = 0
const DIFFICULTY_HARD = 1
const DIFFICULTY_LEGENDARY = 2

# ids
const ID_PLAYER = "PLAYER-ID"
const ID_BOT = "BOT-ID-"
const ID_REBEL = "NEUTRAL_BOT-ID-"

# fort
const MAX_TROOP_IN_AREA = 45

# player
const STATUS_IS_PLAYER = "IS_PLAYER"
const STATUS_IS_BOT = "STATUS_IS_BOT"
const STATUS_IS_REBEL = "STATUS_IS_REBEL"

# rebel color
const REBEL_COLOR = Color.gray

static func get_random_color() -> Color:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return Color(
		rng.randf_range(0.15,0.80),
		rng.randf_range(0.15,0.80),
		rng.randf_range(0.15,0.80),
		1.0
	)

# minimap
const EXPAND = "EXPAND_MINIMAP"
const NORMAL = "MINI_MINIMAP"

# troop
const MAXIMUM_ENGANGEMENT_DISTANCE = 820.0

static func kFormatter(num) ->String :
	if abs(num) > 999:
		return str(sign(num) * stepify((abs(num)/1000), 0.1)) + 'k'
	return str(sign(num)*abs(num))

# fort build mode 
const BUILD_MODE = "BUILD_MODE"
const DEMOLISH_MODE = "DEMOLISH_MODE"

################# LIST BUILDING ################
const SPAWNER_BUILDINGS  = [
	FortBuilding.MILLITIA_BARRACK, # 200
	FortBuilding.REGULAR_BARRACK, # 500
	FortBuilding.IMPERIAL_BARRACK, # 1200
	FortBuilding.MERCENARY_CAMP, # 900
	FortBuilding.ARCHERY_RANGE, # 700
	FortBuilding.MILLITARY_ACADEMY, #1600
	FortBuilding.STABLE, # 1400
	FortBuilding.IMPERIAL_STABLE, # 1750
	FortBuilding.ROYAL_STABLE # 2000
]

const TROOP_UPGRADE_SPECIAL_BUILDINGS = [
	FortBuilding.BLACKSMITH,
	FortBuilding.ARMORER,
	FortBuilding.RANGE_WORKSHOP,
	FortBuilding.TRAINING_FIELD,
	FortBuilding.HUNTER_LODGE,
	FortBuilding.ARMORY
]

static func get_random_special_buildings(maximum :int = 1) -> Array:
	var buildings = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for i in maximum:
		var building = TROOP_UPGRADE_SPECIAL_BUILDINGS[rng.randf_range(0,TROOP_UPGRADE_SPECIAL_BUILDINGS.size())].duplicate(true)
		buildings.append(building)
	
	return buildings

const FORT_UPGRADE_BUILDINGS = [
	FortBuilding.GARRISON_EXPANSION,
	FortBuilding.EXPERT_SHOTER_TRAINING,
	FortBuilding.ADDITIONAL_SHOTER,
	FortBuilding.FOREIGN_INSTRUCTOR,
	FortBuilding.MILLITARY_MANDATORY_SERVICE,
]
const FORT_REPLACE_BUILDINGS = [
	FortBuilding.MUSKETEER_GARRISON,
	FortBuilding.HEAVY_BALISTA,
	FortBuilding.FIXED_WALL_CANNON,
	FortBuilding.DICIPLINE_FORCE
]

static func get_random_fort_facilities(maximum :int = 1) -> Array:
	var buildings = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if randf() < 0.3:
		var building = FORT_REPLACE_BUILDINGS[rng.randf_range(0,FORT_REPLACE_BUILDINGS.size())].duplicate(true)
		buildings.append(building)
		
	for i in maximum:
		var building = FORT_UPGRADE_BUILDINGS[rng.randf_range(0,FORT_UPGRADE_BUILDINGS.size())].duplicate(true)
		buildings.append(building)
		
	return buildings

const LOGISTIC_UPGRADE_BUILDINGS = [
	FortBuilding.IMPROVE_LAND_FERTILITY_1,
	FortBuilding.IMPROVE_IRRIGATION_1,
	FortBuilding.IMPROVE_HARVESTING_TOOL_1,
	
	FortBuilding.IMPROVE_LAND_FERTILITY_2,
	FortBuilding.IMPROVE_IRRIGATION_2,
	FortBuilding.IMPROVE_HARVESTING_TOOL_2,
	
	FortBuilding.IMPROVE_LAND_FERTILITY_3,
	FortBuilding.IMPROVE_IRRIGATION_3,
	FortBuilding.IMPROVE_HARVESTING_TOOL_3,
]
static func get_random_logistic_upgrade(maximum :int = 1) -> Array:
	var buildings = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for i in maximum:
		var building = LOGISTIC_UPGRADE_BUILDINGS[rng.randf_range(0,LOGISTIC_UPGRADE_BUILDINGS.size())].duplicate(true)
		buildings.append(building)
		
	return buildings
	

const MAX_COLONY_UNIQUE_BUILDING = 3

static func set_colony_building(colony_name, max_unique_building = 1) -> Array:
	var _buildings = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for b in SPAWNER_BUILDINGS:
		_buildings.append(b.duplicate(true))
		
	var unique_buildings = []
	var count = int(rng.randf_range(1,max_unique_building))
	for i in count:
		var generated_building = generate_unique_building(colony_name)
		if !is_already_append(unique_buildings,generated_building):
			unique_buildings.append(generated_building)
	
	for unique_building in unique_buildings:
		embed_building(_buildings,unique_building)
		
	return _buildings

static func is_already_append(items,item) -> bool:
	for i in items:
		if i.id == item.id:
			return true
	return false

static func embed_building(_buildings, building):
	var pos = 0
	for _building in _buildings:
		if _building.id == building.id:
			break
		pos += 1

	building.id = GDUUID.v4()
	_buildings.insert(pos, building)
	
static func generate_unique_building(colony_name) -> Dictionary :
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var _building = SPAWNER_BUILDINGS[rng.randf_range(0,SPAWNER_BUILDINGS.size())].duplicate(true)
	_building.name = colony_name + "'s " + _building.name
	_building.description = "Unique " + colony_name + " " + _building.description 
	_building.cost = round(rng.randf_range(_building.cost - 100, _building.cost + 50))
	
	for troop in _building.troops:
		troop.name = colony_name + "'s " + troop.name
		
		var stats = troop.data.duplicate()
		var unique_stats = {
			"melee_attack_damage" : round(rng.randf_range(stats.melee_attack_damage - 1.0,stats.melee_attack_damage + 5.0)),
			"pierce_attack_damage" : round(rng.randf_range(stats.pierce_attack_damage - 1.0,stats.pierce_attack_damage + 5.0)),
			"hit_point" : round(rng.randf_range(stats.hit_point - 15.0,stats.hit_point + 25.0)),
			"melee_armor" : round(rng.randf_range(stats.melee_armor - 1.0,stats.melee_armor + 5.0)),
			"pierce_armor" : round(rng.randf_range(stats.pierce_armor - 1.0,stats.pierce_armor + 3.0)),
			"range_attack" : round(rng.randf_range(stats.range_attack - 10.0,stats.range_attack + 10.0)),
		}
		var new_cost = troop.cost
		for unique_stats_key in unique_stats.keys():
			if unique_stats[unique_stats_key] < 0.0:
				unique_stats[unique_stats_key] = 1.0
				
			troop.data[unique_stats_key] = unique_stats[unique_stats_key]
			
			if unique_stats[unique_stats_key] > stats[unique_stats_key]:
				new_cost += rng.randf_range(0,15)
			else:
				new_cost -= rng.randf_range(0,15)
		
		troop.cost = round(new_cost)
		
	return _building
	





