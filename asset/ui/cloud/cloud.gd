extends Sprite

onready var _visibile_detector = $VisibilityNotifier2D

var is_move = false
var speed = 150.0
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_opacity(val):
	modulate.a = val

func random_scale():
	var _scale = randf() + rand_range(0.5,1.5)
	scale = Vector2(_scale,_scale)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_move:
		position.x = position.x + speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
 
