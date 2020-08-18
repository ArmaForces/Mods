[
    QGVAR(enabled),
    "CHECKBOX",
    [ELSTRING(common,Enabled), ELSTRING(common,Enabled_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

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

if (EGVAR(common,aceArsenal)) then {
    [
        QGVAR(addArsenalCategory),
        "CHECKBOX",
        LLSTRING(AddArsenalCategory),
        LSTRING(DisplayName),
        true,
        false,
        {},
        true
    ] call CBA_fnc_addSetting;
};
