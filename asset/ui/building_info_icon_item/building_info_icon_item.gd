extends PanelContainer


onready var _icon = $VBoxContainer/HBoxContainer/icon
onready var _name = $VBoxContainer/HBoxContainer/VBoxContainer/building_name
onready var _description = $VBoxContainer/HBoxContainer/VBoxContainer/building_description
onready var _content_holder = $VBoxContainer/HBoxContainer/VBoxContainer

onready var _text_description_template = $VBoxContainer/HBoxContainer/VBoxContainer/text_description_template

var data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	display_data()

func display_data():
	_name.text = data.name
	_description.text = data.description
	_icon.texture = load(data.icon)
	
	for description in data.descriptions:
		var template = _text_description_template.duplicate()
		template.text = description
		template.visible = true
		_content_holder.add_child(template)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
