#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function checks if any ACRE mission modules are present in game.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: True if any ACRE modules are placed <BOOL>
 *
 * Example:
 * call afm_acre_fnc_acreModulesPresent
 *
 * Public: No
 */

count (allMissionObjects "Module_F" select {
    typeOf _x isEqualTo "acre_api_basicMissionSetup" || {
    typeOf _x isEqualTo "acre_api_nameChannels"}
}) > 0
