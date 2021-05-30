extends Node2D

onready var _audio = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	_audio.stream = preload("res://asset/sound/explode2.wav")
	_audio.play()
	
func _on_AudioStreamPlayer2D_finished():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	var _burn_count = rand_range(1,2)
	for i in _burn_count:
		_spawn_burning()
		
func _on_life_time_timeout():
	queue_free()
	
func _spawn_burning():
	randomize()
	var burn = preload("res://asset/ui/burning/burning.tscn").instance()
	burn.position = position + Vector2(rand_range(-35,35),rand_range(-35,35))
	burn.time = 1.5
	burn.set_as_toplevel(true)
	add_child(burn)
	


