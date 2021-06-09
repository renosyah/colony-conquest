extends Node

const MAXIMUM_COLONY_GENERATED = 5

onready var _fort_holder = $fort_holder
onready var _env_holder = $env_holder
onready var _flag_holder = $flag_holder
onready var _farm_holder = $farm_holder
onready var _loading = $Camera2D/loading
onready var _map = $map

onready var _camera = $Camera2D
onready var _cloud_spawn_point = $Camera2D/cloud/cloud_spawn_point
onready var _cloud_spawn_point2 = $Camera2D/cloud/cloud_spawn_point2
onready var _cloud_holder = $cloud_holder

onready var _audio = $AudioStreamPlayer2D
onready var _music = $music

onready var _ui = $colony_menu
onready var _adds = $adds

onready var _bandit_holder = $bandit_attack
var bandit_troop_datas = [
	TroopData.TROOP_TYPE_SPEARMAN,
	TroopData.TROOP_TYPE_MACEMAN,
	TroopData.TROOP_TYPE_MILITIAMEN
] 
var forts = []
var regions = []

var battle_setting = {
	players = {},
	max_player = 1,
	max_bot = 4,
	max_neutral_bot = 7,
	max_farm = 3,
	max_tree = 4,
	max_tower = 2,
	starting_logistic = 550.0,
	difficulty = GlobalConst.DIFFICULTY_NORMAL,
	biom_id = Biom.GRASS_LAND
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_camera.enable = false
	_music.stream = preload("res://asset/sound/music.ogg")
	_music.play()
	
	var colonies = load_generated_colonies()
	if colonies.empty():
		colonies = generate_new_colonies()
		save_generated_colonies(colonies)
		
	display_colonies(colonies)
	
	if is_new_daily_reward_session():
		_adds.load_rewarded_video()
		
	_ui.set_randomize_button_visible(false)
	set_process(false)
	
	
func display_colonies(colonies):
	_ui.set_colony_list(colonies)
	battle_setting.players[GlobalConst.ID_PLAYER] = colonies[0]
	spawn_player_choosed_colony()

func load_generated_colonies() -> Array:
	var colonies = []
	var s = SaveLoad.new()
	colonies = s.load_save(SaveLoad.GAME_GENERATED_COLONY_FILENAME)
	if !colonies:
		return []
		
	return colonies
	
func save_generated_colonies(colonies):
	var s = SaveLoad.new()
	s.save(SaveLoad.GAME_GENERATED_COLONY_FILENAME,colonies)

func is_new_daily_reward_session() -> bool:
	var _date_to_string = ("{year}/{month}/{day}").format(OS.get_date())
	
	var s = SaveLoad.new()
	var _session = s.load_save(SaveLoad.GAME_REWARD_SESSION_FILENAME)
	
	if !_session or _session.date != _date_to_string:
		s.save(SaveLoad.GAME_REWARD_SESSION_FILENAME,{date = _date_to_string})
		return true
		
	return false
	
	
func clear_all():
	regions.clear()
	forts.clear()
	remove_node_child(_fort_holder)
	remove_node_child(_farm_holder)
	remove_node_child(_fort_holder)
	remove_node_child(_env_holder)
	remove_node_child(_flag_holder)

func remove_node_child(node):
	for child in node.get_children():
		node.remove_child(child)

func generate_new_colonies() -> Array:
	var colonies = []
	for i in MAXIMUM_COLONY_GENERATED:
		randomize()
		var _name = RandomNameGenerator.generate()
		var colony = {
			owner_id = GlobalConst.ID_PLAYER,
			name = _name + "'s Colony",
			status = GlobalConst.STATUS_IS_PLAYER,
			color = GlobalConst.get_random_color(),#Color(0.04,0.14,0.5,1),
			logistic = battle_setting.starting_logistic,
			troop_train = 0,
			troop_killed = 0,
			troop_lost = 0,
			buildings = [],
			special_buildings = GlobalConst.get_random_special_buildings(),
			fort_facilities = GlobalConst.get_random_fort_facilities(),
			logistic_ugrades = GlobalConst.get_random_logistic_upgrade(),
			logo = Logo.generate_logo()
		}
		
		var max_unique_building = rand_range(1,GlobalConst.MAX_COLONY_UNIQUE_BUILDING)
		for x in max_unique_building:
			var _unique_building = GlobalConst.generate_unique_building(_name)
			if !GlobalConst.is_already_append(colony.buildings,_unique_building):
				colony.buildings.append(
					_unique_building
			)
			
		colonies.append(colony)
		
	return colonies
	
func spawn_player_choosed_colony():
	clear_all()
	_ui.set_visible(false)
	
	var regions_owners = []
	regions_owners.append(battle_setting.players[GlobalConst.ID_PLAYER].duplicate())
		
	_map.set_region_owners(regions_owners)
	_map.make_regions()
	
	_loading.init_cloud()
	
func spawn_cloud(from,speed):
	var cloud = preload("res://asset/ui/cloud/cloud.tscn").instance()
	cloud.position = from
	cloud.is_move = true
	cloud.random_scale()
	cloud.speed = speed
	_cloud_holder.add_child(cloud)

func get_random_y():
	randomize()
	var _speed = rand_range(-150,-300)
	var x = _cloud_spawn_point.global_position.x + 2900
	var y = _cloud_spawn_point.global_position.y
	var y_size = get_viewport().get_visible_rect().size.y
	if randf() < 0.5:
		x = _cloud_spawn_point2.global_position.x - 2900
		y = _cloud_spawn_point2.global_position.y
		y_size = get_viewport().get_visible_rect().size.y
		_speed = -_speed
		
	y = rand_range(y + 1850 , y + y_size - 1850)
	return {from = Vector2(x,y), speed = _speed}
	
func show_all_region_border(show):
	for region in regions:
		region.show_border(show)
	
	
func spawn_forts(regions):
	for region in regions:
			
		var fort = preload("res://asset/military/fort/fort.tscn").instance()
		fort.position = region.position
		fort.owner_id = region.owner_id
		fort.fort_name = "Fort " + RandomNameGenerator.generate()
		fort.color = region.color
		fort.region = region
		fort.logo = region.logo
		_fort_holder.add_child(fort)
		forts.append(fort)
		
		# make camera focus to player fort
		if region.owner_id == GlobalConst.ID_PLAYER:
			_camera.position = region.position
			_camera.position.y += 150.0
			_camera.zoom = Vector2(1.2,1.2)
			_camera.set_anchor(fort.position)
			_loading.init_cloud()
			_loading.remove_cloud()
			
		fort.connect("on_fort_click",self,"_on_fort_click")
#		fort.connect("on_fort_captured",self,"_on_fort_captured")
		fort.connect("on_ready_to_train_troop", self, "_on_ready_to_train_troop")
#		fort.connect("on_progress_training_troop", self, "_on_progress_training_troop")
#		fort.connect("on_training_troop_pending", self, "_on_training_troop_pending")
#		fort.connect("on_training_troop_finish", self, "_on_training_troop_finish")
#		fort.connect("on_fort_add_garrison",self,"_on_fort_add_garrison")
#		fort.connect("on_fort_garrison_dead",self,"_on_fort_garrison_dead")
		
		
		var formations = Formation.new().get_formation_circle(region.position,10, 100)
		var num_env = rand_range(2,battle_setting.max_tree)
		for i in num_env:
			spawn_tree(formations[rand_range(0,formations.size())].position)
			
		var farms = []
		var towers = []
		var num_tower = rand_range(0,battle_setting.max_tower)
		for i in num_tower:
			var tower = spawn_tower(formations[rand_range(0,formations.size())].position)
			towers.append(tower)
			
		var num_farm = rand_range(0,battle_setting.max_farm)
		for i in num_farm:
			var farm = spawn_farm(formations[rand_range(0,formations.size())].position)
			farms.append(farm)
			
		fort.set_fort_property(towers, farms)
		for building in battle_setting.players[region.owner_id].buildings:
			fort.add_building(building)
		
		for building in battle_setting.players[region.owner_id].special_buildings:
			spawn_facility(building.image_sprite,formations[rand_range(0,formations.size())].position)
			fort.add_building(building)
			
		for building in battle_setting.players[region.owner_id].fort_facilities:
			fort.add_building(building)
			
		for building in battle_setting.players[region.owner_id].logistic_ugrades:
			fort.add_building(building)
			
		fort.instant_spawn_garrison()
		fort.show_current_garrison()
			
func spawn_facility(image_sprite, pos):
	randomize()
	var _scatter_x = pos.x + rand_range(-150, 160)
	var _scatter_y = pos.y + rand_range(-150, 160)
	var facility = preload("res://asset/civil/facility/facility.tscn").instance()
	facility.position = Vector2(_scatter_x,_scatter_y)
	facility.image_sprite = image_sprite
	_flag_holder.add_child(facility)

func spawn_tower(pos) -> RigidBody2D :
	randomize()
	var _scatter_x = pos.x + rand_range(-150, 160)
	var _scatter_y = pos.y + rand_range(-150, 160)
	var tower = preload("res://asset/military/tower/tower.tscn").instance()
	tower.position = Vector2(_scatter_x,_scatter_y)
	_flag_holder.add_child(tower)
	return tower
	
func spawn_farm(pos) -> RigidBody2D:
	randomize()
	var _scatter_x = pos.x + rand_range(-150, 160) * 2
	var _scatter_y = pos.y + rand_range(-150, 160) * 2
	var farm = preload("res://asset/civil/farm/farm.tscn").instance()
	farm.position = Vector2(_scatter_x,_scatter_y)
	#farm.connect("on_income",self,"_on_income")
	_farm_holder.add_child(farm)
	return farm
	
func spawn_tree(pos):
	var tree = preload("res://asset/terrain/tree/tree.tscn").instance()
	tree.position = pos
	_env_holder.add_child(tree)
	
func spawn_bandit_troop(troop_data : Dictionary, spawn_pos : Vector2, parent : Node,signal_to_connect : Node, rally_point : Vector2):
	var troop = preload("res://asset/military/troop/troop.tscn").instance()
	troop.data = troop_data.duplicate(true)
	troop.position = spawn_pos
	troop.rally_point = rally_point
	troop.data.side = GDUUID.v4()
	troop.data.color = GlobalConst.REBEL_COLOR
	troop.data.logo = Logo.generate_logo()
#	troop.connect("on_troop_dead",signal_to_connect,"_on_troop_dead")
	troop.connect("on_troop_iddle",signal_to_connect,"_on_troop_iddle")
	troop.set_as_toplevel(true)
	parent.add_child(troop)
	
	troop.set_facing_direction((troop.rally_point - troop.global_position).normalized())
	troop.set_process(true)
	
	
func pick_random_pos_around(from : Vector2) -> Vector2:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var position_picked = Vector2.ZERO
	var count = 15
	while count > 0:
		position_picked = from + Vector2(rng.randf_range(-710,710),rng.randf_range(-710,710))
		var distance_to_from = position_picked.distance_to(from)
		if distance_to_from > 600.0:
			break
			
		count -= 1
		
	return position_picked
	
	
func _on_fort_click(fort,region):
	#_ui.display_colony_info()
	region.show_border(!region.is_border_showing())
	fort.highlight(region.is_border_showing(), Color.white)
	
func _on_ready_to_train_troop(fort, troop_to_train):
	fort.start_training_troop(troop_to_train)
	
	
func _on_map_on_regions_generated(_regions):
	regions = _regions
	spawn_forts(regions)
	show_all_region_border(false)
	_ui.set_player_colony(battle_setting.players[GlobalConst.ID_PLAYER])
	
func _on_loading_on_loading_finish():
	_camera.enable = true
	_ui.set_visible(true)
	
func _on_cloud_spawn_timer_timeout():
	randomize()
	if randf() < 0.3 and (_camera.zoom.x - 1.0) > 0.4:
		var origin = get_random_y()
		spawn_cloud(origin.from,origin.speed)
	
	
func _on_bandit_attack_timeout_timeout():
	for fort in forts:
		var troop = bandit_troop_datas[rand_range(0,bandit_troop_datas.size())]
		spawn_bandit_troop(troop, pick_random_pos_around(fort.global_position), fort.get_garrison_holder(),fort, fort.pick_random_pos_around())
	
	
	
func _on_Camera2D_on_camera_moving(_pos, _zoom):
	var _transparacy =  _zoom.x
	var _cloud_transparacy = (_zoom.x - 1.0) # 1.0 => 0.5
	
	if _transparacy > 0.6:
		_transparacy = 1.0
	elif _transparacy < 0.0:
		_transparacy = 0.4
		
	_fort_holder.modulate.a = _transparacy
	_env_holder.modulate.a = _transparacy 
	_flag_holder.modulate.a = _transparacy 
	_farm_holder.modulate.a = _transparacy 
	
	for fort in forts:
		fort.set_opacity(_transparacy)
		
		
	if _cloud_transparacy < 0.4:
		_cloud_transparacy = 0.0
		
	elif _cloud_transparacy > 1.0:
		_cloud_transparacy = 1.0
		
	for cloud in _cloud_holder.get_children():
		cloud.set_opacity(_cloud_transparacy)
		
		
func _on_colony_menu_on_back_button_click():
	get_tree().change_scene("res://asset/menu/menu.tscn")
	
	
func _on_colony_menu_on_randomize_button_click():
	_adds.show_rewarded_video()
#	get_tree().change_scene("res://asset/menu/colony_menu/colony_menu.tscn")
	
	
func _on_adds_rewarded_video_loaded():
	_ui.set_randomize_button_visible(true)
	
func _on_adds_rewarded_video_closed():
	_ui.set_randomize_button_visible(false)
	
func _on_adds_rewarded_video_failed_to_load(_error_code):
	_ui.set_randomize_button_visible(false)
	
func _on_adds_rewarded(_currency, _ammount):
	_ui.set_randomize_button_visible(true)
	
	var colonies = generate_new_colonies()
	save_generated_colonies(colonies)
	
	get_tree().reload_current_scene()
	
	
func _on_colony_menu_on_battle_setting_set(max_bot, max_neutral_bot, starting_logistic,dificulty,biom_id):
	battle_setting.max_bot = max_bot
	battle_setting.max_neutral_bot = max_neutral_bot
	battle_setting.starting_logistic = starting_logistic
	battle_setting.dificulty = dificulty
	battle_setting.biom_id = biom_id
	
	
func _on_colony_menu_on_start_battle_button_click():
	var colony_name = battle_setting.players[GlobalConst.ID_PLAYER].name
	var unique_buildings = battle_setting.players[GlobalConst.ID_PLAYER].buildings.duplicate(true)
	
	battle_setting.players[GlobalConst.ID_PLAYER].buildings.clear()
	battle_setting.players[GlobalConst.ID_PLAYER].buildings += GlobalConst.SPAWNER_BUILDINGS.duplicate(true)
	
	for unique_building in unique_buildings:
		 GlobalConst.embed_building(battle_setting.players[GlobalConst.ID_PLAYER].buildings, unique_building)
	
	var s = SaveLoad.new()
	s.save(SaveLoad.GAME_BATTLE_FILENAME, battle_setting)
	
	get_tree().change_scene("res://asset/game/game.tscn")
	
	
	
func _on_colony_menu_on_colony_item_click(data):
	battle_setting.players[GlobalConst.ID_PLAYER] = data
	spawn_player_choosed_colony()
	




