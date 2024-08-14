#include "script_component.hpp"

["login", {
    [{IS_ADMIN}, {
        player setVariable [QGVAR(isAdmin), true, true];
    }, nil, 5] call CBA_fnc_waitUntilAndExecute;
}, "all"] call CBA_fnc_registerChatCommand;

["logout", {
    if (player getVariable [QGVAR(isAdmin), false]) then {
        player setVariable [QGVAR(isAdmin), false, true];
    };
}, "all"] call CBA_fnc_registerChatCommand;

["unit", {
    params ["_newPlayer", "_oldPlayer"];

    if (IS_ADMIN) then {
        _newPlayer setVariable [QGVAR(isAdmin), true, true];
    };

    if (_oldPlayer getVariable [QGVAR(isAdmin), false]) then {
        _oldPlayer setVariable [QGVAR(isAdmin), false, true];
    };
}, true] call CBA_fnc_addPlayerEventHandler;
