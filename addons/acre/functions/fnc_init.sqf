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
    INFO("Initializing Babel and Per side Radios.");
    [GVAR(babel), GVAR(perSideRadios)] call acre_api_fnc_setupMission;
};

if (GVAR(perSideRadios) && GVAR(perSideChannelNames)) then {
    INFO("Initializing channel names per side.");
    {
        [_x] call FUNC(initChannelsNames);
    } forEach [WEST, EAST, INDEPENDENT, CIVILIAN];
} else {
    if (GVAR(perSideRadios)) then {
        INFO("Initializing common channel names for per side radios.");
        // Need to set channels names for each side separately
        [CIVILIAN, true] call FUNC(initChannelsNames);
    } else {
        INFO("Initializing common channel names.");
        // All sides share channel names, doesn't matter which side will set up channels.
        call FUNC(initChannelsNames);
    };
};

nil
