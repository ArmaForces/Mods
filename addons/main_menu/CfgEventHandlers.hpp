class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};
class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayRemoteMissions {
        init = QUOTE(ARR_2([_this select 0, 'RscDisplayRemoteMissions']) call COMPILE_FILE(XEH_multiplayerDisplay));
    };
    class RscDisplayMultiplayerSetup {
        init = QUOTE(ARR_2([_this select 0, 'RscDisplayMultiplayerSetup']) call COMPILE_FILE(XEH_multiplayerDisplay));
    };
};
