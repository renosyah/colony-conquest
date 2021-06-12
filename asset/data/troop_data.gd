extends Node
class_name TroopData

const MAX_STATS = {
	"name" : "",
	"description" : "",
	"squad_icon" : "",
	"attack_damage" : 15.0,
	"hit_point" : 500.0,
	"melee_armor" : 15.0,
	"pierce_armor" : 15.0,
	"range_attack" : 500.0,
	"max_speed" : 500.0,
	"morale_point" : 15
}

const CLASS_NON_COMBATANT = 0
const CLASS_MELEE = 1
const CLASS_RANGE = 2

const CATEGORY_LIGHT_SWORD_INFANTRY = "clsi-1"
const CATEGORY_LIGHT_SPEAR_INFANTRY = "clsi-2"
const CATEGORY_LIGHT_RANGE_INFANTRY = "clri-3"

const CATEGORY_MEDIUM_SWORD_INFANTRY = "cmsi-1"
const CATEGORY_MEDIUM_SPEAR_INFANTRY = "cmsi-2"
const CATEGORY_MEDIUM_RANGE_INFANTRY = "cmri-3"

const CATEGORY_HEAVY_SWORD_INFANTRY = "chsi-1"
const CATEGORY_HEAVY_SPEAR_INFANTRY = "chsi-2"
const CATEGORY_HEAVY_RANGE_INFANTRY = "chri-3"

const CATEGORY_LIGHT_SWORD_CAVALRY = "clsc-1"
const CATEGORY_LIGHT_SPEAR_CAVALRY  = "clsc-2"
const CATEGORY_LIGHT_RANGE_CAVALRY = "clrc-3"

const CATEGORY_MEDIUM_SWORD_CAVALRY = "cmsc-1"
const CATEGORY_MEDIUM_SPEAR_CAVALRY = "cmsc-2"
const CATEGORY_MEDIUM_RANGE_CAVALRY = "cmrc-3"

const CATEGORY_HEAVY_SWORD_CAVALRY = "chsc-1"
const CATEGORY_HEAVY_SPEAR_CAVALRY = "chsc-2"
const CATEGORY_HEAVY_RANGE_CAVALRY = "chrc-3"


# cosmetic troop only
const TROOP_TYPE_FLAG_HOLDER = {
	"class" : CLASS_NON_COMBATANT,
	"melee_attack_damage" : 0.0,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 1.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 70.0,
	"attack_delay" : 6.0,
	"max_speed" : 40.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/shako.png",
	"body_armor_sprite" : "res://asset/military/uniform/back_pack.png",
	"weapon" : WeaponData.BANNER,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SWORD_INFANTRY,
	"counter_bonus" : {}
}
const TROOP_TYPE_DRUMMER = {
	"class" : CLASS_NON_COMBATANT,
	"melee_attack_damage" : 0.0,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 1.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 70.0,
	"attack_delay" : 6.0,
	"max_speed" : 40.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/shako.png",
	"body_armor_sprite" : "res://asset/military/uniform/back_pack.png",
	"weapon" : WeaponData.DRUM,
	"secondary_weapon" : WeaponData.DAGGER,
	"ambient_sounds" : [
		"res://asset/sound/drum_roll.ogg",
		"res://asset/sound/war_drum.ogg",
		"res://asset/sound/drum_roll.ogg",
		"res://asset/sound/drum_roll.ogg",
		"res://asset/sound/snare.ogg",
		"res://asset/sound/drum_roll.ogg",
		"res://asset/sound/drum_roll.ogg",
	],
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SWORD_INFANTRY,
	"counter_bonus" : {}
}

# data troop class
const TROOP_TYPE_MILITIAMEN = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 3.6,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 65.0,
	"melee_armor" : 1.0,
	"pierce_armor" : 0.0,
	"range_attack" : 35.0,
	"attack_delay" : 2.0,
	"max_speed" : 60.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/no_armor.png",
	"head_sprite" : "res://asset/military/uniform/no_armor_head.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SWORD_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 6.0
		},
	}
}
const TROOP_TYPE_SPEARMAN = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 4.1,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 80.0,
	"melee_armor" : 1.5,
	"pierce_armor" : 0.0,
	"range_attack" : 80.0,
	"attack_delay" : 2.0,
	"max_speed" : 60.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/light_armor.png",
	"head_sprite" : "res://asset/military/uniform/cap_armor_helm_3.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.SPEAR,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SPEAR_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SWORD_CAVALRY: {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_MEDIUM_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 8.0
		},
	}
}
const TROOP_TYPE_ARCHER_MILITIA = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 2.5,
	"pierce_attack_damage" : 8.5,
	"hit_point" : 65.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 520.0,
	"attack_delay" : 3.4,
	"max_speed" : 50.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/no_armor.png",
	"head_sprite" : "res://asset/military/uniform/no_armor_head.png",
	"body_armor_sprite" : "res://asset/military/uniform/arrow_carrier.png",
	"weapon" : WeaponData.BOW,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 10.0
		}
	}
}
const TROOP_TYPE_SWORDMAN = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 5.2,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 90.0,
	"melee_armor" : 2.2,
	"pierce_armor" : 0.0,
	"range_attack" : 50.0,
	"attack_delay" : 2.0,
	"max_speed" : 50.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/light_armor.png",
	"head_sprite" : "res://asset/military/uniform/light_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.SHORT_SWORD,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_SWORD_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_LIGHT_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 6.0
		},
	}
}
const TROOP_TYPE_PIKEMAN = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 6.5,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 90.0,
	"melee_armor" : 2.2,
	"pierce_armor" : 0.0,
	"range_attack" : 95.0,
	"attack_delay" : 3.0,
	"max_speed" : 50.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/light_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.PIKE,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_SPEAR_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_CAVALRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SWORD_CAVALRY: {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_RANGE_CAVALRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_HEAVY_SWORD_CAVALRY: {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_HEAVY_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_HEAVY_RANGE_CAVALRY: {
			"bonus_attack_damage" : 10.0
		},
	}
}
const TROOP_TYPE_MACEMAN = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 7.0,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 55.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 35.0,
	"attack_delay" : 1.3,
	"max_speed" : 70.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/no_armor.png",
	"head_sprite" : "res://asset/military/uniform/spike_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/no_body_armor.png",
	"weapon" : WeaponData.MACE,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SWORD_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
	}
}
const TROOP_TYPE_KNIGHT = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 7.8,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 120.0,
	"melee_armor" : 7.0,
	"pierce_armor" : 3.0,
	"range_attack" : 60.0,
	"attack_delay" : 2.5,
	"max_speed" : 25.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.LONG_SWORD,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_SWORD_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY: {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 8.0
		},
	}
}
const TROOP_TYPE_HALBERDIER = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 7.4,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 110.0,
	"melee_armor" : 6.5,
	"pierce_armor" : 2.0,
	"range_attack" : 100.0,
	"attack_delay" : 2.8,
	"max_speed" : 30.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm_2.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.HALBERD,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_SPEAR_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_CAVALRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SWORD_CAVALRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_RANGE_CAVALRY: {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_SWORD_CAVALRY: {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_HEAVY_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_HEAVY_RANGE_CAVALRY: {
			"bonus_attack_damage" : 12.0
		},
	}
}
const TROOP_TYPE_SENTINEL = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 8.8,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 90.0,
	"melee_armor" : 5.5,
	"pierce_armor" : 2.0,
	"range_attack" : 35.0,
	"attack_delay" : 1.7,
	"max_speed" : 35.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm_3.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.HAMMER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_SWORD_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 20.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 16.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 16.0
		},
	}
}

const TROOP_TYPE_AXEMAN = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 8.0,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 60.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 35.0,
	"attack_delay" : 1.3,
	"max_speed" : 70.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/no_armor.png",
	"head_sprite" : "res://asset/military/uniform/wolf_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/no_body_armor.png",
	"weapon" : WeaponData.AXE,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SWORD_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 16.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 16.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 16.0
		},
	}
}
const TROOP_TYPE_SAMURAI = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 9.0,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 60.0,
	"melee_armor" : 2.0,
	"pierce_armor" : 5.0,
	"range_attack" : 85.0,
	"attack_delay" : 4.3,
	"max_speed" : 65.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/light_armor.png",
	"head_sprite" : "res://asset/military/uniform/samurai_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/samurai_armor.png",
	"weapon" : WeaponData.KATANA,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_SWORD_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_SWORD_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
	}
}
const TROOP_TYPE_JAVELINEER = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 2.2,
	"pierce_attack_damage" : 11.5,
	"hit_point" : 65.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 3.0,
	"range_attack" : 260.0,
	"attack_delay" : 1.8,
	"max_speed" : 60.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/no_armor.png",
	"head_sprite" : "res://asset/military/uniform/wolf_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.JAVELINE,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_RANGE_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
	}
}
const TROOP_TYPE_BOMB_THROWER = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 2.4,
	"pierce_attack_damage" : 18.5,
	"hit_point" : 65.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 360.0,
	"attack_delay" : 8.8,
	"max_speed" : 50.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/no_armor.png",
	"head_sprite" : "res://asset/military/uniform/no_armor_head.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.FIRE_BOMB,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_LIGHT_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY: {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_LIGHT_SWORD_CAVALRY: {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY: {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_LIGHT_RANGE_CAVALRY: {
			"bonus_attack_damage" : 6.0
		},
	}
}

const TROOP_TYPE_ARCHER = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 2.3,
	"pierce_attack_damage" : 10.5,
	"hit_point" : 70.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.5,
	"range_attack" : 580.0,
	"attack_delay" : 2.4,
	"max_speed" : 60.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/cap_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/arrow_carrier.png",
	"weapon" : WeaponData.BOW,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 6.0
		}
	}
}
const TROOP_LONGBOWMAN = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 2.3,
	"pierce_attack_damage" : 12.5,
	"hit_point" : 80.0,
	"melee_armor" : 5.0,
	"pierce_armor" : 2.5,
	"range_attack" : 780.0,
	"attack_delay" : 2.9,
	"max_speed" : 40.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/light_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/arrow_carrier.png",
	"weapon" : WeaponData.LONGBOW,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 6.0
		}
	}
}
const TROOP_TYPE_CROSSBOWMAN = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 4.3,
	"pierce_attack_damage" : 24.5,
	"hit_point" : 115.0,
	"melee_armor" : 6.0,
	"pierce_armor" : 4.0,
	"range_attack" : 520.0,
	"attack_delay" : 4.2,
	"max_speed" : 30.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.CROSSBOW,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY: {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_HEAVY_SWORD_INFANTRY: {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 10.0
		},
	}
}
const TROOP_TYPE_MUSKETEER = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 5.2,
	"pierce_attack_damage" : 29.0,
	"hit_point" : 70.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 560.0,
	"attack_delay" : 7.0,
	"max_speed" : 40.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/tricon_hat.png",
	"body_armor_sprite" : "res://asset/military/uniform/back_pack.png",
	"weapon" : WeaponData.MUSKET,
	"secondary_weapon" : WeaponData.MUSKET_MELEE,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_SWORD_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_RANGE_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
	}
}
const TROOP_TYPE_GRENADIER = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 2.7,
	"pierce_attack_damage" : 19.2,
	"hit_point" : 70.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 0.0,
	"range_attack" : 460.0,
	"attack_delay" : 6.0,
	"max_speed" : 40.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/shako.png",
	"body_armor_sprite" : "res://asset/military/uniform/back_pack.png",
	"weapon" : WeaponData.POWDER_GRENADE,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_RANGE_INFANTRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY: {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_SWORD_CAVALRY: {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY: {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_RANGE_CAVALRY: {
			"bonus_attack_damage" : 8.0
		},
	}
}
const TROOP_TYPE_SCOUT_CAVALRY = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 6.0,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 180.0,
	"melee_armor" : 4.0,
	"pierce_armor" : 0.5,
	"range_attack" : 80.0,
	"attack_delay" : 4.0,
	"max_speed" : 100.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/light_armor.png",
	"head_sprite" : "res://asset/military/uniform/light_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.SHORT_SWORD,
	"mount_sprite":"res://asset/military/mount/horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SWORD_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY : {
			"bonus_attack_damage" : 6.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
	}
}
const TROOP_TYPE_LIGHT_CAVALRY = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 5.5,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 180.0,
	"melee_armor" : 3.5,
	"pierce_armor" : 3.5,
	"range_attack" : 110.0,
	"attack_delay" : 3.0,
	"max_speed" : 100.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/light_armor.png",
	"head_sprite" : "res://asset/military/uniform/light_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/chain_body_armor.png",
	"weapon" : WeaponData.LANCE,
	"mount_sprite":"res://asset/military/mount/horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_SPEAR_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY : {
			"bonus_attack_damage" : 10.0
		},
	}
}
const TROOP_TYPE_SABER_CAVALRY = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 7.0,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 180.0,
	"melee_armor" : 1.5,
	"pierce_armor" : 0.5,
	"range_attack" : 70.0,
	"attack_delay" : 3.0,
	"max_speed" : 120.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/light_armor.png",
	"head_sprite" : "res://asset/military/uniform/shako.png",
	"body_armor_sprite" : "res://asset/military/uniform/back_pack.png",
	"weapon" : WeaponData.SABER_SWORD,
	"mount_sprite":"res://asset/military/mount/horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_SWORD_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_LIGHT_SWORD_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
	}
}

const TROOP_TYPE_LANCE_CAVALRY = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 7.5,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 175.0,
	"melee_armor" : 2.0,
	"pierce_armor" : 2.0,
	"range_attack" : 70.0,
	"attack_delay" : 3.0,
	"max_speed" : 120.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/light_armor.png",
	"head_sprite" : "res://asset/military/uniform/shako.png",
	"body_armor_sprite" : "res://asset/military/uniform/back_pack.png",
	"weapon" : WeaponData.MEDIUM_LANCE,
	"mount_sprite":"res://asset/military/mount/horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_MEDIUM_SPEAR_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		}
	}
}
const TROOP_TYPE_CAVALIER = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 7.5,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 220.0,
	"melee_armor" : 5.5,
	"pierce_armor" : 4.0,
	"range_attack" : 100.0,
	"attack_delay" : 4.3,
	"max_speed" : 85.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm_2.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.HEAVY_LANCE,
	"mount_sprite":"res://asset/military/mount/armored_horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_SPEAR_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_SWORD_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 10.0
		},
		CATEGORY_MEDIUM_SWORD_CAVALRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_MEDIUM_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 8.0
		},
	}
}
const TROOP_TYPE_HEAVY_CAVALRY = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 8.5,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 240.0,
	"melee_armor" : 7.5,
	"pierce_armor" : 4.0,
	"range_attack" : 70.0,
	"attack_delay" : 3.0,
	"max_speed" : 80.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.SHORT_SWORD,
	"mount_sprite":"res://asset/military/mount/armored_horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_SWORD_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_RANGE_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_MEDIUM_RANGE_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_LIGHT_SWORD_CAVALRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_LIGHT_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SWORD_CAVALRY : {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_MEDIUM_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_HEAVY_SPEAR_CAVALRY : {
			"bonus_attack_damage" : 12.0
		},
	}
}
const TROOP_TYPE_ARCHER_CAVALRY = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 4.0,
	"pierce_attack_damage" : 14.2,
	"hit_point" : 180.0,
	"melee_armor" : 0.0,
	"pierce_armor" : 1.0,
	"range_attack" : 550.0,
	"attack_delay" : 2.6,
	"max_speed" : 100.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/archer_armor.png",
	"head_sprite" : "res://asset/military/uniform/cap_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/arrow_carrier.png",
	"weapon" : WeaponData.BOW,
	"secondary_weapon" : WeaponData.DAGGER,
	"mount_sprite":"res://asset/military/mount/horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_LIGHT_RANGE_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 8.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 6.0
		}
	}
}
const TROOP_TYPE_MUSKET_CAVALRY = {
	"class" : CLASS_RANGE,
	"melee_attack_damage" : 6.2,
	"pierce_attack_damage" : 32.5,
	"hit_point" : 220.0,
	"melee_armor" : 6.5,
	"pierce_armor" : 4.0,
	"range_attack" : 560.0,
	"attack_delay" : 8.0,
	"max_speed" : 80.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.MUSKET,
	"secondary_weapon" : WeaponData.MUSKET_MELEE,
	"mount_sprite":"res://asset/military/mount/armored_horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_RANGE_CAVALRY,
	"counter_bonus" : {
		CATEGORY_LIGHT_SWORD_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SWORD_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_SWORD_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_LIGHT_SPEAR_INFANTRY : {
			"bonus_attack_damage" : 14.0
		},
		CATEGORY_MEDIUM_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
		CATEGORY_HEAVY_SPEAR_INFANTRY: {
			"bonus_attack_damage" : 12.0
		},
	}
}
const TROOP_TYPE_GENERAL_CAVALRY = {
	"class" : CLASS_MELEE,
	"melee_attack_damage" : 16.2,
	"pierce_attack_damage" : 0.0,
	"hit_point" : 190.0,
	"melee_armor" : 9.5,
	"pierce_armor" : 2.0,
	"range_attack" : 80.0,
	"attack_delay" : 3.0,
	"max_speed" : 80.0,
	"side" : "","logo" : {},
	"color" : Color(Color.white),
	"body_sprite" : "res://asset/military/uniform/heavy_armor.png",
	"head_sprite" : "res://asset/military/uniform/heavy_armor_helm.png",
	"body_armor_sprite" : "res://asset/military/uniform/steel_body_armor.png",
	"weapon" : WeaponData.LONG_SWORD,
	"mount_sprite":"res://asset/military/mount/armored_horse.png",
	"bonus" : {
		"attack" : 0.0,
		"defence" : 0.0,
		"mobility" : 0.0,
		"attack_delay" : 0.0
	},
	"category" : CATEGORY_HEAVY_SWORD_CAVALRY,
	"counter_bonus" : {}
}
