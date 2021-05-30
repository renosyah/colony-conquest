extends RigidBody2D

signal on_region_detect_body(body)
signal on_body_leave_region(body)
signal on_region_click(is_border_showing)

onready var _area = $Area2D
onready var _shape = $CollisionShape2D
onready var _area_click = $Area2D/CollisionShape2D
onready var _sprite = $Sprite

var size
var owner_id = ""
var color = Color.gray
var logo = {}

func make_region(_owner_id,_color,_logo, _pos, _size):
	owner_id = _owner_id
	position = _pos
	logo = _logo
	size = _size
	color = _color
	var s = RectangleShape2D.new()
	s.custom_solver_bias = 0.75
	s.extents = size
	_shape.shape = s
	_sprite.scale = Vector2(_size.x * 2 / _sprite.texture.get_size().x,_size.y * 2  / _sprite.texture.get_size().y)
	_area_click.shape = s
	_sprite.visible = false
	_sprite.modulate = _color
	_sprite.modulate.a = 0.8
	
func get_shape():
	return _shape

func show_border(show):
	_sprite.visible = show
	emit_signal("on_region_click", is_border_showing())

func is_border_showing():
	return _sprite.visible

func update_ownership(_new_owner_id,_new_color):
	owner_id = _new_owner_id
	color = _new_color
	_sprite.modulate = color
	_sprite.modulate.a = 0.6

func reset_area():
#	_area.monitoring = false
#	_area.monitoring = true
	pass

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		emit_signal("on_region_detect_body",body)
	
	
func _on_Area2D_body_exited(body):
	if body is KinematicBody2D:
		emit_signal("on_body_leave_region",body)

