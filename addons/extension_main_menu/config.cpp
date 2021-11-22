#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "afm_extension",
            "afm_main_menu"
        };
        author = "ArmaForces";
        authors[] = {"veteran29"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
