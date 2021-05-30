extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _life_time = $life_time

var time = 4.0
var keep_burn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_life_time.wait_time = time


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_life_time_timeout():
	if keep_burn:
		return
	queue_free()
