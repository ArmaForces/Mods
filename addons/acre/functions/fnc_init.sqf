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

nil
