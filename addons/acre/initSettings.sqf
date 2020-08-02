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
