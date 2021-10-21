#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(ace) = IS_MOD_LOADED(ace_common);
GVAR(aceArsenal) = IS_MOD_LOADED(ace_arsenal);
GVAR(aceFatigue) = IS_MOD_LOADED(ace_advanced_fatigue);
GVAR(aceFastroping) = IS_MOD_LOADED(ace_fastroping);
GVAR(aceFinger) = IS_MOD_LOADED(ace_finger);
GVAR(aceHearing) = IS_MOD_LOADED(ace_hearing);
GVAR(aceInteractMenu) = IS_MOD_LOADED(ace_interact_menu);
GVAR(aceMedical) = IS_MOD_LOADED(ace_medical_engine);
GVAR(aceSafemode) = IS_MOD_LOADED(ace_safemode);
GVAR(aceTagging) = IS_MOD_LOADED(ace_tagging);
GVAR(aceThrowing) = IS_MOD_LOADED(ace_advanced_throwing);
GVAR(aceTowing) = IS_MOD_LOADED(ace_towing);
GVAR(acre) = IS_MOD_LOADED(acre_main);

GVAR(playerMarkerIdx) = 0;

// Handling for running code after settings are initialized
GVAR(settingsInitialized) = false;
GVAR(runAfterSettingsInit) = [];

["CBA_settingsInitialized", {
    GVAR(settingsInitialized) = true;

    {
        _x params ["_function", "_args"];
        _args call _function;
    } forEach GVAR(runAfterSettingsInit);

    GVAR(runAfterSettingsInit) = nil;
}] call CBA_fnc_addEventHandler;

ADDON = true;
