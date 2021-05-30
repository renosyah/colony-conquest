extends Control

onready var _bg_result = $TextureRect2

onready var _title_result = $VBoxContainer/Label
onready var _sub_title_result = $VBoxContainer/Label2
onready var _image_result = $VBoxContainer/TextureRect

onready var _layout_home_button = $VBoxContainer/HBoxContainer
onready var _layout_surrender_button = $VBoxContainer/HBoxContainer2

onready var _score_board = $VBoxContainer/score_board
onready var _score_item_holder = $VBoxContainer/score_board/HBoxContainer/ScrollContainer/VBoxContainer

var _data_score = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func display_surrender():
	_title_result.text = "Resign?"
	_sub_title_result.text = ""
	_layout_surrender_button.visible = true
	_layout_home_button.visible = false
	_bg_result.visible = true
	_score_board.visible = false
	
func display_win():
	display_score_board()
	_title_result.text = "Victory"
	_sub_title_result.text = "All fort has been captured!\n\n"
	_image_result.texture = preload("res://asset/ui/ilustration/win.png")
	_layout_surrender_button.visible = false
	_layout_home_button.visible = true
	_bg_result.visible = true
	
func display_lose():
	display_score_board()
	_title_result.text = "Defeated"
	_sub_title_result.text = "All fort has been lost!\n\n"
	_image_result.texture = preload("res://asset/ui/ilustration/loss.png")
	_layout_surrender_button.visible = false
	_layout_home_button.visible = true
	_bg_result.visible = true

func set_data_score(_data):
	_data_score = _data

func display_score_board():
	if _data_score.empty():
		return
		
	_score_board.visible = true
	for data in _data_score.values():
		var item = preload("res://asset/game/score_board/score_board_item.tscn").instance()
		item.data = data
		_score_item_holder.add_child(item)

func _on_to_home_button_pressed():
#	var root = get_tree().get_root()
#	var current_scene = root.get_child(root.get_child_count() -1)
#	current_scene.queue_free()
#
	get_tree().change_scene("res://asset/menu/menu.tscn")
	
func _on_yes_button_pressed():
	display_lose()

func _on_no_button_pressed():
	visible = false
	_bg_result.visible = false
