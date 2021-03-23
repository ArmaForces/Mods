[
    QGVAR(enabled),
    "CHECKBOX",
    [ELSTRING(common,Enabled), ELSTRING(common,Enabled_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(babel),
    "CHECKBOX",
    [LSTRING(Babel), LSTRING(Babel_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(startBppVolume),
    "SLIDER",
    [LSTRING(StartBppVolume), LSTRING(StartBppVolume_Description)],
    LSTRING(DisplayName),
    [0, 4, DEFAULT_BPP_VOLUME, 0],
    1
] call CBA_fnc_addSetting;

[
    QGVAR(startLeaderVolume),
    "SLIDER",
    [LSTRING(StartLeaderVolume), LSTRING(StartLeaderVolume_Description)],
    LSTRING(DisplayName),
    [0, 4, DEFAULT_LEADER_VOLUME, 0],
    1
] call CBA_fnc_addSetting;

[
    QGVAR(perSideRadios),
    "CHECKBOX",
    [LSTRING(PerSideRadios), LSTRING(PerSideRadios_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(perSideChannelNames),
    "CHECKBOX",
    [LSTRING(PerSideChannelNames), LSTRING(PerSideChannelNames_Description)],
    LSTRING(DisplayName),
    false,
    1,
    {},
    true
] call CBA_fnc_addSetting;

if (EGVAR(common,aceArsenal)) then {
    [
        QGVAR(addArsenalCategory),
        "CHECKBOX",
        LLSTRING(AddArsenalCategory),
        LSTRING(DisplayName),
        true,
        false,
        {},
        true
    ] call CBA_fnc_addSetting;
};

#include "initSettingsChannelNames.sqf"
