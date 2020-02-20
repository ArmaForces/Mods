[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(toggle)}
] call CBA_fnc_addSetting;
