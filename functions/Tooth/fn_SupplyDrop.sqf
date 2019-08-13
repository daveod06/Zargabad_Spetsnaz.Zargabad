params ["_plane"];

_arsenalCrateType = selectRandom ["B_supplyCrate_F"]; // crate type(s)
_arsenalParachuteType = selectRandom ["O_Parachute_02_F"]; // parachute type(s)

_vehName = _plane;
_crew = fullCrew _vehName;
_c130DropPos = getPosATL _vehName;
_arsenalCrate = createVehicle [ _arsenalCrateType, _c130DropPos, [], 0, "CAN_COLLIDE" ]; // create the crate
///////////////////////////////////////////////////////////////////////////////////////
waitUntil {!isNull _arsenalCrate}; // wait until crate actually exists
///////////////////////////////////////////////////////////////////////////////////////
//[(_vehCrew select 0),"Supplies out!"] remoteExec ["sideChat",0,false];
_c130Velocity = velocity _vehName;
//_arsenalCrate setVelocity _c130Velocity;
clearWeaponCargoGlobal _arsenalCrate; // empty crate contents
clearItemCargoGlobal _arsenalCrate; // empty crate contents
clearBackpackCargoGlobal _arsenalCrate; // empty crate contents
clearMagazineCargoGlobal _arsenalCrate; // empty crate contents
_arsenalCrate allowDamage false; // disallow damage to crate
_arsenalCrate disableCollisionWith _vehName;

{
    _man = _x select 0;
    _arsenalCrate disableCollisionWith _man;
} foreach (_crew);

//hint format ["SHOULD HAVE SPAWNED CRATE AT %1, %2 meters from player",(_c130DropPos),(_grenadeObj distance2D _arsenalCrate)];
//diag_log format ["SHOULD HAVE SPAWNED CRATE AT %1, %2 meters from player",(_c130DropPos),(_grenadeObj distance2D _arsenalCrate)];
waitUntil { ((getPosATL _arsenalCrate) select 2) < 100 };
_arsenalChute = createVehicle [ _arsenalParachuteType, [(getPosATL _arsenalCrate select 0),(getPosATL _arsenalCrate select 1), (getPosATL _arsenalCrate select 2)], [], 0, "CAN_COLLIDE" ]; // create the parachute
_arsenalChute allowDamage false; // disallow damage to parachute
_arsenalCrate attachTo [_arsenalChute, [0,0,0]]; // attach the crate to the parachute
///////////////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////////////
waitUntil {getPosATL _arsenalCrate select 2 < 0.2}; // wait until the crate is less than 20cm above terrain level
detach _arsenalChute;
//deleteVehicle _arsenalChute;
deleteVehicle _arsenalCrate;

_arsenalCrateNew = createVehicle [ _arsenalCrateType, (getPosATL _arsenalCrate), [], 0, "NONE" ]; // create the crate
waitUntil {!isNull _arsenalCrateNew}; // wait until crate actually exists
clearWeaponCargoGlobal _arsenalCrateNew; // empty crate contents
clearItemCargoGlobal _arsenalCrateNew; // empty crate contents
clearBackpackCargoGlobal _arsenalCrateNew; // empty crate contents
clearMagazineCargoGlobal _arsenalCrateNew; // empty crate contents
_arsenalCrateNew allowDamage false; // disallow damage to crate
// put weapons in crate
{
  _array = _x;
  _gun = _array select 0;
  _num = _array select 1;
  _arsenalCrateNew addWeaponCargoGlobal [_gun, _num];
} forEach Tooth_arr_AirdropCrateWeapons;
{
  _array = _x;
  _mag = _array select 0;
  _num = _array select 1;
  _arsenalCrateNew addMagazineCargoGlobal  [_mag, _num];
} forEach Tooth_arr_AirdropCrateMags;
{
  _array = _x;
  _item = _array select 0;
  _num = _array select 1;
  _arsenalCrateNew addItemCargoGlobal [_item, _num];
} forEach Tooth_arr_AirdropCrateItems;
{
  _array = _x;
  _pack = _array select 0;
  _num = _array select 1;
  _arsenalCrateNew addBackpackCargoGlobal  [_pack, _num];
} forEach Tooth_arr_AirdropCrateBackpacks;