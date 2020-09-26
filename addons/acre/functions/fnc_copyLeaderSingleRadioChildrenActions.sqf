#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afm_main_fnc_example
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
        _displayName = format ["Set to freq: %1 MHz", _leaderFreq];
    } else {
        _displayName = format ["Set to chn: %1", _leaderRadioChannel];
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
