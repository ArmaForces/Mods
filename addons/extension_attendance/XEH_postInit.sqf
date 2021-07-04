#include "script_component.hpp"

if (!hasInterface || {IS_ATTENDANCE_LOGGED(getPlayerUID player)}) exitWith {
    INFO("Player attendance already logged");
};

INFO_1("Logging player attendance in %1 minutes",ATTENDANCE_DELAY_MIN);

// log attendance after 30 mins of continous playtime
[{
    [QGVAR(markAttendance), getPlayerUID player] call CBA_fnc_serverEvent;
}, nil, ATTENDANCE_DELAY_MIN * 60] call CBA_fnc_waitAndExecute;
