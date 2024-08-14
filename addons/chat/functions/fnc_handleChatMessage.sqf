#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle chat message.
 *
 * Arguments:
 * 0: Channel <NUMBER>
 * 1: N/A
 * 2: N/A
 * 3: Sent text <STRING>
 * 4: Person sending the message <OBJECT>
 *
 * Return Value:
 * Should message be blocked <BOOL>
 *
 * Example:
 * call afm_chat_fnc_handleChatMessage
 *
 * Public: No
 */

params [["_channel", -1], "", ["_from", ""], ["_text", ""], ["_sender", objNull]];
if (_text == "") exitWith {false};

if (GVAR(allowGlobalChat) || {!(_channel in [0, 1])}) exitWith {false};

if (_sender isEqualTo player) exitWith {
    systemChat LLSTRING(AllowGlobalChat_Warning);
    playSound "3DEN_notificationWarning";

    false // return, player always sees his own message
};

if (_sender getVariable [QEGVAR(common,isAdmin), false]) exitWith {
    [format ["(ADMIN) %1", _from], _text]
};

if (!isNull getAssignedCuratorLogic _sender) exitWith {
    [format ["(ZEUS) %1", _from], _text]
};

isNull getAssignedCuratorLogic player // show all messages to zeus
&& !(player getVariable [QEGVAR(common,isAdmin), false]) // show all messages to admin
