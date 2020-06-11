#include "script_component.hpp"

#include "initKeybinds.sqf"

if (IS_MOD_LOADED(diwako_dui_radar)) then {
    [QGVAR(pointed), {
        _this call diwako_dui_radar_fnc_incomingFinger;
    }] call CBA_fnc_addEventHandler;
};
