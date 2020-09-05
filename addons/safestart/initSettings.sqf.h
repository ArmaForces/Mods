
if (EGVAR(common,aceSafemode)) then {
    [
        QGVAR(startLocked),
        "CHECKBOX",
        [LSTRING(StartLocked), LSTRING(StartLocked_Description)],
        LSTRING(DisplayName),
        true,
        2
    ] call CBA_fnc_addSetting;
};
