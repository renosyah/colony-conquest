extends Node

signal on_loading_finish()

onready var _label = $CanvasLayer/Label
onready var _cloud_holder = $CanvasLayer/cloud_holder
onready var _back_bg = $CanvasLayer/bg
onready var _simple_timeout = $simple_timeout

onready var _view_port = get_viewport().get_visible_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	_back_bg.visible = true
	_label.visible = true
	set_process(false)

func _process(delta):
	_back_bg.modulate.a -= 0.02
	if _back_bg.modulate.a <= 0.0:
		emit_signal("on_loading_finish")
		set_process(false)
		return

func init_cloud():
	_label.visible = true
	_back_bg.modulate.a = 1.0
	
	for x in range(-50,_view_port.x, 150):
		for y in range(-50,_view_port.y, 250):
			spawn_cloud(Vector2(x,y))
			
	for x in range(_view_port.x, -50, 150):
		for y in range(-50,_view_port.y, 250):
			spawn_cloud(Vector2(x,y))
			
			
func spawn_cloud(pos):
	var cloud = preload("res://asset/ui/cloud/cloud.tscn").instance()
	cloud.speed = rand_range(750,1200)
	if randf() < 0.5:
		cloud.speed = -cloud.speed
	cloud.is_move = false
	cloud.position = pos
	cloud.random_scale()
	_cloud_holder.add_child(cloud)

func remove_cloud():
	for child in _cloud_holder.get_children():
		child.is_move = true
	
	_simple_timeout.start()


func _on_simple_timeout_timeout():
	_label.visible = false
	set_process(true)
