#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle chat message.
 *
 * Arguments:
 * 0: ? <?>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#ifdef DEBUG_MODE_FULL
    #define IS_ADMIN false
#endif

params [["_channel", -1], "", "", "", ["_person", objNull]];

if (!(_channel in GVAR(blockedChannels)) || {IS_ADMIN || {!isNull getAssignedCuratorLogic player}}) exitWith {false};

if (_person isEqualTo player) exitWith {
    systemChat "Global and side chat have been disabled, only admins/zeus will see your message!";
    playSound "3DEN_notificationWarning";

    false // return, show sent message
};

true // return, block message
