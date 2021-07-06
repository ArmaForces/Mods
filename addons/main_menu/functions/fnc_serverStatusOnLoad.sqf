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

diag_log "asdf";

params ["_ctrlGroup"];

private _ctrlText = _ctrlGroup controlsGroupCtrl 1000;

diag_log _ctrlText;

GVAR(text) = _ctrlText;

_ctrlGroup spawn {
    waitUntil {
        diag_log getClientState;
        diag_log GVAR(text);

        GVAR(text) ctrlSetText getClientState;
        GVAR(text) ctrlCommit 0;

        uiSleep 1;

        isNull _this;
    };
};
