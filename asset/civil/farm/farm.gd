extends RigidBody2D

signal on_income(owner_id,amount)


onready var _income_timer = $income_timer
onready var _sprite = $Sprite
onready var _icon = $Sprite2
onready var _flag = $flag
onready var _collision = $CollisionShape2D
onready var _warning = $Sprite2/Sprite
onready var _income_progress = $Sprite2/income_progress

onready var _burning = $burning

# this is pointer!
var enemies_nearby = []

var owner_id = ""
var color = Color.white
var logo = {}

var data = {
	harvest_time = 5.0,
	amount = 25.0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_burning.visible = false
	_burning.keep_burn = true
	_icon.visible = false
	_icon.texture = preload("res://asset/ui/icons/supply.png")
	_sprite.texture = preload("res://asset/civil/farm/field.png")
	_flag.set_appearance(color,logo)
	_collision.scale = Vector2(2.2,2.2)
	_income_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_income_progress.visible = enemies_nearby.empty()
	_warning.visible = !enemies_nearby.empty()
	_burning.visible = !enemies_nearby.empty()
	
	_income_progress.max_value = _income_timer.wait_time
	_income_progress.value = _income_timer.time_left
	
func on_fort_captured(fort):
	owner_id = fort.owner_id
	_flag.set_appearance(fort.color,fort.logo)
	
func on_region_click(is_showing):
	_icon.visible = is_showing
		
		
func set_enemies_nearby(_targets):
	enemies_nearby = _targets
		
		
func show_income_chatter(text):
	var chatter = preload("res://asset/ui/squad_chatter/squad_chatter.tscn").instance()
	chatter.position = position
	chatter.text = text
	add_child(chatter)
	
	
func _on_income_timer_timeout():
		
	mode = RigidBody2D.MODE_STATIC
	_collision.scale = Vector2(1,1)
	_collision.disabled = true
		
	var time = data.harvest_time
	if time < 1.0:
		time = 1.0
		
	_income_timer.wait_time = time
	_income_timer.start()
		
	if !enemies_nearby.empty():
		return
		
	show_income_chatter("+" + str(data.amount))
	emit_signal("on_income",owner_id, round(data.amount))
	
