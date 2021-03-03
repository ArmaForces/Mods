#include "script_component.hpp"

if (!EGVAR(common,aceTagging)) exitWith {};

if (hasInterface) then {
    ["ace_tagCreated", {
        params ["", "_texture", "_object", "_unit"];
        if (!GVAR(enabled)) exitWith {};
        // Check if tag created on building by local player
        if (!(_object isKindOf "Building") || {_unit isNotEqualTo player}) exitWith {};

        private _colorIndex = {
            if (_texture find _x != -1) exitWith {_forEachIndex};
            -1
        } forEach TEXTURE_COLORS;

        // no matching color, do not create marker
        if (_colorIndex == -1) exitWith {};

        private _marker = [_object, "side", _unit] call EFUNC(common,createPlayerMarker);
        _marker setMarkerShape "ICON";
        _marker setMarkerType "hd_dot";
        _marker setMarkerColor (MARKER_COLORS select _colorIndex);

    }] call CBA_fnc_addEventHandler;
};
