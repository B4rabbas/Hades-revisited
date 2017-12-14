
-- Mutant

mobs:register_mob("mobs_hades:mutant", {
	type = "monster",
	hp_min = 15,
	hp_max = 20,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.x",
	textures = {
		{"mobs_sand_monster.png"},
		{"mobs_sand_monster2.png"},
		{"mobs_sand_monster3.png"},
	},
	visual_size = {x=8,y=8},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_mutant",
		attack = "mobs_mutant",
	},
	view_range = 10,
	walk_velocity = 1.5,
	run_velocity = 4,
	damage = 1,
	drops = {
		{name = "default:sand",
		chance = 2,
		min = 3,
		max = 5,},
		{name = "default:iron_lump",
		chance=9,
		min=1,
		max=2,},
		{name = "default:apple",
		chance=4,
		min=1,
		max=2,},
	},
	armor = 100,
	drawtype = "front",
	water_damage = 3,
	lava_damage = 1,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 39,
		walk_start = 41,
		walk_end = 72,
		run_start = 74,
		run_end = 105,
		punch_start = 74,
		punch_end = 105,
	},
	jump = true,
	step = 0.5,
	blood_texture = "mobs_blood.png",
	floats = 1,
})
mobs:register_spawn("mobs_hades:sand_monster", {"default:sand"}, 20, -1, 16000, 1, 31000)
mobs:register_spawn("mobs_hades:sand_monster", {"default:sand"}, 5, -1, 6000, 3, 31000)
