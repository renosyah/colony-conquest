extends PanelContainer

signal on_build_button_press(item, building)
signal on_demolish_button_press(item, building_id)

onready var _building_info_panel = $VBoxContainer
onready var _icon = $VBoxContainer/HBoxContainer/icon
onready var _name = $VBoxContainer/HBoxContainer/VBoxContainer/building_name
onready var _description = $VBoxContainer/HBoxContainer/VBoxContainer/description
onready var _troop_icon_grid_container = $VBoxContainer/HBoxContainer/VBoxContainer/icon_troop_grid_container
onready var _build_button = $VBoxContainer/build_button
onready var _demolish_button = $VBoxContainer/demolish_button
onready var _display_only_button = $VBoxContainer/display_only_button

onready var _demolish_building_name = $demolish_confirmation_box/building_name
onready var _demolish_confirmation_box = $demolish_confirmation_box

onready var _icon_troop_sample = $VBoxContainer/HBoxContainer/VBoxContainer/icon_troop_grid_container/TextureRect

onready var _cannot_build_container = $unable_build

# this is pointer
var data = {}

var mode = GlobalConst.BUILD_MODE
var can_build = true
var display_only = false
var _data_to_display = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_build_button.visible = !display_only and can_build and mode == GlobalConst.BUILD_MODE
	_demolish_button.visible = !display_only and mode == GlobalConst.DEMOLISH_MODE
	_display_only_button.visible = display_only
	_building_info_panel.visible = true
	_demolish_confirmation_box.visible = false
	_cannot_build_container.visible = !can_build and mode == GlobalConst.BUILD_MODE
	display_building_info()

func display_building_info():
	_data_to_display = data.duplicate(true)
	_icon.texture = load(_data_to_display.icon)
	_name.text = _data_to_display.name
	_demolish_building_name.text = _data_to_display.name
	_description.text = _data_to_display.description
	
	for troop in _data_to_display.troops:
		var _troop_icon = _icon_troop_sample.duplicate()
		_troop_icon.texture = load(troop.icon)
		_troop_icon.visible = true
		_troop_icon_grid_container.add_child(_troop_icon)
		
	_build_button.text = " Build (" + str(_data_to_display.cost) + ")"
	_display_only_button.text = " Cost (" + str(_data_to_display.cost) + ")"

func on_building_build():
	mode = GlobalConst.DEMOLISH_MODE
	_build_button.visible = false
	_demolish_button.visible = true
	_demolish_confirmation_box.visible = false
	_building_info_panel.visible = true

func on_building_demolish():
	mode = GlobalConst.BUILD_MODE
	_build_button.visible = true
	_demolish_button.visible = false
	_demolish_confirmation_box.visible = false
	_building_info_panel.visible = true
	
func _on_build_button_pressed():
	emit_signal("on_build_button_press", self, data)
	
	
func _on_demolish_button_pressed():
	_demolish_confirmation_box.visible = true
	_demolish_button.visible = false
	_building_info_panel.visible = false
	
func _on_demolish_confirm_yes_pressed():
	emit_signal("on_demolish_button_press",self, data.id)
	
	
func _on_demolish_confirm_cancel_pressed():
	_demolish_confirmation_box.visible = false
	_demolish_button.visible = true
	_building_info_panel.visible = true
