[
	QGVAR(enabled), // Global var name
	"CHECKBOX", // Setting type
	[LSTRING(Enabled), LSTRING(Enabled_Description)], // Title, Tooltip
	LSTRING(DisplayName),
	true, // Extra params, depending on settings type
	true, // Is global
	{
		if (_this) exitWith {
			[] call FUNC(init);
		};
	}, // Init/Stop script
	false // Needs mission restart
] call CBA_Settings_fnc_init;

[
	QGVAR(showAllGroups), // Global var name
	"CHECKBOX", // Setting type
	[LSTRING(ShowAllGroups), LSTRING(ShowAllGroups_Description)], // Title, Tooltip
	LSTRING(DisplayName),
	true, // Extra params, depending on settings type
	true, // Is global
	{}, // Init/Stop script
	false // Needs mission restart
] call CBA_Settings_fnc_init;

[
	QGVAR(showUnconc), // Global var name
	"CHECKBOX", // Setting type
	[LSTRING(ShowUnconc), LSTRING(ShowUnconc_Description)], // Title, Tooltip
	LSTRING(DisplayName),
	false, // Extra params, depending on settings type
	true, // Is global
	{}, // Init/Stop script
	false // Needs mission restart
] call CBA_Settings_fnc_init;

[
	QGVAR(refreshRate), // Global var name
	"SLIDER", // Setting type
	[LSTRING(RefreshRate), LSTRING(RefreshRate_Description)], // Title, Tooltip
	LSTRING(DisplayName),
	[1, 600, 5, 0], // Extra params, depending on settings type
	true, // Is global
	{}, // Init/Stop script
	false // Needs mission restart
] call CBA_Settings_fnc_init;

[
	QGVAR(GPS), // Global var name
	"CHECKBOX", // Setting type
	[LSTRING(GPS), LSTRING(GPS_Descrption)], // Title, Tooltip
	LSTRING(DisplayName),
	false, // Extra params, depending on settings type
	true, // Is global
	{}, // Init/Stop script
	false // Needs mission restart
] call CBA_Settings_fnc_init;
