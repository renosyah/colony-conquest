extends RigidBody2D

const MINIMAP_MARKER = "fort"
var MINIMAP_COLOR = Color.white

signal on_fort_click(fort, region)
signal on_fort_captured(fort, by, from)
signal on_fort_add_garrison(fort, troop)
signal on_fort_garrison_dead(fort, troop ,attacked_by)

signal on_ready_to_train_troop(fort, troop_to_train)
signal on_progress_training_troop(fort, troop_to_train, time_left)
signal on_training_troop_finish(fort)
signal on_training_troop_pending(fort)

onready var rng = RandomNumberGenerator.new()
onready var _sprite = $Sprite
onready var _collision = $CollisionShape2D
onready var _garrison = $garrison_holder
onready var _dead_body_holder = $dead_body_holder
onready var _burning_holder = $burning_holder
onready var _shooting_point = $shooting_point
onready var _training_time = $training_time
onready var _shot_delay = $shot_delay
onready var _audio = $AudioStreamPlayer2D
onready var _animation = $AnimationPlayer
onready var _flag = $flag
onready var _garrison_text = $Sprite2/garrison_text
onready var _input_detection = $input_detection
onready var _garrison_ballance_progress = $Sprite2/garrison_ballance_progress
onready var _highlight_sprite = $highlight_sprite

var fort_rebel_id = ""
var fort_rebel_logo = {}

var _target = null

var targets = []
var trespassers = []
var current_training_troop = null

# properties
var owner_id = ""
var fort_name = ""
var color = Color.white
var logo = {}
var region : RigidBody2D

var towers = []
var farms = []

var _data = {
	# buildings
	buildings = [],
	maximum_building = 2,
	
	# unit spawner
	max_troop = 15,
	training_time = 1.0,
	training_fee =  0.0,
	
	# defence
	shot_delay = 1.6,
	damage = 4.1,
	max_shoter = 1,
	speed = 800,
	spread = 0.2,
	payload_scene = "",
	projectile_sprite = "res://asset/military/projectile/arrow/arrow.png",
	show_tracer = true,
	firing_sound = "res://asset/sound/arrow_fly.wav",
	
	
	# min garrison to prevent capture
	min_garrison_defend = 5,
	max_garrison_to_rebel = 15,
	
	# fort combat bonus for both side
	# to spice things up a bit
	fort_bonus = {
		attack = 0.0,
		defence = 0.0,
		mobility = 0.0,
		attack_delay = 0.0
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	MINIMAP_COLOR = color
	_data.max_troop = int(rand_range(8,18))
	_data.maximum_building = int(rand_range(2,4))
	_sprite.texture = preload("res://asset/military/fort/wooded_fort.png")
	if _data.max_troop >= 12:
		_sprite.texture = preload("res://asset/military/fort/castle.png")
		
	_training_time.wait_time = 1
	_collision.scale = Vector2(2,2)
	_flag.set_appearance(color, logo)
	_input_detection.connect("any_gesture", self, "_on_input_touch_is_validated")

	region.connect("on_region_click", self , "_on_region_click")
	region.connect("on_region_detect_body",self,"_on_region_detect_body")
	region.connect("on_body_leave_region",self,"_on_body_leave_region")
	
	show_current_garrison()
	_highlight_sprite.visible = false
	
	fort_rebel_id = GlobalConst.ID_REBEL + GDUUID.v4()
	fort_rebel_logo = Logo.generate_logo()
	
func _on_region_detect_body(body):
	if body is Troop:
			
		if !body.is_alive:
			return
			
		body.set_bonus(_data.fort_bonus)
			
		if trespassers.has(body):
			return
			
		if body.data.side == owner_id:
			return
			
		trespassers.append(body)
			
			
		if body.get_parent() != get_garrison_holder():
			return
			
		body.maximum_engangement_distance = GlobalConst.MAXIMUM_ENGANGEMENT_DISTANCE
			
		if targets.has(body):
			return
			
		trespassers.erase(body)
		targets.append(body)
		
		_on_troop_iddle(body)
		
		
func _on_body_leave_region(body):
	if body is Troop:
		if targets.has(body):
			targets.erase(body)
		
		if trespassers.has(body):
			trespassers.erase(body)
			
		body.remove_bonus()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _shot_delay.is_stopped() and _target:
		for i in _data.max_shoter:
			_shoot_at(_target)
			
		var delay = _data.shot_delay
		if delay < 0.1:
			delay = 0.1
		_shot_delay.wait_time = delay
		_shot_delay.start()
		
		if _target.data.side == owner_id:
			_target = null
		
		
	if current_training_troop:
		emit_signal("on_progress_training_troop", self , current_training_troop, _training_time.time_left)
		
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		emit_signal("on_fort_click", self, region)
		
	# if touch screen
	_input_detection.check_input(event)
	
func _on_input_touch_is_validated(sig ,event):
	if event is InputEventSingleScreenTap:
		emit_signal("on_fort_click", self, region)
		
func _on_region_click(is_showing):
	_animation.stop()
	
	if is_showing:
		_animation.play()
		
	for tower in towers:
		tower.on_region_click(is_showing)
		
	for farm in farms:
		farm.on_region_click(is_showing)
		
		
func set_opacity(_transparacy):
	_sprite.modulate.a = _transparacy

func highlight(is_show,color):
	_highlight_sprite.visible = is_show
	_highlight_sprite.modulate = color
	_highlight_sprite.modulate.a = 0.8
	_animation.stop()
	if is_show:
		_animation.play()
		
func instant_set_fort_ownership(new_owner_id : String, new_owner_color : Color,new_owner_logo : Dictionary):
	owner_id = new_owner_id
	color = new_owner_color
	logo = new_owner_logo
	MINIMAP_COLOR = color
	refresh_fort()
	region.update_ownership(owner_id,color)
	clear_non_garrison()
	instant_spawn_garrison()
	set_fort_property_owner()

func refresh_fort():
	_flag.set_appearance(color,logo)
	
func _on_training_time_timeout():
	
	if current_training_troop:
		spawn_troop(current_training_troop.data)
		current_training_troop = null
		show_current_garrison()
		
		emit_signal("on_training_troop_finish", self)
		
		
func pick_random_troop_to_train():
	
	emit_signal("on_training_troop_pending", self)
	
	# currently still in training
	if current_training_troop:
		return
		
	# predict if traning result in garrrison overload
	# just dont
	if check_owned_troop_number() >= _data.max_troop:
		return
		
	var _random_troop = pick_random_troop_and_apply_upgrade()
	if _random_troop.empty():
		return
	
	emit_signal("on_ready_to_train_troop", self, _random_troop)

func pick_random_troop_and_apply_upgrade() -> Dictionary:
	randomize()
	
	var recruitment_center = get_list_avaliable_troop_to_train()
	var _only_enabled_troop = []
	for troop in recruitment_center.troops:
		if troop.enable:
			_only_enabled_troop.append(troop)
	
	if _only_enabled_troop.empty():
		return {}
	
	var troop_data = _only_enabled_troop[rand_range(0,_only_enabled_troop.size())].duplicate(true)
			
	# buff the heck out unit
	for upgrade in recruitment_center.upgrades:
		if troop_data["data"]["class"] == upgrade.unit_class:
			troop_data["data"][upgrade.attribute] += upgrade.value 
	
	# add training fee
	var total_fee = troop_data.cost + _data.training_fee
	if total_fee < 0.0:
		total_fee = 0.0
	troop_data.cost = total_fee
	
	# add training time
	var total_training_time = troop_data.training_time + _data.training_time
	if total_training_time < 0.0:
		total_training_time = 1.0
		
	troop_data.training_time = total_training_time
	
	return troop_data

func start_training_troop(_troop_to_train):
	current_training_troop = _troop_to_train
	_training_time.wait_time = _troop_to_train.training_time
	_training_time.start()
	
	var chatter = preload("res://asset/ui/squad_chatter/squad_chatter.tscn").instance()
	chatter.position = position
	chatter.color = Color.red
	chatter.text = "-" + str(current_training_troop.cost)
	add_child(chatter)

func set_fort_property(_towers, _farms : Array):
	towers = _towers
	farms = _farms
	set_fort_property_owner()
	
func set_fort_property_owner():
	for tower in towers:
		tower.on_fort_captured(self)
		tower.set_targets(targets)
		
	for farm in farms:
		farm.on_fort_captured(self)
		farm.set_enemies_nearby(targets)
	
	
func add_building(_building):
	var is_exist = false
	for building in _data.buildings:
		if building.id == _building.id:
			is_exist = true
			break
	
	if is_exist:
		return
	
	_data.buildings.append(_building.duplicate(true))
	
	# apply update
	if _building.type == FortBuilding.BUILDING_TYPE_CASTLE_UPGRADER:
		if _building.mode == FortBuilding.CASTLE_UPGRADE_MODE_ADD:
			for update in _building.updates:
				_data[update.attribute] += update.value
		if _building.mode == FortBuilding.CASTLE_UPGRADE_MODE_REPLACE:
			for update in _building.updates:
				_data[update.attribute] = update.value
				
	elif _building.type == FortBuilding.BUILDING_TYPE_FARM_UPGRADER:
		for update in _building.updates:
			for farm in farms:
				farm.data[update.attribute] += update.value
	
func remove_building(_building_id):
	var pos = 0
	for building in _data.buildings:
		if building.id == _building_id:
			break
		pos += 1
	
	# currently only spawner building can be build and demolish
	# other, kindda tricky to do at the moment
	if _data.buildings[pos].type == FortBuilding.BUILDING_TYPE_UNIT_SPAWNER:
		_data.buildings.remove(pos)
		
		
func get_troop_garrison() -> Array:
	var troops = []
	for troop in _garrison.get_children():
		if troop.data.side == owner_id:
			troops.append(troop)
	return troops
	
func get_garrison_holder() -> Node2D:
	return _garrison

func pick_random_pos_around() -> Vector2:
	rng.randomize()
	var position_picked = Vector2.ZERO
	var count = 15
	while count > 0:
		position_picked = _collision.global_position + Vector2(rng.randf_range(-410,410),rng.randf_range(-410,410))
		var distance_to_fort = position_picked.distance_to(_collision.global_position)
		if distance_to_fort > 300.0:
			break
			
		count -= 1
		
	return position_picked

func clear_non_garrison():
	for troop in _garrison.get_children():
		if troop.data.side != owner_id or troop.data.side == fort_rebel_id:
			_garrison.remove_child(troop)
			_dead_body_holder.add_child(troop)
			
	for troop in _dead_body_holder.get_children():
		troop.set_dead(false)
			

func show_current_garrison():
	var count = get_troop_garrison().size()
	
	_garrison_text.modulate = Color.white
	_garrison_text.modulate.a = 1
	
	if count > _data.max_troop:
		_garrison_text.modulate = Color.red
		
	if count < _data.min_garrison_defend:
		_garrison_text.modulate.a = 0.5
		
	_garrison_text.text = str(count) + "/" + str(_data.max_troop)
		
		
func regroup_garrison():
	targets.clear()

	for troop in get_troop_garrison():
		troop.target = null
		troop.rally_point = _garrison.global_position + Vector2(rng.randf_range(-80,80),rng.randf_range(-80,80))
		troop.set_facing_direction((troop.rally_point - troop.global_position).normalized())
		troop.set_process(true)

	region.reset_area()
		
func migrate_garrison(new_fort : Node, send_full = false, with_cosmetic_troop = false):
	
	# migrate kok same fort
	# bha ha
	if new_fort == self:
		return
	
	# no troop to spare
	# no deal
	if get_troop_garrison().empty():
		return
	
	# for performace reason
	if new_fort.get_garrison_holder().get_child_count() >= GlobalConst.MAX_TROOP_IN_AREA:
		return
	
	# send half
	var troop_ordered = int(get_troop_garrison().size() / 2)
		
	if send_full:
		troop_ordered = get_troop_garrison().size()
		
	var migrate_troops = []
	for troop in get_troop_garrison():
		if troop_ordered <= 0:
			break
		migrate_troops.append(troop)
		troop_ordered -= 1
	
	if migrate_troops.empty():
		return
		
	if with_cosmetic_troop:
		if migrate_troops.size() >= 2:
			var flag_holder = TroopData.TROOP_TYPE_FLAG_HOLDER.duplicate(true)
			flag_holder.weapon.color = color
			flag_holder.weapon.logo = logo
			spawn_troop(flag_holder, pick_random_pos_around() , new_fort ,new_fort.get_garrison_holder(), new_fort.pick_random_pos_around())
		
		if migrate_troops.size() >= 4:
			spawn_troop(TroopData.TROOP_TYPE_DRUMMER.duplicate(true), pick_random_pos_around() , new_fort ,new_fort.get_garrison_holder(), new_fort.pick_random_pos_around())
		
		
	for troop in migrate_troops:
		for _signal in troop.get_signal_connection_list("on_troop_dead"):
			troop.disconnect("on_troop_dead",self,_signal.method)
			
		for _signal in troop.get_signal_connection_list("on_troop_iddle"):
			troop.disconnect("on_troop_iddle",self,_signal.method)

		troop.connect("on_troop_dead",new_fort,"_on_troop_dead")
		troop.connect("on_troop_iddle",new_fort, "_on_troop_iddle")
		
		troop.maximum_engangement_distance = INF
		troop.target = null
		troop.rally_point = new_fort.pick_random_pos_around()
		troop.set_facing_direction((troop.rally_point - troop.global_position).normalized())
		troop.set_process(true)
		
		_garrison.remove_child(troop)
		new_fort.get_garrison_holder().add_child(troop)
		
	new_fort.show_current_garrison()
	show_current_garrison()
		
		
func attack_enemy_fort(enemy_fort,send_full = false):
	migrate_garrison(enemy_fort, send_full, true)
	
		
func spawn_troop(troop_data : Dictionary,spawn_pos : Vector2 = pick_random_pos_around(), signal_to_connect : Node = self, parent : Node = _garrison, rally_point : Vector2 = pick_random_pos_around()):
	var _pos = _garrison.position + Vector2(rng.randf_range(-110,110),rng.randf_range(-110,110))
	_pos.y -= 200
	var troop = preload("res://asset/military/troop/troop.tscn").instance()
	troop.data = troop_data.duplicate(true)
	troop.position = spawn_pos
	troop.rally_point = rally_point
	troop.data.side = owner_id
	troop.data.color = color
	troop.data.logo = logo
	troop.connect("on_troop_dead",signal_to_connect,"_on_troop_dead")
	troop.connect("on_troop_iddle",signal_to_connect,"_on_troop_iddle")
	troop.set_as_toplevel(true)
	parent.add_child(troop)
	
	troop.set_facing_direction((troop.rally_point - troop.global_position).normalized())
	troop.set_process(true)
	
	emit_signal("on_fort_add_garrison", signal_to_connect, troop)
	
	
func _on_troop_iddle(troop):
	update_troop_task(troop)

func _on_troop_dead(troop, attack_by):
	emit_signal("on_fort_garrison_dead", self, troop, attack_by)
	show_current_garrison()
	
func set_fort_bonus(_bonus):
	_data.fort_bonus = _bonus.duplicate()
	
# pick a target or roaming arround
func update_troop_task(troop):
	
	# for non combatan
	if troop.data["class"] == TroopData.CLASS_NON_COMBATANT:
		troop.rally_point = pick_random_pos_around()
		troop.set_facing_direction((troop.rally_point - troop.global_position).normalized())
		troop.set_process(true)
		return
	
	rng.randomize()
	
	# if troop are garrison in fort
	if troop.data.side == owner_id:
		troop.rally_point = pick_random_pos_around()
		troop.set_facing_direction((troop.rally_point - troop.global_position).normalized())
		
		var _targets = targets + trespassers
		
		if !_targets.empty():
			var tar = _targets[rng.randf_range(0,_targets.size())]
			
			if is_instance_valid(tar):
				var target_distance_to_fort = tar.global_position.distance_to(global_position)
				
				if tar.is_alive and target_distance_to_fort < GlobalConst.MAXIMUM_ENGANGEMENT_DISTANCE:
					troop.rally_point = null
					troop.target = tar
					troop.display_attack_chatter()
					troop.set_facing_direction((tar.global_position - troop.global_position).normalized())
			
		if troop.rally_point or troop.target:
			troop.set_process(true)
	
	# if troop are enemy in fort
	elif troop.data.side != owner_id:
		troop.rally_point = pick_random_pos_around()
		troop.set_facing_direction((troop.rally_point - troop.global_position).normalized())
		
		if !get_troop_garrison().empty():
			var _gar_target = get_troop_garrison()
			var tar = _gar_target[rng.randf_range(0,_gar_target.size())]
			
			if is_instance_valid(tar):
				var target_distance_to_fort = tar.global_position.distance_to(global_position)
				
				if tar.is_alive and target_distance_to_fort < GlobalConst.MAXIMUM_ENGANGEMENT_DISTANCE:
					troop.rally_point = null
					troop.target = tar
					troop.display_attack_chatter()
					troop.set_facing_direction((tar.global_position - troop.global_position).normalized())
			
		if troop.rally_point or troop.target:
			troop.set_process(true)
			
		
func _update_troop_facing_direction(_waypoint):
	for child in _garrison.get_children():
		child.set_facing_direction((_waypoint - child.global_position).normalized())
		
		
func _on_timer_fort_checking_timeout():
	pick_fort_target()
	check_capturing_condition()
	check_garrison_capacity_status()
	check_rebeling_condition()
	pick_random_troop_to_train()
	
func check_owned_troop_number() -> int:
	return get_troop_garrison().size()

func pick_fort_target():
	if _target:
		return
		
	if targets.empty():
		return
		
	rng.randomize()
	_target = targets[rng.randf_range(0,targets.size())]
	
	for tower in towers:
		tower.pick_tower_target()
		
		
# this will return pointer to array of building !!!!
# any change will result change in fort too  !!!!
func get_list_avaliable_troop_to_train() -> Dictionary:
	# get building data content
	var troops_from_building = []
	var troop_upgrades_from_building = []
	for building in _data.buildings:
		if building.type == FortBuilding.BUILDING_TYPE_UNIT_SPAWNER:
			troops_from_building += building.troops
		elif building.type == FortBuilding.BUILDING_TYPE_UNIT_UPGRADER:
			troop_upgrades_from_building += building.updates
			
	return {troops = troops_from_building, upgrades = troop_upgrades_from_building } 

# this will return pointer to array of building !!!!
# any change will result change in fort too  !!!!
func get_list_installed_building(_type) -> Dictionary:
	# get building data content
	var _buildings = []
	for building in _data.buildings:
		if building.type == _type:
			_buildings.append(building)
	
	return _buildings
	
	
func get_fort_info() -> Dictionary:
	var _building_names = []
	var info = _data.duplicate(true)
	for name in _data["buildings"]:
		_building_names.append(name.name)
		
	info["buildings"] = _building_names
	
	info["tower"] = towers.size()
	info["farm"] = farms.size()
	
	info["sprite"] = _sprite.texture
	 
	return info

func check_garrison_capacity_status():
		
		
	# there is still enemy in here
	if !targets.empty():
		return
		
	# if fort is already rebeled
	# please just stop
	if owner_id == fort_rebel_id:
		
		# just kill overload rebel
		# for sake of game performace
		if get_troop_garrison().size() > _data.max_troop:
			var attrition_rebel = get_troop_garrison().front()
			if attrition_rebel.data.side == fort_rebel_id:
				_garrison.remove_child(attrition_rebel)
				_dead_body_holder.add_child(attrition_rebel)
				attrition_rebel.set_dead(false)
				
		return
		
		
	if get_troop_garrison().empty():
		return
		
	if get_troop_garrison().size() > _data.max_troop:
		_spawn_burning()
			
		var attrition_troop = get_troop_garrison().front()
			
		# change troop into rebel
		attrition_troop.data.side = fort_rebel_id
		attrition_troop.data.color = GlobalConst.REBEL_COLOR
		attrition_troop.data.logo = fort_rebel_logo
		attrition_troop.init_troop()
		trespassers.append(attrition_troop)
		update_troop_task(attrition_troop)
		
		var chatter = preload("res://asset/ui/squad_chatter/squad_chatter.tscn").instance()
		chatter.position = attrition_troop.position
		chatter.text = ""
		chatter.speed = 200
		chatter.texture = preload("res://asset/ui/icons/angry_face.png")
		add_child(chatter)
		
		show_current_garrison()
			
			
func check_rebeling_condition():
	
	# there is still enemy in here
	if !targets.empty():
		return
		
	# if fort is already rebeled
	# please just stop
	if owner_id == fort_rebel_id:
		return
		
	var message = ""
	var old_owner = owner_id + ""
	
	if get_troop_garrison().size() > _data.max_troop and randf() < 0.5:
		_spawn_burning()
			
		message = "Troop Rebeling!"
			
			
	# if troop who rebel exeed maximum
	# limit set, fort will fall into rebel
	if get_rebel_troop_in_garrison().size() >= _data.max_garrison_to_rebel:
		for i in 3:
			_spawn_burning()
		
		instant_set_fort_ownership(fort_rebel_id,GlobalConst.REBEL_COLOR,fort_rebel_logo)
		message = "Overrun by rebel!"
		emit_signal("on_fort_captured", self, fort_rebel_id , old_owner)
		
	if message != "":
		var chatter = preload("res://asset/ui/squad_chatter/squad_chatter.tscn").instance()
		chatter.position = position
		chatter.text = message
		chatter.speed = 80
		add_child(chatter)
		
		
func check_capturing_condition():
	
	_garrison_ballance_progress.visible = false
		
	if targets.empty():
		return
		
	var message = "Fort Captured!"
	var total_number_owned_troop = check_owned_troop_number()
	var total_number_enemy_troop = 0
	var enemies = {}
	
	for target in targets:
		if enemies.has(target.data.side):
			enemies[target.data.side]["number"] += 1
		else:
			enemies[target.data.side] = {
				"color" : target.data.color,
				"side" : target.data.side,
				"logo" : target.data.logo,
				"number" : 1
			}
		
	if enemies.empty():
		return
		
		
	var current_enemy_with_highes_total_troop_in_area = null
	for enemy in enemies.values():
		if current_enemy_with_highes_total_troop_in_area == null:
			current_enemy_with_highes_total_troop_in_area = enemy
			
		elif enemy["number"] > current_enemy_with_highes_total_troop_in_area["number"]:
			current_enemy_with_highes_total_troop_in_area = enemy
		
	total_number_enemy_troop = current_enemy_with_highes_total_troop_in_area["number"]
		
	var max_value = total_number_owned_troop + total_number_enemy_troop - _data.min_garrison_defend
	_garrison_ballance_progress.visible = total_number_enemy_troop
	_garrison_ballance_progress.tint_progress = current_enemy_with_highes_total_troop_in_area["color"]
	
	if total_number_enemy_troop < max_value:
		_garrison_ballance_progress.max_value = max_value
		_garrison_ballance_progress.value = total_number_enemy_troop
		
	# capture condition
	var is_garrison_is_overrun = total_number_owned_troop < _data.min_garrison_defend and total_number_owned_troop < total_number_enemy_troop

	if is_garrison_is_overrun:
		message = "Fort Captured!"
		
	if is_garrison_is_overrun:
		targets.clear()
		var old_owner = owner_id + ""
		owner_id = current_enemy_with_highes_total_troop_in_area["side"]
		color = current_enemy_with_highes_total_troop_in_area["color"]
		logo = current_enemy_with_highes_total_troop_in_area["logo"]
		MINIMAP_COLOR = color
		_flag.set_appearance(color,logo)
		region.update_ownership(owner_id,color)
		clear_non_garrison()
		set_fort_property_owner()
			
		for new_garrison in get_troop_garrison():
			new_garrison.perform_celebration()
		
		var chatter = preload("res://asset/ui/squad_chatter/squad_chatter.tscn").instance()
		chatter.position = position
		chatter.text = message
		chatter.speed = 80
		add_child(chatter)
		
		emit_signal("on_fort_captured", self, owner_id , old_owner)
	
func instant_spawn_garrison():
	
	# enable all recritment
	for building in _data.buildings:
		if building.type == FortBuilding.BUILDING_TYPE_UNIT_SPAWNER:
			for troop in building.troops:
				troop.enable = true
	
	for i in _data.max_troop:
		var _random_troop = pick_random_troop_and_apply_upgrade().data
		if _random_troop.empty():
			return
			
		spawn_troop(_random_troop)
		
		
func get_rebel_troop_in_garrison() -> Array:
	var troops = []
	for troop in _garrison.get_children():
		if troop.data.side == fort_rebel_id:
			troops.append(troop)
	return troops
	
	
func _spawn_burning():
	randomize()
	var burn = preload("res://asset/ui/burning/burning.tscn").instance()
	burn.position = position + Vector2(rand_range(-175,175),rand_range(-175,175))
	burn.set_as_toplevel(true)
	_burning_holder.add_child(burn)
	
func _shoot_at(_target):
	var from = _shooting_point.global_position + Vector2(rand_range(-20,20),rand_range(-20,20))
	var direction = (_target.global_position - global_position).normalized()
	var projectile = preload("res://asset/military/projectile/projectile.tscn").instance()
	projectile.side = owner_id
	projectile.damage = _data.damage
	projectile.speed = _data.speed
	projectile.spread = _data.spread
	projectile.show_tracer = _data.show_tracer
	if _data.payload_scene != "":
		projectile.payload_scene = _data.payload_scene
		
	projectile.sprite = load(_data.projectile_sprite)
	projectile.lauching(from, direction)
	add_child(projectile)
	_play_weapon_firing()
	
func _play_weapon_firing():
	_audio.stream = load(_data.firing_sound)
	_audio.play()
	
	
func _on_disable_physic_timer_timeout():
	_sprite.set_as_toplevel(true)
	_sprite.position = position
	_flag.set_as_toplevel(true)
	_flag.position = position
	_flag.position.y += 40
	_flag.position.x -= 20
	_collision.scale = Vector2(1,1)
	_collision.disabled = true
	sleeping = true


