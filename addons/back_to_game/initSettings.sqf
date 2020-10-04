[
    QGVAR(enableAddon),
    "CHECKBOX",
    [LSTRING(enableAddon), LSTRING(enableAddon_Description)],
    LSTRING(DisplayName),
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(teleportToLeader),
    "CHECKBOX",
    [LSTRING(TeleportToLeader), LSTRING(TeleportToLeader_Description)],
    LSTRING(DisplayName),
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(teleportToVehicle),
    "CHECKBOX",
    [LSTRING(TeleportToVehicle), LSTRING(TeleportToVehicle_Description)],
    LSTRING(DisplayName),
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(removeBody),
    "CHECKBOX",
    [LSTRING(RemoveBody), LSTRING(RemoveBody_Description)],
    LSTRING(DisplayName),
    true,
    true
] call CBA_fnc_addSetting;
