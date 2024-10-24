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
          class Condition;
        };
    };

    class GVAR(moduleRespawn): Module_F {
        scope = 2;

        displayName = "$$$ RESPAWN $$$";
        category = QUOTE(PREFIX);
        icon = "\a3\Modules_f\data\iconRespawn_ca.paa";
        portrait = "\a3\Modules_f\data\portraitRespawn_ca.paa";

        function = QFUNC(moduleRespawn);
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 1;

        class Attributes: AttributesBase {

            class GVAR(applyTo): Combo {
                displayName = "Apply to";

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
                };
            };

            class GVAR(filter): EGVAR(common,codeSmall) {
                displayName = "Filter units code";
                tooltip = "\nparams [""_unit""]";

                property = QGVAR(filter);
                defaultValue = "'true'";
            };

            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description[] = {
                "Synchronize the module with a trigger to respawn players of the selected side once it's activated.",
                "List of the players can be filtered with optional condition code."
            };
            sync[] = {"EmptyDetector"};

            duplicate = 1;
            direction = 0;
            position = 0;

            class EmptyDetector: EmptyDetector {};
        };
    };
};
