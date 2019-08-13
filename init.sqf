// NO PARAMS ARE PASSED INTO INIT.SQF
private ["_useRevive"];
private ["_volume", "_dynamicWeather", "_isJipPlayer"];
private ["_showIntro", "_showPlayerMapAndCompass", "_fog", "_playerIsImmortal", "_playersEnteredWorld"];
_player = player;

diag_log format["init run for %1", name _player];

_isJipPlayer = false;
if (!isServer && isNull player) then
{
    _isJipPlayer = true;
};

if (!hasInterface && !isDedicated) then {
    headlessClients = [];
    headlessClients set [(count headlessClients), player];
    publicVariable "headlessClients";
    headlessClientsOwners = [];
    headlessClientsOwners set [(count headlessClientsOwners), clientOwner];
    publicVariable "headlessClientsOwners";
};

//call compile preprocessFileLineNumbers "config.sqf"; // FIXME

//enableSaving [true, true];
enableSaving [ false, false ]; // Saving disabled without autosave.

setTerrainGrid ( ("Param_Grass" call BIS_fnc_getParamValue)*3.125 );
setViewDistance ("Param_ViewDistance" call BIS_fnc_getParamValue);
setObjectViewDistance [("Param_ObjectViewDistance" call BIS_fnc_getParamValue),("Param_ShadowViewDistance" call BIS_fnc_getParamValue)];
setDetailMapBlendPars [("Param_DetailBlend" call BIS_fnc_getParamValue),("Param_DetailBlend" call BIS_fnc_getParamValue)*2.0];

// blacklist for Alive
call compile preprocessFile "staticData.sqf";

task0Done = false;
task1Done = false;
task2Done = false;

