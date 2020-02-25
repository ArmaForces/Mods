#include "script_component.hpp"
/*
 * Author: <author>
 * Create local player owned marker.
 *
 * Arguments:
 * 0: Marker position <ARRAY, OBJECT>
 * 1: Channel to create marker on <STRING, NUMBER>
 *
 * Return Value:
 * Marker ID, empty string if could not create <STRING>
 *
 * Example:
 * [player ,"global"] call afm_common_fnc_createPlayerMarker
 *
 * Public: No
 */

#define CHANNEL_NAMES   ["global", "side", "command", "group", "vehicle", "direct"]
#define CHANNEL_MIN     0
#define CHANNEL_MAX     5

params [
    ["_position", [0,0,0], [[], objNull]],
    ["_channel", 1, [0, ""]]
];

if (_channel isEqualType "") then {
    _channel = CHANNEL_NAMES find _channel;
};

if (_channel < CHANNEL_MIN || {_channel > CHANNEL_MAX}) exitWith {
    ERROR_1("Invalid channel given! - %1",_channel);

    "" // return
};

// create marker id
private _id = format ["%1_%2", QUOTE(PREFIX), GVAR(playerMarkerIdx)];
GVAR(playerMarkerIdx) = GVAR(playerMarkerIdx) + 1;

private _markerId = format ["_USER_DEFINED #%1/%2/%3", GVAR(clientId), _id, _channel];

createMarker [_markerId, _position] // return
