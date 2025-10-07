#include "script_component.hpp"

[{
    if (EGVAR(common,acre) && GVAR(enabled)) then {
        if (call FUNC(acreModulesPresent)) exitWith {
            ERROR("Mission ACRE Modules detected! AFM ACRE module disabled.");
        };

        call FUNC(init);

        [{acre_core_init}, {
            [FUNC(adjustVoiceVolume), nil, 1] call CBA_fnc_waitAndExecute;
        }] call CBA_fnc_waitUntilAndExecute;
    };
}] call EFUNC(common,runAfterSettingsInit);
