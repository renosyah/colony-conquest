extends TextureRect

signal on_map_item_click(_biom)

onready var _input_detection = $input_detection
onready var _label = $MarginContainer/Label

var biom = {}
var is_choosed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if biom.empty():
		return
	
	_label.text = "\n" + biom.name + "\n"
	texture = load(biom.sprite)
	
	if is_choosed:
		self_modulate = Color.gray
		self_modulate.a = 0.3
	
func _on_input_detection_any_gesture(sig,event):
	if event is InputEventSingleScreenTap:
		emit_signal("on_map_item_click", biom)


func _on_map_choose_item_gui_input(event):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		emit_signal("on_map_item_click", biom)
		
	# if touch screen
	_input_detection.check_input(event)
