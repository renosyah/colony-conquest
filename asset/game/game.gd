extends Node

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

onready var _ui = $game_ui

onready var _waypoint = $waypoint
onready var _audio = $AudioStreamPlayer2D
onready var _music = $music

onready var _bot_attack_delay_timer = $bot/attack_delay

var event_fort = null
var last_clicked_fort = null
var selected_fort = null
var targeting_fort = null

var forts = []
var regions = []

var players = {}
var battle_setting = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	init_game()
	
func init_game():
	
	var s = SaveLoad.new()
	battle_setting = s.load_save(SaveLoad.GAME_BATTLE_FILENAME)
	
	randomize()
	var _name = RandomNameGenerator.generate()
	players[GlobalConst.ID_PLAYER] = battle_setting.players[GlobalConst.ID_PLAYER]
	players[GlobalConst.ID_PLAYER].logistic = battle_setting.starting_logistic
	
	for i in battle_setting.max_bot:
		randomize()
		_name = RandomNameGenerator.generate()
		players[GlobalConst.ID_BOT + str(i)] = {
			owner_id =  GlobalConst.ID_BOT + str(i),
			name = _name + "'s Colony",
			status = GlobalConst.STATUS_IS_BOT,
			color = GlobalConst.get_random_color(),
			logistic = battle_setting.starting_logistic,
			troop_train = 0,
			troop_killed = 0,
			troop_lost = 0,
			buildings = GlobalConst.set_colony_building(_name,GlobalConst.MAX_COLONY_UNIQUE_BUILDING),
			special_buildings = GlobalConst.get_random_special_buildings(),
			fort_facilities = GlobalConst.get_random_fort_facilities(),
			logistic_ugrades = GlobalConst.get_random_logistic_upgrade(),
			logo = Logo.generate_logo()
		}
		
	for i in battle_setting.max_neutral_bot:
		_name = RandomNameGenerator.generate()
		players[GlobalConst.ID_REBEL + str(i)] = {
			owner_id =  GlobalConst.ID_REBEL + str(i),
			name = _name + "'s Native",
			status = GlobalConst.STATUS_IS_REBEL,
			color = GlobalConst.REBEL_COLOR,
			logistic = battle_setting.starting_logistic,
			troop_train = 0,
			troop_killed = 0,
			troop_lost = 0,
			buildings = GlobalConst.set_colony_building(_name,GlobalConst.MAX_COLONY_UNIQUE_BUILDING),
			special_buildings = GlobalConst.get_random_special_buildings(),
			fort_facilities = GlobalConst.get_random_fort_facilities(),
			logistic_ugrades = GlobalConst.get_random_logistic_upgrade(),
			logo = Logo.generate_logo()
		}
		
	var regions_owners = []
	for player in players.values():
		if player.owner_id != GlobalConst.ID_PLAYER:
			regions_owners.append(player)
		
	for i in battle_setting.max_player:
		regions_owners.append(players[GlobalConst.ID_PLAYER].duplicate())
			
			
	_map.biom_id = battle_setting.biom_id
	_map.set_region_owners(regions_owners)
	_map.make_regions()

	_ui.setup_minimap(_camera,players[GlobalConst.ID_PLAYER].color)
	_ui.display_resources_info(get_resources_info(GlobalConst.ID_PLAYER),players[GlobalConst.ID_PLAYER].color)
	
	_camera.enable = false
	_music.stream = preload("res://asset/sound/music.ogg")
	
	_ui.set_game_ui_visible(false)
	_ui.set_data_score(players)
	set_bot_timmer()
	
	set_process(false)
	
	
func set_bot_timmer():
	var wait_time = rand_range(25,35)
	if battle_setting.dificulty == GlobalConst.DIFFICULTY_HARD:
		wait_time = rand_range(15,25)
	elif battle_setting.dificulty == GlobalConst.DIFFICULTY_LEGENDARY:
		wait_time = rand_range(10,15)
		
	_bot_attack_delay_timer.wait_time = wait_time
	_bot_attack_delay_timer.start()

func get_resources_info(id):
	var fort_owned = " " + str(get_number_owned_forts(id)) +"/" + str(forts.size())
	var logistic = " " +  GlobalConst.kFormatter(players[id].logistic)
	return { logistic = logistic, fort = fort_owned }
	
func spawn_forts(regions):
	for region in regions:
		
		# make camera focus to player fort
		if region.owner_id == GlobalConst.ID_PLAYER:
			_camera.position = region.position
			_loading.init_cloud()
			_loading.remove_cloud()
			
			
		var fort = preload("res://asset/military/fort/fort.tscn").instance()
		fort.position = region.position
		fort.owner_id = region.owner_id
		fort.fort_name = "Fort " + RandomNameGenerator.generate()
		fort.color = region.color
		fort.region = region
		fort.logo = region.logo
		_fort_holder.add_child(fort)
		forts.append(fort)
		_ui.add_object_to_minimap(fort)
		
		fort.connect("on_fort_click",self,"_on_fort_click")
		fort.connect("on_fort_captured",self,"_on_fort_captured")
		fort.connect("on_ready_to_train_troop", self, "_on_ready_to_train_troop")
		fort.connect("on_progress_training_troop", self, "_on_progress_training_troop")
		fort.connect("on_training_troop_pending", self, "_on_training_troop_pending")
		fort.connect("on_training_troop_finish", self, "_on_training_troop_finish")
		fort.connect("on_fort_add_garrison",self,"_on_fort_add_garrison")
		fort.connect("on_fort_garrison_dead",self,"_on_fort_garrison_dead")
		
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
		fort.set_fort_bonus({
			attack = rand_range(-3.0,2.0),
			defence = rand_range(-1.5,2.0),
			mobility = rand_range(-2.5,3.0),
			attack_delay = rand_range(-0.1,0.1),
		})
		
		# default building
		fort.add_building(FortBuilding.MILLITIA_BARRACK)
			
		for building in players[region.owner_id].special_buildings:
			spawn_facility(building.image_sprite,formations[rand_range(0,formations.size())].position)
			fort.add_building(building)
			
		for building in players[region.owner_id].fort_facilities:
			fort.add_building(building)
			
		for building in players[region.owner_id].logistic_ugrades:
			fort.add_building(building)
			
			
		
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
	farm.connect("on_income",self,"_on_income")
	_farm_holder.add_child(farm)
	return farm
	
	
func spawn_tree(pos):
	var tree = preload("res://asset/terrain/tree/tree.tscn").instance()
	tree.position = pos
	_env_holder.add_child(tree)
	
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
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _on_income(owner_id,amount):
	if !players.has(owner_id):
		return
	
	var total_amount = amount
	
	# for hard dofficulty
	# AI will get double or quaddruple amount
	if owner_id != GlobalConst.ID_PLAYER:
		if battle_setting.dificulty == GlobalConst.DIFFICULTY_HARD:
			total_amount *= 4.0
		elif battle_setting.dificulty == GlobalConst.DIFFICULTY_LEGENDARY:
			total_amount *= 8.0
		
	players[owner_id].logistic += total_amount
	_ui.display_resources_info(get_resources_info(GlobalConst.ID_PLAYER),players[GlobalConst.ID_PLAYER].color)
	
func _on_ready_to_train_troop(fort, troop_to_train):
	if !players.has(fort.owner_id):
		return
		
	if players[fort.owner_id].logistic - troop_to_train.cost >= 0.0:
		players[fort.owner_id].logistic -= troop_to_train.cost
		_ui.display_resources_info(get_resources_info(GlobalConst.ID_PLAYER),players[GlobalConst.ID_PLAYER].color)
		fort.start_training_troop(troop_to_train)
		
func _on_progress_training_troop(fort, troop_to_train, time_left):
	if last_clicked_fort == fort:
		_ui.display_progress_training_troop(troop_to_train, time_left)

func _on_training_troop_pending(fort):
	if last_clicked_fort == fort:
		_ui.display_pending_training_troop()

func _on_training_troop_finish(fort):
	if last_clicked_fort == fort:
		_ui.display_empty_training_troop()

func _on_fort_add_garrison(fort, troop):
	_ui.add_object_to_minimap(troop)
	
	if !players.has(fort.owner_id):
		return
		
	players[fort.owner_id].troop_train += 1
	
func _on_fort_garrison_dead(fort, troop, attack_by):
	_ui.remove_object_from_minimap(troop)
		
	if !players.has(troop.data.side):
		return
		
		
	if troop.data["class"] == TroopData.CLASS_NON_COMBATANT:
		return
		
		
	if attack_by != "" and players.has(attack_by):
		players[attack_by].troop_killed += 1
		
		
	players[troop.data.side].troop_lost += 1
	
func _on_fort_click(fort, region):
	
	last_clicked_fort = fort
	
	var _fort_display_name = ""
	if players.has(fort.owner_id):
		_fort_display_name = fort.fort_name +"\n("+ players[fort.owner_id].name + ")  "
	else:
		_fort_display_name = fort.fort_name +"\n(Rebel)"
		
	_ui.display_fort_name(_fort_display_name, !region.is_border_showing())
	
	region.show_border(!region.is_border_showing())
	
	if fort.owner_id == GlobalConst.ID_PLAYER:
		if selected_fort:
			# if player click same fort
			if selected_fort == fort:
				selected_fort.regroup_garrison()
				deselect()
				return
			
			# migrate troops
			selected_fort.migrate_garrison(fort)
			_waypoint.show_waypoint(players[GlobalConst.ID_PLAYER].color, fort.global_position)
			_audio.stream = preload("res://asset/sound/click.wav")
			_audio.play()
			deselect()
			
		else:
			# set fort as curently selected fort
			selected_fort = fort
			targeting_fort = null
			_ui.set_visibility_fort_option_ui(true, true)
			set_all_fort_highlight_display(true)
			set_all_player_fort_highlight_display(true)
			_audio.stream = preload("res://asset/sound/click.wav")
			_audio.play()
			
	else:
		
		if selected_fort:
			# attack single to single enemy fort
			selected_fort.attack_enemy_fort(fort)
			_waypoint.show_waypoint(Color.red, fort.global_position)
			_audio.stream = preload("res://asset/sound/assault_click.wav")
			_audio.play()
			deselect()
			
			
		else:
			
			# if player click same fort
			if targeting_fort == fort:
				deselect()
				return
			
			# enable all for attack to one fort ability
			targeting_fort = fort
			show_all_region_border(false)
			region.show_border(true)
			_ui.set_visibility_fort_option_ui(true, false)
			set_all_fort_highlight_display(false)
			fort.highlight(true, Color.red)
			set_all_player_fort_highlight_display(true)
			
func show_all_region_border(show):
	for region in regions:
		region.show_border(show)

func get_owned_forts(owner_id):
	var _forts = []
	for fort in forts:
		if fort.owner_id == owner_id:
			_forts.append(fort)
			
	return _forts
	
func get_number_owned_forts(id):
	return get_owned_forts(id).size()
	
func set_all_fort_highlight_display(is_show):
	for fort in forts:
		fort.highlight(is_show, Color.red)
		
func set_all_player_fort_highlight_display(is_show):
	var _player_forts = get_owned_forts(GlobalConst.ID_PLAYER)
	for fort in _player_forts:
		fort.highlight(is_show, Color.white)
		
		
func _on_loading_on_loading_finish():
	_camera.enable = true
	_ui.set_game_ui_visible(true)
	
func _on_map_on_regions_generated(_regions):
	regions = _regions
	spawn_forts(regions)
	show_all_region_border(false)
	_music.play()

func deselect():
	show_all_region_border(false)
	set_all_fort_highlight_display(false)
	set_all_player_fort_highlight_display(false)
	_ui.set_visibility_fort_option_ui(false, false)
	selected_fort = null
	targeting_fort = null

func _on_fort_captured(fort,new_owner,old_owner):
	if players.has(new_owner):
		if new_owner == GlobalConst.ID_PLAYER:
			event_fort = fort
			var message = fort.fort_name  + " has been captured"
			_ui.display_fort_capture(message)
		
		if old_owner == GlobalConst.ID_PLAYER:
			event_fort = fort
			var message = fort.fort_name  + " has been lost"
			_ui.display_fort_lost(message)
	else:
		if old_owner == GlobalConst.ID_PLAYER:
			event_fort = fort
			var message = fort.fort_name  + " has been rebel"
			_ui.display_fort_rebel(message)
	
	# for legendary difficulty
	# all building in captured fort
	# will be reset to only millitia barrack
	if new_owner == GlobalConst.ID_PLAYER:
		if battle_setting.dificulty == GlobalConst.DIFFICULTY_LEGENDARY:
			var _buildings = fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_UNIT_SPAWNER)
			for building in _buildings:
				fort.remove_building(building.id)
				
			fort.add_building(FortBuilding.MILLITIA_BARRACK)
			
			
	var owned = get_number_owned_forts(GlobalConst.ID_PLAYER)
	
	# win condition
	if owned == forts.size():
		_ui.show_win(players)
	if owned == 0:
		_ui.show_lose(players)
		
	_ui.display_resources_info(get_resources_info(GlobalConst.ID_PLAYER),players[GlobalConst.ID_PLAYER].color)
	
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
		
		
func _on_cloud_spawn_timer_timeout():
	randomize()
	if randf() < 0.3 and (_camera.zoom.x - 1.0) > 0.4:
		var origin = get_random_y()
		spawn_cloud(origin.from,origin.speed)
		
			
func _on_game_ui_on_all_fort_attack_button_pressed():
	if !targeting_fort:
		return
		
	if targeting_fort.owner_id == GlobalConst.ID_PLAYER:
		deselect()
		return
		
	var _forts = get_owned_forts(GlobalConst.ID_PLAYER)
	for fort in _forts:
		if fort.targets.empty():
			fort.attack_enemy_fort(targeting_fort)
	
	_waypoint.show_waypoint(Color.red, targeting_fort.global_position)
	_audio.stream = preload("res://asset/sound/assault_click.wav")
	_audio.play()
	
	
func _on_game_ui_on_build_option_button_pressed():
	if last_clicked_fort:
		var _info = last_clicked_fort.get_fort_info()
		var _buildings = last_clicked_fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_UNIT_SPAWNER)
		var _player_building = players[GlobalConst.ID_PLAYER].buildings
		_ui.display_fort_list_avaliable_building_to_build(_info,_buildings,_player_building)
		_audio.stream = preload("res://asset/sound/click.wav")
		_audio.play()
		
		
func _on_game_ui_on_fort_info_button_pressed():
	if last_clicked_fort and players.has(last_clicked_fort.owner_id):
		_ui.display_fort_info(last_clicked_fort, players[last_clicked_fort.owner_id].name)
		_audio.stream = preload("res://asset/sound/click.wav")
		_audio.play()
		
func _on_game_ui_on_troop_traning_progress_button_pressed():
	if last_clicked_fort:
		_ui.display_fort_list_avaliable_troop_to_train(last_clicked_fort.get_fort_info(),last_clicked_fort.get_list_avaliable_troop_to_train())
		_audio.stream = preload("res://asset/sound/click.wav")
		_audio.play()
		
func _on_game_ui_on_cicle_region_button_pressed():
	
	_audio.stream = preload("res://asset/sound/click.wav")
	_audio.play()
	
	if event_fort:
		_camera.position = event_fort.position
		#_camera.smoothing_enabled = true
		event_fort = null
		return
	
	var _forts = get_owned_forts(GlobalConst.ID_PLAYER)
		
	if _forts.empty():
		return
		
	var _last_nearest_fort = _forts[0]
	for fort in _forts:
		var _distance_to_camera = fort.position.distance_to(_camera.position)
		var _last_nearest_fort_distance_to_camera = _last_nearest_fort.position.distance_to(_camera.position)
		if _distance_to_camera < _last_nearest_fort_distance_to_camera:
			_last_nearest_fort = null
			_last_nearest_fort = fort
			
#	_on_deselect_button_pressed()
#	_on_fort_click(_fort, _fort.region)
	
	_camera.position = _last_nearest_fort.position
	#_camera.smoothing_enabled = true
		
	
func _on_game_ui_on_deselect_button_pressed():
	deselect()
	_audio.stream = preload("res://asset/sound/click.wav")
	_audio.play()
	

func _on_game_ui_on_any_close_button_press():
	_audio.stream = preload("res://asset/sound/click.wav")
	_audio.play()
	
	
func _on_game_ui_on_troop_recruitment_upgrade_button_press(item, cost):
	if players[GlobalConst.ID_PLAYER].logistic - cost >= 0.0:
		players[GlobalConst.ID_PLAYER].logistic -= cost
		item.upgrade_troop()
		
		_audio.stream = preload("res://asset/sound/cash.wav")
		_audio.play()
		
	else:
		
		_audio.stream = preload("res://asset/sound/cant_click.wav")
		_audio.play()
		
	_ui.display_resources_info(get_resources_info(GlobalConst.ID_PLAYER),players[GlobalConst.ID_PLAYER].color)
	
	
func _on_game_ui_on_build_button_press(item, building):
	if !last_clicked_fort:
		return
		
	if players[GlobalConst.ID_PLAYER].logistic - building.cost >= 0.0:
		players[GlobalConst.ID_PLAYER].logistic -= building.cost
		last_clicked_fort.add_building(building)
		item.on_building_build()
		
		_audio.stream = preload("res://asset/sound/building.wav")
		_audio.play()
			
	else:
			
		_audio.stream = preload("res://asset/sound/cant_click.wav")
		_audio.play()
		
	# redisplay building option
	var _info = last_clicked_fort.get_fort_info()
	var _buildings = last_clicked_fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_UNIT_SPAWNER)
	var _player_building = players[GlobalConst.ID_PLAYER].buildings
	_ui.display_fort_list_avaliable_building_to_build(_info,_buildings,_player_building)
	
	_ui.display_resources_info(get_resources_info(GlobalConst.ID_PLAYER),players[GlobalConst.ID_PLAYER].color)
	
		
func _on_game_ui_on_demolish_button_press(item, building_id):
	if !last_clicked_fort:
		return
		
	last_clicked_fort.remove_building(building_id)
	item.on_building_demolish()
	
	# redisplay building option
	var _info = last_clicked_fort.get_fort_info()
	var _buildings = last_clicked_fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_UNIT_SPAWNER)
	var _player_building = players[GlobalConst.ID_PLAYER].buildings
	_ui.display_fort_list_avaliable_building_to_build(_info,_buildings,_player_building)
	
	
	_audio.stream = preload("res://asset/sound/explode3.wav")
	_audio.play()
		
		
func _on_attack_delay_timeout():
	set_bot_timmer()
	
	var _enemies_id_bot_with_forts = []
	for i in battle_setting.max_bot:
		if get_number_owned_forts(GlobalConst.ID_BOT + str(i)) > 0:
			_enemies_id_bot_with_forts.append(GlobalConst.ID_BOT + str(i))
			
	var _neutrals_id_bot_with_forts = []
	for i in battle_setting.max_neutral_bot:
		if get_number_owned_forts(GlobalConst.ID_REBEL + str(i)) > 0:
			_neutrals_id_bot_with_forts.append(GlobalConst.ID_REBEL + str(i))
		
	var _all_target = []
	for key in players.keys():
		if get_number_owned_forts(key) > 0:
			_all_target.append(key)
				
				
	var _all_neutral_target = []
	for i in battle_setting.max_neutral_bot:
		if get_number_owned_forts(GlobalConst.ID_REBEL + str(i)) > 0:
			_all_neutral_target.append(GlobalConst.ID_REBEL + str(i))
			
			
	if !_enemies_id_bot_with_forts.empty() and !_all_target.empty():
		var _enemy_bot_id = _enemies_id_bot_with_forts[rand_range(0,_enemies_id_bot_with_forts.size())]
		enemy_bot_on_action(_enemy_bot_id,_all_target)
		enemy_bot_upgrade_troop(_enemy_bot_id)
		enemy_bot_build(_enemy_bot_id)
			
			
	if !_neutrals_id_bot_with_forts.empty() and !_all_neutral_target.empty():
		var _neutral_bot_id = _neutrals_id_bot_with_forts[rand_range(0,_neutrals_id_bot_with_forts.size())]
		enemy_bot_on_action(_neutral_bot_id,_all_neutral_target)
		enemy_bot_upgrade_troop(_neutral_bot_id)
		enemy_bot_build(_neutral_bot_id)
	
	
func enemy_bot_build(bot_id):
	if !players.has(bot_id):
		return
		
	var _bot_forts = get_owned_forts(bot_id)
	if _bot_forts.empty():
		return
		
	var _bot_buildings = players[bot_id].buildings
	if _bot_buildings.empty():
		return
	
	for fort in _bot_forts:
		var installed_building = fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_UNIT_SPAWNER).size()
		var number_maximum_building = fort.get_fort_info()["maximum_building"]
		if  installed_building < number_maximum_building:
			var _random_building_to_build = _bot_buildings[rand_range(0,_bot_buildings.size())]
			if _random_building_to_build.cost <= players[bot_id].logistic:
				players[bot_id].logistic -= _random_building_to_build.cost
				fort.add_building(_random_building_to_build)
			
			
func enemy_bot_upgrade_troop(bot_id):
	if !players.has(bot_id):
		return
		
	var _bot_forts = get_owned_forts(bot_id)
	if _bot_forts.empty():
		return
		
	for fort in _bot_forts:
		var _list_troop_to_upgrade = fort.get_list_avaliable_troop_to_train().troops
		if !_list_troop_to_upgrade.empty():
			var _random_troop = _list_troop_to_upgrade[rand_range(0,_list_troop_to_upgrade.size())]
			var _troop_upgrade_cost = FortBuilding.get_troop_upgrade_cost(_random_troop)
			if _troop_upgrade_cost <= players[bot_id].logistic:
				players[bot_id].logistic -= _troop_upgrade_cost
				FortBuilding.upgrade_troop(_random_troop)
				
				
func enemy_bot_on_action(bot_id, targets):
	
	if forts.empty():
		return
		
	var _shuffle_fort = []
	var _bot_selected_fort = []
	var _target_fort = null
	
	# select bot player and if all of his fort
	var bot_player = bot_id
	var bot_forts = get_owned_forts(bot_player)
	
	# no fort, no deal
	if bot_forts.empty():
		return
	
	for fort in bot_forts:
		_shuffle_fort.append(fort)
	
	randomize()
	_shuffle_fort.shuffle()
	
	for fort in _shuffle_fort:
		# select only iddle fort
		if fort.owner_id == bot_player and fort.targets.empty():
			_bot_selected_fort.append(fort)
				
			# chance 50/50 to select one or more
			if randf() < 0.5:
				break
				
	# no fort selected, no deal
	if _bot_selected_fort.empty():
		return
	
	_shuffle_fort.clear()
		
		
	for fort in forts:
		
		# only attack specific player id
		if targets.has(fort.owner_id):
			_shuffle_fort.append(fort)
		
	randomize()
	_shuffle_fort.shuffle()
	
	randomize()
	_target_fort = _shuffle_fort[rand_range(0,_shuffle_fort.size())]
		
	# no target fort selected, no deal
	if !_target_fort:
		return
		
	for fort in _bot_selected_fort:
		fort.regroup_garrison()
		
		# only launching full force on normal difficulty
		# prevent player for capturing fort easily
		var is_full_force = (randf() < 0.5 and battle_setting.dificulty == GlobalConst.DIFFICULTY_NORMAL)
		fort.attack_enemy_fort(_target_fort,is_full_force)
		
	#print("army from fort " + _bot_selected_fort.fort_name + " ("+ _bot_selected_fort.owner_id +") is moving toward fort " +_target_fort.fort_name + " ("+ _target_fort.owner_id +")")


