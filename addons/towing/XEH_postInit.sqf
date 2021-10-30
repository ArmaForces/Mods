#include "script_component.hpp"

if (!isServer || {!EGVAR(common,aceTowing)}) exitWith {};

if (GVAR(addToHeavyDutyVehicles)) then {
    {
        [_x, "initPost", {
            params ["_vehicle"];
            _vehicle addItemCargoGlobal ["ACE_rope12", 2];
            _vehicle addItemCargoGlobal ["ACE_rope27", 1];
        }, true, [], true] call CBA_fnc_addClassEventHandler;
    } forEach [
        "Tank_F",
        "Wheeled_APC_F",
        "MRAP_01_base_F",
        "MRAP_02_base_F"
    ];
};

if (GVAR(addToCars)) then {
    ["Car_F", "initPost", {
        params ["_vehicle"];
        _vehicle addItemCargoGlobal ["ACE_rope6", 2];
        _vehicle addItemCargoGlobal ["ACE_rope12", 1];
    }, true, ["MRAP_01_base_F", "MRAP_02_base_F"], true] call CBA_fnc_addClassEventHandler;
};
