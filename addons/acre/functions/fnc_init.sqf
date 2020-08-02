#include "script_component.hpp"
/*
 * Author: veteran29
 * Initialize ACRE functionalities.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call afm_acre_fnc_init
 *
 * Public: No
 */

if (hasInterface) then {
    [GVAR(babel), GVAR(perSideRadios)] call acre_api_fnc_setupMission;
};

if (isServer) then {
    if (GVAR(perSideChannelNames)) then {
        {
            [_x, _forEachIndex + 2] call FUNC(initNameChannelsModule);
        } forEach [WEST, EAST, INDEPENDENT, CIVILIAN];
    } else {
        // All sides share channel names so we use only WEST side's channel names
        [WEST, 1] call FUNC(initNameChannelsModule);
    };
};

nil
