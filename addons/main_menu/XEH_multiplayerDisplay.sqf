#include "script_component.hpp"
/*
 * Author: veteran29
 * Handles initialization of multiplayer display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Display name <STRING>
 *
 * Return Value:
 * None
 *
 */

params ["_display", "_displayName"];

// if no world is loaded missionNamespace will be empty
// copy logging function from uiNamespace
if (isNil "CBA_fnc_log") then {
    CBA_fnc_log = uiNamespace getVariable QUOTE(CBA_fnc_log);
};

TRACE_2("Multiplayer display init",_display,_displayName);

// base offset values
ctrlPosition (_display displayCtrl IDC_CANCEL) params ["_baseX", "_baseY", "_offsetW", "_offsetH"];
ctrlPosition MP_PWD_BORDER_CONTROL params ["_boundX", "", "_boundW"];
private _rightBorder = _boundX + _boundW;


private _passwordInput  = _display ctrlCreate ["RscEdit", -1];
private _passwordButton = _display ctrlCreate ["RscButtonMenu", -1];

#define MP_PWD_INPUT_X (_baseX + _offsetW + (0.2 * GUI_GRID_W))

_passwordInput ctrlSetPosition [
    MP_PWD_INPUT_X,
    _baseY,
    _rightBorder - MP_PWD_INPUT_X - _offsetW,
    _offsetH //+ pixelH
];
_passwordButton ctrlSetPosition [
    _rightBorder - _offsetW,
    _baseY,
    _offsetW,
    _offsetH
];
_passwordInput ctrlSetBackgroundColor [0, 0, 0, 0.75];
_passwordInput ctrlSetText LLSTRING(PasswordPlaceholder);
_passwordInput ctrlEnable !IS_ADMIN;
_passwordInput ctrlCommit 0;

_passwordButton ctrlSetText ([LLSTRING(AdminLogin), LLSTRING(AdminLogout)] select IS_ADMIN);
_passwordButton ctrlCommit 0;

_passwordButton setVariable [QGVAR(passwordInput), _passwordInput];
_passwordButton ctrlAddEventHandler ["ButtonClick", {
    params ["_passwordButton"];
    private _passwordInput = _passwordButton getVariable QGVAR(passwordInput);

    // prevent spamming of the button
    _passwordButton ctrlEnable false;
    _passwordInput ctrlEnable false;

    if (IS_ADMIN) then {
        INFO("Logging out from admin");

        serverCommand "#logout";

        // wait until logged out or restore state on timeout
        [_passwordInput, _passwordButton] spawn {
            params ["_passwordInput", "_passwordButton"];

            private _timeout = diag_tickTime + 10;
            waitUntil {!IS_ADMIN || {diag_tickTime > _timeout}};

            if (!IS_ADMIN) exitWith {
                INFO("Logged out from admin");

                _passwordButton ctrlSetText LLSTRING(AdminLogin);
                _passwordButton ctrlEnable true;
                _passwordInput ctrlEnable true;
            };

            WARNING("Admin log out timeout");
            _passwordButton ctrlEnable true;
        };
    } else {
        INFO("Logging in as admin");

        serverCommand format ["#login %1", ctrlText _passwordInput];
        _passwordInput ctrlSetText LLSTRING(PasswordPlaceholder);

        // wait until logged in or restore state on timeout
        [_passwordInput, _passwordButton] spawn {
            params ["_passwordInput", "_passwordButton"];

            private _timeout = diag_tickTime + 10;
            waitUntil {IS_ADMIN || {diag_tickTime > _timeout}};

            if (IS_ADMIN) exitWith {
                INFO("Logged in as admin");

                _passwordButton ctrlSetText LLSTRING(AdminLogout);
                _passwordButton ctrlEnable true;
            };

            WARNING("Admin log in timeout/Wrong password");
            _passwordButton ctrlEnable true;
            _passwordInput ctrlEnable true;
        };
    };
}];

nil
