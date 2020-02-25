
if (EGVAR(common,aceTagging)) then {
    [
        QGVAR(enabled),
        "CHECKBOX",
        [LSTRING(Enabled), LSTRING(Enabled_Description)],
        LSTRING(DisplayName),
        true,
        true
    ] call CBA_fnc_addSetting;
};
