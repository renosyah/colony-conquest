extends Control

signal on_cicle_region_button_pressed()
signal on_all_fort_attack_button_pressed()
signal on_build_option_button_pressed()
signal on_troop_traning_progress_button_pressed()
signal on_fort_info_button_pressed()
signal on_deselect_button_pressed()
signal on_troop_recruitment_upgrade_button_press(item, cost)
signal on_build_button_press(item, building)
signal on_demolish_button_press(item, building_id)
signal on_any_close_button_press()

onready var _game_ui_menu = $CanvasLayer/game_ui_menu

onready var _logistic_info_button = $CanvasLayer/game_ui_menu/Control/HBoxContainer/VBoxContainer2/margin_container/HBoxContainer/logistic_info_button
onready var _fort_captured_info_button = $CanvasLayer/game_ui_menu/Control/HBoxContainer/VBoxContainer2/margin_container/HBoxContainer/fort_info_button
onready var _resource_display_frame = $CanvasLayer/game_ui_menu/Control/HBoxContainer/VBoxContainer2/margin_container/TextureRect

onready var _top_menu = $CanvasLayer/game_ui_menu/Control/HBoxContainer
onready var _bottom_menu = $CanvasLayer/game_ui_menu/Control/HBoxContainer2
onready var _fort_option_menu = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer

onready var _fort_name_button = $CanvasLayer/game_ui_menu/Control/HBoxContainer/VBoxContainer2/HBoxContainer/fort_name

onready var _label_instruction = $CanvasLayer/game_ui_menu/Control/label_instruction
onready var _all_fort_attack_button = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/all_fort_attack_button
onready var _build_menu_button = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/build_menu_button
onready var _fort_info_button = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/fort_info_button
onready var _deselect = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/deselect_button

onready var _focus_to_my_region_button = $CanvasLayer/game_ui_menu/focus_to_my_region_button
onready var _focus_to_my_region_button_icon = $CanvasLayer/game_ui_menu/focus_to_my_region_button/TextureRect4

onready var _fort_training_troop_info = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/fort_training_troop_info
onready var _icon_current_training_troop = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/fort_training_troop_info/VBoxContainer/TextureRect
onready var _fort_training_progress = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/fort_training_troop_info/fort_training_progress
onready var _fort_training_label_time_left = $CanvasLayer/game_ui_menu/Control/HBoxContainer2/HBoxContainer/fort_training_troop_info/Label

onready var _bg_transparent = $CanvasLayer/game_ui_menu/TextureRect2
onready var _battle_result = $CanvasLayer/game_ui_menu/battle_result

onready var _fort_info_panel = $CanvasLayer/game_ui_menu/fort_info_panel
onready var _fort_info_sprite = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/Control/TextureRect
onready var _fort_info_color = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/Control/bg
onready var _fort_info_logo = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/Control/logo_ui
onready var _fort_info_panel_name = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/HBoxContainer/Label
onready var _fort_info_panel_colony_name = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/Control/MarginContainer4/colony_name
onready var _fort_info_panel_bonus_description = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/Label2
onready var _fort_installed_fort_facility_container = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer4/VBoxContainer
onready var _fort_installed_troop_upgrader_container = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer3/VBoxContainer
onready var _fort_installed_farm_upgrader_container = $CanvasLayer/game_ui_menu/fort_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer7/VBoxContainer

onready var  fort_recruitment_center = $CanvasLayer/game_ui_menu/fort_recruitment_center
onready var _fort_recruitment_center_troop = $CanvasLayer/game_ui_menu/fort_recruitment_center/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/Label2
onready var _grid_container_troop_recruitment_center = $CanvasLayer/game_ui_menu/fort_recruitment_center/VBoxContainer/ScrollContainer/VBoxContainer/GridContainer/HBoxContainer

onready var _mini_map = $CanvasLayer/game_ui_menu/MiniMap
onready var _close_minimap = $CanvasLayer/game_ui_menu/close_minimap_button
onready var _expand_map_button = $CanvasLayer/game_ui_menu/open_map_button
onready var _expand_map_button_icon = $CanvasLayer/game_ui_menu/open_map_button/TextureRect2
var _mini_map_fix_position : Vector2


onready var _event_display = $CanvasLayer/game_ui_menu/Control/event_display
onready var _event_title = $CanvasLayer/game_ui_menu/Control/event_display/Label
onready var _event_sub_title = $CanvasLayer/game_ui_menu/Control/event_display/Label2

onready var _button_setting = $CanvasLayer/game_ui_menu/Control/HBoxContainer/VBoxContainer/button_setting
onready var _setting_menu = $CanvasLayer/game_ui_menu/setting_menu


onready var _build_menu = $CanvasLayer/game_ui_menu/fort_build_menu
onready var _maximum_building = $CanvasLayer/game_ui_menu/fort_build_menu/VBoxContainer/HBoxContainer/MarginContainer/Label
onready var _grid_container_buildings = $CanvasLayer/game_ui_menu/fort_build_menu/VBoxContainer/ScrollContainer/VBoxContainer/GridContainer/HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	_fort_option_menu.visible = false
	_fort_name_button.visible = false
	_focus_to_my_region_button.visible = true
	_mini_map.visible = true
	_fort_info_panel.visible = false
	fort_recruitment_center.visible = false
	_close_minimap.visible = false
	_mini_map_fix_position = _mini_map.rect_position
	_event_display.visible = false
	_label_instruction.visible = false
	_build_menu.visible = false
	set_game_ui_visible(false)
	set_process(false)

func _process(delta):
	_event_display.modulate.a -= 0.002
	if _event_display.modulate.a <= 0.4:
		_event_display.visible = false
		set_process(false)
		return

func set_game_ui_visible(_visible : bool):
	_game_ui_menu.visible = _visible


func display_resources_info(_info: Dictionary,_color : Color):
	_logistic_info_button.text = _info.logistic
	_fort_captured_info_button.text = _info.fort
	_resource_display_frame.modulate = _color
	_expand_map_button_icon.modulate = _color
	_focus_to_my_region_button_icon.modulate = _color

func set_visibility_ui(_visible : bool):
	_top_menu.visible = _visible
	_bottom_menu.visible = _visible

func set_visibility_fort_option_ui(_all_visible : bool, _is_option_for_player : bool):
	_fort_option_menu.visible = _all_visible
	_fort_name_button.visible = _all_visible
	_focus_to_my_region_button.visible = !_all_visible
	_expand_map_button.visible = !_all_visible
	#_mini_map.visible = !_all_visible
	_all_fort_attack_button.visible = !_is_option_for_player
	_build_menu_button.visible = _is_option_for_player
	_fort_training_troop_info.visible = _is_option_for_player
	_fort_info_button.visible = _is_option_for_player
	_label_instruction.visible = _is_option_for_player
	_close_minimap.visible = false

func display_progress_training_troop(troop_to_train, time_left):
	_fort_training_troop_info.icon = null
	_icon_current_training_troop.texture = load(troop_to_train.icon)
	_fort_training_progress.max_value = troop_to_train.training_time
	_fort_training_progress.value = time_left
	_fort_training_label_time_left.text = ""
	if time_left > 0.1:
		_fort_training_label_time_left.text = str(stepify(time_left, 0.1))
		
func display_pending_training_troop():
	_fort_training_troop_info.icon = preload("res://asset/ui/icons/recruit.png")
	#_fort_training_troop_info.icon = preload("res://asset/ui/icons/sleep.png")
	_icon_current_training_troop.texture = preload("res://asset/military/weapon/empty_weapon.png")
	_fort_training_progress.max_value = 1.0
	_fort_training_progress.value = 0.0
	_fort_training_label_time_left.text = ""
	
	
func display_empty_training_troop():
	_fort_training_troop_info.icon = preload("res://asset/ui/icons/recruit.png")
	_icon_current_training_troop.texture = preload("res://asset/military/weapon/empty_weapon.png")
	_fort_training_progress.max_value = 1.0
	_fort_training_progress.value = 0.0
	_fort_training_label_time_left.text = ""
	
func display_fort_info(last_clicked_fort : Node, player_name: String):
	var _fort_name = last_clicked_fort.fort_name
	var _info = last_clicked_fort.get_fort_info()
	var _fort_upgrader_buildings = last_clicked_fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_CASTLE_UPGRADER)
	var _fort_farm_upgrader_buildings = last_clicked_fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_FARM_UPGRADER)
	var _troop_upgrader_buildings = last_clicked_fort.get_list_installed_building(FortBuilding.BUILDING_TYPE_UNIT_UPGRADER)
		
	_fort_info_panel_name.text = _fort_name
	_fort_info_panel_colony_name.text = player_name
	_fort_info_sprite.texture = _info.sprite
	_fort_info_color.modulate = last_clicked_fort.color
	_fort_info_logo.set_logo(last_clicked_fort.logo)
	
	_fort_info_panel_bonus_description.text = "Region Combat Condition : \n"
	_fort_info_panel_bonus_description.text += "* " + show_positif_or_negative(stepify(_info.fort_bonus.attack,0.1)) + " troop attack\n"
	_fort_info_panel_bonus_description.text += "* " + show_positif_or_negative(stepify(_info.fort_bonus.defence,0.1)) + " troop defence\n"
	_fort_info_panel_bonus_description.text += "* " + show_positif_or_negative(stepify(_info.fort_bonus.mobility,0.1)) + " mobility\n"
	
	_fort_info_panel_bonus_description.text += "\nFort Property : \n"
	_fort_info_panel_bonus_description.text += "* " + str(_info.tower) + " Tower\n"
	_fort_info_panel_bonus_description.text += "* " + str(_info.farm) + " Farm\n"
	
	for child in _fort_installed_farm_upgrader_container.get_children():
		_fort_installed_farm_upgrader_container.remove_child(child)
	
	for child in _fort_installed_fort_facility_container.get_children():
		_fort_installed_fort_facility_container.remove_child(child)
		
	for child in _fort_installed_troop_upgrader_container.get_children():
		_fort_installed_troop_upgrader_container.remove_child(child)
		
	for farm in _fort_farm_upgrader_buildings:
		var item = preload("res://asset/ui/building_info_icon_item/building_info_icon_item.tscn").instance()
		item.data = farm
		_fort_installed_farm_upgrader_container.add_child(item)
		
	for facility in _fort_upgrader_buildings:
		var item = preload("res://asset/ui/building_info_icon_item/building_info_icon_item.tscn").instance()
		item.data = facility
		_fort_installed_fort_facility_container.add_child(item)
		
	for building in _troop_upgrader_buildings:
		var item = preload("res://asset/ui/building_info_icon_item/building_info_icon_item.tscn").instance()
		item.data = building
		_fort_installed_troop_upgrader_container.add_child(item)
	
	
	_fort_info_panel.visible = true
	_bg_transparent.visible = true
	#_on_deselect_button_pressed()

func show_positif_or_negative(_num) -> String:
	if _num > 0.0:
		return "+" + str(_num)
	return str(_num)


func display_fort_list_avaliable_troop_to_train(_info, _recruitment_center):
	fort_recruitment_center.visible = true
	_fort_recruitment_center_troop.visible = _recruitment_center.troops.empty()
	_fort_recruitment_center_troop.text = "No recruitment avaliable!"
		
	for child in _grid_container_troop_recruitment_center.get_children():
		_grid_container_troop_recruitment_center.remove_child(child)
		
	for troop in _recruitment_center.troops:
		var item = preload("res://asset/ui/troop_icon_item/troop_icon_item.tscn").instance()
		item.data = troop
		item.upgrades = _recruitment_center.upgrades
		item.fort_info = _info
		item.connect("on_status_change", self,"_on_status_change")
		item.connect("on_upgrade_button_press", self,"_on_upgrade_button_press")
		_grid_container_troop_recruitment_center.add_child(item)
		
	_bg_transparent.visible = true
	#_on_deselect_button_pressed()
		
		
func display_fort_list_avaliable_building_to_build(_info, _installed_buildings, _player_buildings_to_build):
	_build_menu.visible = true
	_maximum_building.text = str(_installed_buildings.size()) + "/" + str(_info["maximum_building"])
	
	for child in _grid_container_buildings.get_children():
		_grid_container_buildings.remove_child(child)
		
	for building in _player_buildings_to_build:
		var mode = GlobalConst.BUILD_MODE
		if is_building_already_installed(_installed_buildings,building):
			mode = GlobalConst.DEMOLISH_MODE
			
		var item = preload("res://asset/ui/buildings_icon_item/building_icon_item.tscn").instance()
		item.data = building
		item.mode = mode
		item.can_build = (_installed_buildings.size() < _info["maximum_building"])
		item.connect("on_build_button_press", self,"_on_build_button_press")
		item.connect("on_demolish_button_press", self,"_on_demolish_button_press")
		_grid_container_buildings.add_child(item)
	
	_bg_transparent.visible = true
	
	#_on_deselect_button_pressed()
	
func is_building_already_installed(_installed_buildings, _building_to_build):
	for installed_building in _installed_buildings:
		if _building_to_build.id == installed_building.id:
			return true
	return false

func set_data_score(_data):
	_battle_result.set_data_score(_data)
	
	
func display_fort_capture(message):
	_event_display.modulate.a = 1.0
	_event_display.visible = true
	_event_title.text = "Fort Captured!"
	_event_sub_title.text = message
	set_process(true)
	
	
func display_fort_lost(message):
	_event_display.modulate.a = 1.0
	_event_display.visible = true
	_event_title.text = "Fort Lost!"
	_event_sub_title.text = message
	set_process(true)
	
	
func display_fort_rebel(message):
	_event_display.modulate.a = 1.0
	_event_display.visible = true
	_event_title.text = "Fort Rebel!"
	_event_sub_title.text = message
	set_process(true)

func show_win(_players):
	_battle_result.visible = true
	_top_menu.visible = false
	_mini_map.visible = false
	_bottom_menu.visible = false
	_battle_result.display_win()
	
	
func show_lose(_players):
	_battle_result.visible = true
	_top_menu.visible = false
	_mini_map.visible = false
	_bottom_menu.visible = false
	_battle_result.display_lose()


func display_fort_name(_fort_name: String, _visible: bool):
	_fort_name_button.text = _fort_name
	_fort_name_button.visible = _visible

func setup_minimap(_camera,_color):
	_mini_map.set_camera(_camera)
	_mini_map.set_minimap_border_color(_color)

func add_object_to_minimap(_object):
	_mini_map.add_object(_object)

func remove_object_from_minimap(_object):
	_mini_map.remove_object(_object)

func set_minimap_to_fullsize():
	_on_deselect_button_pressed()
	_mini_map.mode = GlobalConst.EXPAND
	_mini_map.anchor_top = 0
	_mini_map.anchor_bottom = 0
	_mini_map.anchor_left = 0
	_mini_map.anchor_right = 0
	_mini_map.rect_position = Vector2.ZERO
	_mini_map.rect_size = get_viewport().size
	_close_minimap.visible = true
	_top_menu.visible = false

func set_minimap_to_smallsize():
	_mini_map.mode = GlobalConst.NORMAL
	_mini_map.anchor_top = 0
	_mini_map.anchor_bottom = 0
	_mini_map.anchor_left = 0
	_mini_map.anchor_right = 0
	_mini_map.rect_position = _mini_map_fix_position
	_mini_map.rect_size = Vector2(200,200)
	_close_minimap.visible = false
	_top_menu.visible = true
	
	
	
# on player set troop to train or not train
# but righ now it no need
func _on_status_change():
	pass

func _on_upgrade_button_press(item,cost):
	emit_signal("on_troop_recruitment_upgrade_button_press",item,cost)
	
func _on_build_button_press(item,building):
	emit_signal("on_build_button_press",item, building)
	
func _on_demolish_button_press(item,building_id):
	emit_signal("on_demolish_button_press",item, building_id)
	

func _on_button_pause_pressed():
	_battle_result.visible = true
	_battle_result.display_surrender()
	
func _on_focus_to_my_region_button_pressed():
	emit_signal("on_cicle_region_button_pressed")

func _on_deselect_button_pressed():
	emit_signal("on_deselect_button_pressed")

func _on_all_fort_attack_button_pressed():
	emit_signal("on_all_fort_attack_button_pressed")

func _on_build_menu_button_pressed():
	emit_signal("on_build_option_button_pressed")
	
func _on_fort_training_troop_info_pressed():
	emit_signal("on_troop_traning_progress_button_pressed")

func _on_fort_info_button_pressed():
	emit_signal("on_fort_info_button_pressed")

func _on_button_close_info_fort_pressed():
	_fort_info_panel.visible = false
	_bg_transparent.visible = false
	emit_signal("on_any_close_button_press")

func _on_button_close_fort_recruitment_center_pressed():
	fort_recruitment_center.visible = false
	_bg_transparent.visible = false
	emit_signal("on_any_close_button_press")

func _on_button_close_fort_building_menu_pressed():
	_build_menu.visible = false
	_bg_transparent.visible = false
	emit_signal("on_any_close_button_press")
	
func _on_open_map_button_toggled(button_pressed):
	if button_pressed:
		_on_MiniMap_on_minimap_click()
	else:
		_on_close_minimap_button_pressed()
	
	
func _on_MiniMap_on_minimap_click():
	_expand_map_button.pressed = true
	set_minimap_to_fullsize()

func _on_close_minimap_button_pressed():
	_expand_map_button.pressed = false
	set_minimap_to_smallsize()
	
	
func _on_button_setting_pressed():
	_setting_menu.visible = true
	
	
func _on_setting_menu_on_setting_close_button_press():
	_setting_menu.visible = false
