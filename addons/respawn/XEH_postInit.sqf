#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(saveEquipment), {
        GVAR(savedEquipment) = getUnitLoadout player;
    }] call CBA_fnc_addEventHandler;

    [{alive player}, {
        [QGVAR(saveEquipment)] call CBA_fnc_localEvent;
    }] call CBA_fnc_waitUntilAndExecute;
};
