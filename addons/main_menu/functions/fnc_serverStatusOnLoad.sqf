#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle initialization of server status panel.
 *
 * Arguments:
 * 0: Server status panel control group <CONTROL>
 *
 * Return Value:
 * None
 *
 *
 * Public: No
 */

params ["_ctrlGroup"];

TRACE_1("Server status panel init",_ctrlGroup);

if (getClientState == "NONE" && !is3DEN) exitWith {
    LOG("Not joining, hidding status panel");

    _ctrlGroup ctrlShow false;
};

private _ctrlText = _ctrlGroup controlsGroupCtrl 1000;
private _ctrlLoginInput = _ctrlGroup controlsGroupCtrl 1001;
private _ctrlLoginButton = _ctrlGroup controlsGroupCtrl 1002;
private _ctrlMissionsButton = _ctrlGroup controlsGroupCtrl 1003;

_ctrlMissionsButton ctrlEnable IS_ADMIN;

// Server status update loop
_ctrlText spawn {

    private _dots = "";

    waitUntil {
        if (getClientStateNumber < 3) then {
            if (count _dots > 3) then {
                _dots = "";
            };

            _this ctrlSetText (["Joining", _dots] joinString "");
            _dots = [_dots, "."] joinString "";
        } else {
            _this ctrlSetText "Connected to server";
        };

        uiSleep 1;

        isNull _this;
    };
};

[_ctrlLoginInput, _ctrlLoginButton, _ctrlMissionsButton] call FUNC(addMultiplayerButtonsLogic);

nil
