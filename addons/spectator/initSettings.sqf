[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(toggle)}
] call CBA_fnc_addSetting;

[
    QGVAR(sides),
    "LIST",
    [LSTRING(Sides), LSTRING(Sides_Description)],
    LSTRING(DisplayName),
    [[0, 1, 2], [LSTRING(Friendly), LSTRING(Own), "str_all_voices"], 0],
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;

[
    QGVAR(civilianSide),
    "CHECKBOX",
    [LSTRING(CivilianSide), LSTRING(CivilianSide_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;

[
    QGVAR(allowAI),
    "CHECKBOX",
    [LSTRING(AllowAI), LSTRING(AllowAI_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;
