class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class GVAR(codeBig): Default {
                control = "EditCodeMulti5";
                typeName = "STRING";
                expression = "_this setVariable ['%s', compileFinal _value];";
                validate = "none";
                // these seem buggy, _this is a control during validation and breaks it
                // validate = "expression";
                // validate = "condition";
            };
            class GVAR(codeSmall): GVAR(codeBig) {
                control = "EditCodeMulti3";
            };
        };
    };
};
