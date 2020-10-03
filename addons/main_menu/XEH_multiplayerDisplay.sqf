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

TRACE_2("Multiplayer display init",_display,_displayName);

// base offset values
ctrlPosition (_display displayCtrl IDC_CANCEL) params ["_baseX", "_baseY", "_offsetW", "_offsetH"];
ctrlPosition MP_PWD_BORDER_CONTROL params ["_boundX", "", "_boundW"];
private _rightBorder = _boundX + _boundW;

/*
    Create controls
*/
private _passwordInput  = _display ctrlCreate ["RscEdit", -1];
private _passwordButton = _display ctrlCreate ["RscButtonMenu", -1];
private _missionsButton = _display ctrlCreate ["RscButtonMenu", -1];

#define BUTTON_SPACING (0.1 * GUI_GRID_W)
#define BUTTON_W _offsetW
#define MP_PWD_INPUT_X (_baseX + BUTTON_W * 2 + (2 * BUTTON_SPACING))

_missionsButton ctrlSetPosition [
    _baseX + BUTTON_W + BUTTON_SPACING,
    _baseY,
    BUTTON_W,
    _offsetH
];
_missionsButton ctrlEnable (_displayName != 'RscDisplayRemoteMissions') && {IS_ADMIN};
_missionsButton ctrlSetText LLSTRING(Missions);
_missionsButton ctrlCommit 0;

_passwordInput ctrlSetPosition [
    MP_PWD_INPUT_X,
    _baseY,
    _rightBorder - MP_PWD_INPUT_X - BUTTON_W - BUTTON_SPACING,
    _offsetH //+ pixelH
];
_passwordButton ctrlSetPosition [
    _rightBorder - BUTTON_W,
    _baseY,
    BUTTON_W,
    _offsetH
];
_passwordInput ctrlSetBackgroundColor [0, 0, 0, 0.75];
_passwordInput ctrlSetText LLSTRING(PasswordPlaceholder);
_passwordInput ctrlEnable !IS_ADMIN;
_passwordInput ctrlCommit 0;

_passwordButton ctrlSetText ([LLSTRING(AdminLogin), LLSTRING(AdminLogout)] select IS_ADMIN);
_passwordButton ctrlCommit 0;

/*
    Init logic
*/
_missionsButton ctrlAddEventHandler ["ButtonClick", {
    params ["_missionsButton"];
    _missionsButton ctrlEnable false;
    serverCommand "#missions";
}];

_passwordButton setVariable [QGVAR(passwordInput), _passwordInput];
_passwordButton setVariable [QGVAR(missionsButton), _missionsButton];
_passwordButton ctrlAddEventHandler ["ButtonClick", {
    params ["_passwordButton"];
    private _passwordInput = _passwordButton getVariable QGVAR(passwordInput);
    private _missionsButton = _passwordButton getVariable QGVAR(missionsButton);

    // prevent spamming of the button
    _passwordButton ctrlEnable false;
    _passwordInput ctrlEnable false;
    _missionsButton ctrlEnable false;

    if (IS_ADMIN) then {
        INFO("Logging out from admin");

        serverCommand "#logout";

        // wait until logged out or restore state on timeout
        [_passwordInput, _passwordButton, _missionsButton] spawn {
            with uiNamespace do {
                params ["_passwordInput", "_passwordButton", "_missionsButton"];

                private _timeout = diag_tickTime + 10;
                waitUntil {!IS_ADMIN || {diag_tickTime > _timeout}};

                if (!IS_ADMIN) exitWith {
                    INFO("Logged out from admin");

                    _missionsButton ctrlEnable false;
                    _passwordButton ctrlSetText LLSTRING(AdminLogin);
                    _passwordButton ctrlEnable true;
                    _passwordInput ctrlEnable true;
                };

                WARNING("Admin log out timeout");
                _passwordButton ctrlEnable true;
                _missionsButton ctrlEnable true;
            };
        };
    } else {
        INFO("Logging in as admin");

        serverCommand format ["#login %1", ctrlText _passwordInput];
        _passwordInput ctrlSetText LLSTRING(PasswordPlaceholder);

        // wait until logged in or restore state on timeout
        [_passwordInput, _passwordButton, _missionsButton] spawn {
            with uiNamespace do {
                params ["_passwordInput", "_passwordButton", "_missionsButton"];

                private _timeout = diag_tickTime + 10;
                waitUntil {IS_ADMIN || {diag_tickTime > _timeout}};

                if (IS_ADMIN) exitWith {
                    INFO("Logged in as admin");

                    _missionsButton ctrlEnable true;
                    _passwordButton ctrlSetText LLSTRING(AdminLogout);
                    _passwordButton ctrlEnable true;
                };

                WARNING("Admin log in timeout/Wrong password");
                _missionsButton ctrlEnable false;
                _passwordButton ctrlEnable true;
                _passwordInput ctrlEnable true;
            };
        };
    };
}];

_passwordInput ctrlAddEventHandler ["SetFocus", {
    params ["_input"];

    if (ctrlText _input == LLSTRING(PasswordPlaceholder)) then {
        _input ctrlSetText "";
    };
}];

_passwordInput ctrlAddEventHandler ["KillFocus", {
    params ["_input"];

    if (ctrlText _input == "") then {
        _input ctrlSetText LLSTRING(PasswordPlaceholder);
    };
}];

nil
