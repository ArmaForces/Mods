#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer && EGVAR(extension,enabled)) then {

    GVAR(currentMissionId) = "";

    ["set_current_mission_id", {
        params ["_missionId"];
        if (_missionId == "") exitWith {
            WARNING("No ongoing mission");
        };

        INFO_1("Received mission id - '%1'",_missionId);

        missionNamespace setVariable [QGVAR(currentMissionId), _missionId, true];
    }] call EFUNC(extension,setHandler);

    ["get_current_mission_error", {
        private _msg = LOG_SYS_FORMAT("ERROR","Failed to fetch current mission id - notify AF Admins");

        _msg remoteExec ["systemChat", 0];
    }] call EFUNC(extension,setHandler);

    EXT callExtension "get_current_mission_id";

    [QGVAR(markAttendance), {
        params ["_playerId"];

        if (IS_ATTENDANCE_LOGGED(_playerId)) exitWith {};
        SET_ATTENDANCE_LOGGED(_playerId);

        EXT callExtension ["post_attendance", [GVAR(currentMissionId), _playerId]];
    }] call CBA_fnc_addEventHandler;
};


ADDON = true;
