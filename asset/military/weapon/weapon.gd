extends Node2D

signal on_animation_attack_performed()

onready var rng = RandomNumberGenerator.new()
onready var _sprite = $sprite
onready var _ammo = $sprite/ammo
onready var _arm_left = $arm_left
onready var _arm_right = $arm_right
onready var _animation = $AnimationPlayer
onready var _audio = $AudioStreamPlayer2D
onready var _logo = $sprite/logo

var damage = 0.0
var color = Color.white
var _ready_animation = "weapon_ready"
var _iddle_animation = "weapon_iddle"
var _is_ready = false

var is_primary = true

var data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_data(_data, _is_primary = true):
	data = _data
	is_primary = _is_primary
	_arm_left.self_modulate = color
	_arm_right.self_modulate = color
	_ready_animation = data.ready_animation[rng.randf_range(0,data.ready_animation.size())]
	_sprite.texture = load(data.weapon_sprite)
	_ammo.texture = load(data.weapon_projectile_sprite)
	_sprite.self_modulate = Color.white
	
	if data.color:
		_sprite.self_modulate = data.color
		
	_logo.visible = false
	if data.has("logo"):
		_logo.visible = true
		_logo.set_logo(data.logo)
	
	do_nothing()
	
	
func do_nothing():
	_is_ready = false
	if (data.has("iddle_animation")):
		_iddle_animation = data.iddle_animation[rng.randf_range(0,data.iddle_animation.size())]
	
	_animation.play(_iddle_animation)
	
func make_ready():
	if _is_ready:
		return
	_is_ready = true
	_ready_animation = data.ready_animation[rng.randf_range(0,data.ready_animation.size())]
	_animation.play(_ready_animation)
	#emit_signal("on_animation_attack_performed")
	
func perform_attack():
	var _anim = data.attack_animation[rng.randf_range(0,data.attack_animation.size())]
	_animation.play(_anim)
	#_animation.playback_speed = 2

func _on_animation_firing_performed():
	_is_ready = false
	emit_signal("on_animation_attack_performed")
