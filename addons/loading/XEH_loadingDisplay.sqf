#include "script_component.hpp"
/*
 * Author: veteran29
 * Initializes loading screen display and adds ArmaForces branding.
 *
 * Arguments:
 * 0: Loading display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display"];

TRACE_1("Loading screen",_display);

private _size = 0.1;
private _width = _size * safezoneW;
private _height = _size * safezoneH * (getResolution select 4);

private _picture = _display ctrlCreate ["RscPicture", -1];
_picture ctrlSetPosition [
    safezoneX,
    safezoneY + safeZoneH - _height,
    _width, _height
];

switch (systemTime select 1) do {
    case 10: {
        _picture ctrlSetText QPATHTOF(ui\logo_256_oct_ca.paa);
    };
    case 12: {
        _picture ctrlSetText QPATHTOF(ui\logo_256_dec_ca.paa);
    };
    // case TODO_EASTER: {
    //     _picture ctrlSetText QPATHTOF(ui\logo_256_easter_ca.paa);
    // };
    default {
        _picture ctrlSetText QPATHTOF(ui\logo_256_ca.paa);
    };
};
_picture ctrlCommit 0;

private _ctrlBg = _display displayctrl IDC_LOADINGSTART_CUSTOM_BG;
private _background = uiNamespace getVariable [QGVAR(background), ""];
if (_background == "") then {
    _background = format [QPATHTOF(ui\loading\%1_co.paa), floor random 11];
    uiNamespace setVariable [QGVAR(background), _background];
    TRACE_1("Loading background",_background);
};

_ctrlBg ctrlSetText _background;
_ctrlBg ctrlCommit 0;

nil
