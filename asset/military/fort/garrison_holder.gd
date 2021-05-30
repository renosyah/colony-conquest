extends Node2D
class_name GarrisonHolder

var unique_id = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var uuid = GDUUID.new()
	unique_id = uuid.v4()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
