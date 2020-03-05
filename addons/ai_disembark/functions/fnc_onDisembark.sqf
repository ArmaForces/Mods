#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle AI vehicle disembark.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];
if (!local _unit || {!GVAR(enabled) || {isPlayer _unit}}) exitWith {};

TRACE_1("Disembark",_unit);

_unit playActionNow "ReloadMagazine";

nil
