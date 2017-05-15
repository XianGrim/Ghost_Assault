_paramDaytimeHour = "paramDaytimeHour" call BIS_fnc_getParamValue;
if (_paramDaytimeHour == 0) then {
setDate [2024, 3, 1, (round(random 24)), (round(random 55))];//(round(random 1440))
} else {
setDate [2024, 3, 1, _paramDaytimeHour, 0];
};

//set respawntent
missionnamespace setVariable ["ghst_respawntent_data", [], true];

//Set weather
_randnum = round (random 100);
_PARAM_Fog = "PARAM_Fog" call BIS_fnc_getParamValue;
if (_PARAM_Fog == 1) then {
	[_randnum * 0.01, 0.125, 2] call BIS_fnc_setFog;
} else {
	[_PARAM_Fog * 0.01, 0.125, 2] call BIS_fnc_setFog;
};
_PARAM_Overcast = "PARAM_Overcast" call BIS_fnc_getParamValue;
if (_PARAM_Overcast == 1) then {
	[_randnum * 0.01] call bis_fnc_setOvercast;
} else {
	[_PARAM_Overcast * 0.01] call bis_fnc_setOvercast;
};

//call ghst_fnc_acquirelocations;
//[] spawn ghst_fnc_randweather;
private ["_patrolcartype"];
//RHS Escalation Detect
_PARAM_RHS = "PARAM_RHS" call BIS_fnc_getParamValue;
if ((isClass(configFile >> "CfgPatches" >> "rhs_main")) and (_PARAM_RHS == 1)) then {
	ghst_rhsmod = true;
	_patrolcartype = "rhsusf_m1025_d_m2";
} else {
	ghst_rhsmod = false;
	_patrolcartype = "B_MRAP_01_hmg_F";
};

//spawn patrolcar
_pos = getposatl patrol_car1;
_dir = getdir patrol_car1;
_patrolcar1_array = [_pos, _dir, _patrolcartype, WEST] call BIS_fnc_spawnVehicle;
_patrol_car1 = _patrolcar1_array select 0;
_wGrp = _patrolcar1_array select 2;
_patrol_car1 allowdamage false;
_wGrp copyWaypoints group patrol_car1;
deletevehicle patrol_car1;

//Enemy Unit list
call ghst_fnc_unitlist;

[["AA1","AA2","AA3","AA4"],ghst_friendlybase_def,false,WEST] spawn ghst_fnc_basedef;

[getposatl ghst_artillery,ghst_friendlybase_arty,50,[0,-15,+15],false,WEST] spawn ghst_fnc_basearty;
ghst_mapsize = getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize") / 2;
[(getmarkerpos "eairspawn"),(getmarkerpos "center"),[ghst_mapsize,ghst_mapsize],600,3,[true,15],[false,"ColorRed"]] spawn ghst_fnc_eair;

_PARAM_AISkill = "PARAM_AISkill" call BIS_fnc_getParamValue;
[[(getmarkerpos "Respawn_West"),1000],[600,600],(4 + round(random 2)),[false,"ColorRed"],(_PARAM_AISkill/10)] spawn ghst_fnc_randespawn;

//Spawn Base helicopters
if (true) then {
private ["_helolist","_markarray","_namearray","_air","_marksel","_VarName"];
if ghst_rhsmod then {_helolist = ["rhsusf_CH53E_USMC","RHS_UH60M"];} else {_helolist = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_camo_F"];};
_markarray = ["heli_1spawn","heli_2spawn"];
_namearray = ["heli_1","heli_2"];
	{
	_VarName = _namearray select 0;
	_namearray = _namearray - [_VarName];
	_marksel = _markarray select 0;
	_markarray = _markarray - [_marksel];
	_air = createVehicle [_x,(getmarkerpos _marksel), [], 0, "NONE"];
	_air setVehicleVarName _VarName;
	missionNamespace setVariable [_VarName,_air];
	publicVariable _VarName;
	_air setdir (markerdir _marksel);
	_data = [missionNamespace,_air] call BIS_fnc_addRespawnPosition;
	nul = [_air,5,false] execfsm "scripts\ghst_vehrespawn.fsm";
	} foreach _helolist;
};

//Spawn F16C ReArm
_PARAM_FA16C = "PARAM_FA16C" call BIS_fnc_getParamValue;
if (_PARAM_FA16C == 1) then {
private ["_markarray","_namearray","_baseplate","_marksel","_VarName"];
_markarray = ["fir_bp1","fir_bp2"];
_namearray = ["f16rearm_1","f16rearm_2"];
    {
    _VarName = _namearray select 0;
    _namearray = _namearray - [_VarName];
    _marksel = _markarray select 0;
    _markarray = _markarray - [_marksel];
    _baseplate = createVehicle [_x,(getmarkerpos _marksel), [], 0, "NONE"];
    _baseplate setVehicleVarName _VarName;
    _baseplate setdir (markerdir _marksel) -180;
   _baseplate allowdamage false
    } foreach ["FIR_Baseplate","FIR_Baseplate"];
};
//#include "servermodules.sqf"

["Initialize", [true]] call BIS_fnc_dynamicGroups;
["RegisterGroup", [group (playableunits select 0),leader group (playableunits select 0),["insignia_GL", "Phoenix Squad", false]]] call BIS_fnc_dynamicGroups;

//call ghst_fnc_randomobj;	