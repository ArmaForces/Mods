#include "script_component.hpp"

if (isServer) then {
    // Event forces respawn for all clients
    [QGVAR(force), {
        [QGVAR(force)] call CBA_fnc_remoteEvent;
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // Save equipment event if anyone wanted to save it by himself at any time
    [QGVAR(saveEquipment), {
        GVAR(savedEquipment) = getUnitLoadout player;
    }] call CBA_fnc_addEventHandler;

    // Save initial equipment
    [{alive player}, {
        [QGVAR(saveEquipment)] call CBA_fnc_localEvent;
    }] call CBA_fnc_waitUntilAndExecute;

    // Event forces respawn for local client if he's ded
    [QGVAR(force), {
        if (alive player) exitWith {};
        setPlayerRespawnTime TIME_MINIMUM;
    }] call CBA_fnc_addEventHandler;

    // Events for enabling/disabling respawn locally
    [QGVAR(enable), {
        _this call FUNC(enable);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(disable), {
        _this call FUNC(disable);
    }] call CBA_fnc_addEventHandler;

    // Event for adjusting remaining respawn time when respawn time changes
    [QGVAR(adjustTimeLocal), {
        _this call FUNC(adjustTimeLocal);
    }] call CBA_fnc_addEventHandler;
};
