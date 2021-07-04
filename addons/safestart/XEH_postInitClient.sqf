#include "script_component.hpp"

if (is3DEN) exitWith {};

[QGVAR(enableSafety), player] call CBA_fnc_localEvent;

call FUNC(grenadeBindWarn);
