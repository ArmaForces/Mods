class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Combo;
            class EGVAR(common,codeSmall);
            class ModuleDescription;
        };

        class ModuleDescription {
          class EmptyDetector;
        };
    };

    class GVAR(moduleRespawn): Module_F {
        scope = 2;

        displayName = CSTRING(ModuleRespawn_DisplayName);
        category = QUOTE(PREFIX);
        icon = "\a3\Modules_f\data\iconRespawn_ca.paa";
        portrait = "\a3\Modules_f\data\portraitRespawn_ca.paa";

        function = QFUNC(moduleRespawn);
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 1;

        class Attributes: AttributesBase {

            class GVAR(applyTo): Combo {
                displayName = CSTRING(ModuleRespawn_Attribute_ApplyTo_DisplayName);

                property = QGVAR(applyTo);
                typeName = "NUMBER";

                class Values {
                    class EAST {
                        name = "$STR_A3_CfgGroups_East0";
                        value = 0;
                    };
                    class WEST {
                        name = "$STR_A3_CfgGroups_West0";
                        value = 1;
                        default = 1;
                    };
                    class INDEP {
                        name = "$STR_A3_CfgGroups_Indep0";
                        value = 2;
                    };
                    class CIVILIAN {
                        name = "$STR_Civilian";
                        value = 2;
                    };
                };
            };

            class GVAR(filter): EGVAR(common,codeSmall) {
                displayName = CSTRING(ModuleRespawn_Attribute_Filter_DisplayName);
                tooltip = "params [""_unit""]";

                property = QGVAR(filter);
                defaultValue = "'true'";
            };

            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description[] = {
                CSTRING(ModuleRespawn_Description_0),
                CSTRING(ModuleRespawn_Description_1),
            };
            sync[] = {"EmptyDetector"};

            duplicate = 1;
            direction = 0;
            position = 0;

            class EmptyDetector: EmptyDetector {};
        };
    };
};
