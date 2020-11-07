

```cpp
class DefaultVehicleSystemsDisplayManagerLeft;
class DefaultVehicleSystemsDisplayManagerRight {
    class Components;
};

class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class Components {
            class VehicleSystemsDisplayManagerComponentLeft: DefaultVehicleSystemsDisplayManagerLeft {};
            class VehicleSystemsDisplayManagerComponentRight: DefaultVehicleSystemsDisplayManagerRight {
                class Components: Components {
                    class GVAR(TestComponent) {
                        componentType = "CustomDisplayComponent";
                        resource = QGVAR(RscBasicComponent);
                    };
                };
            };
        };
    };
};
```
