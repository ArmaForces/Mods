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
    QGVAR(allowUnconscious),
    "CHECKBOX",
    [LSTRING(AllowUnconscious), LSTRING(AllowUnconscious_Description)],
    [LSTRING(DisplayName), LSTRING(Unconscious)],
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;

[
    QGVAR(unconsciousDelay),
    "SLIDER",
    [LSTRING(UnconsciousDelay), LSTRING(UnconsciousDelay_Description)],
    [LSTRING(DisplayName), LSTRING(Unconscious)],
    [1, 300, 30, 0],
    1
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
    QGVAR(sidesUnconscious),
    "LIST",
    [LSTRING(Sides), LSTRING(Sides_Description)],
    [LSTRING(DisplayName), LSTRING(Unconscious)],
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
    QGVAR(civilianSideUnconscious),
    "CHECKBOX",
    [LSTRING(CivilianSide), LSTRING(CivilianSide_Description)],
    [LSTRING(DisplayName), LSTRING(Unconscious)],
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

[
    QGVAR(allowAIUnconscious),
    "CHECKBOX",
    [LSTRING(AllowAI), LSTRING(AllowAI_Description)],
    [LSTRING(DisplayName), LSTRING(Unconscious)],
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;

[
    QGVAR(freeCamera),
    "CHECKBOX",
    [LSTRING(FreeCamera), LSTRING(FreeCamera_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;

[
    QGVAR(freeCameraUnconscious),
    "CHECKBOX",
    [LSTRING(FreeCamera), LSTRING(FreeCamera_Description)],
    [LSTRING(DisplayName), LSTRING(Unconscious)],
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;

[
    QGVAR(TPPCamera),
    "CHECKBOX",
    [LSTRING(TPPCamera), LSTRING(TPPCamera_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;

[
    QGVAR(TPPCameraUnconscious),
    "CHECKBOX",
    [LSTRING(TPPCamera), LSTRING(TPPCamera_Description)],
    [LSTRING(DisplayName), LSTRING(Unconscious)],
    false,
    1,
    {[_this] call FUNC(restart)}
] call CBA_fnc_addSetting;
