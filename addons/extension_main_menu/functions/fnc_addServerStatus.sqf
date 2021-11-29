#include "script_component.hpp"
/*
 * Author: veteran29
 * Inject server status into main menu spotlight
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define IDC_MAIN_SPOTLIGHT_GROUP_1 1020

if (uiNamespace getVariable [QGVAR(serverStatus), false]) exitWith {};

[] spawn {
    uiNamespace setVariable [QGVAR(serverStatus), true];

    private _display = findDisplay 0;
    private _ctrlSpotlightMain = _display displayctrl IDC_MAIN_SPOTLIGHT_GROUP_1;
    TRACE_1("Adding server status text",_ctrlSpotlightMain);

    // get first spotlight
    private _ctrlGrpSpotlight = (_ctrlSpotlightMain getVariable "spotlights") param [0, controlNull];

    ctrlPosition _ctrlGrpSpotlight params ["_x", "_y", "_w", "_h"];

    private _ctrlText = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrpSpotlight];
    _ctrlText ctrlSetPosition [0, 0, _w, _h];
    _ctrlText ctrlCommit 0;

    // restore spotlight on hover functionality
    {
        _ctrlText ctrlAddEventHandler [_x, {with uiNamespace do {['spotlightEnter',_this,''] call RscDisplayMain_script}}];
    } foreach ["mouseEnter", "setFocus"];
    {
        _ctrlText ctrlAddEventHandler [_x, {with uiNamespace do {['spotlightExit',_this,''] call RscDisplayMain_script}}];
    } foreach ["mouseExit", "killFocus"];

    uiNamespace setVariable [QGVAR(ctrlServerStatus), _ctrlText];
    [] call FUNC(updateServerStatus);

};

nil
