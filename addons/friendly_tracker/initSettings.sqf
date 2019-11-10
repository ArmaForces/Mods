[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    LSTRING(DisplayName),
    true,
    true,
    {
        if (_this) exitWith {
            [] call FUNC(init);
        };
    }
] call CBA_fnc_addSetting;

[
    QGVAR(showAllGroups),
    "CHECKBOX",
    [LSTRING(ShowAllGroups), LSTRING(ShowAllGroups_Description)],
    LSTRING(DisplayName),
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(showGroups),
    "CHECKBOX",
    [LSTRING(showGroups), LSTRING(showGroups_Description)],
    LSTRING(DisplayName),
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showUnconc),
    "CHECKBOX",
    [LSTRING(ShowUnconc), LSTRING(ShowUnconc_Description)],
    LSTRING(DisplayName),
    false,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(showVehicle),
    "CHECKBOX",
    [LSTRING(showVehicle), LSTRING(showVehicle_Description)],
    LSTRING(DisplayName),
    false,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(refreshRate),
    "SLIDER",
    [LSTRING(RefreshRate), LSTRING(RefreshRate_Description)],
    LSTRING(DisplayName),
    [1, 600, 5, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(GPS),
    "CHECKBOX",
    [LSTRING(GPS), LSTRING(GPS_Descrption)],
    LSTRING(DisplayName),
    false,
    true
] call CBA_fnc_addSetting;
