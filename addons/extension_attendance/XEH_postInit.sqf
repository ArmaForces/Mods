#include "script_component.hpp"

if (!hasInterface || {IS_ATTENDANCE_LOGGED(getPlayerUID player)}) exitWith {};

// log attendance after 30 mins of continous playtime
[{
    [QGVAR(markAttendance), getPlayerUID player] call CBA_fnc_serverEvent;
}, nil, 30 * 60] call CBA_fnc_waitAndExecute;
