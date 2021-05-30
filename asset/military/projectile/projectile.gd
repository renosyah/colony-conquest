extends Area2D

onready var _tracer = $sprite/tracer
onready var _life_time = $life_time
onready var _area_impact = $CollisionShape2D
onready var _animation = $AnimationPlayer

var damage = 0.0
var speed = 800.0
var spread = 0.1
var sprite = preload("res://asset/military/projectile/empty.png")

var velocity : Vector2
var side = ""
var show_tracer = true
var enable_spin = false

var payload_scene = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	
	_tracer.visible = show_tracer
	if payload_scene != "":
		_life_time.wait_time = rand_range(1.4,2.3)
		_area_impact.scale = Vector2(3.0,3.0)
		
	if enable_spin:
		_animation.play("spin")
		
	set_process(true)
		
		
func lauching(from, to: Vector2):
	position = from
	velocity = to
	velocity = velocity.rotated(rand_range(-spread, spread))
	$sprite.rotation = velocity.angle()
	$sprite.texture = sprite
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * speed * delta
	if !enable_spin:
		$sprite.rotation = velocity.angle()
	
func _on_arrow_body_entered(body):
	if body.is_a_parent_of(self):
		return
	if not body is KinematicBody2D:
		return
	if body.data.side == side:
		return
		
	if payload_scene != "":
		var payload = load(payload_scene).instance()
		payload.position = position
		get_parent().call_deferred("add_child", payload)
		body.take_explosive_damage(get_parent(), damage)
		
	else:
		body.take_projectile_damage(get_parent(), damage)
		body.hit_by_projectile(sprite)
		
	queue_free()


func _on_time_out_timeout():
	if payload_scene != "":
		var payload = load(payload_scene).instance()
		payload.position = position
		get_parent().call_deferred("add_child", payload)
		
	queue_free()


func _on_tracer_display_delay_timeout():
	$sprite/tracer.visible = show_tracer
	


