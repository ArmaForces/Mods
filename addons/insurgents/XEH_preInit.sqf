#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

// random gear system will be only initialized after placing first insurgent
GVAR(randomGearInitialized) = false;
GVAR(randomGear) = true call CBA_fnc_createNamespace;

{
    {
        private _key = configName _x;
        private _items = GVAR(randomGear) getVariable _key;
        if (isNil "_items") then {
            _items = [];
            GVAR(randomGear) setVariable [_key, _items];
        };

        // add and filter unavilable classes
        {
            if (!isNull (_x call CBA_fnc_getItemConfig)) then {
                LOG_1("Adding '%1' to random gear pool",_x);
                // we allow duplicates so chance of certain item can be increased by having it more times in arrays
                _items pushBack _x;
            };
        } forEach getArray _x;
    } forEach configProperties [_x, "isArray _x"];
} forEach ("true" configClasses (configFile >> "CfgInsurgentGear"));

ADDON = true;
