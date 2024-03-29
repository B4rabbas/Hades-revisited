local mod_name = "vines"
local average_height = 12
local spawn_interval = 90
local vines_group = {attached_node=1,vines=1,snappy=3,flammable=2,hanging_node=1}
-- globals

local walldir ={}

minetest.register_node("vines:side", {
  description = "Jungle Vine",
  walkable = false,
  climbable = true,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "wallmounted",
  tiles = { "vines_side.png" },
  drawtype = "signlike",
  inventory_image = "vines_side.png",
  wield_image = "vines_side.png",
  groups = vines_group,
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
  after_dig_node = function(pos, oldnode, oldmetadata, user)
    local wielded if user:get_wielded_item() ~= nil then wielded = user:get_wielded_item() else return end
    if 'vines:shears' == wielded:get_name() then 
      local inv = user:get_inventory()
      if inv then
        inv:add_item("main", ItemStack(oldnode.name))
      end
    end
  end
})

minetest.register_node("vines:side_rotten", {
  description = "Rotten Jungle Vine",
  walkable = false,
  climbable = false,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "wallmounted",
  tiles = { "vines_side_rotten.png" },
  drawtype = "signlike",
  inventory_image = "vines_side_rotten.png",
  wield_image = "vines_side_rotten.png",
  groups = {snappy = 3,flammable=2, hanging_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
})



minetest.register_node("vines:willow", {
  description = "Willow Vine",
  walkable = false,
  climbable = true,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "wallmounted",
  tiles = { "vines_willow.png" },
  drawtype = "signlike",
  inventory_image = "vines_willow.png",
  wield_image = "vines_willow.png",
  groups = vines_group,
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
  after_dig_node = function(pos, oldnode, oldmetadata, user)
    local wielded if user:get_wielded_item() ~= nil then wielded = user:get_wielded_item() else return end
    if 'vines:shears' == wielded:get_name() then 
      local inv = user:get_inventory()
      if inv then
        inv:add_item("main", ItemStack(oldnode.name))
      end
    end
  end
})



minetest.register_node("vines:willow_rotten", {
  description = "Rotten Willow Vine",
  walkable = false,
  climbable = false,
  sunlight_propagates = true,
  paramtype = "light",
  drop = "",
  paramtype2 = "wallmounted",
  tiles = { "vines_willow_rotten.png" },
  drawtype = "signlike",
  inventory_image = "vines_willow_rotten.png",
  wield_image = "vines_willow_rotten.png",
  groups = {snappy = 3,flammable=2, hanging_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
})



minetest.register_node("vines:root", {
  description = "Root Vine",
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  paramtype = "light",
  tiles = { "vines_root.png" },
  drawtype = "plantlike",
  inventory_image = "vines_root.png",
  wield_image = "vines_root.png",
  groups = {vines=1,snappy = 3,flammable=2, hanging_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
  },
})



minetest.register_node("vines:vine", {
  description = "Cave Vine",
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  drop = "",
  paramtype = "light",
  tiles = { "vines_vine.png" },
  drawtype = "plantlike",
  inventory_image = "vines_vine.png",
  groups = vines_group,
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-0.3, -1/2, -0.3, 0.3, 1/2, 0.3},
  },
  after_dig_node = function(pos, oldnode, oldmetadata, user)
    local wielded if user:get_wielded_item() ~= nil then wielded = user:get_wielded_item() else return end
    if 'vines:shears' == wielded:get_name() then 
      local inv = user:get_inventory()
      if inv then
        inv:add_item("main", ItemStack(oldnode.name))      end
    end
  end
})



minetest.register_node("vines:vine_rotten", {
  description = "Rotten Cave Vine",
  walkable = false,
  climbable = true,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  tiles = { "vines_vine_rotten.png" },
  drawtype = "plantlike",
  inventory_image = "vines_vine_rotten.png",
  wield_image = "vines_vine_rotten.png",
  groups = {snappy = 3,flammable=2, hanging_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-0.3, -1/2, -0.3, 0.3, 1/2, 0.3},
  },
})



--ABM

minetest.register_abm({
  nodenames = {"vines:vine", "vines:side", "vines:willow"},
  interval = 300,
  chance = 8,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if minetest.find_node_near(pos, 5, "group:tree") == nil then
      walldir = node.param2
      minetest.add_node(pos, {name=node.name.."_rotten", param2 = walldir})
    end
  end
})



minetest.register_abm({
  nodenames = {"vines:vine", "vines:side", "vines:willow"},
  interval = 300,
  chance = 2,
  action = function(pos, node, active_object_count, active_object_count_wider)
    local p = {x=pos.x, y=pos.y-1, z=pos.z}
    local n = minetest.get_node(p)
    if n.name == "air" then
      walldir = node.param2
      minetest.add_node(p, {name=node.name, param2 = walldir})
    end
  end
})


--Craft


minetest.register_craftitem("vines:vines", {
  description = "Detached Vine",
  inventory_image = "vines_item.png",
})


--spawning
plantslib:spawn_on_surfaces({
  avoid_nodes = {"vines:vine"},
  avoid_radius = 5,
  spawn_delay = spawn_interval,
  spawn_plants = {"vines:vine"},
  spawn_chance = 50,
  spawn_surfaces = {"default:dirt_with_grass","default:dirt"},
  spawn_on_bottom = true,
  plantlife_limit = -0.9,
})

plantslib:spawn_on_surfaces({
  avoid_nodes = {"vines:vine", "vines:side"},
  avoid_radius = 3,
  spawn_delay = spawn_interval,
  spawn_plants = {"vines:side"},
  spawn_chance = 50,
  spawn_surfaces = {"group:leafdecay"},
  spawn_on_side = true,
  near_nodes = {"default:water_source", "default:jungletree"},
  near_nodes_size = 10,
  near_nodes_vertical = 5,
  near_nodes_count = 3,
  plantlife_limit = -0.9,
})

plantslib:spawn_on_surfaces({
  spawn_plants = {"vines:willow"},
  avoid_radius = 3,
  spawn_delay = spawn_interval,
  spawn_chance = 50,
  spawn_surfaces = {"group:leaves"},
  spawn_on_side = true,
  near_nodes = {"default:water_source"},
  near_nodes_size = 7,
  near_nodes_vertical = 4,
  near_nodes_count = 3,
  plantlife_limit = -0.9,
})

--Shears jojoa1997's shears


minetest.register_tool("vines:shears", {
	description = "Shears",
	inventory_image = "shears.png",
	wield_image = "shears.png",
	stack_max = 1,
	max_drop_level=3,
	groups = { shears = 1 },
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
		snappy={times={[3]=0.2, [2]=0.5, [1]=1.5}, uses=20, maxlevel=3},
		}
	},
})

minetest.register_craft({
	output = 'vines:shears',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'group:stick', 'group:wood', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_node("vines:vines_block",{
	description = "Vines Block",
	sunlight_propagates = true,
	climbable = true,
	tiles = {"vines_block.png", "vines_block.png", "vines_block.png"},
	drawtype = "allfaces_optional",
	paramtype = "light",
	groups = {snappy=2,flammable=2 },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
        output = 'vines:vines_block',
        recipe = {
                {'farming:string', '', 'farming:string'},
                {'', 'group:vines', ''},
                {'farming:string', '', 'farming:string'},
        }
})

local ENABLE_STAIRSPLUS = true


if minetest.get_modpath("moreblocks") and ENABLE_STAIRSPLUS then
	register_stair_slab_panel_micro(
		"vines",
		"vines_block",
		"vines:vines_block",
		{choppy=2, oddly_breakable_by_hand=2, flammable=2},
        	{
                	"vines_block.png", 
                	"vines_block.png", 
                	"vines_block.png", 
                	"vines_block.png", 
                	"vines_block.png", 
                	"vines_block.png"
		},
		"Vines",
		"vines_block",
		0
	)
	table.insert(circular_saw.known_stairs, "vines:vines_block")
end

minetest.register_alias("vines:rope", "vines:root")
minetest.register_alias("vines:rope_end", "vines:root")
minetest.register_alias("vines:rope_block", "default:wood")

minetest.log("action", "[vines] Loaded!")
