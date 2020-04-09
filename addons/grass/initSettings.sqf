[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Forced), LSTRING(Forced_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(toggle)}
] call CBA_fnc_addSetting;
