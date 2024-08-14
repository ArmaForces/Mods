#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Enhanced original BIS_fnc_EGSpectator to support array of units/groups as spectator targets instead of sides only.
 *
 * Arguments:
 * 1: _whitelistedSides - Changed to support units/groups too.
 *
 * Public: No
 */

/*
    Author:
    Nelson Duarte

    Description:
    Spectator instance

    Returns:
    Multiple values / none

    Examples:
    ["Initialize", [player]] call BIS_fnc_EGSpectator; 	// Initializes spectator for given player
    ["Terminate"] call BIS_fnc_EGSpectator; 			// Terminates spectator for given player
*/

// Do not execute from within 3DEN
if (count (supportInfo "n:is3DEN") > 0 && { is3DEN }) exitWith {};

// Do not serialize this script
disableSerialization;

// Name of this script
scriptName "BIS_fnc_EGSpectator";

// Common spectator defines
#include "\A3\Functions_F_Exp_A\EGSpectatorCommonDefines.inc"

// Parameters
private _mode   = _this param [0, "", [""]];
private _params = _this param [1, [], [[]]];

if (_mode != "GetTargetEntities" && _mode != "GetTargetGroups") exitWith {
    private _return = _this call BIS_fnc_EGSpectatorCore;

    // isNil check is needed to prevent warnings in scheduled
    if (isNil "_return") exitWith {};
    _return // return
};

// Sub functions
switch (_mode) do
{
    /**
     * Returns entities that are visible to the spectator
     */
    case "GetTargetEntities" :
    {
        private _allowAi = missionNamespace getVariable [VAR_ALLOW_AI_SWITCH, false];
        private _whitelist = missionNamespace getVariable [VAR_WHITELISTED_SIDES, []];
        private _whitelistEmpty = count _whitelist < 1;
        private _entities = [];
        private _validEntities = [];

        // AI filter
        if (_allowAi) then
        {
            _entities = allUnits;
        }
        else
        {
            _entities = [] call BIS_fnc_listPlayers;
        };

        // Side filter
        {
            if
            (
                simulationEnabled _x && {simulationEnabled vehicle _x} &&
                { !isObjectHidden _x && {!isObjectHidden vehicle _x} } &&
                { !(_x isKindOf SPECTATOR_CLASS) } &&
                // Added '|| { group _x in _whitelist || {_x in _whitelist}}' to support unit/group
                { (_whitelistEmpty || { side group _x in _whitelist || { group _x in _whitelist || {_x in _whitelist}}}) }
            ) then
            {
                _validEntities pushBack _x;
            };
        } forEach _entities;

        _validEntities;
    };

    /**
     * Returns groups that are visible to the spectator
     */
    case "GetTargetGroups" :
    {
        private _allowAi = missionNamespace getVariable [VAR_ALLOW_AI_SWITCH, false];
        private _whitelist = missionNamespace getVariable [VAR_WHITELISTED_SIDES, []];
        private _whitelistEmpty = count _whitelist < 1;
        private _groups = [];
        private _validGroups = [];

        // AI filter
        if (_allowAi) then
        {
            _groups = allGroups;
        }
        else
        {
            private _players = [] call BIS_fnc_listPlayers;
            { _groups pushBackUnique (group _x); } forEach _players;
        };

        // Side and number of units filter
        {
            // Added '|| { _x in _whitelist || { units _x findIf {_x in _whitelist} != -1 }}'
            if ((_whitelistEmpty || { side _x in _whitelist || { _x in _whitelist || { units _x findIf {_x in _whitelist} != -1 }}}) && {{!(_x isKindOf SPECTATOR_CLASS)} count units _x > 0 }) then
            {
                _validGroups pushBack _x;
            };
        } forEach _groups;


        _validGroups;
    };
};
