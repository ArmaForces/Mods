#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function returns free curator module or creates new module if no free module available.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: Free curator module <OBJECT>
 *
 * Example:
 * call afm_curator_fnc_getFreeCuratorModule
 *
 * Public: No
 */

private _freeCuratorID = GVAR(curators) findIf {isNull getAssignedCuratorUnit _x};
if (_freeCuratorID isEqualTo -1) exitWith {
    call FUNC(createCuratorModule)
};

GVAR(curators) select _freeCuratorID
