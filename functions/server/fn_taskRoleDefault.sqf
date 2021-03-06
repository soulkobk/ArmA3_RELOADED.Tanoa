/*
	----------------------------------------------------------------------------------------------
	
	Copyright © 2017 soulkobk (soulkobk.blogspot.com)

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.

	----------------------------------------------------------------------------------------------
	
	Name: fn_taskRoleDefault.sqf
	Version: 1.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 12:00 PM 12/06/2017
	Modification Date: 12:00 PM 12/06/2017
	
	Description:

	Parameter(s): none

	Example: none
	
	Change Log:
	1.0 - original base script.
	
	----------------------------------------------------------------------------------------------
*/

///////////////////////////////////////////////////////////////////////////////////////////////////
if !(isServer) exitWith {};
///////////////////////////////////////////////////////////////////////////////////////////////////

_taskRole = "Secure"; // default option for 'sack'

///////////////////////////////////////////////////////////////////////////////////////////////////
#include "..\..\debug.hpp"
#ifdef RELO_DEBUG
	#define __DEBUG__
#endif
///////////////////////////////////////////////////////////////////////////////////////////////////
params ["_taskLocation","_taskAreaBase","_taskTitle","_taskMkr","_taskUnits","_taskGroups","_taskDefinition"];
///////////////////////////////////////////////////////////////////////////////////////////////
_locationMkrCurr = RELO_var_locationMkrCurr;
///////////////////////////////////////////////////////////////////////////////////////////////////
sleep 10;
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskObject = createVehicle ["Land_Sack_F", _taskLocation, [], 0, "CAN_COLLIDE"];
_taskObjectPos = [_taskLocation, 1, 10, 0.5, 1, 10, 0] call BIS_fnc_findSafePos;
_taskObject setPos _taskObjectPos;
_taskObject setVariable ["taskIsSecure",false,true];
///////////////////////////////////////////////////////////////////////////////////////////////////
_scriptName = format ["RELO_fnc_taskRole%1: %2 task for object %3 (%4)",_taskRole,_taskTitle,_taskObject,typeOf _taskObject];
scriptName _scriptName;
///////////////////////////////////////////////////////////////////////////////////////////////////
if (surfaceIsWater _taskObjectPos) then
{
	_taskObjectPos = getPosATL _taskObject;
	_taskObjectPosNew = _taskObjectPos;
	_taskObjectPosIntersect = +_taskObjectPosNew;
	_taskObjectPosIntersect set [2, 100];
	while {(lineIntersects [ATLToASL _taskObjectPosIntersect,ATLToASL _taskObjectPosNew])} do
	{
		_taskObjectPosNew set [2, ((_taskObjectPosNew select 2) + 0.25)];
	};
	_taskObjectPos = ATLToASL _taskObjectPosNew;
	_taskObject setPosASL _taskObjectPos;
};
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskObjectType = typeOf _taskObject;
_taskObjectDisplayName = "unknown";
_cfgArray = "";
{
	_cfg = _x select 0;
	_cfgText = _x select 1;
	_cfgArray = "(getText (_x >> _cfgText) isEqualTo _taskObjectType)" configClasses (configFile >> _cfg);
	if !(_cfgArray isEqualTo "") exitWith
	{
		_taskObjectDisplayName = getText (configFile >> _cfg >> _taskObjectType >> "displayName");
	};
} forEach [["cfgVehicles","_generalMacro"],["cfgWeapons","_generalMacro"],["cfgMagazines","ammo"]];
///////////////////////////////////////////////////////////////////////////////////////////////////
sleep 10;
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskTitle call BIS_fnc_taskDescription params ["_taskDescriptionCurr","_taskTitleCurr","_taskMkrCurr"];
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskDescriptionUpdate = "";
if (_taskObjectDisplayName isEqualTo "unknown") then
{
	_taskDescriptionUpdate = format ["%1 (looks like there is no hint on how to secure... you're on your own soldiers!)",_taskDescriptionCurr select 0];
}
else
{
	_taskDescriptionUpdate = format ["%1 (psst!.. you will need to %2 the object '%3' to secure the task)",_taskDescriptionCurr select 0,toLower _taskRole,_taskObjectDisplayName];
};
///////////////////////////////////////////////////////////////////////////////////////////////////
[_taskTitle,[_taskDescriptionUpdate,_taskTitleCurr,_taskMkrCurr]] call BIS_fnc_taskSetDescription;
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskObjectSecureAction = [_taskObject, ["Secure Task", {player playAction 'PutDown'; (_this select 0) setVariable ["taskIsSecure",true,true];},nil,1.5,true,true,"","!(_target getVariable ['taskIsSecure',false])",3,false,""]] remoteExec ["addAction",0,_taskObject];
///////////////////////////////////////////////////////////////////////////////////////////////////
sleep 10;
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskCreated = [_taskTitle,"CREATED",false] spawn BIS_fnc_taskSetState;
///////////////////////////////////////////////////////////////////////////////////////////////////
waitUntil {sleep 1; (_taskObject getVariable ["taskIsSecure",false]) || !(alive _taskObject) || !(_locationMkrCurr isEqualTo RELO_var_locationMkrCurr)};
///////////////////////////////////////////////////////////////////////////////////////////////////
deleteVehicle _taskObject; // delete the potato sack!
///////////////////////////////////////////////////////////////////////////////////////////////////
if !(_locationMkrCurr isEqualTo RELO_var_locationMkrCurr) exitWith {}; // if current AO is over/finished, exit
///////////////////////////////////////////////////////////////////////////////////////////////////
_locationSize = selectMax (markerSize RELO_var_locationMkrCurr);
_taskSize = selectMax (markerSize _taskMkr);
_taskSizeHalf = (_taskSize / 2);
///////////////////////////////////////////////////////////////////////////////////////////////////
if (alive _taskObject) then
{
	_taskSuccess = [_taskTitle,"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	RELO_var_locationTasksActive = RELO_var_locationTasksActive - [_taskTitle];
	RELO_var_locationTasksFinished pushBack _taskTitle;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	RELO_var_locationNATOProgress = RELO_var_locationNATOProgress + 5;
	RELO_var_locationCSATProgress = RELO_var_locationCSATProgress - 5;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	_taskMkr setMarkerPos _taskLocation;
	_taskMkr setMarkerColor "colorBlue";
	_taskMkr setMarkerSize [_taskSizeHalf,_taskSizeHalf];
	_taskMkr setMarkerAlpha 1;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	_taskMkrComplete = createMarker [format ["RELO_task_completedTask_%1_%2",_taskTitle,_taskLocation],_taskLocation];
	_taskMkrComplete setMarkerShape "ICON";
	_taskMkrComplete setMarkerType "waypoint";
	// _taskMkrComplete setMarkerText _taskTitle;
	_taskMkrComplete setMarkerSize [0.5,0.5];
	// _taskMkrComplete setMarkerSize [1,1];
	_taskMkrComplete setMarkerColor "colorBlue";
	_taskMkrComplete setMarkerAlpha 1;
	RELO_var_locationMkrsTask pushBack _taskMkrComplete;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	_taskTitle call BIS_fnc_taskDescription params ["_taskDescriptionCurr","_taskTitleCurr","_taskMkrCurr"];
	_taskDescriptionUpdate = format ["%1 SUCCESS! Well done soldiers!",_taskDescriptionCurr select 0];
	[_taskTitle,[_taskDescriptionUpdate,_taskTitleCurr,_taskMkrCurr]] call BIS_fnc_taskSetDescription;
}
else
{
	_taskFailed = [_taskTitle, "FAILED",true] spawn BIS_fnc_taskSetState;
	RELO_var_locationTasksActive = RELO_var_locationTasksActive - [_taskTitle];
	RELO_var_locationTasksFinished pushBack _taskTitle;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	RELO_var_locationNATOProgress = RELO_var_locationNATOProgress - 5;
	RELO_var_locationCSATProgress = RELO_var_locationCSATProgress + 5;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	_taskMkr setMarkerPos _taskLocation;
	_taskMkr setMarkerColor "colorBlack";
	_taskMkr setMarkerSize [_taskSizeHalf,_taskSizeHalf];
	_taskMkr setMarkerAlpha 1;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	_taskMkrComplete = createMarker [format ["RELO_task_failedTask%1_%2",_taskTitle,_taskLocation],_taskLocation];
	_taskMkrComplete setMarkerShape "ICON";
	_taskMkrComplete setMarkerType "waypoint";
	// _taskMkrComplete setMarkerText _taskTitle;
	_taskMkrComplete setMarkerSize [0.5,0.5];
	// _taskMkrComplete setMarkerSize [1,1];
	_taskMkrComplete setMarkerColor "colorBlack";
	_taskMkrComplete setMarkerAlpha 1;
	RELO_var_locationMkrsTask pushBack _taskMkrComplete;
	///////////////////////////////////////////////////////////////////////////////////////////////////
	_taskTitle call BIS_fnc_taskDescription params ["_taskDescriptionCurr","_taskTitleCurr","_taskMkrCurr"];
	_taskDescriptionUpdate = format ["%1 FAILED? What happened soldiers?",_taskDescriptionCurr select 0];
	[_taskTitle,[_taskDescriptionUpdate,_taskTitleCurr,_taskMkrCurr]] call BIS_fnc_taskSetDescription;
};
///////////////////////////////////////////////////////////////////////////////////////////////////
waitUntil {sleep 1; ((_taskTitle in RELO_var_locationTasksFinished) && !(_taskTitle in RELO_var_locationTasksActive)) || !(_locationMkrCurr isEqualTo RELO_var_locationMkrCurr)};
if !(_locationMkrCurr isEqualTo RELO_var_locationMkrCurr) exitWith {}; // if current AO is over/finished, exit
///////////////////////////////////////////////////////////////////////////////////////////////////
if (_taskDefinition isEqualTo "simple") exitWith {}; // simple tasks don't redeploy troop reinforcements anywhere
///////////////////////////////////////////////////////////////////////////////////////////////////
// _aiCount = count (allUnits select {(_x getVariable ["unitBelongsToLocation","noLocation"]) isEqualTo RELO_var_locationMkrCurr});
// if (_aiCount >= RELO_var_locationTroopAmount) exitWith
// {
	// #ifdef __DEBUG__
		// format ["   ! no reinforcements deployed due to troop limit of %1 (%2 troop currently within the AO)",RELO_var_locationTroopAmount,_aiCount] remoteExec ["RELO_fnc_systemChatGlobal",[0,-2] select isDedicated];
		// diag_log format ["   ! no reinforcements deployed due to troop limit of %1 (%2 troop currently within the AO)",RELO_var_locationTroopAmount,_aiCount];
	// #endif
// };
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskUnitsTotal = (_taskUnits * _taskGroups);
// task complete reinforcements won't respawn after being killed! temporary second wave only.
_taskReinforcements = selectRandom ["NONE","LIGHT","MEDIUM","HEAVY","BOMBARD"];
switch (_taskReinforcements) do
{
	case "NONE": {_taskGroups = 0; _taskUnits = 0;};
	case "LIGHT": {_taskGroups = 1; _taskUnits = 6;};
	case "MEDIUM": {_taskGroups = 2; _taskUnits = 6;};
	case "HEAVY": {_taskGroups = 3; _taskUnits = 6;};
	case "BOMBARD": {_taskGroups = 4; _taskUnits = 6;};
};
#ifdef __DEBUG__
	format ["   ! number of %1 temporary reinforcements will be %2 (%3)",_taskTitle,(_taskUnits * _taskGroups),_taskReinforcements] remoteExec ["RELO_fnc_systemChatGlobal",[0,-2] select isDedicated];
	diag_log format ["   ! number of %1 temporary reinforcements will be %2 (%3)",_taskTitle,(_taskUnits * _taskGroups),_taskReinforcements];
#endif
if (_taskGroups > 0) then
{
	for [{_i = 0},{_i < _taskGroups},{_i = _i + 1}] do
	{
		_chosenRedeployMethod =	selectRandomWeighted ["ground",0.8,"para",0.5,"unload",0.2];
		_chosenTaskMarker = _taskMkr;
		_chosenTaskPos = getMarkerPos _chosenTaskMarker;
		if (surfaceIsWater _chosenTaskPos) then
		{
			_chosenTaskPosDepth = ASLtoATL _chosenTaskPos;
			_chosenTaskPosDepth = (_chosenTaskPosDepth select 2);
			if (_chosenTaskPosDepth >= 2) then
			{
				_chosenRedeployMethod = "para";
			};
		};
		switch (_chosenRedeployMethod) do
		{
			case "ground": {[_chosenTaskMarker,_locationMkrCurr,_taskSize * 1.5,"random",100 + random(100),_taskUnits,0.5] spawn RELO_fnc_deployGroundTroop;};
			case "para": {[_chosenTaskMarker,_locationMkrCurr,_locationSize * 3,"random",50 + random(50),100 + random(100),_taskUnits,0.5,50 + random(50),false,false,false] spawn RELO_fnc_deployParaTroop;};
			case "unload": {[_chosenTaskMarker,_locationMkrCurr,_locationSize * 3,"random",25,100 + random(100),_taskUnits,0.5,false,false,false] spawn RELO_fnc_deployUnloadTroop;};
		};
	};
};
///////////////////////////////////////////////////////////////////////////////////////////////////
_taskPatrolReinforcements = selectRandom ["NONE","LIGHT","MEDIUM"];
switch (_taskPatrolReinforcements) do
{
	case "NONE": {_taskUnits = 0;};
	case "LIGHT": {_taskUnits = 6;};
	case "MEDIUM": {_taskUnits = 12;};
};
RELO_var_locationPatrolTroop = RELO_var_locationPatrolTroop + _taskUnits; // increase units to patrol COB.
#ifdef __DEBUG__
	format ["   ! number of AO respawnable reinforcements will be %1 (%2)",_taskUnits,_taskPatrolReinforcements] remoteExec ["RELO_fnc_systemChatGlobal",[0,-2] select isDedicated];
	diag_log format ["   ! number of AO respawnable reinforcements will be %1 (%2)",_taskUnits,_taskPatrolReinforcements];
#endif
///////////////////////////////////////////////////////////////////////////////////////////////////
// if (_deployChoice isEqualTo "COB") then
// {
	// _taskCOBReinforcements = selectRandom ["NONE","LIGHT","MEDIUM"];
	// switch (_taskCOBReinforcements) do
	// {
		// case "NONE": {_taskUnits = 0;};
		// case "LIGHT": {_taskUnits = 6;};
		// case "MEDIUM": {_taskUnits = 12;};
	// };
	// RELO_var_locationCOBTroop = RELO_var_locationCOBTroop + _taskUnits; // increase units to patrol COB.
	// #ifdef __DEBUG__
		// format ["   ! number of COB respawnable reinforcements will be %1 (%2)",_taskUnits,_taskCOBReinforcements] remoteExec ["RELO_fnc_systemChatGlobal",[0,-2] select isDedicated];
		// diag_log format ["   ! number of COB respawnable reinforcements will be %1 (%2)",_taskUnits,_taskCOBReinforcements];
	// #endif
// };
///////////////////////////////////////////////////////////////////////////////////////////////////
