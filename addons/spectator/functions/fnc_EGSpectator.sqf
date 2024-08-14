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
private _mode 	= _this param [0, "", [""]];
private _params = _this param [1, [], [[]]];

// Sub functions
switch (_mode) do
{
    /**
     * Initializes spectator
     * @return <BOOL> True if initialized correctly, false if not
     */
    case "Initialize" :
    {
        _params params
        [
            ["_spectator", objNull, [objNull]],
            ["_whitelistedSides", [], []],
            ["_allowAi", false, [false]],
            ["_allowFreeCamera", true, [false]],
            ["_allow3PPCamera", true, [false]],
            ["_showFocusInfo", true, [false]],
            ["_showCameraButtons", true, [false]],
            ["_showControlsHelper", true, [false]],
            ["_showHeader", true, [false]],
            ["_showLists", true, [false]]
        ];

        // Make sure call was not done by a dedicated server or headless client
        if (!hasInterface) exitWith {};

        // Make sure local player is fully initialized
        waitUntil { !isNil { player } && { !isNull player } };

        // Whether spectator systems are already initialized
        private _bIsInitialized	= ["IsInitialized"] call SPEC;

        // Whether given unit is also local player
        private _isPlayer = _spectator == player;

        // Make sure that:
        // * Spectator was not initialized already
        // * We only execute spectator for local player if controlling unit
        if (!_bIsInitialized && _isPlayer) then
        {
            // Flag as initialized
            _bIsInitialized = true;

            // Start drawing
            missionNamespace setVariable [VAR_DRAW3D, addMissionEventHandler ["Draw3D", { [] call SPEC_DRAW3D; }]];

            // Flag as initialized
            missionNamespace setVariable [VAR_INITIALIZED, _bIsInitialized];

            // Add entity respawn event handler
            missionNamespace setVariable [VAR_ENTITY_RESPAWNED, addMissionEventHandler ["EntityRespawned", { (_this select 0) setVariable [VAR_EVENT_FIRED, nil]; }]];

            // The whitelisted sides, if empty, all sides will be visible
            private _sides = [];

            {
                switch (toUpper _x) do
                {
                    case "WEST" : {_sides pushBack WEST;};
                    case "EAST" : {_sides pushBack EAST;};
                    case "RESISTANCE" : {_sides pushBack RESISTANCE;};
                    default {_sides pushBack CIVILIAN;};
                };
            } forEach (_spectator getVariable ["WhitelistedSides", []]);

            // Configuration
            missionNamespace setVariable [VAR_ALLOW_AI_SWITCH, _spectator getVariable ["AllowAi", _allowAi]];
            missionNamespace setVariable [VAR_ALLOW_FREE_CAMERA, _spectator getVariable ["AllowFreeCamera", _allowFreeCamera]];
            missionNamespace setVariable [VAR_ALLOW_3PP_CAMERA, _spectator getVariable ["Allow3PPCamera", _allow3PPCamera]];
            missionNamespace setVariable [VAR_SHOW_FOCUS_INFO, _spectator getVariable ["ShowFocusInfo", _showFocusInfo]];
            missionNamespace setVariable [VAR_SHOW_CAMERA_BUTTONS, _spectator getVariable ["ShowCameraButtons", _showCameraButtons]];
            missionNamespace setVariable [VAR_SHOW_CONTROLS_HELPER, _spectator getVariable ["ShowControlsHelper", _showControlsHelper]];
            missionNamespace setVariable [VAR_SHOW_HEADER, _spectator getVariable ["ShowHeader", _showHeader]];
            missionNamespace setVariable [VAR_SHOW_LISTS, _spectator getVariable ["ShowLists", _showLists]];
            if (count _sides > 0) then { missionNamespace setVariable [VAR_WHITELISTED_SIDES, _sides]; } else { missionNamespace setVariable [VAR_WHITELISTED_SIDES, _whitelistedSides]; };

            // The view distance
            missionNamespace setVariable [VAR_VIEW_DISTANCE, viewDistance];

            // Draw locations in 3D
            missionNamespace setvariable [VAR_DRAW_3D_LOCATIONS, true];

            // Projectiles and grenades lists
            missionNamespace setVariable [VAR_PROJECTILES, []];
            missionNamespace setVariable [VAR_GRENADES, []];

            // The desired camera mode
            // Free and Follow camera modes might be blocked
            private _initialMode = if (_allowFreeCamera) then
            {
                MODE_FREE;
            }
            else
            {
                if (_allow3PPCamera) then
                {
                    MODE_FOLLOW;
                }
                else
                {
                    MODE_FPS;
                };
            };

            // Create camera
            ["Initialize", [TYPE_CURATOR, _initialMode]] call CAM;

            // Create display
            ["CreateDisplay"] spawn SPEC;

            // Do not allow damage for the spectator unit
            _spectator allowDamage false;

            // Thread
            missionNamespace setVariable [VAR_THREAD, [] spawn
            {
                scriptName "BIS_EGSpectator_thread";

                private _delay = 0.25;

                while { true } do
                {
                    // Store units icons
                    // Used in Draw3D
                    missionNamespace setVariable [VAR_UNITS_ICONS_TO_DRAW, [] call SPEC_GET_UNITS_TO_DRAW];

                    private _allUnits = allUnits;
                    private _allUnitsCount = count _allUnits;

                    // Go through all units and add fired event handler to those which do not have it
                    {
                        if (isNil { _x getVariable VAR_EVENT_FIRED }) then
                        {
                            _x setVariable [VAR_EVENT_FIRED, _x addEventHandler ["Fired",
                            {
                                private _weapon = _this param [1, "", [""]];
                                private _projectile = _this param [6, objNull, [objNull]];

                                // Fire time used for highlighting
                                (_this select 0) setVariable [VAR_HIGHLIGHT_TIME, time + FIRE_HIGHLIGHT_TIME];

                                // Store projectiles / grenades for drawing
                                if (!isNull _projectile && {missionNamespace getVariable [VAR_DRAW_PROJECTILES_PATH, false]}) then
                                {
                                    private _projectiles = missionNamespace getVariable [VAR_PROJECTILES, []];
                                    private _grenades = missionNamespace getVariable [VAR_GRENADES, []];

                                    if (_weapon == "Throw") then
                                    {
                                        if (count _grenades > MAX_GRENADES) then {_grenades deleteAt 0};
                                        _grenades pushBack _projectile;
                                        missionNamespace setVariable [VAR_GRENADES, _grenades];
                                    }
                                    else
                                    {
                                        if (count _projectiles > MAX_PROJECTILES) then {_projectiles deleteAt 0};
                                        _projectiles pushBack [_projectile, [[getPosVisual _projectile, [1,0,0,0]]]];
                                        missionNamespace setVariable [VAR_PROJECTILES, _projectiles];
                                    };
                                };
                            }]];
                        };

                        sleep (_delay / _allUnitsCount);
                    } forEach _allUnits;

                    // Delay next check
                    sleep _delay;
                };
            }];
        };

        // Log
        ["VirtualSpectator_F: %1 / %2 / %3 / %4", _bIsInitialized, player == _spectator, player, _spectator] call BIS_fnc_logFormat;

        // Return whether initialization was succeded or not
        _bIsInitialized;
    };

    /**
     * Terminates spectator, if currently running, making player take back control of it's unit / virtual entity
     * @return <BOOL> True if terminated correctly, false if it was never initialized
     */
    case "Terminate" :
    {
        private "_bSucceeded";
        _bSucceeded = false;

        // Make sure that spectator is initialized
        if (["IsInitialized"] call SPEC) then
        {
            // Stop drawing
            removeMissionEventHandler ["Draw3D", missionNamespace getVariable [VAR_DRAW3D, -1]];

            // Stop thread
            terminate (missionNamespace getVariable [VAR_THREAD, scriptNull]);

            // Remove entity respawned event handler
            removeMissionEventHandler ["EntityRespawned", missionNamespace getVariable [VAR_ENTITY_RESPAWNED, -1]];

            // Reset mission variables
            missionNamespace setVariable [VAR_DRAW3D, nil];
            missionNamespace setVariable [VAR_CUSTOM_ICONS, nil];
            missionNamespace setVariable [VAR_INITIALIZED, nil];
            missionNamespace setVariable [VAR_ENTITY_RESPAWNED, nil];
            missionNamespace setVariable [VAR_THREAD, nil];

            // Configuration
            missionNamespace setVariable [VAR_ALLOW_AI_SWITCH, nil];
            missionNamespace setVariable [VAR_ALLOW_FREE_CAMERA, nil];
            missionNamespace setVariable [VAR_ALLOW_3PP_CAMERA, nil];
            missionNamespace setVariable [VAR_SHOW_FOCUS_INFO, nil];
            missionNamespace setVariable [VAR_SHOW_CAMERA_BUTTONS, nil];
            missionNamespace setVariable [VAR_SHOW_CONTROLS_HELPER, nil];
            missionNamespace setVariable [VAR_SHOW_HEADER, nil];
            missionNamespace setVariable [VAR_SHOW_LISTS, nil];
            missionNamespace setVariable [VAR_WHITELISTED_SIDES, nil];

            // Projectiles / grenades containers
            missionNamespace setVariable [VAR_PROJECTILES, nil];
            missionNamespace setVariable [VAR_GRENADES, nil];

            // Destroy spectator display
            ["DestroyDisplay"] call SPEC;

            // Destroy camera
            ["Terminate"] call CAM;

            // Switch back to unit
            player switchCamera "Internal";

            // Do allow damage for the spectator unit
            player allowDamage true;

            // The view distance
            setViewDistance (missionNamespace getVariable [VAR_VIEW_DISTANCE, viewDistance]);

            // We have a successful termination
            _bSucceeded = true;
        };

        // Return whether termination was succeeded
        _bSucceeded;
    };

    /**
     * Whether spectator is currently running
     * @return <BOOL> True if spectator was initialized, false if not
     */
    case "IsInitialized" :
    {
        !isNil { missionNamespace getVariable VAR_INITIALIZED };
    };

    /**
     * Whether given object is a VirtualSpectator_F
     * @param <OBJECT> The object to check
     * @return <BOOL> True if object is spectator, false if not
     */
    case "IsSpectator" :
    {
        params [["_object", objNull, [objNull]]];

        _object isKindOf SPECTATOR_CLASS;
    };

    /**
     * Whether we are currently spectating
     * @return <BOOL> True if spectating, false if not
     */
    case "IsSpectating" :
    {
        !isNil { missionNamespace getVariable VAR_INITIALIZED };
    };

    /**
     * The spectator camera which player is currently controlling
     * @return <OBJECT> The camera player is controlling
     */
    case "GetCamera" :
    {
        ["GetCamera"] call CAM;
    };

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

        // hint str _validEntities;

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
            // if ((_whitelistEmpty || { side _x in _whitelist }) && {{!(_x isKindOf SPECTATOR_CLASS)} count units _x > 0 }) then
            if ((_whitelistEmpty || { side _x in _whitelist || { _x in _whitelist || units _x findIf {_x in _whitelist} != -1 }}) && {{!(_x isKindOf SPECTATOR_CLASS)} count units _x > 0 }) then
            {
                _validGroups pushBack _x;
            };
        } forEach _groups;

        // hint str _validGroups;

        _validGroups;
    };

    /**
     * Creates and returns the spectator display
     * @return <BOOL> If the display was created
     */
    case "CreateDisplay" :
    {
        private _display = displayNull;

        waitUntil
        {
            _display = [] call BIS_fnc_displayMission;
            !isNull _display
        };

        _display createDisplay "RscDisplayEGSpectator";
    };

    /**
     * Destroys spectator display
     * @return <BOOL> Whether display was successfully destroyed
     */
    case "DestroyDisplay" :
    {
        private _display = ["GetDisplay"] call SPEC;

        if (!isNull _display) then
        {
            _display closeDisplay 2;
        };

        isNull (["GetDisplay"] call SPEC);
    };

    /**
     * Get's the spectator display, if open
     * @return <DISPLAY> The spectator display
     */
    case "GetDisplay" :
    {
        findDisplay IDD_RSCDISPLAYEGSPECTATOR;
    };

    /**
     * Adds a custom icon to be drawn
     */
    case "AddCustomIcon" :
    {
        private ["_id", "_target", "_iconParams", "_background", "_conditionShow"];
        _id 		= _params param [0, "", [""]];
        _target		= _params param [1, objNull, [objNull, []]];
        _iconParams	= _params param [2, ["", [1,1,1,1], [0,0,0], 4.0, -0.7, 0, "", 2, 0.035, "PuristaLight", "center"], [[]]];
        _background	= _params param [3, [false, [1,1,1,0.5]], [[]]];
        _conditionShow	= _params param [4, { true }, [{}]];

        if (_id == "") exitWith
        {
            "AddCustomIcon: Unique ID can not be empty" call BIS_fnc_error;
        };

        if (["HasCustomIcon", [_id]] call SPEC) exitWith
        {
            ["AddCustomIcon: Unique ID (%1) already in use by another custom icon, no action taken", _id] call BIS_fnc_error;
        };

        private _list = ["GetCustomIcons"] call SPEC;

        // Add new custom icon to list
        _list pushBack [_id, _target, _iconParams, _background, _conditionShow];

        // Store data
        ["SetCustomIcons", _list] call SPEC;
    };

    /**
     * Removes a custom icon from being drawn
     */
    case "RemoveCustomIcon" :
    {
        private _id = _params param [0, "", [""]];
        private _index = ["GetCustomIconIndex", [_id]] call SPEC;

        // Make sure icon with such id actually exists
        if (_index < 0) exitWith
        {
            ["RemoveCustomIcon: Unique ID (%1) not found, there is no such custom icon registered", _id] call BIS_fnc_error;
        };

        private _list = ["GetCustomIcons"] call SPEC;

        // Delete icon entry
        _list deleteAt _index;

        // Store data
        ["SetCustomIcons", _list] call SPEC;
    };

    /**
     * Get's list of all custom icons to be drawn
     */
    case "GetCustomIcons" :
    {
        missionNamespace getVariable [VAR_CUSTOM_ICONS, []];
    };

    /**
     * Set's list of all custom icons to be drawn
     */
    case "SetCustomIcons" :
    {
        missionNamespace setVariable [VAR_CUSTOM_ICONS, _params];
    };

    /**
     * Whether icon with given id exists
     */
    case "HasCustomIcon" :
    {
        private _id = _params param [0, "", [""]];

        ["GetCustomIconIndex", [_id]] call SPEC >= 0;
    };

    /**
     * Get's the array index in which given icon data is at
     */
    case "GetCustomIconIndex" :
    {
        private _id = _params param [0, "", [""]];
        private _list 	= ["GetCustomIcons"] call SPEC;
        private _index	= -1;

        {
            private _idOther = _x param [0, "", [""]];

            if (_idOther == _id) exitWith
            {
                _index = _forEachIndex;
            };
        } forEach _list;

        _index;
    };

    /**
     * Get's list of all locations
     */
    case "GetLocations" :
    {
        missionNamespace getVariable [VAR_LOCATIONS, []];
    };

    /**
     * Get's location with matching id
     */
    case "GetLocationById" :
    {
        private _id = _params select 0;
        private _locations = missionNamespace getVariable [VAR_LOCATIONS, []];
        private _location = [];

        {
            if (_x select 0 == _id) exitWith
            {
                _location = _x;
            };
        } forEach _locations;

        _location;
    };

    /**
     * Whether given location id is already stored
     */
    case "IsLocationIdUsed" :
    {
        private _locations = missionNamespace getVariable [VAR_LOCATIONS, []];
        private _index = -1;

        {
            if (_x select 0 == _id) exitWith
            {
                _index = _forEachIndex;
            };
        } forEach _locations;

        if (_index != -1) then
        {
            true;
        }
        else
        {
            false;
        };
    };

    /**
     * Add's a new location
     */
    case "AddLocation" :
    {
        private ["_id", "_description", "_texture", "_cameraTransform", "_dirOverride"];
        _id 			= _params param [0, "", [""]];
        _name 			= _params param [1, "", [""]];
        _description 		= _params param [2, "", [""]];
        _texture		= _params param [3, "", [""]];
        _cameraTransform 	= _params param [4, [[], [], []], [[]]];
        _dirOverride		= _params param [5, [0, false], [[]]];

        if (_id != "" && !(["IsLocationIdUsed", [_id]] call SPEC)) then
        {
            private _locations = missionNamespace getVariable [VAR_LOCATIONS, []];

            if (_texture == "") then { _texture = "#(rgb,8,8,3)color(0,0,0,0)"; };

            _locations pushBack [_id, _name, _description, _texture, _cameraTransform, _dirOverride];
            missionNamespace setVariable [VAR_LOCATIONS, _locations];
        };
    };

    /**
     * Remove a location
     */
    case "RemoveLocation" :
    {
        private _id = _params param [0, "", [""]];
        private _locations = missionNamespace getVariable [VAR_LOCATIONS, []];
        private _index = -1;

        {
            if (_x select 0 == _id) exitWith
            {
                _index = _forEachIndex;
            };
        } forEach _locations;

        if (_index != -1) then
        {
            _locations deleteAt _index;
            missionNamespace setVariable [VAR_LOCATIONS, _locations];
        };
    };

    /**
     * Returns number of all spectator units in game
     */
    case "CountSpectators" :
    {
        private _count = 0;

        {
            if (_x isKindOf SPECTATOR_CLASS) then
            {
                _count = _count + 1;
            };
        } forEach allPlayers;

        _count;
    };

    /**
     * Issue error on unkown mode
     */
    default
    {
        ["Unknown mode: %1", _mode] call BIS_fnc_error;
    };
};
