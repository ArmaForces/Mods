#include "script_component.hpp"
/*
 * Author: veteran29
 * Get child actions with list of certain radio type channels that can be copied from leader.
 *
 * Arguments:
 * 0: Unit to set radio channels on <OBJECT>
 * 1: Unused
 * 2: Radio data arguments <ARRAY>
 *  0: Unit unique radio class <STRING>
 *  1: List of unique radio classes that channels can be copied from <ARRAY>
 *
 * Return Value:
 * List of actions with leader channels that can be set on parent node radio <ARRAY>
 *
 * Example:
 * [player, nil, ["ACRE_PRC343_ID1", ["ACRE_PRC343_ID2", "ACRE_PRC343_ID3"]]] call afm_acre_fnc_copyLeaderSingleRadioChildrenActions
 *
 * Public: No
 */

params ["_target", "", "_args"];
_args params ["_radio", "_leaderRadios"];

private _actions = [];

{
    private _leaderRadioChannel = _x call acre_api_fnc_getRadioChannel;
    private _maxChannelsCount = [_x, "getState", "channels"] call acre_sys_data_fnc_dataEvent;
    private "_displayName";
    if (isNil "_maxChannelsCount") then {
        // Display frequency if single-channel radio (eg. AN/PRC-77)
        private _txData = [_x, "getCurrentChannelData"] call acre_sys_data_fnc_dataEvent;
        private _leaderFreq = _txData getVariable "frequencyTX";
        _displayName = format [LLSTRING(SetToFrequency), _leaderFreq];
    } else {
        _displayName = format [LLSTRING(SetToChannel), _leaderRadioChannel];
    };

    // TODO support radios without channels
    if (!isNil "_maxChannelsCount") then {
        private _action = [
            _x,
            _displayName,
            "",
            {
                params ["", "", "_args"];
                _args call acre_api_fnc_setRadioChannel;
            },
            {true},
            nil,
            [_radio, _leaderRadioChannel]
        ] call ACEFUNC(interact_menu,createAction);

        _actions pushBack [_action, [], _target];
    };
} forEach _leaderRadios;

_actions // return
