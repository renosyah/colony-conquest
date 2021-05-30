extends Control

signal on_setting_close_button_press()

onready var _save_load = SaveLoad.new()
onready var _sfx_slider = $Panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer6/sfx_slider
onready var _music_slider = $Panel/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer7/music_slider

var _setting

# Called when the node enters the scene tree for the first time.
func _ready():
	_setting = _save_load.load_save(SaveLoad.GAME_SETTING_FILENAME)
	if !_setting:
		_setting = {sfx = -20, music = -20}
		
	apply_setting()

func apply_setting():
	_sfx_slider.value = _setting.sfx
	_music_slider.value = _setting.music

func save_setting():
	if _setting:
		_save_load.save(SaveLoad.GAME_SETTING_FILENAME,_setting)

func _on_button_close_pressed():
	emit_signal("on_setting_close_button_press")

func _on_sfx_slider_value_changed(value):
	if !_setting:
		return
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), value)
	_setting.sfx = value
	save_setting()
	
	
func _on_music_slider_value_changed(value):
	if !_setting:
		return
		
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), value)
	_setting.music = value
	save_setting()
