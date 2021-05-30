extends Node2D
class_name Logo

onready var _bg = $bg
onready var _symbol = $symbol

const BGS = [
	"res://asset/military/logo/background/bg_1.png",
	"res://asset/military/logo/background/bg_2.png",
	"res://asset/military/logo/background/bg_3.png",
	"res://asset/military/logo/background/bg_4.png",
	"res://asset/military/logo/background/bg_5.png",
	"res://asset/military/logo/background/bg_6.png",
	"res://asset/military/logo/background/bg_7.png",
	"res://asset/military/logo/background/bg_8.png",
	"res://asset/military/logo/background/bg_9.png",
]

const SYMBOLS = [
	"res://asset/military/logo/symbol/symbol_1.png",
	"res://asset/military/logo/symbol/symbol_2.png",
	"res://asset/military/logo/symbol/symbol_3.png",
	"res://asset/military/logo/symbol/symbol_4.png",
	"res://asset/military/logo/symbol/symbol_5.png",
	
	"res://asset/military/logo/symbol/symbol_6.png",
	"res://asset/military/logo/symbol/symbol_7.png",
	"res://asset/military/logo/symbol/symbol_8.png",
	"res://asset/military/logo/symbol/symbol_9.png",
	"res://asset/military/logo/symbol/symbol_10.png",
	
	"res://asset/military/logo/symbol/symbol_11.png",
	"res://asset/military/logo/symbol/symbol_12.png",
	"res://asset/military/logo/symbol/symbol_13.png",
	"res://asset/military/logo/symbol/symbol_14.png",
	"res://asset/military/logo/symbol/symbol_15.png",
	
	"res://asset/military/logo/symbol/symbol_16.png",
	"res://asset/military/logo/symbol/symbol_17.png",
	"res://asset/military/logo/symbol/symbol_18.png",
	"res://asset/military/logo/symbol/symbol_19.png",
	"res://asset/military/logo/symbol/symbol_20.png",
	
	"res://asset/military/logo/symbol/symbol_21.png",
	"res://asset/military/logo/symbol/symbol_22.png",
	"res://asset/military/logo/symbol/symbol_23.png",
	"res://asset/military/logo/symbol/symbol_24.png",
	"res://asset/military/logo/symbol/symbol_25.png"
]

static func generate_logo() -> Dictionary:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
		
	return {
		bg = BGS[rng.randf_range(0,BGS.size())],
		symbol = SYMBOLS[rng.randf_range(0,SYMBOLS.size())],
		bg_color = get_random_color(0.15,0.60),
		symbol_color = get_random_color(0.35,0.80),
	}
	
static func get_random_color(mn,mx) -> Color:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return Color(
		rng.randf_range(mn,mx),
		rng.randf_range(mn,mx),
		rng.randf_range(mn,mx),
		1.0
	)
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
