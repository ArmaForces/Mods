[
    QGVAR(highJogCoefEnabled),
    "CHECKBOX",
    [LSTRING(High_Jog_Coef_Enabled), LSTRING(High_Jog_Coef_Enabled_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(toggleHighJogFactor)}
] call CBA_fnc_addSetting;

[
    QGVAR(highJogCoef),
    "SLIDER",
    [LSTRING(High_Jog_Coef), LSTRING(High_Jog_Coef_Description)],
    LSTRING(DisplayName),
    [0, 1, 0.95, 2],
    1
] call CBA_fnc_addSetting;
