extends RigidBody2D


const TREE_SPRITE_PATH = [
	"res://asset/terrain/tree/tree1.png",
	"res://asset/terrain/tree/tree2.png",
	"res://asset/terrain/tree/tree3.png",
	"res://asset/terrain/tree/tree4.png",
	"res://asset/terrain/tree/tree5.png"
]

onready var rng = RandomNumberGenerator.new()
onready var _sprite = $Sprite
onready var _collision = $CollisionShape2D

func _ready():
	_show_tree()
	_collision.scale = Vector2(1.7,1.7)
	
func _show_tree():
	rng.randomize()
	_sprite.texture = load(TREE_SPRITE_PATH[rng.randf_range(0,TREE_SPRITE_PATH.size())])


func _on_Timer_timeout():
	mode = RigidBody2D.MODE_STATIC
	_collision.scale = Vector2(1,1)
	_collision.disabled = true
	
