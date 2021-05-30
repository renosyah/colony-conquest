extends VBoxContainer

onready var _logo = $PanelContainer/HBoxContainer/VBoxContainer/TextureRect/logo_ui
onready var _player_banner = $PanelContainer/HBoxContainer/VBoxContainer/TextureRect
onready var _name = $PanelContainer/HBoxContainer/VBoxContainer/Label
onready var _troop_train = $PanelContainer/HBoxContainer/VBoxContainer2/Label1
onready var _troop_kill = $PanelContainer/HBoxContainer/VBoxContainer2/Label2
onready var _troop_lost = $PanelContainer/HBoxContainer/VBoxContainer2/Label3
onready var _logistic = $PanelContainer/HBoxContainer/VBoxContainer2/Label4

var data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_logo.set_logo(data.logo)
	_player_banner.modulate = data.color
	_name.text = data.name
	_troop_train.text = "Troop Train : " + str(data.troop_train)
	_troop_kill.text = "Enemy Killed : " + str(data.troop_killed)
	_troop_lost.text = "Troop Lost : " + str(data.troop_lost)
	_logistic.text = "Logistic : " + str(data.logistic)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
