extends Node2D

var speed = 100.0
var velocity = Vector2.ZERO

var text = ""
var texture
var color = Color(Color.white)
var label_scale = Vector2(1,1)

onready var label = $Label
onready var icon = $Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if texture:
		icon.texture = texture
	label.text = text
	label.modulate = color
	label.set_as_toplevel(true)
	set_as_toplevel(true)
	label.rect_global_position = global_position
	label.rect_scale = label_scale
	
	
func _process(delta):
	label.rect_global_position.y += -1.0 * speed * delta
	position.y += -1.0 * speed * delta

func _on_life_time_timeout():
	queue_free()
