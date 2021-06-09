extends Node
class_name Biom


const GRASS_LAND = 0
const WET_LAND = 1
const MUD_LAND = 2
const URBAN_LAND = 3
const SAND_LAND = 4

const BIOMS = [
	{
		"id" : GRASS_LAND,
		"name" : "Grass Land",
		"sprite" : "res://asset/ui/map_biom/grass_land.png"
	},
#	{
#		"id" : WET_LAND,
#		"name" : "Wet Land",
#		"sprite" : "res://asset/ui/map_biom/wet_land.png"
#	},
	{
		"id" : MUD_LAND,
		"name" : "Mud Land",
		"sprite" : "res://asset/ui/map_biom/mud_land.png"
	},
	{
		"id" : URBAN_LAND,
		"name" : "Urban Land",
		"sprite" : "res://asset/ui/map_biom/urban_land.png"
	},
	{
		"id" : SAND_LAND,
		"name" : "Sand Land",
		"sprite" : "res://asset/ui/map_biom/sand_land.png"
	},
]
const TILE_ID = {
	'grass' : 0,
	'mud' : 1,
	'water' : 2,
	'dirt' : 3,
	'wall' : 4,
	'sand' : 5
}
const SOLID_TILE_ID = {
	'grass' : 0,
	'mud' : 1,
	'sand' : 5
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
