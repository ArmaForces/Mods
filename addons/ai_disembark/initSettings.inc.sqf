
[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    LSTRING(DisplayName),
    false,
    1
] call CBA_fnc_addSetting;

[
    QGVAR(stayInImmobileChance),
    "SLIDER",
    [LSTRING(StayInImmobileChance), LSTRING(StayInImmobileChance_Description)],
    LSTRING(DisplayName),
    [0, 1, 0, 0, true],
    1
] call CBA_fnc_addSetting;
