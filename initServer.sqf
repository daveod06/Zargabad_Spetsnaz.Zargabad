//if (!isServer or hasInterface) exitWith {};


// set up zeus for 4 players
missionCurators = [];
CuratorLogicGroup = creategroup sideLogic;

// Enable/Disbale animals, flies, and bugs -- false turns them off
enableEnvironment true;

_timeOfDay = ("Param_TimeOfDay" call BIS_fnc_getParamValue);
_hour = _timeOfDay;
switch (_timeOfDay) do {
    case 24: { 
		_hour = round(random(24));
	};
    case 25: {
		_hour = 6+round(random(12));  //Between 0600 and 1800
	};
	case 26: { 
		_hour = 20 + round(random(8)); //Between 2000 and 0400
		_hour = _hour % 24;
	};
    default { _hour = _timeOfDay };
};
setDate [Tooth_year, Tooth_month, Tooth_day, _timeOfDay, 0];

uiSleep 0.2;
setTimeMultiplier ("Param_TimeMultiplier" call BIS_fnc_getParamValue);
if ( ("Param_UseCustomWeather" call BIS_fnc_getParamValue) == 1) then
{
};


[] spawn
{
	{
  		_x addCuratorEditableObjects [allUnits,true];
  		_x addCuratorEditableObjects [vehicles,true];
	} forEach allCurators;
	sleep 30.0;
};


// disable AI respawning
{
	_x addMPEventHandler ["MPRespawn", {
		_unit = _this select 0;
		if (!isPlayer _unit) exitWith
		{
			deleteVehicle _unit
		};
		}
	];
} forEach playableUnits;









/*
// --------------------------------------  START UP EOS
VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1.0;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units
EOS_USE_FLASHLIGHTS=false;   // Attempts to make spawned units use flashlights
EOS_SUICIDE_CHANCE=0.0;     // Attemps to % of units as suicide bombers 0.0 -1.0
EOS_FLARE_ATTACK_SIGNAL=false; // shoot flare to signal beginning of wave
EOS_TASK_INDEX=0; // set index for EOS tasks
BAS_TASK_INDEX=0; // set index for BAS tasks

_eosZones = ["south_base"];
_houseGroups = [4,2,100];
_patrolGroups = [5,2,75];
_lightVehicles = [2,1,75];
_armoredVehicles = [1,50];
_staticWeapons = [2,50];
_helicopters = [0,0];
_faction = 12; // TKA
_markertype = 1;
_distance = 1000;
_side = east;
_heightlimit = true;
_debug = false;
_cache = false;
_createTask = false;
_settings = [_faction,_markertype,_distance,_side,_heightlimit,_debug,_cache,_createTask];
[_eosZones,_houseGroups,_patrolGroups,_lightVehicles,_armoredVehicles,_staticWeapons,_helicopters,_settings] spawn EOS_fnc_EOSMaster;

_eosZones = ["garmsar_base"];
_houseGroups = [2,2,100];
_patrolGroups = [2,3,75];
_lightVehicles = [2,1,75];
_armoredVehicles = [1,50];
_staticWeapons = [1,50];
_helicopters = [0,0];
_faction = 12; // TKA
_markertype = 1;
_distance = 800;
_side = east;
_heightlimit = true;
_debug = false;
_cache = false;
_createTask = false;
_settings = [_faction,_markertype,_distance,_side,_heightlimit,_debug,_cache,_createTask];
[_eosZones,_houseGroups,_patrolGroups,_lightVehicles,_armoredVehicles,_staticWeapons,_helicopters,_settings] spawn EOS_fnc_EOSMaster;

_eosZones = ["spetsnaz_camp_0","spetsnaz_camp_1","spetsnaz_camp_2"];
_houseGroups = [1,1,80];
_patrolGroups = [3,2,75];
_lightVehicles = [0,0,0];
_armoredVehicles = [0,0];
_staticWeapons = [0,0];
_helicopters = [0,0];
_faction = 7; // OKSVA
_markertype = 2;
_distance = 800;
_side = east;
_heightlimit = true;
_debug = false;
_cache = false;
_createTask = false;
_settings = [_faction,_markertype,_distance,_side,_heightlimit,_debug,_cache,_createTask];
[_eosZones,_houseGroups,_patrolGroups,_lightVehicles,_armoredVehicles,_staticWeapons,_helicopters,_settings] spawn EOS_fnc_EOSMaster;

_eosZones = ["naran_darre_pass_south","naran_darre_pass_north"];
_houseGroups = [1,1,100];
_patrolGroups = [1,2,100];
_lightVehicles = [0,0,0];
_armoredVehicles = [0,0];
_staticWeapons = [2,100];
_helicopters = [0,0];
_faction = 8; // MIDDLE EASTERN MILITIA
_markertype = 1;
_distance = 1000;
_side = independent;
_heightlimit = true;
_debug = false;
_cache = false;
_createTask = false;
_settings = [_faction,_markertype,_distance,_side,_heightlimit,_debug,_cache,_createTask];
[_eosZones,_houseGroups,_patrolGroups,_lightVehicles,_armoredVehicles,_staticWeapons,_helicopters,_settings] spawn EOS_fnc_EOSMaster;




// --------------------------------------  START UP CIVILIANS
_faction = 0;
_civSide = civilian;
_civMinSkill = 0.3;
_civMaxSkill = 0.5;
_civMaxWaitTime = 300.0;
_civRunChance = 0.01;
_civInstanceNo = 0;
_unitsPerBuilding = 0.1;
_max_groups_count = 50;
_min_spawn_distance = 50;
_max_spawn_distance = 500;
_blacklist_markers = ["naran_darre_pass_south","naran_darre_pass_north","mujahideen_camp","north_base","spetsnaz_camp_0","spetsnaz_camp_1","spetsnaz_camp_2","south_base","garmsar_base","feruz_abad_base","jilavur_base"];
_hide_blacklist_markers = true;
_on_unit_spawned_callback = {};
_on_unit_remove_callback = {true};
_debug = false;
//[_faction,_unitsPerBuilding,_max_groups_count,_min_spawn_distance,_max_spawn_distance,_blacklist_markers,_hide_blacklist_markers,_on_unit_spawned_callback,_on_unit_remove_callback,_debug] call DJOCivilians_fnc_CiviliansMaster;




// --------------------------------------  START UP TRAFFIC
_faction = 0;
_side = civilian;
_vehicles_count = 6;
_max_groups_count = 6;
_min_spawn_distance = 600;
_max_spawn_distance = 900;
_min_skill = 0.3;
_max_skill = 0.6;
_area_marker = "taor_0";
_hide_area_marker = true;
_on_unit_creating = {true};
_on_unit_created = {};
_on_unit_removing = {};
//[_faction,_side,_vehicles_count,_max_groups_count,_min_spawn_distance,_max_spawn_distance,_min_skill,_max_skill,_area_marker,_hide_area_marker,_on_unit_creating,_on_unit_created,_on_unit_removing] spawn DJOTraffic_fnc_TrafficMaster;



// --------------------------------------  START UP CONVOYS
_btr_convoy = [
"OKSVA_BRDM2",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_BTR60PB",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];
_bmp_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMP1K",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_BMP1",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_R142",
"OKSVA_BRDM2UM_Armed"
];
_truck_convoy = [
"OKSVA_UAZ_Open",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66",
"OKSVA_GAZ66_Ammo"
];
_bmd_convoy = [
"OKSVA_BRDM2",
"OKSVA_BMD1K",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_BMD1",
"OKSVA_GAZ66_Ammo",
"OKSVA_BRDM2UM_Armed"
];
_tank_convoy = [
"OKSVA_BRDM2",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_T72B_1984",
"OKSVA_Ural_Fuel",
"OKSVA_GAZ66_Repair",
"OKSVA_BRDM2UM_Armed"
];
_armed_supply_convoy = [
"OKSVA_BRDM2",
"OKSVA_GAZ66_ZU23",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_BRDM2"
];
_unarmed_supply_convoy = [
"OKSVA_UAZ",
"OKSVA_GAZ66",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel",
"OKSVA_GAZ66"
];
_small_supply_convoy = [
"OKSVA_UAZ",
"OKSVA_GAZ66_Ammo",
"OKSVA_GAZ66_Ammo",
"OKSVA_Ural_Fuel",
"OKSVA_Ural_Fuel"
];
_possible_convoys=[_btr_convoy,_truck_convoy,_armed_supply_convoy,_unarmed_supply_convoy,_small_supply_convoy];
_convoy_route = ["convoy_route_0","convoy_route_1","convoy_route_2","convoy_route_3"];
_convoy_spawn_points = ["convoy_pos_0","convoy_pos_1","convoy_pos_2","convoy_pos_3","convoy_pos_4","convoy_pos_5","convoy_pos_6","convoy_pos_7","convoy_pos_8"];
_convoy_side = east;
_enemy_side = resistance;
_pos_name_prefix = "convoy_pos_";
_convoy_type = selectRandom _possible_convoys;
_speed_kph = 65;
_threat_radius_m = 300;
_speed_str = "FULL";
_behavior = "CARELESS";
_numConvoys = 5;
_waitTime = 60*20;
//[_convoy_route,_convoy_spawn_points,_convoy_side,_enemy_side,_pos_name_prefix,_convoy_type,_speed_kph,_threat_radius_m,_speed_str,_behavior,_numConvoys,_waitTime] call DJOAiConvoys_fnc_ConvoyMaster;



// --------------------------------------  START UP ARTILLERY
RydFFE_NoControl = []; // ["camp_carrol_mortar","uns_M1_81mm_mortar","camp_carrol_howitzer","uns_m107sp"]; // each arty group (battery) held inside this array will be excluded from FAW control
RydFFE_ArtyShells = 300; // positive integer. Multiplier of default magazines loadout per kind per each artillery piece
RydFFE_Interval = 20; // time gap (in seconds) between each “seek for targets cycle (each cycle each idle battery on map looks for new fire mission opportunity)
RydFFE_Debug = true; // if set as true, will be shown map markers that allows user to watch, what is going on. See DEBUG MARKERS chapter for details;
RydFFE_ShellView = true;
RydFFE_FOClass = [
"OKSVA_Spotter_MSV",
"OKSVA_Senior_Technician_MSV",
"OKSVA_Senior_Officer_MSV",
"OKSVA_Officer_MSV",
"OKSVA_Junior_Officer_MSV",
"OKSVA_Officer_VDV",
"B_Soldier_Universal_F"
]; // if this array is set as not empty (even with objNull), limited spotting modebecomes active, so only members of groups, which names are inside this array or whichleaders are of proper class (see below), will have ability of spotting targets for batteries.
RydFFE_Amount = 5; // this holds number of shells, that in summary should be fired in each fire mission. CLUSTER and GUIDED salvo amount is always divided by 3 (rounded up);
RydFFE_Acc = 3; // multiplier of whole salvo drift radius. The bigger value, the bigger radius;
RydFFE_Safe = 200; // salvo will be not planned for coordinates located within this radius (in meters) around any allied group leader;
RydFFE_Monogamy = false; // by default each enemy group can be a target for only one battery at the time. If set to false, there is no such limitation, so one target can be shelled by any number of batteries at the time;
RydFFE_Add_SPMortar = []; // here you can list classnames of custom SP mortar units, that should be controlled by ;
RydFFE_Add_Mortar = ["OKSVA_2B14"]; // here you can list classnames of custom mortar units, that should be controlled by ;
RydFFE_Add_Rocket = ["OKSVA_BM21"]; // here you can list classnames of custom rocket artillery units, that should be controlled by ;
RydFFE_Add_Other = []; // here you can list classnames of other custom artillery units (lowercase only!), that should be controlled by , if are using custom magazines (classes added here shouldn't be added to any other array). Format:
//RydFFE_Add_Other =
//[
//[["gun_classname_1","gun_classname_2"],["ammo_classname_1","ammo_classname_2"]],
//[["gun_classname_3"],["ammo_classname_3","ammo_classname_4"]]
//];
[] spawn DJOAiArtillery_fnc_FFE_ArtilleryMaster;


{
	_x setMarkerAlpha 0.0;
}
forEach ["naran_darre_pass_south","naran_darre_pass_north","mujahideen_camp","north_base","spetsnaz_camp_0","spetsnaz_camp_1","spetsnaz_camp_2","south_base","garmsar_base","feruz_abad_base","jilavur_base"];

*/









	_skillset = [
		0.13,        // aimingAccuracy
		0.13,        // aimingShake
		0.23,        // aimingSpeed
		0.5,         // spotDistance
		0.5,        // spotTime
		1.0,        // courage
		0.5,        // reloadSpeed
		0.8,        // commanding
		0.8        // general
		];

	{
		//_x addEventHandler ["HandleDamage", ATR_FNC_ReduceDamage];

		_unit = _x;
		{
			_skillvalue = (_skillset select _forEachIndex);
			_unit setSkill [_x,_skillvalue];
		} forEach ["aimingAccuracy","aimingShake","aimingSpeed","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
		_unit setUnitTrait ["camouflageCoef ", 0.6];
		_unit setUnitTrait ["audibleCoef", 0.6];
	} forEach units playerGroup;

	playerGroup enableGunLights "ForceOff";

	[] spawn
	{
		sleep 60*20;
		{
			_unit = _x;
			if (!isPlayer _unit) then
			{
				_primaryWeapon = primaryWeapon _unit;
				_magazineClass = "";

				if (_primaryWeapon != "") then
				{
					_magazines = getArray (configFile / "CfgWeapons" / _primaryWeapon / "magazines");
					if (count _magazines > 0) then
					{
						_magazineClass = _magazines select 0;
					}
					else
					{
						_magazineClass = "";
					};
					if (_magazineClass != "") then
					{
						_unit addMagazines [_magazineClass, 15];
					};
				};

				_unit addMagazines ["rhs_mag_rgd5", 1];
				_unit enableGunLights "ForceOff";
			};
		} forEach (units playerGroup);
	};


	_Param_EnemySkill = ("Param_EnemySkill" call BIS_fnc_getParamValue);

	_aiSkillBase = 0.11;

	switch (_Param_EnemySkill) do
	{
	    case 0: //conscript very low skill
	    {
	        _aiSkillBase = 0.1;
	    };
	    case 1: //rebels low skill
	    {
	        _aiSkillBase = 0.15;
	    };
	    case 2: //regular fair skill
	    {
	        _aiSkillBase = 0.2;
	    };
	    case 3: //elite soldiers medium skill
	    {
	        _aiSkillBase = 0.3;
	    };
	    case 4: // specops good skill
	    {
	        _aiSkillBase = 0.4;
	    };
	    default
	    { 
	        _aiSkillBase = 0.1;
	    };
	};

	_skill = _aiSkillBase;

	_InfSkillSet=
	[
	0.4 * _skill,        // aimingAccuracy
	0.4 * _skill,        // aimingShake
	0.4 * _skill,        // aimingSpeed
	0.4 * _skill,         // spotDistance
	1.0 * _skill,        // spotTime
	2.0 * _skill,        // courage
	2.5 * _skill,        // reloadSpeed
	2.0 * _skill,        // commanding
	0.8 * _skill        // general
	];

	{
		_unit = _x;
		if (side _unit isEqualTo INDEPENDENT) then
		{
			{
				_skillvalue = (_InfSkillSet select _forEachIndex);
				_unit setSkill [_x,_skillvalue];
			} forEach ["aimingAccuracy","aimingShake","aimingSpeed","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
		};
	} forEach allUnits;








sleep 1.0;
missionNameSpace setvariable["A3E_ServerInitialized",true,true];
