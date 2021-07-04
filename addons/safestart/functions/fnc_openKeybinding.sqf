#include "script_component.hpp"
/*
 * Author: veteran29
 * Opens keyboard action rebinding screen.
 *
 * Arguments:
 * 0: Translation key for keybind <STRING> (Default: STR_USRACT_THROW)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["STR_USRACT_THROW"] call afm_safestart_fnc_openKeybinding
 *
 * Public: No
 */

#define CONTROLS_DISPLAY        (findDisplay 4)
#define CTRL_CONTROLS           303
#define CTRL_KEYBIND_CATEGORY   108
#define CTRL_KEYBIND_KEYS       102

params [
    ["_keybindingKey", "STR_USRACT_THROW", [""]]
];

private _interruptDisplay = MISSION_DISPLAY createDisplay (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);
private _controlsCtrl = _interruptDisplay displayCtrl CTRL_CONTROLS;
ctrlActivate _controlsCtrl;

[{!isNull CONTROLS_DISPLAY}, {
    private _categoryCombo = CONTROLS_DISPLAY displayCtrl CTRL_KEYBIND_CATEGORY;
    _categoryCombo lbSetCurSel 1;

    private _keysList = CONTROLS_DISPLAY displayCtrl CTRL_KEYBIND_KEYS;

    private _localizedKey = localize _this;
    for "_idx" from 0 to (lbSize _keysList - 1) do {
        if (_keysList lbText _idx == _localizedKey) exitWith {
            _keysList lbSetCurSel _idx;
        };
    };
}, _keybindingKey] call CBA_fnc_waitUntilAndExecute;

nil
