#include "script_component.hpp"
/*
 * Author: veteran29
 * Show warning about dangerous throw keybind.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

[
    LSTRING(Warning),
    [
        [LSTRING(Warn_GrenadeHeader), 1.5],
        LSTRING(Warn_GrenadeLine_1),
        LSTRING(Warn_GrenadeLine_2)
    ]
] call afm_common_fnc_modal;

nil
