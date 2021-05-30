extends Node

onready var _rng = RandomNumberGenerator.new()
onready var _bg = $bg
onready var _cloud_spawn_point = $cloud_spawn_point
onready var _cloud_spawn_point2 = $cloud_spawn_point2
onready var _timer = $Timer
onready var _audio = $AudioStreamPlayer2D
onready var _setting_menu = $setting_menu
onready var _about = $about
onready var _loading = $loading

onready var _input_detection = $input_detection

onready var _screen_size = get_viewport().get_visible_rect().size

var next_scene = ""
var menu_click = 0
enum {
	MENU_CAMPAIGN_PLAY,
	MENU_CUSTOM_PLAY,
	MENU_SETTING,
	MENU_ABOUT
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_loading.init_cloud()
	_loading.remove_cloud()
	spawn_initial_cloud()
	set_process(false)

func _on_Timer_timeout():
	if _rng.randf() <= 0.1:
		var origin = get_random_y()
		spawn_cloud(origin.from,origin.speed)

func _process(delta):
	_bg.modulate.a += 0.02
	if _bg.modulate.a >= 1.0:
		to_battle()
		set_process(false)
		return

func to_battle():
#	var root = get_tree().get_root()
#	var current_scene = root.get_child(root.get_child_count() -1)
#	current_scene.queue_free()
#
	get_tree().change_scene(next_scene)

func spawn_initial_cloud():
	_rng.randomize()
	for i in 5:
		var _speed = _rng.randf_range(150,400)
		var _pos = Vector2(_rng.randf_range(-900, _screen_size.x),_rng.randf_range(50 , _screen_size.y))
		if randf() < 0.5:
			_speed = -_speed
		spawn_cloud(_pos, _speed)

func spawn_cloud(from,speed):
	var cloud = preload("res://asset/ui/cloud/cloud.tscn").instance()
	cloud.position = from
	cloud.is_move = true
	cloud.random_scale()
	cloud.speed = speed
	_cloud_spawn_point.add_child(cloud)

func get_random_y():
	_rng.randomize()
	var _speed = _rng.randf_range(-150,-300)
	var x = _cloud_spawn_point.rect_global_position.x
	var y = _cloud_spawn_point.rect_global_position.y 
	var y_size = _cloud_spawn_point.rect_size.y
	if randf() < 0.5:
		x = _cloud_spawn_point2.rect_global_position.x - 2900
		y = _cloud_spawn_point2.rect_global_position.y 
		y_size = _cloud_spawn_point2.rect_size.y
		_speed = -_speed
		
	y = _rng.randf_range(y + 50 , y + y_size - 50)
	return {from = Vector2(x,y), speed = _speed}
	
	
func on_menu_click_check():
	match menu_click:
		MENU_CAMPAIGN_PLAY:
			pass
			
		MENU_CUSTOM_PLAY:
			next_scene = "res://asset/menu/colony_menu/colony_menu.tscn"
			get_tree().change_scene(next_scene)
			
		MENU_ABOUT:
			_about.visible = true
			
		MENU_SETTING:
			_setting_menu.visible = true
	
	
func _on_setting_pressed():
	_setting_menu.visible = true
	
func _on_setting_menu_on_setting_close_button_press():
	_setting_menu.visible = false
	
func _on_about_on_about_close_button_press():
	_about.visible = false
	
	
func _on_setting_gui_input(event):
	_input_detection.check_input(event)
	menu_click = MENU_SETTING
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		on_menu_click_check()

func _on_campaign_play_gui_input(event):
	_input_detection.check_input(event)
	menu_click = MENU_CAMPAIGN_PLAY
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		on_menu_click_check()
	
func _on_custom_play_gui_input(event):
	_input_detection.check_input(event)
	menu_click = MENU_CUSTOM_PLAY
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		on_menu_click_check()
		
func _on_about_gui_input(event):
	_input_detection.check_input(event)
	menu_click = MENU_ABOUT
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		on_menu_click_check()
	
func _on_input_touch_is_validated(sig ,event):
	if event is InputEventSingleScreenTap:
		on_menu_click_check()
	
func _on_button_close_pressed():
	get_tree().quit()

