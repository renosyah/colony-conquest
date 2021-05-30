extends Node2D

onready var _sprite = $Sprite
onready var _animation = $AnimationPlayer
onready var _timer = $life_time

var color = Color(Color.white)

# Called when the node enters the scene tree for the first time.
func _ready():
	_animation.play("waypoint_change_size")
	_sprite.modulate = color
	_sprite.visible = false

func show_waypoint(_color,_at):
	global_position = _at
	_sprite.modulate = _color
	_sprite.visible = true
	_timer.start()

func _on_life_time_timeout():
	_sprite.visible = false
