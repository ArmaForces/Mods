#include "script_component.hpp"
/*
 * Author: veteran29, ACRE2Team
 * Get child actions to copy radio settings from leader, based on ACRE2 fnc_radioListChildrenActions function.
 *
 * Arguments:
 * 0: Unit to copy radio settings from it's leader <OBJECT>
 *
 * Return Value:
 * List of actions with radios that are both on target and his leader <ARRAY>
 *
 * Example:
 * [player] call afm_acre_fnc_copyLeaderRadioChildrenActions
 *
 * Public: No
 */

params ["_target"];

private _targetLeader = leader _target;

private _radioList = [] call acre_api_fnc_getCurrentRadioList;
if (_radioList isEqualTo []) exitWith { [] }; // Quick exit if we have no radios

private _actions = [];
private _currentRadio = [] call acre_api_fnc_getCurrentRadio;
private _pttAssign = [] call acre_api_fnc_getMultiPushToTalkAssignment;

{
    private _baseRadio = [_x] call acre_api_fnc_getBaseRadio;
    private _leaderRadios = [_baseRadio, _targetLeader] call acre_api_fnc_getAllRadiosByType;
    if (_leaderRadios isNotEqualTo []) then {
        private _itemCfg = configFile >> "CfgWeapons" >> _baseRadio;

        private _displayName = [_x, _itemCfg] call FUNC(getRadioDisplayName);

        private _picture = getText (_itemCfg >> "picture");
        private _isActive = _x isEqualTo _currentRadio;

        // Display radio keys in front of those which are bound
        private _radiokey = (_pttAssign find _x) + 1;
        if (_radiokey <= 3) then {
            _displayName = format ["%1: %2", _radiokey, _displayName];
        };

        private _action = [
            _x,
            _displayName,
            _picture,
            nil,
            {true},
            {_this call FUNC(copyLeaderSingleRadioChildrenActions)},
            [_x, _leaderRadios]
        ] call ACEFUNC(interact_menu,createAction);

        _actions pushBack [_action, [], _target];
    };
} forEach _radioList;

_actions // return
