#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Creates acre_api_nameChannels module.
 * Retrieves channel names for given side from settings
 * and sets them as channel names for given side setup.
 *
 * Arguments:
 * 0: Gets channel names for this side <SIDE>
 * 1: Sets channel names for this side(s) <NUMBER>
 *      1 - All
 *      2 - WEST
 *      3 - EAST
 *      4 - INDEPENDENT
 *      5 - CIVILIAN
 *
 * Return Value:
 * None
 *
 * Example:
 * [WEST, 1] call afm_acre_fnc_initNameChannelsModule
 *
 * Public: No
 */

params ["_side", "_sideListBoxIndex"];

private _module = createGroup sideLogic createUnit ["acre_api_nameChannels", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_module setVariable ["SideSelect", _sideListBoxIndex]; // 1 is All, 5 is Civilian
for "_channelNumber" from 1 to 10 step 1 do {
    private _variableName = [_side, _channelNumber] call FUNC(getSideChannelNumberVariableName);
    private _channelName = missionNamespace getVariable [_variableName, ""];
    _module setVariable [format ["Channel_%1", _channelNumber], _channelName];
};
_module setVariable ["bis_fnc_initModules_activate", true];

nil
