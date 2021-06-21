#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer && {EGVAR(extension,enabled)}) then {

    GVAR(currentMissionId) = "";
    GVAR(retries) = 0;

    ["set_current_mission_id", {
        params ["_missionId"];

        GVAR(currentMissionId) = _missionId;
    }] call EFUNC(extension,setHandler);

    EXT callExtension "get_current_mission_id";

    // Try to get current mission id for first 20mins
    ["retry_get_current_mission_id", {
        if (GVAR(retries) >= 5) exitWith {};

        INC(GVAR(retries));

        // TODO notify admins about the issue

        [{EXT callExtension "get_current_mission_id"}, (20 * 60) / 5] call CBA_fnc_waitAndExecute;
    }] call EFUNC(extension,setHandler);


    [QGVAR(markAttendance), {
        params ["_playerId"];

        if (IS_ATTENDANCE_LOGGED(_playerId)) exitWith {};
        SET_ATTENDANCE_LOGGED(_playerId);

        EXT callExtension ["post_attendance", [GVAR(currentMissionId), _playerId]];
    }] call CBA_fnc_addEventHandler;
};


ADDON = true;
