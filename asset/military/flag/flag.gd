extends StaticBody2D

onready var _sprite = $Sprite
onready var _logo = $logo


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_appearance(_color,_logo_data):
	_logo.set_logo(_logo_data)
	_sprite.modulate = _color
	_sprite.modulate.a = 1
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
