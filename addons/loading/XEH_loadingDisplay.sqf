#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
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
    case ([] call EFUNC(common,easterDate) select 1): {
        _picture ctrlSetText QPATHTOF(ui\logo_256_easter_ca.paa);
    };
    default {
        _picture ctrlSetText QPATHTOF(ui\logo_256_ca.paa);
    };
};
_picture ctrlCommit 0;

private _ctrlBg = _display displayctrl IDC_LOADINGSTART_CUSTOM_BG;
private _backgroundCfg = uiNamespace getVariable [QGVAR(backgroundCfg), configNull];
if (isNull _backgroundCfg) then {
    _backgroundCfg = selectRandom ("true" configClasses (CFG_LOADING_SCREEN >> "Backgrounds"));
    uiNamespace setVariable [QGVAR(backgroundCfg), _backgroundCfg];
    TRACE_1("Loading background",_backgroundCfg);
};

_ctrlBg ctrlSetText getText (_backgroundCfg >> "path");
_ctrlBg ctrlCommit 0;

private _ctrlGrpLoadingStart = _display displayctrl IDC_LOADINGSTART_LOADINGSTART;
private _loadingLabel = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrpLoadingStart];
_loadingLabel ctrlSetPosition [0, 0, 1, 1];
_loadingLabel ctrlSetStructuredText parseText ([
    '<t size="1.17" shadow="2">',
    format [LLSTRING(Author), getText (_backgroundCfg >> "author")],
    '</t>'
] joinString "");
_loadingLabel ctrlCommit 0;

_loadingLabel ctrlSetPosition [
    safeZoneW - ctrlTextWidth _loadingLabel,
    0,
    ctrlTextWidth _loadingLabel, ctrlTextHeight _loadingLabel
];
_loadingLabel ctrlCommit 0;

nil
