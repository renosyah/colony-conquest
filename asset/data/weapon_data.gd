extends Node
class_name WeaponData

const CLASS_WEAPON_MELEE = 0
const CLASS_WEAPON_RANGE = 1

# polearms
const PITCHFORK = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/pitchfork.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_polearm_trusting"],
}
const SPEAR = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/spear.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" :  ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_polearm_trusting"],
}
const PIKE = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/pike.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" :  ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_sword_slashing_2","weapon_polearm_trusting"],
}
const HALBERD = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/halberd.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" :  ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_sword_slashing_2","weapon_polearm_trusting"],
}
const LANCE = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/lance.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" :  ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_sword_slashing_2","weapon_polearm_trusting","weapon_sword_slashing"],
}
const MEDIUM_LANCE = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/medium_lance.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" :  ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_sword_slashing_2","weapon_polearm_trusting","weapon_sword_slashing"],
}
const HEAVY_LANCE = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/heavy_lance.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" :  ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_sword_slashing_2","weapon_polearm_trusting","weapon_sword_slashing"],
}
const MUSKET_MELEE = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/musket.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" :  ["weapon_ready","weapon_ready_2"],
	"attack_animation" : ["weapon_polearm_trusting"],
}


# special purpose
const DAGGER = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/dagger.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready","weapon_ready_3"],
	"attack_animation": ["weapon_sword_slashing_2"]
}
const AXE = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/axe.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready_3"],
	"attack_animation": ["weapon_sword_slashing","weapon_sword_slashing_2"]
}
const MACE = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/mace.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready_3"],
	"attack_animation": ["weapon_sword_slashing","weapon_sword_slashing_2"]
}
const HAMMER = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/war_hammer.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready_3"],
	"attack_animation": ["weapon_sword_slashing","weapon_sword_slashing_2"]
}

# cosmetic
const BANNER = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/banner.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"logo" : {},
	"iddle_animation" :  ["banner_iddle"],
	"ready_animation" :  ["banner_iddle"],
	"attack_animation" : ["banner_iddle"],
}
const DRUM = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/drum.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"iddle_animation" :  ["drumer_iddle"],
	"ready_animation" :  ["drumer_iddle"],
	"attack_animation" : ["drumer_iddle"],
}


# sword
const SHORT_SWORD = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/short_sword.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready_3"],
	"attack_animation" : ["weapon_sword_slashing","weapon_sword_slashing_2"]
}
const LONG_SWORD = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/sword.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready_3"],
	"attack_animation": ["weapon_sword_slashing","weapon_sword_slashing_2"]
}
const SABER_SWORD = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/saber_sword.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready_3"],
	"attack_animation" : ["weapon_sword_slashing_2"]
}
const KATANA = {
	"weapon_type" : CLASS_WEAPON_MELEE,
	"weapon_sprite":"res://asset/military/weapon/katana.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "",
	"color" : null,
	"ready_animation" : ["weapon_ready_2","weapon_ready_3"],
	"attack_animation": ["weapon_sword_slashing_2"]
}


# bow
const BOW = {
	"weapon_type" : CLASS_WEAPON_RANGE,
	"weapon_sprite":"res://asset/military/weapon/bow.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/arrow/arrow.png",
	"weapon_firing_sound": "",
	"color" : null,
	"projectile_speed" : 700.0,
	"ready_animation" : ["weapon_iddle"],
	"attack_animation": ["weapon_bow_firing"]
}
const LONGBOW = {
	"weapon_type" : CLASS_WEAPON_RANGE,
	"weapon_sprite":"res://asset/military/weapon/long_bow.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/arrow/arrow.png",
	"weapon_firing_sound": "",
	"color" : null,
	"projectile_speed" : 650.0,
	"ready_animation" : ["weapon_iddle"],
	"attack_animation": ["weapon_bow_firing"]
}
# javeline
const JAVELINE = {
	"weapon_type" : CLASS_WEAPON_RANGE,
	"weapon_sprite":"res://asset/military/projectile/javeline/javelin.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/javeline/javelin.png",
	"weapon_firing_sound": "",
	"color" : null,
	"projectile_speed" : 600.0,
	"ready_animation" : ["weapon_ready"],
	"attack_animation": ["weapon_throwing"]
}
# grenade
const POWDER_GRENADE = {
	"weapon_type" : CLASS_WEAPON_RANGE,
	"weapon_sprite":"res://asset/military/projectile/powder_grenade/powder_grenade.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/powder_grenade/powder_grenade.png",
	"weapon_firing_sound": "",
	"color" : null,
	"payload_scene" : "res://asset/military/projectile/payload/explosive_payload.tscn",
	"projectile_speed" : 400.0,
	"ready_animation" : ["weapon_ready"],
	"attack_animation": ["weapon_throwing"]
}
# fire bomb
const FIRE_BOMB = {
	"weapon_type" : CLASS_WEAPON_RANGE,
	"weapon_sprite":"res://asset/military/projectile/fire_bomb/fire_bomb.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/fire_bomb/fire_bomb.png",
	"weapon_firing_sound": "",
	"color" : null,
	"payload_scene" : "res://asset/military/projectile/payload/explosive_payload.tscn",
	"projectile_speed" : 400.0,
	"ready_animation" : ["weapon_ready"],
	"attack_animation": ["weapon_throwing"]
}

# cross bow
const CROSSBOW = {
	"weapon_type" : CLASS_WEAPON_RANGE,
	"weapon_sprite":"res://asset/military/weapon/crossbow.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/bolt/bolt.png",
	"weapon_firing_sound": "",
	"color" : null,
	"projectile_speed" : 800.0,
	"ready_animation" : ["weapon_ready"],
	"attack_animation": ["weapon_crossbow_firing"]
}
# firearms
const MUSKET = {
	"weapon_type" : CLASS_WEAPON_RANGE,
	"weapon_sprite":"res://asset/military/weapon/musket.png",
	"weapon_projectile_sprite":"res://asset/military/projectile/empty.png",
	"weapon_firing_sound": "res://asset/sound/cannon.wav",
	"color" : null,
	"projectile_speed" : 850.0,
	"ready_animation" : ["weapon_iddle"],
	"attack_animation": ["weapon_musket_firing"]
}

