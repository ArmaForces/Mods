#include "script_component.hpp"
/*
 * Author: veteran29
 * Warns the player that he has default bind "G" to throw grenade.
 * It's considered good pratice to rebind it ;-)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!(call FUNC(grenadeBindCondition))) exitWith { nil };

[{!isNull MISSION_DISPLAY}, {
    private _script = [] spawn {

        private _warnMessage = if (EGVAR(common,aceThrowing)) then {
            LLSTRING(ThrowBind_Warn)
        } else {
            LLSTRING(ThrowBind_WarnNoACEThrowing)
        };

        private _confirm = [
            parseText _warnMessage,
            "Dangerous bind!",
            "Rebind",
            LLSTRING(ThrowBind_Deny)
        ] call BIS_fnc_guiMessage;

        // Open rebiding screen
        if (_confirm) exitWith {
            ["STR_USRACT_THROW"] call FUNC(openKeybinding);
        };

        // Ask for second confirmation
        private _confirm = [
            parseText LLSTRING(ThrowBind_Warn2),
            "Dangerous bind!",
            "Rebind",
            LLSTRING(ThrowBind_Confirm)
        ] call BIS_fnc_guiMessage;

        // Open rebiding screen
        if (_confirm) exitWith {
            ["STR_USRACT_THROW"] call FUNC(openKeybinding);
        };

        // Do not ask again
        profileNamespace setVariable [QGVAR(grenadeConfirmed), true];
        saveProfileNamespace;
    };
}] call CBA_fnc_waitUntilAndExecute;

nil
