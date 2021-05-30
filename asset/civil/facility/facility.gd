extends RigidBody2D


onready var _sprite = $Sprite
onready var _collision = $CollisionShape2D

var image_sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	_sprite.texture = load(image_sprite)
	_collision.scale = Vector2(1.2,1.2)

func _on_Timer_timeout():
	mode = RigidBody2D.MODE_STATIC
	_collision.scale = Vector2(1,1)
	_collision.disabled = true
		
