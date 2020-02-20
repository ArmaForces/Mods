#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function starts spectator for given player
 *
 * Arguments:
 * 0: player unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call afm_spectator_fnc_start
 *
 * Public: No
 */

params [["_player", player]];

if (!(local _player)) exitWith {[QGVAR(start), _this, _player] call CBA_fnc_targetEvent};

if (["IsInitialized"] call BIS_fnc_EGSpectator) exitWith {WARNING("Spectator already initialized!")};

// Determine spectator parameters based on player consciousness
private _unconscious = [player] call EFUNC(common,isUnconscious);

private _sides = [GVAR(sides), GVAR(sidesUnconscious)] select _unconscious;
private _civilianSide = [GVAR(civilianSide), GVAR(civilianSideUnconscious)] select _unconscious;
private _allowAI = [GVAR(allowAI), GVAR(allowAIUnconscious)] select _unconscious;
private _freeCamera = [GVAR(freeCamera), GVAR(freeCameraUnconscious)] select _unconscious;
private _TPPCamera = [GVAR(TPPCamera), GVAR(TPPCameraUnconscious)] select _unconscious;

// Determine sides available for spectating
private _whitelistedSides = switch _sides do {
    // Friendly sides spectator
    case 0: {playerSide call BIS_fnc_friendlySides};
    // Player side spectator
    case 1: {[playerSide]};
    // All sides spectator
    case 2: {[WEST, INDEPENDENT, EAST]};
    default {playerSide call BIS_fnc_friendlySides};
};

if (_civilianSide) then {
    _whitelistedSides pushBack CIVILIAN;
};

// Start spectator
["Initialize", [player, _whitelistedSides, _allowAI, _freeCamera, _TPPCamera, true, true, true, true, true]] call BIS_fnc_EGSpectator;
WARNING("Starting spectator!");
