#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(objectAdd), player] call CBA_fnc_serverEvent;
    [[LLSTRING(GetZeus), LLSTRING(GetZeus_Description)], {player call FUNC(assignZeus)}] call EFUNC(debug_console,addButton);
};
