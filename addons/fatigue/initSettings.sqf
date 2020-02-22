[
    QGVAR(highJogCoefEnabled),
    "CHECKBOX",
    [LSTRING(High_Jog_Coef_Enabled), LSTRING(High_Jog_Coef_Enabled_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {[_this] call FUNC(toggleHighJogFactor)}
] call CBA_fnc_addSetting;
