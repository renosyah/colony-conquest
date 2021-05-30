extends MarginContainer

signal on_colony_item_click(idx,data)

onready var _color = $TextureRect
onready var _logo = $logo_ui
onready var _selected = $TextureRect2

onready var _input_detection = $input_detection

# this is pointer
var data = {}
var idx = 0
var is_selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if data.empty():
		return
	
	_selected.visible = is_selected
	_color.self_modulate = data.color
	_logo.set_logo(data.logo)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_selected(val):
	is_selected = val
	_selected.visible = is_selected

func _on_input_detection_any_gesture(sig,event):
	if event is InputEventSingleScreenTap:
		emit_signal("on_colony_item_click",idx, data)
	
	
func _on_logo_ui_gui_input(event):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		emit_signal("on_colony_item_click",idx, data)
		
	_input_detection.check_input(event)
	
	
	
	
	





