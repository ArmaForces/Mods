[
    QGVAR(babel),
    "CHECKBOX",
    [LSTRING(Babel), LSTRING(Babel_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(perSideRadios),
    "CHECKBOX",
    [LSTRING(PerSideRadios), LSTRING(PerSideRadios_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(perSideChannelNames),
    "CHECKBOX",
    [LSTRING(PerSideChannelNames), LSTRING(PerSideChannelNames_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

#include "initSettingsChannelNames.sqf"
