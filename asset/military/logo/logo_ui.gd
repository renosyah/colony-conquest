extends CenterContainer

onready var _bg = $bg
onready var _symbol = $symbol

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func set_logo(data):
	if data.empty():
		return
	_bg.texture = load(data.bg)
	_bg.modulate = data.bg_color
	_symbol.texture = load(data.symbol)
	_symbol.modulate = data.symbol_color
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
