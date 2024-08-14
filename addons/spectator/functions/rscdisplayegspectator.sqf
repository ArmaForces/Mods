#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Enhanced original RscDisplayEGSpectator to support showing only valid units from group on the list for selection instead of whole group.
 *
 * Return Value:
 * The same as original RscDisplayEGSpectator (Probably none)
 *
 * Public: No
 */

/*
    Author:
    Nelson Duarte

    Description:
    Handles spectator display

    Returns:
    Multiple values / none

    Event Handlers:
    RscDisplayEGSpectator_OnCursorObjectFocused
    RscDisplayEGSpectator_OnFocusChanged
    RscDisplayEGSpectator_OnUiVisibilityChanged
    RscDisplayEGSpectator_MapStateChanged

    Notes:
    Not to be used directly
*/
// Do not serialize this script
disableSerialization;

// Name this script
scriptName "RscDisplayEGSpectator";

// Common spectator defines
#include "\A3\Functions_F_Exp_A\EGSpectatorCommonDefines.inc"

// Params
private ["_mode", "_params"];
_mode   = _this param [0, "", [""]];
_params = _this param [1, [], [[]]];

if (_mode != "Update_PlayerList") exitWith {
    private _return = _this call BIS_fnc_RscDisplayEGSpectatorCore;

    // isNil check is needed to prevent warnings in scheduled
    if (isNil "_return") exitWith {};
    _return // return
};

switch _mode do
{
    /**
     * Updates player list
     */
    case "Update_PlayerList" :
    {
        scriptName "RscDisplayEGSpectator: Update_PlayerList";

        if !(missionNamespace getVariable [VAR_SHOW_LISTS, true]) exitWith {};

        private _display    = uiNamespace getVariable [VAR_DISPLAY, displayNull];
        private _ctrl       = _display displayCtrl IDC_RSCDISPLAYEGSPECTATOR_LIST;

        private _oldList    = [] + (uiNamespace getVariable [VAR_ENTITIES_LIST_OLD, []]);
        private _groups     = [] + (["GetTargetGroups"] call SPEC);
        private _validUnits = [] + (["GetTargetEntities"] call SPEC); // Added

        private ["_west", "_east", "_indep", "_civ"];
        _west       = [];
        _east       = [];
        _indep      = [];
        _civ        = [];

        // Go through groups and get the valid ones only, also cache group units information
        {
            private _group = _x;
            private _units = units _x;
            private _showAiGroups = missionNamespace getVariable [VAR_ALLOW_AI_SWITCH, true];
            private _groupTexture = ["GetGroupTexture", [_group]] call BIS_fnc_dynamicGroups;
            private _groupInfo = [_group, side _group, _groupTexture, groupId _group];
            private _unitsInfo = [];

            // Validate units
            {
                // Added '&& {_validUnits findIf {_x isEqualTo _unit} != -1}'
                private _unit = _x;
                if (simulationEnabled _x && {!isObjectHidden _x} && {simulationEnabled vehicle _x} && {!isObjectHidden vehicle _x} && {isPlayer _x || {_showAiGroups}} && {_validUnits findIf {_x isEqualTo _unit} != -1} && !(_x isKindOf SPECTATOR_CLASS)) then
                {
                    _unitsInfo pushBack [_x, alive _x, alive _x && { _x getVariable [VAR_INCAPACITATED, false] }, [_x, true, NAME_MAX_CHARACTERS] call BIS_fnc_getName, _group];
                };
            } forEach _units;

            // If we have valid units in the group, group is deemed valid
            if (count _unitsInfo > 0) then
            {
                private _result = [_groupInfo, _unitsInfo];

                // Add group to corresponding array, divided per side
                switch (side _group) do
                {
                    case WEST:       { _west pushBack _result; };
                    case EAST:       { _east pushBack _result; };
                    case RESISTANCE: { _indep pushBack _result; };
                    default          { _civ pushBack _result; };
                };
            };
        } forEach _groups;

        // The new list
        private _newList = [_west, _east, _indep, _civ];

        // Whether an update to the list is required (really only if something changed)
        if !(_oldList isEqualTo _newList) then
        {
            private _allElements = ["TreeGetAllElements"] call DISPLAY;
            private _groupElements = _allElements select 1;
            private _unitElements = _allElements select 2;

            // Remove units from list which no longer exist
            {
                private _data = _x;
                private _bExists = false;

                {
                    private _sideList = _x;

                    {
                        private _unitsInfo = _x select 1;

                        {
                            private _unitInfo = _x;
                            private _unit = _unitInfo select 0;
                            private _var = [_unit] call BIS_fnc_objectVar;

                            if (_var == _data) exitWith
                            {
                                _bExists = true;
                            };
                        }
                        forEach _unitsInfo;

                        if (_bExists) exitWith {};
                    }
                    forEach _sideList;

                    if (_bExists) exitWith {};
                }
                forEach _newList;

                if (!_bExists) then
                {
                    ["TreeDeleteUnit", [_data]] call DISPLAY;
                    //["   Unit %1 removed", _data] call BIS_fnc_error;
                };
            }
            forEach _unitElements;

            // Remove groups from list which no longer exist
            {
                private _data = _x;
                private _bExists = false;

                {
                    private _sideList = _x;

                    {
                        private _groupInfo = _x select 0;
                        private _group = _groupInfo select 0;
                        private _id = str _group;

                        if (_id == _data) exitWith
                        {
                            _bExists = true;
                        };
                    }
                    forEach _sideList;

                    if (_bExists) exitWith {};
                }
                forEach _newList;

                if (!_bExists) then
                {
                    ["TreeDeleteGroup", [_data]] call DISPLAY;
                    //["Group %1 removed", _data] call BIS_fnc_error;
                };
            }
            forEach _groupElements;

            // Update or add
            {
                private _sideIndex = _forEachIndex;
                private _sideType = switch (_forEachIndex) do
                {
                    case 0: { "WEST"; };
                    case 1: { "EAST"; };
                    case 2: { "RESISTANCE"; };
                    default { "CIVILIAN"; };
                };
                private _sideColor = switch (_forEachIndex) do
                {
                    case 0: { [WEST] call BIS_fnc_sideColor; };
                    case 1: { [EAST] call BIS_fnc_sideColor; };
                    case 2: { [RESISTANCE] call BIS_fnc_sideColor; };
                    default { [CIVILIAN] call BIS_fnc_sideColor; };
                };
                private _sideString = switch (_forEachIndex) do
                {
                    case 0: { localize "str_west"; };
                    case 1: { localize "str_east"; };
                    case 2: { localize "str_guerrila"; };
                    default { localize "str_civilian"; };
                };

                if (_ctrl tvCount [] == _forEachIndex) then
                {
                    _ctrl tvAdd [[], _sideString];
                    _ctrl tvSetData [[_forEachIndex], _sideType];
                };

                _ctrl tvExpand [_sideIndex];
                //_ctrl tvSort [[_sideIndex], false];

                {
                    private _groupInfo = _x select 0;
                    private _unitsInfo = _x select 1;
                    private _group = _groupInfo select 0;
                    private _i = ["TreeGetDataIndex", [str _group]] call DISPLAY;
                    private _groupIndex = if (count _i > 0) then {_i select 1} else {-1};

                    //["Group %1 with index %2 being checked", _group, _groupIndex] call BIS_fnc_error;

                    if (_i isEqualTo []) then
                    {
                        _groupIndex = _ctrl tvAdd [[_sideIndex], groupId _group];
                        _ctrl tvSetData [[_sideIndex, _groupIndex], str _group];
                        _ctrl tvSetPicture [[_sideIndex, _groupIndex], _groupInfo select 2];
                        _ctrl tvSetPictureColor [[_sideIndex, _groupIndex], [1, 1, 1, 0.5]];
                        _ctrl tvSetTooltip [[_sideIndex, _groupIndex], groupId _group];
                        _ctrl tvExpand [_sideIndex, _groupIndex];
                        //_ctrl tvSort [[_sideIndex, _groupIndex], false];
                        //["Group %1 added with index %2", str _group, _groupIndex] call BIS_fnc_error;
                    }
                    else
                    {
                        _ctrl tvSetText [_i, groupId _group];
                        _ctrl tvSetPicture [_i, _groupInfo select 2];
                        _ctrl tvSetPictureColor [_i, [1, 1, 1, 0.5]];
                        _ctrl tvSetTooltip [_i, groupId _group];
                        //["Group %1 Updated with index %2", str _group, _groupIndex] call BIS_fnc_error;
                    };

                    {
                        private ["_unit", "_isAlive", "_isIncapacitated", "_name", "_groupId"];
                        _unit               = _x select 0;
                        _isAlive            = _x select 1;
                        _isIncapacitated    = _x select 2;
                        _name               = _x select 3;
                        _groupId            = _x select 4;

                        private _text = if (isPlayer _unit) then { _name } else { format ["%1: %2", localize "str_player_ai", _name] };
                        private _tooltip = if (isPlayer _unit) then { format ["%1 - %2", _name, _groupId] } else { format ["%1: %2 - %3", localize "str_player_ai", _name, _groupId] };
                        private _i = ["TreeGetDataIndex", [[_unit] call BIS_fnc_objectVar]] call DISPLAY;
                        private _unitIndex = if (count _i > 0) then {_i select 1} else {-1};
                        private _unitIcon = getText (configfile >> "CfgVehicles" >> typeOf _unit >> "icon");

                        private _texture = switch (true) do
                        {
                            case (!_isAlive) :          { ICON_DEAD };
                            case (_isIncapacitated) :   { ICON_REVIVE };
                            default                     { if (_unitIcon != "") then {getText (configfile >> "CfgVehicleIcons" >> _unitIcon)} else {""} };
                        };

                        if (_i isEqualTo []) then
                        {
                            _unitIndex = _ctrl tvAdd [[_sideIndex, _groupIndex], _text];
                            _ctrl tvSetData [[_sideIndex, _groupIndex, _unitIndex], [_unit] call BIS_fnc_objectVar];
                            _ctrl tvSetPicture [[_sideIndex, _groupIndex, _unitIndex], _texture];
                            _ctrl tvSetPictureColor [[_sideIndex, _groupIndex, _unitIndex], _sideColor];
                            _ctrl tvSetTooltip [[_sideIndex, _groupIndex, _unitIndex], _tooltip];
                            //["   Unit %1 added (%2 / %3)", [_unit] call BIS_fnc_objectVar, _group, _groupIndex] call BIS_fnc_error;
                        }
                        else
                        {
                            _ctrl tvSetText [_i, _text];
                            _ctrl tvSetPicture [_i, _texture];
                            _ctrl tvSetPictureColor [_i, _sideColor];
                            _ctrl tvSetTooltip [_i, _tooltip];
                            //["   Unit %1 updated (%2 / %3)", [_unit] call BIS_fnc_objectVar, _group, _groupIndex] call BIS_fnc_error;
                        };
                    }
                    forEach _unitsInfo;
                }
                forEach _x;
            }
            forEach _newList;

            // Store the new list
            uiNamespace setVariable [VAR_ENTITIES_LIST_OLD, _newList];
        };

        // Current focused unit
        private _focus = ["GetFocus"] call DISPLAY;

        // Update focus if required
        if (!isNull _focus && {count tvCurSel _ctrl < 3}) then
        {
            // Get index of current focus in the list
            private _i = ["TreeGetDataIndex", [[_focus] call BIS_fnc_objectVar]] call DISPLAY;

            // If found, select it
            if !(_i isEqualTo []) then
            {
                _ctrl tvSetCurSel _i;
            };
        };
    };
};
