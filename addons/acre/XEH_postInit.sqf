#include "script_component.hpp"

[{
    if (EGVAR(common,acre) && {GVAR(enabled)}) then {
        if (call FUNC(acreModulesPresent)) exitWith {
            ERROR("Mission ACRE Modules detected! AFM ACRE module disabled.");
        };
        call FUNC(init);
        call FUNC(adjustVoiceVolume);
    };
}] call EFUNC(common,runAfterSettingsInit);
