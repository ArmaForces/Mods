class CfgFunctions
{
    class A3_Expansion_A
    {
        class Spectator
        {
            class EGSpectator
            {
                file = QPATHTOF(functions\DOUBLES(fnc,EGSpectator).sqf);
            };
            class EGSpectatorCore
            {
                file = QUOTE(a3\functions_f_exp_a\EGSpectator\fn_EGSpectator.sqf);
            };
            class RscDisplayEGSpectatorCore
            {
                file = QUOTE(a3\ui_f\scripts\gui\rscdisplayegspectator.sqf);
            };
        };
    };
};
