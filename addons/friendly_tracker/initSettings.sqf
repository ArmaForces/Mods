[
    QGVAR(enabled), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [LSTRING(Enabled), LSTRING(Enabled_Description)], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    LSTRING(DisplayName), // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType. <ANY>
    true, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    {
		if (_this) exitWith {
			[] call FUNC(init);
		};
	} // Script to execute when setting is changed. (optional) <CODE>
] call CBA_fnc_addSetting;

[
    QGVAR(showAllGroups), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [LSTRING(ShowAllGroups), LSTRING(ShowAllGroups_Description)], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    LSTRING(DisplayName), // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType. <ANY>
    true // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
] call CBA_fnc_addSetting;

[
    QGVAR(showUnconc), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [LSTRING(ShowUnconc), LSTRING(ShowUnconc_Description)], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    LSTRING(DisplayName), // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType. <ANY>
    true // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
] call CBA_fnc_addSetting;

[
    QGVAR(refreshRate), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [LSTRING(RefreshRate), LSTRING(RefreshRate_Description)], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    LSTRING(DisplayName), // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 600, 5, 0], // Extra properties of the setting depending of _settingType. <ANY>
    true // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
] call CBA_fnc_addSetting;

[
    QGVAR(GPS), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [LSTRING(GPS), LSTRING(GPS_Descrption)], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    LSTRING(DisplayName), // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType. <ANY>
    true // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
] call CBA_fnc_addSetting;
