minetest.register_node("columnia:machine", {
	description = "Columnia Workstation",
	tiles = {
		"columnia_machine_top.png",
		"columnia_machine_bottom.png",
		"columnia_machine_side2.png",
		"columnia_machine_side1.png",
		"columnia_machine_back.png",
		"columnia_machine_front.png"
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=3, cracky=3, oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.1875, -0.5, 0.5, -0.0625, 0.5},
			{-0.125, 0.0625, -0.125, 0.125, 0.5, 0.125},
			{-0.25, 0, -0.25, 0.25, 0.125, 0.25},
			{-0.4375, -0.5, -0.4375, -0.3125, -0.1875, -0.3125},
			{-0.4375, -0.5, 0.3125, -0.3125, -0.1875, 0.4375},
			{0.3125, -0.5, -0.4375, 0.4375, -0.1875, -0.3125},
			{0.3125, -0.5, 0.3125, 0.4375, -0.1875, 0.4375},
			{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
			{-0.1875, -0.0625, -0.3125, -0.125, 0, 0.3125},
			{0.125, -0.0625, -0.3125, 0.1875, 0, 0.3125},
			{-0.4375, -0.0625, -0.4375, -0.375, 0, -0.0625},
			{-0.375, -0.0625, -0.4375, -0.1875, 0, -0.375}, 
			{0.28125, -0.0625, 0.3125, 0.46875, 0.0625, 0.4375}, 
			{0.34375, -0.0625, -0.0625, 0.40625, 0, 0.4375},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5}
	},
	sounds = default.node_sound_wood_defaults(),

	after_place_node = function(pos, placer)
	local meta = minetest.env:get_meta(pos);
			meta:set_string("owner",  (placer:get_player_name() or ""));
			meta:set_string("infotext",  "Columnia workstation is empty (owned by " .. (placer:get_player_name() or "") .. ")");
		end,

	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("ingot") then
			return false
		elseif not inv:is_empty("res") then
			return false
		end
		return true
	end,

	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "invsize[10,10;]"..
			"background[-0.20,-0.25;10.40,11;columnia_background.png]"..
			"listcolors[#001100;#006600;#ffffff;#006600;#ffffff]"..
			"list[current_name;ingot;7,5;1,1;]"..
			"list[current_name;res;8,5;1,1;]"..
			"label[7,4.5;Input:]"..
			"label[8,4.5;Output:]"..

			"label[1,0;Basics]"..
			"image_button[1,0.5;1,1;columnia_mach1.png;column_bottom; ]"..
			"image_button[2,0.5;1,1;columnia_mach2.png;column_mid; ]"..
			"image_button[3,0.5;1,1;columnia_mach3.png;column_top; ]"..
			"image_button[4,0.5;1,1;columnia_mach4.png;column_crosslink; ]"..

			"label[1,1.5;Links]"..
			"image_button[1,2;1,1;columnia_mach5.png;column_link; ]"..
			"image_button[2,2;1,1;columnia_mach7.png;column_linkcross; ]"..
			"image_button[3,2;1,1;columnia_mach10.png;column_linkangle; ]"..
			"image_button[4,2;1,1;columnia_mach14.png;column_linktee; ]"..

			"label[1,3;Links with Downs]"..
			"image_button[1,3.5;1,1;columnia_mach6.png;column_linkdown; ]"..
			"image_button[2,3.5;1,1;columnia_mach8.png;column_linkcrossdown; ]"..
			"image_button[3,3.5;1,1;columnia_mach13.png;column_linkangle_down; ]"..
			"image_button[4,3.5;1,1;columnia_mach15.png;column_linktee_down; ]"..
			"image_button[5,3.5;1,1;columnia_mach9.png;column_linkvertical; ]"..

			"label[1,4.5;Stair Substructures]"..
			"image_button[1,5;1,1;columnia_mach11.png;column_stairsub; ]"..
			"image_button[2,5;1,1;columnia_mach12.png;column_stairsubpillar; ]"..

			"list[current_player;main;1,6.25;8,4;]"..

			"listring[current_player;main]"..
			"listring[current_name;ingot]"..
			"listring[current_player;main]"..
			"listring[current_name;res]")
		meta:set_string("infotext", "Columnia workstation")
		local inv = meta:get_inventory()
		inv:set_size("ingot", 1)
		inv:set_size("res", 1)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()

-----------------------------
if fields["column_bottom"] 
or fields["column_mid"]
or fields["column_top"]
or fields["column_crosslink"]
or fields["column_link"]
or fields["column_linkdown"]
or fields["column_linkcross"]
or fields["column_linkcrossdown"]
or fields["column_linkvertical"]
or fields["column_linkangle"]
or fields["column_linkangle_down"]
or fields["column_linktee"]
or fields["column_linktee_down"]
or fields["column_stairsub"]
or fields["column_stairsubpillar"]
then

--Crown Mould-----------------------------------------

	local material, shape
	local make_ok = false
	local anzahl

	if inv:is_empty("ingot") then
		return
	end

	if fields["column_bottom"] then
		anzahl = 1
		shape = "columnia:column_bottom_"
	end

	if fields["column_mid"] then
		make_ok = false
		anzahl = 1
		shape = "columnia:column_mid_"
	end

	if fields["column_top"] then
		anzahl = 1
		shape = "columnia:column_top_"
	end

	if fields["column_crosslink"] then
		make_ok = false
		anzahl = 1
		shape = "columnia:column_crosslink_"
	end

	if fields["column_link"] then
		anzahl = 2
		shape = "columnia:column_link_"
	end

	if fields["column_linkdown"] then
		anzahl = 2
		shape = "columnia:column_linkdown_"
	end

	if fields["column_linkcross"] then
		anzahl = 2
		shape = "columnia:column_linkcross_"
	end

	if fields["column_linkcrossdown"] then
		anzahl = 2
		shape = "columnia:column_linkcrossdown_"
	end

	if fields["column_linkvertical"] then
		anzahl = 4
		shape = "columnia:column_linkvertical_"
	end

	if fields["column_linkangle"] then
		anzahl = 2
		shape = "columnia:column_linkangle_"
	end

	if fields["column_linkangle_down"] then
		anzahl = 2
		shape = "columnia:column_linkangle_down_"
	end

	if fields["column_linktee"] then
		anzahl = 2
		shape = "columnia:column_linktee_"
	end

	if fields["column_linktee_down"] then
		anzahl = 2
		shape = "columnia:column_linktee_down_"
	end

	if fields["column_stairsub"] then
		anzahl = 1
		shape = "columnia:column_stairsub_"
	end

	if fields["column_stairsubpillar"] then
		anzahl = 1
		shape = "columnia:column_stairsubpillar_"
	end

	local ingotstack = inv:get_stack("ingot", 1)
	local resstack = inv:get_stack("res", 1)

----------------------------------------------------------------------
--Register Items
----------------------------------------------------------------------

	if columnia.registered_materials[ingotstack:get_name()] then
		material = columnia.registered_materials[ingotstack:get_name()]
		make_ok = true
	end
--[[
		if ingotstack:get_name()=="default:sandstone" then
				material = "default_sandstone"
				make_ok = "1"
		end
	
		if ingotstack:get_name()=="default:sandstonebrick" then
				material = "default_sandstonebrick"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:clay" then
				material = "default_clay"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:desert_stone" then
				material = "default_desert_stone"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:cobble" then
				material = "default_cobble"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:stone" then
				material = "default_stone"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:cactus" then
				material = "default_cactus"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:wood" then
				material = "default_wood"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:pinewood" then
				material = "default_pinewood"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:dirt" then
				material = "default_dirt"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:brick" then
				material = "default_brick"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:bronzeblock" then
				material = "default_bronzeblock"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:coalblock" then
				material = "default_coalblock"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:copperblock" then
				material = "default_copperblock"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:diamondblock" then
				material = "default_diamondblock"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:glass" then
				material = "default_glass"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:goldblock" then
				material = "default_goldblock"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:jungletree" then
				material = "default_jungletree"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:junglewood" then
				material = "default_junglewood"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:mese" then
				material = "default_mese"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:mossycobble" then
				material = "default_mossycobble"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:obsidian" then
				material = "default_obsidian"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:obsidian_glass" then
				material = "default_obsidian_glass"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:obsidianbrick" then
				material = "default_obsidian_brick"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:pinetree" then
				material = "default_pinetree"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:steelblock" then
				material = "default_steelblock"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:stonebrick" then
				material = "default_stonebrick"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:tree" then
				material = "default_tree"
				make_ok = "1"
		end
		
		if ingotstack:get_name()=="columnia:rusty_block" then
				material = "columnia_rusty_block"
				make_ok = "1"
		end

		if ingotstack:get_name()=="farming:straw" then
				material = "farming_straw"
				make_ok = "1"
		end 

		---------------
		-- hades
		
		if ingotstack:get_name()=="default:palewood" then
				material = "default_palewood"
				make_ok = "1"
		end 
		
		
		if ingotstack:get_name()=="default:colwood_black" then
				material = "default_colwood_black"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_blue" then
				material = "default_colwood_blue"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_brown" then
				material = "default_colwood_brown"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_cyan" then
				material = "default_colwood_cyan"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_dark_green" then
				material = "default_colwood_dark_green"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_dark_grey" then
				material = "default_colwood_dark_grey"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_grey" then
				material = "default_colwood_grey"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_green" then
				material = "default_colwood_green"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_magenta" then
				material = "default_colwood_magenta"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_orange" then
				material = "default_colwood_orange"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_pink" then
				material = "default_colwood_pink"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_red" then
				material = "default_colwood_red"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_violet" then
				material = "default_colwood_violet"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_white" then
				material = "default_colwood_white"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:colwood_yellow" then
				material = "default_colwood_yellow"
				make_ok = "1"
		end 
		
		-- BRICKS
		
		if ingotstack:get_name()=="default:brick_black" then
				material = "default_brick_black"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_blue" then
				material = "default_brick_blue"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_brown" then
				material = "default_brick_brown"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_cyan" then
				material = "default_brick_cyan"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_dark_green" then
				material = "default_brick_dark_green"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_dark_grey" then
				material = "default_brick_dark_grey"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_green" then
				material = "default_brick_green"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_grey" then
				material = "default_brick_grey"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_magenta" then
				material = "default_brick_magenta"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_orange" then
				material = "default_brick_orange"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_pink" then
				material = "default_brick_pink"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_red" then
				material = "default_brick_red"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_violet" then
				material = "default_brick_violet"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_white" then
				material = "default_brick_white"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:brick_yellow" then
				material = "default_brick_yellow"
				make_ok = "1"
		end 
		
		-- MORE Stones
		
	
		
		if ingotstack:get_name()=="default:marble_brick" then
				material = "default_marble_brick"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:marble" then
				material = "default_marble"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:chondrit_brick" then
				material = "default_chondrit_brick"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:chondrit" then
				material = "default_chondrit"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:tuff_brick" then
				material = "default_tuff_brick"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:tuff" then
				material = "default_tuff"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:tuff_baked_brick" then
				material = "default_tuff_baked_brick"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:tuff_baked" then
				material = "default_tuff_baked"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:essexit_brick" then
				material = "default_essexit_brick"
				make_ok = "1"
		end 
		
		if ingotstack:get_name()=="default:essexit" then
				material = "default_essexit"
				make_ok = "1"
		end 
		
		
		
		if ingotstack:get_name()=="default:cactus_block" then
				material = "default_cactus_block"
				make_ok = "1"
		end
		
		if ingotstack:get_name()=="default:cactus_brick" then
				material = "default_cactus_brick"
				make_ok = "1"
		end
		
		
----------------------------------------------------------------------------
--wool

		if ingotstack:get_name()=="wool:white" then
				material = "wool_white"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:black" then
				material = "wool_black"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:blue" then
				material = "wool_blue"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:brown" then
				material = "wool_brown"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:cyan" then
				material = "wool_cyan"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:dark_green" then
				material = "wool_dark_green"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:dark_grey" then
				material = "wool_dark_grey"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:green" then
				material = "wool_green"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:grey" then
				material = "wool_grey"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:magenta" then
				material = "wool_magenta"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:orange" then
				material = "wool_orange"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:pink" then
				material = "wool_pink"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:red" then
				material = "wool_red"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:violet" then
				material = "wool_violet"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:yellow" then
				material = "wool_yellow"
				make_ok = "1"
		end
]]

	if make_ok == true then
		local output_item = shape..material
		if not inv:is_empty("res") and resstack:get_name() ~= output_item then
			return
		end

		local success = false
		for i = 0, anzahl-1 do
			local result = inv:add_item("res", output_item)
			if result ~= nil then
				success = true
			end
		end
		if success then
			ingotstack:take_item()
			inv:set_stack("ingot", 1, ingotstack)
		end
	end
end
end

})

--Craft

minetest.register_craft({
	output = 'columnia:machine',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'group:wood', 'default:stone', 'group:wood'},
		{'default:stone', "", 'default:stone'},		
	},
})

