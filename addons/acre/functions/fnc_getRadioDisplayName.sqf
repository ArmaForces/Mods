#include "script_component.hpp"
/*
 * Author: veteran29
 * Returns formatted radio display name with channels/MHz.
 *
 * Arguments:
 * 0: Unique radio ID <STRING>
 * 1: Base radio config <CONFIG>
 *
 * Return Value:
 * Radio display value <STRING>
 *
 * Example:
 * ["acre_prc152_id_1", configFile >> "CfgWeapons" >> "acre_prc152"] call afm_acre_fnc_getRadioDisplayName
 *
 * Public: Yes
 */

params ["_uniqueRadio", "_radioConfig"];

private _displayName = getText (_radioConfig >> "displayName");

private _currentChannel = [_uniqueRadio] call acre_api_fnc_getRadioChannel;
private _maxChannelsCount = [_uniqueRadio, "getState", "channels"] call acre_sys_data_fnc_dataEvent;

if (isNil "_maxChannelsCount") then {
    // Display frequency if single-channel radio (eg. AN/PRC-77)
    private _txData = [_uniqueRadio, "getCurrentChannelData"] call acre_sys_data_fnc_dataEvent;
    private _currentFreq = _txData getVariable "frequencyTX";
    _displayName = format ["%1 %2 MHz", _displayName, _currentFreq];
} else {
    _displayName = format [localize "STR_ACRE_ace_interact_channelShort", _displayName, _currentChannel];
};

_displayName // return
