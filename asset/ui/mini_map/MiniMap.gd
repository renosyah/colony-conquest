extends MarginContainer

signal on_minimap_click()

var camera : Camera2D # If this is null, the map will not function.
var zoom = 2.5 # Scale multiplier.

# Node references.
onready var grid = $MarginContainer/Grid
onready var frame = $Frame
onready var camera_marker = $MarginContainer/Grid/Camera
onready var fort_marker = $MarginContainer/Grid/FortMarker
onready var troop_marker = $MarginContainer/Grid/TroopMarker
onready var input_detection = $input_detection

# Link object icon setting to Sprite marker.
onready var icons = {
	"camera": camera_marker,
	"fort": fort_marker,
	"troop": troop_marker,
}

var mode = GlobalConst.NORMAL
var map_objects = []
var grid_scale  # Calculated world to map scale.
var markers = {}  # Dictionary of object: marker.


func _ready():
	camera_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	input_detection.connect("any_gesture", self, "_on_input_touch_is_validated")

func set_camera(_camera):
	camera = _camera
	camera.connect("on_camera_moving", self, "_on_camera_moving")

func set_minimap_border_color(_color):
	frame.self_modulate = _color
	
func _process(delta):
	# If no player is assigned, do nothing.
	if !camera:
		return
	grid_scale = grid.rect_size / (get_viewport_rect().size * clamp(zoom , 0.5, 5))
	
	var cam_pos = grid_scale + grid.rect_size / 2
	cam_pos.x = clamp(cam_pos.x, 0, grid.rect_size.x)
	cam_pos.y = clamp(cam_pos.y, 0, grid.rect_size.y)
	
	camera_marker.position = cam_pos
	#frame.visible = (mode == GlobalConst.NORMAL)
	
	for item in markers:
		if is_instance_valid(item):
			var obj_pos = (item.position - camera.position) * grid_scale + grid.rect_size / 2
			# If marker is outside grid, hide or shrink it.
			if grid.get_rect().has_point(obj_pos + grid.rect_position):
				markers[item].get_child(0).visible = false
				markers[item].self_modulate = item.MINIMAP_COLOR
				
				if item.MINIMAP_MARKER == "fort":
					markers[item].scale = Vector2(4, 4) / Vector2(zoom, zoom) 
					if mode == GlobalConst.EXPAND:
						markers[item].scale = Vector2(2, 2)
						markers[item].get_child(0).visible = true
				
				elif item.MINIMAP_MARKER == "troop":
					markers[item].scale = Vector2(1, 1) / Vector2(zoom, zoom) 
					if mode == GlobalConst.EXPAND:
						markers[item].scale = Vector2(1, 1)
						
				markers[item].modulate.a = 1.0
				markers[item].show()
				
			else:
				markers[item].scale = Vector2(1, 1) / Vector2(zoom, zoom) 
				if mode == GlobalConst.EXPAND:
					markers[item].scale = Vector2(1, 1)
					
				markers[item].modulate.a = 0.5
				markers[item].get_child(0).visible = false
				
				if item.MINIMAP_MARKER == "troop":
					markers[item].hide()
				#markers[item].hide()
			
			# Don't draw markers outside grid rectangle.
			obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
			obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)
			markers[item].position = obj_pos
		
		
func add_object(object):
	var new_marker = icons[object.MINIMAP_MARKER].duplicate()
	if object.MINIMAP_MARKER == "fort":
		new_marker.get_child(0).text = object.fort_name
	else:
		new_marker.get_child(0).visible = false
		
	grid.add_child(new_marker)
	grid.move_child(new_marker, 0)
	new_marker.self_modulate = object.MINIMAP_COLOR
	new_marker.show()
	markers[object] = new_marker
		
		
func remove_object(object):
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)
		
		
func set_zoom(value):
	zoom = value
	grid_scale = grid.rect_size / (get_viewport_rect().size * clamp(zoom , 0.5, 5))
	
func _on_camera_moving( _pos, _zoom):
	set_zoom(_zoom.x + 1.5 * 2)
	camera_marker.scale = _zoom / 1.5
	
func _on_MiniMap_gui_input(event):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		minimap_click()
		
	input_detection.check_input(event)
	
	if mode == GlobalConst.EXPAND:
		camera.parsing_input(event)
		
	#get_viewport().unhandled_input(event)

func _on_input_touch_is_validated(sig ,event):
	if event is InputEventSingleScreenTap:
		minimap_click()
		
func minimap_click():
	emit_signal("on_minimap_click")

