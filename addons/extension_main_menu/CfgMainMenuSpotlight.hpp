class CfgMainMenuSpotlight {
    class EGVAR(main_menu,server1) {
        // inject server status into spotlight
        condition = QUOTE(call FUNC(addServerStatus); true);
    };
};
