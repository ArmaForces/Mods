#include "script_component.hpp"
/*
 * Author: veteran29
 * onLoad handler for modal
 *
 * Arguments:
 * 0: Modal display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display"];

uiNamespace setVariable [QGVAR(ModalDisplay), _display];

nil
