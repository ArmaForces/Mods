#include "script_component.hpp"

if (EGVAR(common,aceFastroping)) then {
    [
        QGVAR(autoAdd),
        "CHECKBOX",
        [LSTRING(autoAdd), LSTRING(autoAdd_Description)],
        [LSTRING(DisplayName), QUOTE(COMPONENT)],
        true,
        true
    ] call CBA_fnc_addSetting;
};
