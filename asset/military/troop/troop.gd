extends KinematicBody2D
class_name Troop

const MINIMAP_MARKER = "troop"
var MINIMAP_COLOR = Color.white

const dead_animations = [
	"troop_dead",
	"troop_dead_2"
]
const attack_animations = [
	"troop_attacking"
]

const MINIMUM_RANGE_ATTACK = 70.0


# const
const dead_sound = [
	preload("res://asset/sound/maledeath1.wav"),
	preload("res://asset/sound/maledeath2.wav"),
	preload("res://asset/sound/maledeath3.wav"),
	preload("res://asset/sound/maledeath4.wav"),
]
const combats_sound = [
	preload("res://asset/sound/fight1.wav"),
	preload("res://asset/sound/fight2.wav"),
	preload("res://asset/sound/stab2.wav"),
	preload("res://asset/sound/stab2.wav"),
	preload("res://asset/sound/fight3.wav"),
	preload("res://asset/sound/stab1.wav"),
	preload("res://asset/sound/fight4.wav"),
	preload("res://asset/sound/stab1.wav"),
	preload("res://asset/sound/fight5.wav"),
	preload("res://asset/sound/stab1.wav"),
	preload("res://asset/sound/stab2.wav"),
]
const stabs_sound = [
	preload("res://asset/sound/stab1.wav"),
	preload("res://asset/sound/stab2.wav"),
]


signal on_troop_dead(troop,killed_by)
signal on_troop_iddle(troop)

onready var rng = RandomNumberGenerator.new()
onready var _body = $body
onready var _body_armor = $body/body_armor
onready var _head = $body/head
onready var _weapon = $body/weapon
onready var _mount = $body/mount
onready var _leg_left = $body/leg_left
onready var _leg_right = $body/leg_right
onready var _mount_leg_left = $body/mount/mount_leg_left
onready var _collision = $CollisionShape2D
onready var _attack_delay = $attack_delay
onready var _animation = $AnimationPlayer
onready var _audio = $AudioStreamPlayer2D
onready var _iddle_delay = $iddle_delay
onready var _health_bar = $holder/health_bar

var is_alive = true
var target : KinematicBody2D = null
var rally_point = null #vector2
var attacked_by = ""
var maximum_engangement_distance = GlobalConst.MAXIMUM_ENGANGEMENT_DISTANCE

var data = {}

func _ready():
	init_troop()
	
func init_troop():
	MINIMAP_COLOR = data.color
	_body.self_modulate = data.color
	_body.self_modulate.a = 1
	_leg_left.self_modulate = data.color
	_leg_right.self_modulate = data.color
	_head.texture = load(data.head_sprite)
	_body.texture = load(data.body_sprite)
	_body_armor.texture = load(data.body_armor_sprite)
	_animation.play("troop_walking")
	_weapon.color = data.color
	_health_bar.max_value = data.hit_point + 0.5
	_health_bar.value = data.hit_point
	_health_bar.visible = false
	_mount_leg_left.texture = null
	_mount.texture = null
	_mount_leg_left.visible = false
	_mount.visible = false
	if data.mount_sprite != "":
		_mount.texture = load(data.mount_sprite)
		_mount_leg_left.texture = preload("res://asset/military/uniform/mount_leg.png")
		_mount_leg_left.self_modulate = data.color
		_mount_leg_left.visible = true
		_mount.visible = true
		
	if data.weapon.has("logo"):
		data.weapon.logo = data.logo
		data.weapon.color = data.color
		
	_weapon.set_data(data.weapon)
	
	_play_ambient_sound()
	set_process(false)
	set_physics_process(false)
	

func set_bonus(bon):
	data.bonus = bon

func remove_bonus():
	data.bonus = {
		attack = 0.0,
		defence = 0.0,
		mobility = 0.0,
		attack_delay = 0.0
	}

func set_facing_direction(_direction):
	if _direction.x > 0:
		_body.scale.x = 1
	else:
		_body.scale.x = -1
		
		
func _process(delta):
	var velocity = Vector2.ZERO
	var direction = Vector2.ZERO
	var distance_to_target = 0.0
	
	if !is_alive or data.hit_point <= 0.0:
		set_dead()
		return
		
	if rally_point:
		direction = (rally_point - global_position).normalized()
		distance_to_target = global_position.distance_to(rally_point)
		
		if distance_to_target > 55.0:
			_weapon.do_nothing()
			_animation.play("troop_running")
			velocity = direction * _get_troop_data_mobility()# * delta
			#velocity = Steering.arrive_to(velocity, global_position, rally_point, _get_troop_data_mobility())
		else:
			_animation.play("troop_walking")
			rally_point = null
			set_process(false)
			_iddle_delay.wait_time = rng.randf_range(2,5)
			_iddle_delay.start()
			
	elif target:
		direction = (target.global_position - global_position).normalized()
		distance_to_target = global_position.distance_to(target.global_position)
		var target_distance_to_fort = target.global_position.distance_to(get_parent().get_parent().global_position)
		if target.is_alive:
			if distance_to_target > data.range_attack:
				_weapon.make_ready()
				_animation.play("troop_running")
				set_facing_direction(direction)
				velocity = direction * _get_troop_data_mobility()# * delta
				#velocity = Steering.arrive_to(velocity,global_position,target.global_position, _get_troop_data_mobility())
				
			elif distance_to_target <= data.range_attack:
				if _attack_delay.is_stopped():
					set_facing_direction(direction)
					_start_combat(target,direction,distance_to_target)
					_attack_delay.wait_time = _get_troop_data_attack_delay()
					_attack_delay.start()
					
					
			if target_distance_to_fort > maximum_engangement_distance:
				target = null
				_weapon.do_nothing()
				_animation.play("troop_walking")
				set_process(false)
				_iddle_delay.wait_time = rng.randf_range(1,3)
				_iddle_delay.start()
				return
				
		else:
			_animation.play("troop_walking")
			if randf() < 0.5:
				perform_celebration()
			else:
				target = null
				_weapon.do_nothing()
				set_process(false)
				_iddle_delay.wait_time = rng.randf_range(1,2)
				_iddle_delay.start()
			return
				
				
	else:
		_weapon.do_nothing()
		_animation.play("troop_walking")
		set_process(false)
		return
		
		
	#move_and_collide(velocity)
	move_and_slide(velocity) 

func _start_combat(_target, _direction, _distance):
		
	if data["class"] == TroopData.CLASS_MELEE:
		_weapon.perform_attack()
		_animation.play(attack_animations[rng.randf_range(0,attack_animations.size())])
		
	elif data["class"] == TroopData.CLASS_RANGE:
		if _distance <= MINIMUM_RANGE_ATTACK:
			if data.has("secondary_weapon"):
				_weapon.set_data(data.secondary_weapon, false)
				
			_weapon.perform_attack()
			_animation.play(attack_animations[rng.randf_range(0,attack_animations.size())])
		
		else:
			_weapon.set_data(data.weapon, true)
			_weapon.perform_attack()
			_animation.play("troop_walking")
			
	elif data["class"] == TroopData.CLASS_NON_COMBATANT:
		if data.has("secondary_weapon"):
			_weapon.set_data(data.secondary_weapon, false)
			_weapon.perform_attack()
			_animation.play(attack_animations[rng.randf_range(0,attack_animations.size())])
			
			
func _on_weapon_on_animation_attack_performed():
	if !is_instance_valid(target):
		return
		
	if !target.is_alive:
		return
		
	if data["class"] == TroopData.CLASS_RANGE:
		if _weapon.is_primary:
			_play_weapon_firing()
			_shoot_at(target)
		else:
			_play_fighting_sound()
			target.take_melee_damage(self, data.melee_attack_damage)
		
	elif data["class"] == TroopData.CLASS_MELEE or data["class"] == TroopData.CLASS_NON_COMBATANT:
		_play_fighting_sound()
		target.take_melee_damage(self, _get_troop_data_melee_attack_damage())
		
		
		
func _on_iddle_delay_timeout():
	_health_bar.visible = false
	if rally_point or target:
		return
	emit_signal("on_troop_iddle", self)
	
func perform_celebration():
	rally_point = null
	target = null
	set_process(false)
	_weapon.do_nothing()
	_animation.play("troop_happy")
	yield(_animation,"animation_finished")
	_animation.play("troop_walking")
	emit_signal("on_troop_iddle", self)

func _shoot_at(_target):
	var direction = (_target.global_position - global_position).normalized()
	var projectile = preload("res://asset/military/projectile/projectile.tscn").instance()
	projectile.side = data.side
	projectile.damage = _get_troop_data_pierce_attack_damage()
	projectile.sprite = load(data.weapon.weapon_projectile_sprite)
	if data.weapon.has("payload_scene"):
		projectile.payload_scene = data.weapon.payload_scene
		projectile.enable_spin = true
		projectile.show_tracer = false
		
	if data.weapon.has("projectile_speed"):
		projectile.speed = data.weapon.projectile_speed
		
	projectile.lauching(global_position, direction)
	add_child(projectile)

func hit_by_projectile(_projectile_sprite):
	if rng.randf() < 0.4 and data.hit_point <= 10.0:
		_attach_projectile(_projectile_sprite)
	#_play_stab_sound()

func _attach_projectile(_projectile_sprite):
	var _projectile_attach = Sprite.new()
	_projectile_attach.texture = _projectile_sprite
	_projectile_attach.rotate(rand_range(-0.10, 0.10))
	_projectile_attach.flip_h = true
	_projectile_attach.scale.x = 0.8
	_projectile_attach.scale.y = 0.8
	_projectile_attach.offset = Vector2(rand_range(8.0, 10.0),rand_range(-4, -10))
	_projectile_attach.show_behind_parent = true
	_body.add_child(_projectile_attach)
	
	
func take_explosive_damage(from,dmg):
	attacked_by = ""
	data.melee_armor -= 2.5
	data.pierce_armor -= 2.5
	data.hit_point -= dmg
	_health_bar.value = data.hit_point
	_health_bar.visible = true
		
		
func take_projectile_damage(from,dmg):
	attacked_by = ""
	if from is KinematicBody2D:
		if !target:
			rally_point = null
			target = from
			set_process(true)
			
		attacked_by = from.data.side
		
	var _dmg = _get_damage_receive_by_projectile(dmg)
	data.hit_point -= _dmg
	_health_bar.value = data.hit_point
	_health_bar.visible = true
		
		
func take_melee_damage(from,dmg):
	attacked_by = ""
	if from is KinematicBody2D:
		if target != from:
			rally_point = null
			target = from
			set_process(true)
			
		attacked_by = from.data.side
		
	var _dmg = _get_damage_receive_by_melee(dmg)
	data.hit_point -= _dmg
	_health_bar.value = data.hit_point
	_health_bar.visible = true
	
	
func set_dead(with_sound : bool = true):
	set_process(false)
	data.hit_point = -10.0
	is_alive = false
	_weapon.do_nothing()
	if with_sound:
		_play_dead_sound()
		
	_play_troop_dead_animation()
	
func _play_troop_dead_animation():
	
	_animation.play(dead_animations[rng.randf_range(0,dead_animations.size())])
	yield(_animation,"animation_finished")
	
	if rng.randf() < 0.5:
		_body.rotation_degrees = rand_range(-90, 90)
		_weapon.rotation_degrees = rand_range(-90, 90)
		
	emit_signal("on_troop_dead", self , attacked_by)
	_collision.disabled = true
	queue_free()
	
func _get_troop_data_melee_attack_damage():
	var dmg = data.melee_attack_damage + data.bonus.attack
	
	if target and !target.data.counter_bonus.empty():
		if data.counter_bonus.has(target.data.category):
			dmg += data.counter_bonus[target.data.category].bonus_attack_damage
		
	if dmg < 0.0:
		dmg = 1.0
		
	return dmg
	
func _get_troop_data_pierce_attack_damage():
	var dmg = data.pierce_attack_damage + data.bonus.attack
	
	if target and !target.data.counter_bonus.empty():
		if data.counter_bonus.has(target.data.category):
			dmg += data.counter_bonus[target.data.category].bonus_attack_damage
		
	if dmg < 0.0:
		dmg = 1.0
		
	return dmg
	
func _get_troop_data_attack_delay():
	var delay = data.attack_delay + data.bonus.attack_delay
	if delay < 0.0:
		delay = 0.5
	return delay
	
func _get_troop_data_mobility():
	var speed = data.max_speed + data.bonus.mobility
	if speed < 0.0:
		speed = 10.0
		
	return speed
	
func _get_damage_receive_by_melee(dmg):
	# armor value reduce
	data.melee_armor -= 1.0
	if data.melee_armor < 0.0:
		data.melee_armor = 0.0
		
	var _dmg = (dmg - (data.melee_armor + data.bonus.defence))
	if _dmg < 0.0:
		_dmg = 0.5
		
	return _dmg
	
func _get_damage_receive_by_projectile(dmg):
	# armor value reduce
	data.pierce_armor -= 1.0
	if data.pierce_armor < 0.0:
		data.pierce_armor = 0.0
	
	var _dmg = (dmg - (data.pierce_armor + data.bonus.defence))
	if _dmg < 0.0:
		_dmg = 0.5
		
	return _dmg
		
func _play_weapon_firing():
	if not visible:
		return
		
	if data.weapon.weapon_firing_sound == "":
		return
		
	_audio.stream = load(data.weapon.weapon_firing_sound)
	_audio.play()
	
func _play_fighting_sound():
	if not visible:
		return
		
	rng.randomize()
	_audio.stream = combats_sound[rng.randf_range(0,combats_sound.size())]
	_audio.play()
	
func _play_stab_sound():
	if not visible:
		return
		
	rng.randomize()
	_audio.stream = stabs_sound[rng.randf_range(0,stabs_sound.size())]
	_audio.play()
	
func _play_dead_sound():
	if not visible:
		return
		
	rng.randomize()
	_audio.stream = dead_sound[rng.randf_range(0,dead_sound.size())]
	_audio.play()

func _play_ambient_sound():
	if not visible:
		return
		
	if data.has("ambient_sounds"):
		var sound = data.ambient_sounds[rand_range(0,data.ambient_sounds.size())]
		_audio.stream = load(sound)
		_audio.play()

func display_attack_chatter():
	if rng.randf() < 0.5:
		var chatter = preload("res://asset/ui/squad_chatter/squad_chatter.tscn").instance()
		chatter.position = position
		chatter.text = TroopChatter.TROOP_ATTACK_CHATTERS[rng.randf_range(0,TroopChatter.TROOP_ATTACK_CHATTERS.size())]
		chatter.speed = 120
		chatter.label_scale = Vector2(0.5,0.5)
		add_child(chatter)
	
	
	
func _on_VisibilityNotifier2D_screen_entered():
	visible = true
	
	
func _on_VisibilityNotifier2D_screen_exited():
	visible = false
	
