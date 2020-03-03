#include "script_component.hpp"
/*
 * Author: veteran29
 * Randomize gear of the unit from available items.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 *
 * Public: No
 */
params [
    ["_unit", objNull, [objNull]]
];

private _currentLoadout = getUnitLoadout _unit;
_currentLoadout set [7, ""]; // ignore facewear

if (!local _unit || {!(EMPTY_LOADOUT isEqualTo _currentLoadout) || {is3DEN}}) exitWith {
    LOG_1("Unit modified, no randomization - %1",_unit);
};

LOG_1("Randomizing gear - %1",_unit);

// check if there is a chance for the unit to have headgear and facewear
if (random 1 <= CHANCE_HEADGEAR) then {
    _unit addHeadgear selectRandom RANDOM_GEAR(headgear);
};

if (random 1 <= CHANCE_FACEWEAR) then {
    removeGoggles _unit;
    _unit addGoggles selectRandom RANDOM_GEAR(facewear);
};

_unit forceAddUniform selectRandom RANDOM_GEAR(uniforms);
_unit addVest selectRandom RANDOM_GEAR(vests);

nil
