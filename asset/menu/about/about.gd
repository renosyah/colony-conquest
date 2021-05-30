extends Control

signal on_about_close_button_press()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_button_close_pressed():
	emit_signal("on_about_close_button_press")
	
func _on_fb_pressed():
	OS.shell_open("https://www.facebook.com/renosyah975/")
	
func _on_git_pressed():
	OS.shell_open("https://github.com/renosyah")
	
func _on_gd_pressed():
	OS.shell_open("https://godotengine.org")
