extends Node
class_name FortBuilding

const BUILDING_TYPE_UNIT_SPAWNER = "UNIT_SPAWNER_BUILDING"
const BUILDING_TYPE_UNIT_UPGRADER = "UNIT_UPGRADER_BUILDING"
const BUILDING_TYPE_CASTLE_UPGRADER = "CASTLE_UPGRADER_BUILDING"
const BUILDING_TYPE_FARM_UPGRADER = "FARM_UPGRADER_BUILDING"


################# unit spawner ################

const MILLITIA_BARRACK = {
	"id" : "B01",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Militia Barrack",
	"description" : "Millitary building enable fort training basic unit",
	"icon" : "res://asset/ui/buildings/militia_barrack.png",
	"cost" : 200.0,
	"troops" : [
		{
			"name" : "Militiamen",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_empty.png",
			"enable" : true,
			"cost" : 15.0,
			"training_time" : 1.7,
			"data" : TroopData.TROOP_TYPE_MILITIAMEN,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 15.0,
				"melee_armor" : 1.0,
			}
		},
		{
			"name" : "Spearman",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_spearman.png",
			"enable" : true,
			"cost" : 20.0,
			"training_time" : 1.9,
			"data" : TroopData.TROOP_TYPE_SPEARMAN,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 18.0,
				"melee_armor" : 1.0,
			}
		},
		{
			"name" : "Archer Militia",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_archer_militia.png",
			"enable" : true,
			"cost" : 25.0,
			"training_time" : 1.5,
			"data" : TroopData.TROOP_TYPE_ARCHER_MILITIA,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 14.0,
				"melee_armor" : 0.0,
			}
		}
	]
}
const MERCENARY_CAMP = {
	"id" : "B02",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Mercenary Camp",
	"description" : "Millitary building enable fort to train mercenary specialize unit",
	"icon" : "res://asset/ui/buildings/mercenary_barrack.png",
	"cost" : 900.0,
	"troops" : [
		{
			"name" : "Axeman",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_axeman.png",
			"enable" : true,
			"cost" : 45.0,
			"training_time" : 1.4,
			"data" : TroopData.TROOP_TYPE_AXEMAN,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 2.0,
				"hit_point" : 5.0,
			}
		},
		{
			"name" : "Javelineer",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_javelineer.png",
			"enable" : true,
			"cost" : 35.0,
			"training_time" : 1.6,
			"data" : TroopData.TROOP_TYPE_JAVELINEER,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 1.5,
				"hit_point" : 5.0,
			}
		},
		{
			"name" : "Bomber",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_bomber.png",
			"enable" : true,
			"cost" : 55.0,
			"training_time" : 1.7,
			"data" : TroopData.TROOP_TYPE_BOMB_THROWER,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 2.0,
				"hit_point" : 2.0,
			}
		},
		{
			"name" : "Archer Cavalry",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_archer_cavalry.png",
			"enable" : true,
			"cost" : 65.0,
			"training_time" : 3.8,
			"data" : TroopData.TROOP_TYPE_ARCHER_CAVALRY,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 0.5,
				"hit_point" : 10.0,
			}
		},
		{
			"name" : "Samurai",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_samurai.png",
			"enable" : true,
			"cost" : 85.0,
			"training_time" : 4.8,
			"data" : TroopData.TROOP_TYPE_SAMURAI,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 8.0,
				"melee_armor" : 1.0,
			},
		},
	]
}
const REGULAR_BARRACK = {
	"id" : "B03",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Barrack",
	"description" : "Millitary building enable fort to train regular infantry",
	"icon" : "res://asset/ui/buildings/barrack.png",
	"cost" : 500.0,
	"troops" : [
		{
			"name" : "Swordman",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_man_at_arms.png",
			"enable" : true,
			"cost" : 30.0,
			"training_time" : 1.3,
			"data" : TroopData.TROOP_TYPE_SWORDMAN,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 5.0,
				"melee_armor" : 1.0,
			},
		},
		{
			"name" : "Pikeman",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_pikeman.png",
			"enable" : true,
			"cost" : 35.0,
			"training_time" : 1.3,
			"data" : TroopData.TROOP_TYPE_PIKEMAN,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 5.0,
				"melee_armor" : 1.0,
			},
		},
		{
			"name" : "Maceman",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_maceman.png",
			"enable" : true,
			"cost" : 40.0,
			"training_time" : 1.3,
			"data" : TroopData.TROOP_TYPE_MACEMAN,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.5,
				"hit_point" : 5.0,
			},
		},
	]
}
const IMPERIAL_BARRACK = {
	"id" : "B04",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Imperial Barrack",
	"description" : "Millitary building enable fort to train heavy infantry",
	"icon" : "res://asset/ui/buildings/imperial_barrack.png",
	"cost" : 1200.0,
	"troops" : [
		{
			"name" : "Knight",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_swordman.png",
			"enable" : true,
			"cost" : 65.0,
			"training_time" : 2.6,
			"data" : TroopData.TROOP_TYPE_KNIGHT,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 15.0,
				"melee_armor" : 2.0,
			},
		},
		{
			"name" : "Halberdier",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_halberdier.png",
			"enable" : true,
			"cost" : 55.0,
			"training_time" : 2.4,
			"data" : TroopData.TROOP_TYPE_HALBERDIER,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 15.0,
				"melee_armor" : 2.0,
			},
		},
		{
			"name" : "Sentinel",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_sentinel.png",
			"enable" : true,
			"cost" : 65.0,
			"training_time" : 2.4,
			"data" : TroopData.TROOP_TYPE_SENTINEL,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 3.0,
				"hit_point" : 25.0,
				"melee_armor" : 1.0,
			},
		},
	]
}
const ARCHERY_RANGE = {
	"id" : "B05",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Archery Range",
	"description" : "Millitary building enable fort to train range unit",
	"icon" : "res://asset/ui/buildings/archer_range.png",
	"cost" : 700.0,
	"troops" : [
		{
			"name" : "Archer",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_archer.png",
			"enable" : true,
			"cost" : 20.0,
			"training_time" : 1.4,
			"data" : TroopData.TROOP_TYPE_ARCHER,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 0.1,
				"hit_point" : 5.0,
			},
		},
		{
			"name" : "Crossbowman",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_crossbowman.png",
			"enable" : true,
			"cost" : 70.0,
			"training_time" : 2.8,
			"data" : TroopData.TROOP_TYPE_CROSSBOWMAN,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 2.0,
				"melee_attack_damage" : 1.0,
				"hit_point" : 10.0,
				"melee_armor" : 1.0,
			},
		},
		{
			"name" : "Longbowman",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_longbowman.png",
			"enable" : true,
			"cost" : 45.0,
			"training_time" : 1.8,
			"data" : TroopData.TROOP_LONGBOWMAN,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 1.0,
				"hit_point" : 5.0,
			},
		},
	]
}
const MILLITARY_ACADEMY = {
	"id" : "B06",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Millitary Academy",
	"description" : "Millitary building enable fort to train black powder range unit",
	"icon" : "res://asset/ui/buildings/military_academy.png",
	"cost" :1600.0,
	"troops" : [
		{
			"name" : "Musketeer",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_musketeer.png",
			"enable" : true,
			"cost" : 75.0,
			"training_time" : 2.8,
			"data" : TroopData.TROOP_TYPE_MUSKETEER,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 1.0,
				"melee_attack_damage" : 1.0,
				"hit_point" : 5.0,
			},
		},
		{
			"name" : "Grenadier",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_grenadier.png",
			"enable" : true,
			"cost" : 85.0,
			"training_time" : 2.7,
			"data" : TroopData.TROOP_TYPE_GRENADIER,
			"level" : 1,
			"upgrade" : {
				"pierce_attack_damage" : 2.0,
				"hit_point" : 5.0,
			},
		}
	]
}
const STABLE = {
	"id" : "B07",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Stable",
	"description" : "Millitary building enable fort to train light armor mounted unit",
	"icon" : "res://asset/ui/buildings/stable.png",
	"cost" : 1400.0,
	"troops" : [
		{
			"name" : "Spear Cavalry",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_light_cavalry.png",
			"enable" : true,
			"cost" : 60.0,
			"training_time" : 2.6,
			"data" : TroopData.TROOP_TYPE_LIGHT_CAVALRY,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 2.0,
				"hit_point" : 10.0,
				"melee_armor" : 1.0,
				"pierce_armor" : 0.5,
			},
		},
		{
			"name" : "Sword Cavalry",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_scout_cavalry.png",
			"enable" : true,
			"cost" : 65.0,
			"training_time" : 2.3,
			"data" : TroopData.TROOP_TYPE_SCOUT_CAVALRY,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.5,
				"hit_point" : 20.0,
				"melee_armor" : 1.0,
				"pierce_armor" : 0.5,
			},
		},
	]
}
const IMPERIAL_STABLE = {
	"id" : "B08",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Imperial Stable",
	"description" : "Millitary building enable fort to train heavy armor mounted unit",
	"icon" : "res://asset/ui/buildings/imperial_stable.png",
	"cost" : 1750.0,
	"troops" : [
		{
			"name" : "Cavalier",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_cavalier.png",
			"enable" : true,
			"cost" : 90.0,
			"training_time" : 3.2,
			"data" : TroopData.TROOP_TYPE_CAVALIER,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 15.0,
				"melee_armor" : 2.0,
			},
		},
		{
			"name" : "Paladin",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_heavy_cavalry.png",
			"enable" : true,
			"cost" : 95.0,
			"training_time" : 3.4,
			"data" : TroopData.TROOP_TYPE_HEAVY_CAVALRY,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 20.0,
				"melee_armor" : 2.0,
			},
		},
	]
}
const ROYAL_STABLE = {
	"id" : "B09",
	"type" : BUILDING_TYPE_UNIT_SPAWNER,
	"name" : "Royal Stable",
	"description" : "Millitary building enable fort to train advance mounted unit",
	"icon" : "res://asset/ui/buildings/royal_stable.png",
	"cost" : 2000.0,
	"troops" : [
		{
			"name" : "Lancer",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_lance_cavalry.png",
			"enable" : true,
			"cost" : 80.0,
			"training_time" : 2.3,
			"data" : TroopData.TROOP_TYPE_LANCE_CAVALRY,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 15.0,
				"melee_armor" : 0.5,
			},
		},
		{
			"name" : "Hussar",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_saber_cavalry.png",
			"enable" : true,
			"cost" : 85.0,
			"training_time" : 2.4,
			"data" : TroopData.TROOP_TYPE_SABER_CAVALRY,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 1.0,
				"hit_point" : 15.0,
				"melee_armor" : 0.5,
			},
		},
		{
			"name" : "Dragoon",
			"icon" : "res://asset/ui/icons/squad_icon/icon_squad_musket_cavalry.png",
			"enable" : true,
			"cost" : 105.0,
			"training_time" : 4.4,
			"data" : TroopData.TROOP_TYPE_MUSKET_CAVALRY,
			"level" : 1,
			"upgrade" : {
				"melee_attack_damage" : 2.0,
				"hit_point" : 15.0,
				"melee_armor" : 1.5,
			},
		},
	]
}

static func get_troop_upgrade_cost(_troop_in_building) -> float:
	var total_current_attribute = 0.0
	for attribute in _troop_in_building.data.values():
		if attribute is float:
			total_current_attribute += attribute
			
	return round(_troop_in_building.cost + total_current_attribute * _troop_in_building.level)

static func upgrade_troop(_pointer_to_troop_in_building):
	_pointer_to_troop_in_building.level += 1
	for upgrade_key in _pointer_to_troop_in_building.upgrade.keys():
		_pointer_to_troop_in_building.data[upgrade_key] += _pointer_to_troop_in_building.upgrade[upgrade_key]
		
		
		
		
################# unit upgrade ################

const BLACKSMITH = {
	"id" : "C01",
	"type" : BUILDING_TYPE_UNIT_UPGRADER,
	"name" : "Blacksmith",
	"icon" : "res://asset/ui/buildings/blacksmith.png",
	"image_sprite":"res://asset/civil/facility/blacksmith.png",
	"description" : "\"Wanna sharpen your blade, sir?, i know the place\"",
	"descriptions" : [
		"+ 2.2 Attack for all melee unit"
	],
	"updates" : [{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "melee_attack_damage",
		"value" : 2.2
	}]
}
const ARMORER = {
	"id" : "C02",
	"type" : BUILDING_TYPE_UNIT_UPGRADER,
	"name" : "Armorer",
	"icon" : "res://asset/ui/buildings/armorer.png",
	"image_sprite":"res://asset/civil/facility/armored_workshop.png",
	"description" : "\"Wear something shinny would you\"",
	"descriptions" : [
		"+ 2.4 Melee armor for all melee unit",
		"+ 1.2 Pierce armor for all melee unit",
	],
	"updates" : [{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "melee_armor",
		"value" : 2.4
	},
	{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "pierce_armor",
		"value" : 1.2
	}]
}
const ARMORY = {
	"id" : "C02-1",
	"type" : BUILDING_TYPE_UNIT_UPGRADER,
	"name" : "Armory",
	"icon" : "res://asset/ui/buildings/armory.png",
	"image_sprite":"res://asset/civil/facility/armory.png",
	"description" : "\"Always have something for everybody\"",
	"descriptions" : [
		"+ 1.5 Attack for all melee unit",
		"+ 1.5 Attack for all range unit",
		"+ 1.0 Melee armor for all melee unit",
		"+ 1.0 Melee armor for all range unit",
		"+ 0.5 Pierce armor for all melee unit",
		"+ 0.5 Pierce armor for all range unit",
	],
	"updates" : [{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "melee_attack_damage",
		"value" : 1.5
	},
	{
		"unit_class" : TroopData.CLASS_RANGE,
		"attribute" : "pierce_attack_damage",
		"value" : 1.5
	},
	{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "melee_armor",
		"value" : 1.0
	},
	{
		"unit_class" : TroopData.CLASS_RANGE,
		"attribute" : "melee_armor",
		"value" : 1.0
	},
	{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "pierce_armor",
		"value" : 0.5
	},
	{
		"unit_class" : TroopData.CLASS_RANGE,
		"attribute" : "pierce_armor",
		"value" : 0.5
	}
	]
}
const RANGE_WORKSHOP = {
	"id" : "C03",
	"type" : BUILDING_TYPE_UNIT_UPGRADER,
	"name" : "Weaponsmith",
	"icon" : "res://asset/ui/buildings/range_workshop.png",
	"image_sprite":"res://asset/civil/facility/range_workshop.png",
	"description" : "\"Feel free to shoot at something, no charge necessary\"",
	"descriptions" : [
		"+ 2.5 Attack for all range unit"
	],
	"updates" : [{
		"unit_class" : TroopData.CLASS_RANGE,
		"attribute" : "pierce_attack_damage",
		"value" : 2.5
	}]
}
const TRAINING_FIELD = {
	"id" : "C04",
	"type" : BUILDING_TYPE_UNIT_UPGRADER,
	"name" : "Training Field",
	"icon" : "res://asset/ui/buildings/training_field.png",
	"image_sprite":"res://asset/civil/facility/training_field.png",
	"description" : "\"Not work hard enough? here, there always something you can do\"",
	"descriptions" : [
		"+ 5.0 Speed for all melee unit",
		"+ 25.0 Hitpoint for all melee unit"
	],
	"updates" : [{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "max_speed",
		"value" : 5.0
	},
	{
		"unit_class" : TroopData.CLASS_MELEE,
		"attribute" : "hit_point",
		"value" : 25.0
	}]
}
const HUNTER_LODGE = {
	"id" : "C05",
	"type" : BUILDING_TYPE_UNIT_UPGRADER,
	"name" : "Hunter lodge",
	"icon" : "res://asset/ui/buildings/hunter_lodge.png",
	"image_sprite":"res://asset/civil/facility/hunter_lodge.png",
	"description" : "\"Come on, deer does not hunt by them self\"",
	"descriptions" : [
		"+ 2.5 Attack for all range unit",
		"+ 15.0 Hitpoint for all range unit",
		"+ 10.0 Speed for all range unit",
	],
	"updates" : [{
		"unit_class" : TroopData.CLASS_RANGE,
		"attribute" : "pierce_attack_damage",
		"value" : 2.5
	},
	{
		"unit_class" : TroopData.CLASS_RANGE,
		"attribute" : "hit_point",
		"value" : 15.0
	},
	{
		"unit_class" : TroopData.CLASS_RANGE,
		"attribute" : "max_speed",
		"value" : 10.0
	}]
}

################# castle upgrade ################

const CASTLE_UPGRADE_MODE_REPLACE = "MODE_REPLACE"
const CASTLE_UPGRADE_MODE_ADD = "MODE_ADD"

const GARRISON_EXPANSION = {
	"id" : "D01",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Garrison Expansion",
	"icon" : "res://asset/ui/buildings/garrison_expansion.png",
	"description" : "\"We got more bed and provision here\"",
	"descriptions" : [
		"+ 2 Garrison capacity",
		"+ 4 Garison overload tolerant",
	],
	"mode" : CASTLE_UPGRADE_MODE_ADD,
	"updates" : [{
		"attribute" : "max_troop",
		"value" : 2
	},
	{
		"attribute" : "max_garrison_to_rebel",
		"value" : 4
	}]
}
const ADDITIONAL_SHOTER = {
	"id" : "D02",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Additional Shoter",
	"icon" : "res://asset/ui/buildings/additional_shoter.png",
	"description" : "\"Wow, new guys is amazing\"",
	"descriptions" : [
		"+ 2 Shoter",
	],
	"mode" : CASTLE_UPGRADE_MODE_ADD,
	"updates" : [{
		"attribute" : "max_shoter",
		"value" : 2
	}]
}
const EXPERT_SHOTER_TRAINING = {
	"id" : "D03",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Expert Shoter Garrison",
	"icon" : "res://asset/ui/buildings/expert_shoter.png",
	"description" : "\"I never see someone shot more accurate before\"",
	"descriptions" : [
		"+ 0.7 Damage",
		"+ 120 Projectile speed",
		"+ Increase firerate",
	],
	"mode" : CASTLE_UPGRADE_MODE_ADD,
	"updates" : [{
		"attribute" : "damage",
		"value" : 0.7
	},
	{
		"attribute" : "speed",
		"value" : 120
	},
	{
		"attribute" : "shot_delay",
		"value" : -0.5
	}]
}
const MUSKETEER_GARRISON = {
	"id" : "D05",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Musketeer Garrison",
	"icon" : "res://asset/ui/buildings/musketeer_garrison.png",
	"description" : "\"Pew pew, thats what we need\"",
	"descriptions" : [
		"+ 18 Damage",
		"- Low firerate",
	],
	"mode" : CASTLE_UPGRADE_MODE_REPLACE,
	"updates" : [{
		"attribute" : "damage",
		"value" : 18.0
	},
	{
		"attribute" : "shot_delay",
		"value" : 6.3
	},
	{
		"attribute" : "payload_scene",
		"value" : ""
	},
	{
		"attribute" : "projectile_sprite",
		"value" : "res://asset/military/projectile/empty.png"
	},
	{
		"attribute" : "show_tracer",
		"value" : true
	},
	{
		"attribute" : "firing_sound",
		"value" : "res://asset/sound/cannon.wav"
	}]
}
const HEAVY_BALISTA = {
	"id" : "D06",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Fixed heavy balista",
	"icon" : "res://asset/ui/buildings/fix_balista.png",
	"description" : "\"Here come the pointy logs\"",
	"descriptions" : [
		"+ 12 Damage",
	],
	"mode" : CASTLE_UPGRADE_MODE_REPLACE,
	"updates" : [{
		"attribute" : "damage",
		"value" : 12.0
	},
	{
		"attribute" : "payload_scene",
		"value" : ""
	},
	{
		"attribute" : "projectile_sprite",
		"value" : "res://asset/military/projectile/balista_bolt/balista_bolt.png"
	},
	{
		"attribute" : "show_tracer",
		"value" : true
	},
	{
		"attribute" : "firing_sound",
		"value" : "res://asset/sound/arrow_fly.wav"
	}]
}
const FIXED_WALL_CANNON = {
	"id" : "D07",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Fixed wall mounted cannon",
	"icon" : "res://asset/ui/buildings/fix_cannon.png",
	"description" : "\"Let see how they can stand a chance now\"",
	"descriptions" : [
		"+ 28 Damage",
		"- Low projectile speed",
		"- Low firerate",
	],
	"mode" : CASTLE_UPGRADE_MODE_REPLACE,
	"updates" : [{
		"attribute" : "damage",
		"value" : 28.0
	},
	{
		"attribute" : "shot_delay",
		"value" : 12.3
	},
	{
		"attribute" : "speed",
		"value" : 520
	},
	{
		"attribute" : "payload_scene",
		"value" : "res://asset/military/projectile/payload/explosive_payload.tscn"
	},
	{
		"attribute" : "projectile_sprite",
		"value" : "res://asset/military/projectile/cannon_shell/cannon_shell.png"
	},
	{
		"attribute" : "show_tracer",
		"value" : false
	},
	{
		"attribute" : "firing_sound",
		"value" : "res://asset/sound/explosive.wav"
	}]
}

const DICIPLINE_FORCE = {
	"id" : "D08",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Dicipline Force",
	"icon" : "res://asset/ui/buildings/dicipline_force.png",
	"description" : "\"This is our home now, its worth figting for\"",
	"descriptions" : [
		"+ Decrease minimum garrison to 2",
		"+ Decrease chance garrison to rebel"
	],
	"mode" : CASTLE_UPGRADE_MODE_REPLACE,
	"updates" : [{
		"attribute" : "min_garrison_defend",
		"value" : 2
	},
	{
		"attribute" : "max_garrison_to_rebel",
		"value" : 20
	}]
}

const FOREIGN_INSTRUCTOR = {
	"id" : "D09",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Foreign Instructor",
	"icon" : "res://asset/ui/buildings/foreign_intructor.png",
	"description" : "\"I dont understand what he say, but he harsh\"",
	"descriptions" : [
		"+ Decrease training time by -1.2",
	],
	"mode" : CASTLE_UPGRADE_MODE_ADD,
	"updates" : [{
		"attribute" : "training_time",
		"value" : -1.2
	}]
}

const MILLITARY_MANDATORY_SERVICE = {
	"id" : "D010",
	"type" : BUILDING_TYPE_CASTLE_UPGRADER,
	"name" : "Millitary Mandatory Service",
	"icon" : "res://asset/ui/buildings/millitary_mandatory_service.png",
	"description" : "\"No body will expect conscription soon\"",
	"descriptions" : [
		"+ Decrease training time by -0.3",
		"+ Decrease all recruitmen cost by -25.0",
	],
	"mode" : CASTLE_UPGRADE_MODE_ADD,
	"updates" : [{
		"attribute" : "training_time",
		"value" : -0.3
	},
	{
		"attribute" : "training_fee",
		"value" : -25.0
	}]
}


################# FARM upgrade ################

const IMPROVE_IRRIGATION  = {
	"id" : "E01",
	"type" : BUILDING_TYPE_FARM_UPGRADER,
	"name" : "Improve Irrigation",
	"icon" : "res://asset/ui/buildings/improve_irigiation.png",
	"description" : "\"Wow, look at these waterline\"",
	"descriptions" : [
		"+ Decrease harvest time by -0.4",
		"+ 4.0 Amounts harvested",
	],
	"updates" : [{
		"attribute" : "harvest_time",
		"value" : -0.4
	},
	{
		"attribute" : "amount",
		"value" : 4.0
	}]
}

const IMPROVE_LAND_FERTILITY  = {
	"id" : "E02",
	"type" : BUILDING_TYPE_FARM_UPGRADER,
	"name" : "Improve Land Fertility",
	"icon" : "res://asset/ui/buildings/land_fertility.png",
	"description" : "\"Seed, and fertilezer, hmm... neat\"",
	"descriptions" : [
		"+ Decrease harvest time by -0.3",
		"+ 8.0 Amounts harvested",
	],
	"updates" : [{
		"attribute" : "harvest_time",
		"value" : -0.3
	},
	{
		"attribute" : "amount",
		"value" : 8.0
	}]
}

const IMPROVE_HARVESTING_TOOL  = {
	"id" : "E03",
	"type" : BUILDING_TYPE_FARM_UPGRADER,
	"name" : "Improve Harvesting Tools",
	"icon" : "res://asset/ui/buildings/harvesting_tools.png",
	"description" : "\"We got new hoe, ups.. i mean new tools\"",
	"descriptions" : [
		"+ Decrease harvest time by -1.3",
	],
	"updates" : [
	{
		"attribute" : "harvest_time",
		"value" : -1.3
	}]
}



