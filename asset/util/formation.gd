extends Node
class_name Formation

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_formation_circle(waypoint_position :Vector2 ,number_of_unit : int, space_between_units : int = 120):
	var formations = []
	var unit_pos = waypoint_position
	var circle_size = 0
	var unit_total_count_in_circle = 6 * circle_size
	var unit_count_in_circle = 0
	var current_angle = 0
	for x in number_of_unit:
		formations.append({
			"position": unit_pos
		})
		unit_count_in_circle += 1
		if unit_count_in_circle >= unit_total_count_in_circle:
			unit_count_in_circle = 0
			current_angle = 0
			circle_size += 1
			unit_total_count_in_circle = 6 * circle_size
			unit_pos.x = waypoint_position.x + space_between_units * circle_size
			unit_pos.y = waypoint_position.y
		else:
			current_angle += (PI/3) / circle_size
			unit_pos.x = waypoint_position.x + (space_between_units * circle_size) * cos(current_angle)
			unit_pos.y = waypoint_position.y + (space_between_units * circle_size) * sin(current_angle)
			
	return formations
