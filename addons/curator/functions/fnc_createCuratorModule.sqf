#include "script_component.hpp"
/*
 * Author: 3Mydlo3, ACE Team
 * Function creates curator module.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: New curator module <OBJECT>
 *
 * Example:
 * call afm_curator_fnc_createCuratorModule
 *
 * Public: No
 */

if (!isServer) exitWith {};

private _group = missionNamespace getVariable [QGVAR(group), grpNull];
if (isNull _group) then {
    _group = createGroup sideLogic;
    _group deleteGroupWhenEmpty true;
    GVAR(group) = _group;
};

private _zeus = _group createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
GVAR(curators) pushBack _zeus;
_zeus setVariable ["Addons", 3, true];
_zeus setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
_zeus setCuratorCoef ["Place", 0];
_zeus setCuratorCoef ["Delete", 0];

_zeus
