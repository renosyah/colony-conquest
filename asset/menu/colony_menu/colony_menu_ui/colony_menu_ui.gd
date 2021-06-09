extends Node

signal on_randomize_button_click()
signal on_back_button_click()
signal on_start_battle_button_click()
signal on_battle_setting_set(max_bot,max_neutral_bot,starting_logistic,dificulty,biom)
signal on_colony_item_click(data)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var _title_bar = $CanvasLayer/choose_colony_layout/MarginContainer
onready var _back_button = $CanvasLayer/choose_colony_layout/MarginContainer/HBoxContainer/back_button

onready var _choose_colony_menu = $CanvasLayer/choose_colony_layout
onready var _battle_setting_layout = $CanvasLayer/battle_setting_layout
onready var _bg = $CanvasLayer/bg

onready var _colony_color = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/HBoxContainer/CenterContainer/colony_color
onready var _colony_logo = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/HBoxContainer/CenterContainer/colony_logo
onready var _colony_name = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/HBoxContainer/VBoxContainer/colony_name
onready var _short_description = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/HBoxContainer/VBoxContainer/colony_short_description
onready var _colony_info_button = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/HBoxContainer/colony_info_button

onready var _colony_list_container = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/scroll_colony/HBoxContainer/colony_container
onready var _randomize_button = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/scroll_colony/HBoxContainer/generate_colony_button

onready var _next_button = $CanvasLayer/choose_colony_layout/VBoxContainer/short_description/VBoxContainer/next_button

onready var _colony_info_panel = $CanvasLayer/choose_colony_layout/colony_info_panel
onready var _colony_info_color = $CanvasLayer/choose_colony_layout/colony_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/Control/bg
onready var _colony_info_logo = $CanvasLayer/choose_colony_layout/colony_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/Control/logo_ui
onready var _colony_info_panel_name = $CanvasLayer/choose_colony_layout/colony_info_panel/VBoxContainer/HBoxContainer/Label
onready var _colony_unique_building_container = $CanvasLayer/choose_colony_layout/colony_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer9/ScrollContainer/HBoxContainer/VBoxContainer
onready var _colony_installed_fort_facility_container = $CanvasLayer/choose_colony_layout/colony_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer4/VBoxContainer
onready var _colony_installed_troop_upgrader_container = $CanvasLayer/choose_colony_layout/colony_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer3/VBoxContainer
onready var _colony_installed_farm_upgrader_container = $CanvasLayer/choose_colony_layout/colony_info_panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer7/VBoxContainer

onready var _max_enemy_bot_label = $CanvasLayer/battle_setting_layout/PanelContainer/VBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer6/Label3
onready var _max_neutral_bot_label = $CanvasLayer/battle_setting_layout/PanelContainer/VBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer7/Label3
onready var _max_logistic_label = $CanvasLayer/battle_setting_layout/PanelContainer/VBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer8/Label3

onready var _normal_diff_button = $CanvasLayer/battle_setting_layout/PanelContainer/VBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer9/normal_button
onready var _hard_diff_button = $CanvasLayer/battle_setting_layout/PanelContainer/VBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer9/hard_button
onready var _legendary_diff_button = $CanvasLayer/battle_setting_layout/PanelContainer/VBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer9/legendary_button

onready var _map_biom_item_container = $CanvasLayer/battle_setting_layout/PanelContainer/VBoxContainer/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer5/ScrollContainer/HBoxContainer10/HBoxContainer

onready var _setting_menu = $CanvasLayer/setting_menu

var player = {}

var max_bot = 3
var max_neutral_bot = 4
var starting_logistic = 550.0
var dificulty = GlobalConst.NORMAL
var biom_id = Biom.GRASS_LAND

# Called when the node enters the scene tree for the first time.
func _ready():
	_battle_setting_layout.visible = false
	_choose_colony_menu.visible = true
	_setting_menu.visible = false
	_on_button_close_info_pressed()
	_on_normal_button_pressed()
	show_map_biom_item_container()
	display_setting()
	
func set_colony_list(_colony_list):
	for child in _colony_list_container.get_children():
		_colony_list_container.remove_child(child)
	
	var idx = 0
	for colony in _colony_list:
		var item = preload("res://asset/menu/colony_menu/colony_item/colony_item.tscn").instance()
		item.data = colony
		item.idx = idx
		item.connect("on_colony_item_click", self, "_on_colony_item_click")
		_colony_list_container.add_child(item)
		idx += 1
	
	_colony_list_container.get_children()[0].set_selected(true)
	
func set_player_colony(_player):
	player = _player
	_colony_color.modulate = player.color
	_colony_logo.set_logo(player.logo)
	
	_colony_name.text = _player.name
	
	_short_description.text = ""
	_short_description.text += "Unique building : \n"
	for building in player.buildings:
		_short_description.text += "* "+ building.name +"\n"
	
	
func set_visible(_visible : bool = false):
	_choose_colony_menu.visible = _visible
	
	
func set_randomize_button_visible(_visible : bool = false):
	_randomize_button.visible = _visible
	
	
func display_setting():
	_max_enemy_bot_label.text = "Max Enemy ("+ str(max_bot) +") : "
	_max_neutral_bot_label.text = "Max Neutral ("+ str(max_neutral_bot) +") : "
	_max_logistic_label.text = "Logistic ("+ str(starting_logistic) +") : "
	
func display_colony_info():
	if player.empty():
		return
		
	_colony_info_button.visible = false
	_colony_info_panel.visible = true
	_bg.visible = true
	_title_bar.visible = false
	
	_colony_color.modulate = player.color
	_colony_logo.set_logo(player.logo)
	
	_colony_info_panel_name.text = player.name
	_colony_info_color.modulate = player.color
	_colony_info_logo.set_logo(player.logo)
	
	for child in _colony_installed_farm_upgrader_container.get_children():
		_colony_installed_farm_upgrader_container.remove_child(child)
	
	for child in _colony_installed_fort_facility_container.get_children():
		_colony_installed_fort_facility_container.remove_child(child)
		
	for child in _colony_installed_troop_upgrader_container.get_children():
		_colony_installed_troop_upgrader_container.remove_child(child)
	
	for child in _colony_unique_building_container.get_children():
		_colony_unique_building_container.remove_child(child)
	
	for farm in player.logistic_ugrades:
		var item = preload("res://asset/ui/building_info_icon_item/building_info_icon_item.tscn").instance()
		item.data = farm
		_colony_installed_farm_upgrader_container.add_child(item)
		
	for facility in player.fort_facilities:
		var item = preload("res://asset/ui/building_info_icon_item/building_info_icon_item.tscn").instance()
		item.data = facility
		_colony_installed_fort_facility_container.add_child(item)
		
	for building in player.special_buildings:
		var item = preload("res://asset/ui/building_info_icon_item/building_info_icon_item.tscn").instance()
		item.data = building
		_colony_installed_troop_upgrader_container.add_child(item)

	for building in player.buildings:
		var item = preload("res://asset/ui/buildings_icon_item/building_icon_item.tscn").instance()
		item.data = building
		item.display_only = true
		_colony_unique_building_container.add_child(item)
	
	
	#_on_deselect_button_pressed()


func set_all_difficulty_button_color(color):
	_normal_diff_button.modulate = color
	_hard_diff_button.modulate = color
	_legendary_diff_button.modulate = color


func show_map_biom_item_container():
	for child in _map_biom_item_container.get_children():
		_map_biom_item_container.remove_child(child)
		
	for biom in Biom.BIOMS:
		var item = preload("res://asset/ui/map_chooser_item/map_choose_item.tscn").instance()
		item.biom = biom
		item.is_choosed = (biom.id == biom_id)
		item.connect("on_map_item_click", self, "_on_map_item_click")
		_map_biom_item_container.add_child(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_colony_item_click(idx,data):
	
	if _colony_list_container.get_children()[idx].is_selected:
		return
	
	for child in _colony_list_container.get_children():
		child.set_selected(false)
		
	_colony_list_container.get_children()[idx].set_selected(true)
	
	emit_signal("on_colony_item_click",data)

func _on_button_close_info_pressed():
	_colony_info_panel.visible = false
	_colony_info_button.visible = true
	_bg.visible = false
	_title_bar.visible = true

func _on_colony_info_button_pressed():
	display_colony_info()


func _on_generate_colony_button_pressed():
	emit_signal("on_randomize_button_click")

func _on_back_button_pressed():
	emit_signal("on_back_button_click")

func _on_next_button_pressed():
	_bg.visible = true
	_battle_setting_layout.visible = true
	_choose_colony_menu.visible = false
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)
	
func _on_hostile_bot_slider_value_changed(value):
	max_bot = value
	display_setting()
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)

func _on_neutral_bot_slider_value_changed(value):
	max_neutral_bot = value
	display_setting()
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)
	
func _on_logistic_slider_value_changed(value):
	starting_logistic = value
	display_setting()
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)

func _on_go_to_battle_button_pressed():
	emit_signal("on_start_battle_button_click")


func _on_close_battle_setting_button_pressed():
	_bg.visible = false
	_battle_setting_layout.visible = false
	_choose_colony_menu.visible = true
	
	
func _on_button_setting_pressed():
	_setting_menu.visible = true
	
	
func _on_setting_menu_on_setting_close_button_press():
	_setting_menu.visible = false
	
	
func _on_normal_button_pressed():
	set_all_difficulty_button_color(Color.white)
	_normal_diff_button.modulate = Color.gray
	dificulty = GlobalConst.DIFFICULTY_NORMAL
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)

func _on_hard_button_pressed():
	set_all_difficulty_button_color(Color.white)
	_hard_diff_button.modulate = Color.gray
	dificulty = GlobalConst.DIFFICULTY_HARD
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)
	
func _on_legendary_button_pressed():
	set_all_difficulty_button_color(Color.white)
	_legendary_diff_button.modulate = Color.gray
	dificulty = GlobalConst.DIFFICULTY_LEGENDARY
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)
	
	
func _on_map_item_click(biom):
	biom_id = biom.id
	show_map_biom_item_container()
	emit_signal("on_battle_setting_set",max_bot,max_neutral_bot,starting_logistic,dificulty,biom_id)
	
	
	
	
