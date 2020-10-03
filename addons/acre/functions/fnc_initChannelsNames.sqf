#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Retrieves channel names for given side from settings
 * and sets them as channel names for given sides.
 *
 * Arguments:
 * 0: Gets channel names for this side <SIDE>
 * 1: Set loaded channel names for all sides <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * Set WEST channel names for WEST side:
 * [WEST] call afm_acre_fnc_initNameChannelsModule;
 * Set CIVILIAN channel names for all sides
 * [CIVILIAN, true] call afm_acre_fnc_initNameChannelsModule; //
 *
 * Public: No
 */

#define WEST_PRESET_NAME "default3"
#define EAST_PRESET_NAME "default2"
#define IND_PRESET_NAME "default4"
#define CIV_PRESET_NAME "default"
#define DEFAULT_PRESET_NAME "default"

params [["_sourceSide", CIVILIAN], ["_setForAll", false]];

private _targetSide = [[_sourceSide], [WEST, EAST, INDEPENDENT, CIVILIAN]] select _setForAll;

{
    private _presetName = switch (_x) do {
        case WEST: {WEST_PRESET_NAME};
        case EAST: {EAST_PRESET_NAME};
        case INDEPENDENT: {IND_PRESET_NAME};
        case CIVILIAN: {CIV_PRESET_NAME};
        default {DEFAULT_PRESET_NAME};
    };

    for "_channelNumber" from 1 to 10 step 1 do {
        // Retrieve channel name from settings
        private _variableName = [_sourceSide, _channelNumber] call FUNC(getSideChannelNumberVariableName);
        private _channelName = missionNamespace getVariable [_variableName, ""];
        // If not empty, set
        if (!(_channelName isEqualTo "")) then {
            TRACE_4("Setting %4 label for radio %1 preset %2 channel number %3",_x,DEFAULT_PRESET_NAME,_channelNumber,_channelName);
            {
                [_x, _presetName, _channelNumber, "label", _channelName] call acre_api_fnc_setPresetChannelField;
            } forEach (call acre_api_fnc_getAllRadios select 0);
        };
    };

} forEach _targetSide;

INFO_1("Initialized %1 channel names.", str _targetSide);

nil
