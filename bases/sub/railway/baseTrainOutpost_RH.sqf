/*
	fn_objectsGrabber for EDEN editor by soulkobk.
	revision: 20171123

	mission: baseTrainOutpost_RH
	world: VR
	center position: [0,0,0]
	radius: 100

	array list: [objectClass, objectPosition, objectDirection, objectSimulation, objectSimpleObject, objectPitchBank, objectDamage, objectAllowDamage, objectVarName, objectInit]

	to set object as task object, place in init of object = this setVariable ['taskObject',true];
	to damage/disable/lock vehicle (true to lock), place in init of object = [this,true] call RELO_fnc_vehicleDisable;
	to do a random crate loadout, place in init of object = [this] call RELO_fnc_randomContainerLoadout;

	make sure as many objects as possible have simulation turned off, or simple object enabled!
*/

[
	["Box_CSAT_Equip_F",[-2.75,8.375,0],90,true,false,[0,-0],0,true,"","[this] call RELO_fnc_randomContainerLoadout;"],
	["Box_CSAT_Equip_F",[-2.3596,-5.56981,0],0,true,false,[0,0],0,true,"","[this] call RELO_fnc_randomContainerLoadout;"],
	["Box_CSAT_Equip_F",[4.00073,0.25,0.0597243],180,true,false,[0,-0],0,true,"","[this] call RELO_fnc_randomContainerLoadout;"],
	["Land_BagBunker_01_small_green_F",[-3.125,-10.875,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagBunker_01_small_green_F",[-3.625,11.25,0],181,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_corner_green_F",[3.125,10.5,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[2.875,5.5,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[3.75,1.5,3.625],8.00001,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[-5.125,10.625,0.75],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[5.125,0.125,3.625],88,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[3.875,-1.125,3.625],346,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[2.875,5.5,0.625],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[-5,0,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[5.125,0.125,3],88,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[5.125,0.125,2.625],88,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[3.75,1.625,2.625],8.00001,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[3.875,-1.125,3],346,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[3.875,-1.125,2.75],346,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_end_green_F",[3.75,1.5,3],8.00001,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,2.875,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.625,3.5,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,-2.5,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.625,3.5,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-4.25,2.25,0],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-4.375,-0.625,0.625],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-4.25,2.25,0.625],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-4.375,-0.625,0],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,5.625,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-5,5.375,0.625],2,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.625,9.375,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,-3.625,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.60035,-0.624125,0],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,8.625,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.5,5.125,0.625],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.43302,-10.75,0],269,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.53337,-5.00088,0.625],269,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,4,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,8.625,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.5,-5.375,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,-8,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.5,-5.375,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-4.875,-7.125,0],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-4.75,-7.125,0.625],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.5,-8.375,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.45266,-9.62517,0.625],269,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.5,-8.25,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,-10.75,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.52901,-5.25084,0],269,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-5,5.375,0],2,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,-8.25,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-3.375,7.5,0.625],2,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-3.375,7.5,0],2,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.50436,4.87504,0],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.48102,-8.00042,0],269,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[3.5,-5.25,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.45637,7.62462,0],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.625,9.375,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.58072,0.500704,0.625],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.625,6.5,0],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-1.625,6.5,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.55236,2.12546,0],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_long_green_F",[-6.57701,-2.50126,0],269,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_round_green_F",[4.75,-0.625,0],309,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_round_green_F",[4.625,0.875,2],231,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_round_green_F",[4.625,-0.5,2],309,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_round_green_F",[4.75,1.125,0],231,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[-6.58573,-2.00133,0.625],269,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[2.375,10.75,0.625],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[-6.44764,8.12454,0.625],271,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[1.82843,0.572131,2.02835],92,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[2.375,10.75,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[2.875,1.625,2.00001],0,false,false,[0.399092,-0.102795],0,false,"",""],
	["Land_BagFence_01_short_green_F",[-2.375,10.75,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[-2.125,-7,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[-2,1.5,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[1.875,0.625,3.5],92,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[3.5,-11.25,0.625],90,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[1.875,0.625,2.875],92,false,false,[0,-0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[2.5,-12.125,0],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[2.5,-12.125,0.625],0,false,false,[0,0],0,false,"",""],
	["Land_BagFence_01_short_green_F",[2.875,-8.5,0],0,false,false,[0,0],0,false,"",""],
	["Land_Cargo_Patrol_V1_F",[-1.625,-0.375,4.76837e-007],270,true,false,[0,0],0,true,"",""],
	["Land_LampShabby_F",[-2.25,-7.875,0],180.001,true,false,[0,0],0,true,"",""],
	["Land_LampShabby_F",[2.875,6.375,0],0,true,false,[0,0],0,true,"",""],
	["Land_Locomotive_01_v3_F",[0,5.5,0.25],0,true,false,[0,0],0,true,"","this setVariable ['taskObject',true];"],
	["Land_Plank_01_4m_F",[3.25,0.5,1.875],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[3.125,1.25,1.875],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[3.5,0.75,4.25],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[3.375,-0.25,1.875],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[3.375,-1.375,4.25],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[3.5,1.5,4.25],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[1.75,-2.875,1.00328],191.566,false,false,[-30.3653,-0.961414],0,false,"",""],
	["Land_Plank_01_4m_F",[3.75,0,4.25],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[3,-1,1.875],90,false,false,[0,-0],0,false,"",""],
	["Land_Plank_01_4m_F",[3.75,-0.75,4.25],90,false,false,[0,-0],0,false,"",""],
	["Land_PowerPoleWooden_small_F",[1.5,1.375,0.907077],0,false,false,[0,180],0,false,"",""],
	["Land_PowerPoleWooden_small_F",[5.125,0,0.907077],0,false,false,[0,180],0,false,"",""],
	["Land_PowerPoleWooden_small_F",[3.5,-1.125,0.907077],0,false,false,[0,180],0,false,"",""],
	["Land_PowerPoleWooden_small_F",[1.5,-1,2.78208],0,false,false,[0,180],0,false,"",""],
	["Land_PowerPoleWooden_small_F",[3.5,1.5,0.907077],0,false,false,[0,180],0,false,"",""],
	["Land_RailwayCar_01_tank_F",[0,2.08005e-007,0.375],0,true,false,[0,0],0,true,"","this setVariable ['taskObject',true];"],
	["Land_RailwayCar_01_tank_F",[0.015,-5.7,0.375],0,true,false,[0,0],0,true,"","this setVariable ['taskObject',true];"],
	["O_HMG_01_high_F",[3.25,-0.125,2.125],92,true,false,[0,-0],0,true,"",""],
	["O_HMG_01_high_F",[-4.125,12.125,0],0,true,false,[0,0],0,true,"",""],
	["O_HMG_01_high_F",[-2.875,-11.5,0],178,true,false,[0,-0],0,true,"",""]
]
