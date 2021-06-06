extends RigidBody2D


onready var _sprite = $Sprite
onready var _icon = $Sprite2
onready var _collision = $CollisionShape2D
onready var _shot_delay = $shot_delay
onready var _audio = $AudioStreamPlayer2D
onready var _shooting_point = $shooting_point
onready var _flag = $flag

var _target = null

# this is pointer!
var targets = []

var owner_id = ""
var color = Color.white
var logo = {}

# defence
var _data = {
	shot_delay = 1.7,
	damage = 8.7,
	max_shoter = 1,
	speed = 800,
	spread = 0.2
}


# Called when the node enters the scene tree for the first time.
func _ready():
	_icon.visible = false
	_shot_delay.wait_time = _data.shot_delay
	_flag.set_appearance(color,logo)
	_collision.scale = Vector2(2.3,2.3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if !_target:
		return
		
	if _shot_delay.is_stopped() and !targets.empty():
		for i in _data.max_shoter:
			_shoot_at(_target)
		
		var delay = _data.shot_delay
		if delay < 0.1:
			delay = 0.1
		_shot_delay.wait_time = delay
		_shot_delay.start()
		
		if _target.data.side == owner_id:
			_target = null
		
func set_targets(_targets):
	targets = _targets
	
func pick_tower_target():
	if _target:
		return
		
	if targets.empty():
		return
		
	randomize()
	_target = targets[rand_range(0,targets.size())]
	
func on_fort_captured(fort):
	targets.clear()
	owner_id = fort.owner_id
	_flag.set_appearance(fort.color,fort.logo)
	
func on_region_click(is_showing):
	_icon.visible = is_showing
	
	
func _shoot_at(_target):
	var from = _shooting_point.global_position + Vector2(rand_range(-20,20),rand_range(-20,20))
	var direction = (_target.global_position - global_position).normalized()
	var projectile = preload("res://asset/military/projectile/projectile.tscn").instance()
	projectile.side = owner_id
	projectile.damage = _data.damage
	projectile.speed = _data.speed
	projectile.spread = _data.spread
	projectile.sprite = preload("res://asset/military/projectile/arrow/arrow.png")
	projectile.lauching(from, direction)
	add_child(projectile)
	_play_weapon_firing()
	
func _play_weapon_firing():
	_audio.stream = preload("res://asset/sound/arrow_fly.wav")
	_audio.play()


func _on_Timer_timeout():
	mode = RigidBody2D.MODE_STATIC
	_collision.scale = Vector2(1,1)
	_collision.disabled = true
