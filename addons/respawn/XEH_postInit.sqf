#include "script_component.hpp"

if (isServer) then {
    [QGVAR(force), {
        [QGVAR(force)] call CBA_fnc_remoteEvent;
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(saveEquipment), {
        GVAR(savedEquipment) = getUnitLoadout player;
    }] call CBA_fnc_addEventHandler;

    [{alive player}, {
        [QGVAR(saveEquipment)] call CBA_fnc_localEvent;
    }] call CBA_fnc_waitUntilAndExecute;

    [QGVAR(force), {
        if (alive player) exitWith {};
        setPlayerRespawnTime TIME_MINIMUM;
    }] call CBA_fnc_addEventHandler;
};
