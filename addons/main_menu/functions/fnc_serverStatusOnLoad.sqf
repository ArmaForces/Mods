#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afm_main_fnc_example
 *
 * Public: No
 */

params ["_ctrlGroup"];

if (getClientState == "NONE" && !is3DEN) exitWith {
    _ctrlGroup ctrlShow false;
};

private _ctrlText = _ctrlGroup controlsGroupCtrl 1000;

GVAR(text) = _ctrlText;

_ctrlGroup spawn {
    waitUntil {
        GVAR(text) ctrlSetText getClientState;
        GVAR(text) ctrlCommit 0;

        uiSleep 1;

        isNull _this;
    };
};
