#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function toggles custom high jog duty factor.
 *
 * Arguments:
 * 0: Enable custom duty factor <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call afm_fatigue_fnc_toggleHighJogFactor
 *
 * Public: No
 */

params ["_enable"];

if (!EGVAR(common,aceFatigue)) exitWith {};

if (_enable) then {
    [QGVAR(high_jog_coef), {
        private _isHighJog = (animationState _this) select [9, 3] == "tac";
        if (_isHighJog) exitWith {GVAR(highJogCoef)};
        1
    }] call ACEFUNC(advanced_fatigue,addDutyFactor);
} else {
    [QGVAR(high_jog_coef)] call ACEFUNC(advanced_fatigue,removeDutyFactor);
};

nil
