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










// --------------------------------------  START UP EOS
VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1.0;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units
EOS_USE_FLASHLIGHTS=false;   // Attempts to make spawned units use flashlights
EOS_SUICIDE_CHANCE=0.1;     // Attemps to % of units as suicide bombers 0.0 -1.0
EOS_FLARE_ATTACK_SIGNAL=false; // shoot flare to signal beginning of wave
EOS_TASK_INDEX=0; // set index for EOS tasks
BAS_TASK_INDEX=0; // set index for BAS tasks

_eosZones = ["EOSzone_1","EOSzone_2","EOSzone_3"];
_houseGroups = [3,1,100];
_patrolGroups = [5,2,75];
_lightVehicles = [2,1,50];
_armoredVehicles = [0,100];
_staticWeapons = [0,100];
_helicopters = [0,0];
_faction = 8; // TAK MIDDLE EASTERN MLITIA
_markertype = 1;
_distance = 350;
_side = independent;
_heightlimit = true;
_debug = false;
_cache = false;
_createTask = false;
_settings = [_faction,_markertype,_distance,_side,_heightlimit,_debug,_cache,_createTask];
[_eosZones,_houseGroups,_patrolGroups,_lightVehicles,_armoredVehicles,_staticWeapons,_helicopters,_settings] spawn EOS_fnc_EOSMaster;

_eosZones = ["EOSzone_0"];
_houseGroups = [2,1,100];
_patrolGroups = [3,2,75];
_lightVehicles = [1,1,50];
_armoredVehicles = [0,100];
_staticWeapons = [1,100];
_helicopters = [0,0];
_faction = 8; // TAK MIDDLE EASTERN MLITIA
_markertype = 1;
_distance = 600;
_side = independent;
_heightlimit = false;
_debug = false;
_cache = false;
_createTask = false;
_settings = [_faction,_markertype,_distance,_side,_heightlimit,_debug,_cache,_createTask];
[_eosZones,_houseGroups,_patrolGroups,_lightVehicles,_armoredVehicles,_staticWeapons,_helicopters,_settings] spawn EOS_fnc_EOSMaster;

_basZones = ["BASzone_0"];
_spreadAngle = 60.0;
_spawnDistance = 400.0;
_spawnZones = ["BASspawn_0",_spreadAngle,_spawnDistance];
_patrolGroups = [1,3,100];
_lightVehicles = [2,1,60];
_armoredVehicles = [0,50];
_helicopters = [0,0];
_faction = 8;
_markertype = 1;
_side = independent;
_heightlimit = true;
_debug = false;
_settings = [_faction,_markertype,_side,_heightlimit,_debug]; // [FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG]
_intitialPause = 1*60;
_numWaves = 2;
_waveDelay = 4*60;
_integrateEOS = false;
_showHints = false;
_createTask = false;
_waveParams = [_intitialPause,_numWaves,_waveDelay,_integrateEOS,_showHints,_createTask]; // [INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]
[_basZones,_spawnZones,_patrolGroups,_lightVehicles,_armoredVehicles,_helicopters,_settings,_waveParams] spawn EOS_fnc_BASMaster;




// --------------------------------------  START UP CIVILIANS
_faction = 0;
_civSide = civilian;
_civMinSkill = 0.2;
_civMaxSkill = 0.4;
_civMaxWaitTime = 300.0;
_civRunChance = 0.01;
_civInstanceNo = 0;
_unitsPerBuilding = 0.2;
_max_groups_count = 50;
_min_spawn_distance = 50;
_max_spawn_distance = 500;
_blacklist_markers = ["civ_blacklist_0","civ_blacklist_1","civ_blacklist_2"];
_hide_blacklist_markers = true;
_on_unit_spawned_callback = {};
_on_unit_remove_callback = {true};
_debug = false;
[_faction,_unitsPerBuilding,_max_groups_count,_min_spawn_distance,_max_spawn_distance,_blacklist_markers,_hide_blacklist_markers,_on_unit_spawned_callback,_on_unit_remove_callback,_debug] call DJOCivilians_fnc_CiviliansMaster;




// --------------------------------------  START UP TRAFFIC
_faction = 0;
_side = civilian;
_vehicles_count = 6;
_max_groups_count = 6;
_min_spawn_distance = 600;
_max_spawn_distance = 900;
_min_skill = 0.3;
_max_skill = 0.6;
_area_marker = "civ_traffic_0";
_hide_area_marker = true;
_on_unit_creating = {true};
_on_unit_created = {};
_on_unit_removing = {};
[_faction,_side,_vehicles_count,_max_groups_count,_min_spawn_distance,_max_spawn_distance,_min_skill,_max_skill,_area_marker,_hide_area_marker,_on_unit_creating,_on_unit_created,_on_unit_removing] spawn DJOTraffic_fnc_TrafficMaster;



{
	_x setMarkerAlpha 0.0;
}
forEach ["civ_traffic_0","civ_blacklist_0","civ_blacklist_1","civ_blacklist_2","EOSzone_1","EOSzone_2","EOSzone_3","EOSzone_0","BASspawn_0","BASzone_0"];





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
