#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main"
        };
        author = "ArmaForces";
        VERSION_CONFIG;
    };
};

#include "CfgEden.hpp"
#include "CfgModuleCategories.hpp"
#include "DisplayEden.hpp"
