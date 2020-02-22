#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(aceSafemode) = IS_MOD_LOADED(ace_safemode);
GVAR(aceFastroping) = IS_MOD_LOADED(ace_fastroping);
GVAR(aceFatigue) = IS_MOD_LOADED(ace_advanced_fatigue);
GVAR(aceMedical) = IS_MOD_LOADED(ace_medical_engine);

ADDON = true;
