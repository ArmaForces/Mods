
[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(Enabled), LLSTRING(Enabled_Description)],
    LLSTRING(DisplayName),
    true,
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(allowADS),
    "CHECKBOX",
    [LLSTRING(AllowADS), LLSTRING(AllowADS_Description)],
    LLSTRING(DisplayName),
    true
] call CBA_fnc_addSetting;
