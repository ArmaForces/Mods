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
                file = QUOTE(A3\Functions_F_Exp_A\EGSpectator\fn_EGSpectator.sqf);
            };
            class RscDisplayEGSpectatorCore
            {
                file = QUOTE(A3\Ui_F\Scripts\Gui\rscdisplayegspectator.sqf);
            };
        };
    };
};
