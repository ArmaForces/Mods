#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(randomGear) = true call CBA_fnc_createNamespace;

// init random gear from config
{
    LOG_1("Parsing random gear - %1",_x);
    {
        private _key = configName _x;
        private _items = GVAR(randomGear) getVariable _key;
        if (isNil "_items") then {
            LOG_1("Creating new gear category - %1",_key);
            _items = [];
            GVAR(randomGear) setVariable [_key, _items];
        };

        // add and filter unavailable classes
        {
            if (!isNull (_x call CBA_fnc_getItemConfig)) then {
                LOG_1("Adding '%1' to random gear pool",_x);
                // we allow duplicates so chance of certain item can be increased by having them more times in arrays
                _items pushBack _x;
            };
        } forEach getArray _x;
    } forEach configProperties [_x, "isArray _x"];
} forEach ("true" configClasses (configFile >> "CfgInsurgentGear"));

ADDON = true;
