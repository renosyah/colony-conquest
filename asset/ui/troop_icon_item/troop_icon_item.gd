extends Panel

signal on_status_change()
signal on_upgrade_button_press(item, cost)

onready var _level = $TextureRect/Label4
onready var _icon = $TextureRect
onready var _name = $MarginContainer/VBoxContainer/Label
onready var _stat = $MarginContainer/VBoxContainer/Label3
onready var _cost = $MarginContainer/VBoxContainer/Label2
onready var _black_list = $TextureRect2
onready var _stop_sign = $TextureRect3
onready var _input_detection = $input_detection
onready var _upgrade_button = $MarginContainer/VBoxContainer/upgrade_button

# this 2 var are pointer
# so be aware !!!
var data = {}
var upgrades = []

var upgrade_cost = 0.0

# this for display only
var _data_to_display = {}
var fort_info = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	display_stats()

	_black_list.visible = !data.enable
	_stop_sign.visible = _black_list.visible
	_input_detection.connect("any_gesture", self, "_on_input_touch_is_validated")
	
	display_upgrade_cost()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_input_touch_is_validated(sig ,event):
	if event is InputEventSingleScreenTap:
		_on_troop_icon_item_pressed()

func _on_troop_icon_item_gui_input(event):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		_on_troop_icon_item_pressed()
		
	# if touch screen
	_input_detection.check_input(event)


func _on_troop_icon_item_pressed():
	
	# because this is pointer
	# this will modify value in fort too
	data.enable = !data.enable
	
	_black_list.visible = !data.enable
	_stop_sign.visible = _black_list.visible
	emit_signal("on_status_change")
	
	
func _on_upgrade_button_pressed():
	emit_signal("on_upgrade_button_press", self, upgrade_cost)

func display_stats():
	_data_to_display = null
	_data_to_display = data.duplicate(true)
	
	for upgrade in upgrades:
		if _data_to_display["data"]["class"] == upgrade.unit_class:
			_data_to_display["data"][upgrade.attribute] += upgrade.value 

	# add training fee
	var total_fee = _data_to_display.cost + fort_info.training_fee
	if total_fee < 0.0:
		total_fee = 0.0
	
	_icon.texture = load(_data_to_display.icon)
	_name.text = _data_to_display.name
	if _data_to_display.data["class"] == TroopData.CLASS_MELEE:
		_stat.text = "Atk : " + str(_data_to_display.data.melee_attack_damage) + " / Def : " + str(_data_to_display.data.melee_armor + _data_to_display.data.pierce_armor) + " / Hp : " + str(_data_to_display.data.hit_point)
	elif _data_to_display.data["class"] == TroopData.CLASS_RANGE:
		_stat.text = "Atk : " + str(_data_to_display.data.pierce_attack_damage) + " / Def : " + str(_data_to_display.data.melee_armor + _data_to_display.data.pierce_armor) + " / Hp : " + str(_data_to_display.data.hit_point)
	_cost.text = "Cost " + str(total_fee)
	_level.text = "Level " + (str(_data_to_display.level))
	
	
func display_upgrade_cost():
	upgrade_cost = FortBuilding.get_troop_upgrade_cost(data)
	_upgrade_button.text = " Upgrade (" + str(upgrade_cost) + ")"

func upgrade_troop():
	FortBuilding.upgrade_troop(data)
	display_upgrade_cost()
	display_stats()






