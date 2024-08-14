#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle chat message.
 *
 * Arguments:
 * 0: Channel <NUMBER>
 * 1: Owner id of message sender <NUMBER>
 * 2: Display of whom sent the message <STRING>
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

params [["_channel", -1], ["_ownerSender", -1], ["_from", ""], ["_text", ""], ["_sender", objNull]];
if (_text == "") exitWith {false};

if (GVAR(allowGlobalChat) || {!(_channel in RESTRICTED_CHANNELS)}) exitWith {false};

if (_ownerSender call EFUNC(common,isOwnerAdmin)) exitWith {
    [format ["(ADMIN) %1", _from], _text]
};

if (!isNull getAssignedCuratorLogic _sender) exitWith {
    [format ["(ZEUS) %1", _from], _text]
};

if (_sender isEqualTo player) exitWith {
    systemChat LLSTRING(AllowGlobalChat_Warning);
    playSound "3DEN_notificationWarning";

    false // return, player always sees his own message
};

isNull getAssignedCuratorLogic player // show all messages to zeus
&& !(clientOwner call EFUNC(common,isOwnerAdmin)) // show all messages to admin
