#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer || !hasInterface) then {
    ["Tank_F", "Fired", {
        if !(_this call FUNC(canHeat)) exitWith {};
        TRACE_1("Tank shot by AI, heating up",_this);
        params ["_vehicle"];
        _vehicle setVariable [QGVAR(heatTime), CBA_missionTime + 30];
        // heat up the vehicle
        [QGVAR(heat), _vehicle] call CBA_fnc_globalEvent;
    }] call CBA_fnc_addClassEventHandler;
};

if (hasInterface) then {
    [QGVAR(heat), {
        private _tiPars = getVehicleTiPars _this vectorAdd [0.2,0.2,0.2];
        _this setVehicleTiPars _tiPars;
    }] call CBA_fnc_addEventHandler;
};

ADDON = true;
