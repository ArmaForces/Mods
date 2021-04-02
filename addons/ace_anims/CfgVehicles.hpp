class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class GVAR(actions) {
                displayName = "Animations"; // todo localize
                icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\a_ca.paa";

                class GVAR(relax) {
                    displayName = "Relaxed poses";
                    icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\r_ca.paa";

                    ANIMACTION(Relaxed1,"",Acts_millerCamp_A);

                    ANIMACTION(Relaxed2,"",Acts_AidlPercMstpSnonWnonDnon_warmup_1_loop);
                    ANIMACTION(Relaxed3,"",Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop);
                    ANIMACTION(Relaxed4,"",Acts_AidlPercMstpSnonWnonDnon_warmup_3_loop);
                    ANIMACTION(Relaxed5,"",Acts_AidlPercMstpSnonWnonDnon_warmup_4_loop);
                    ANIMACTION(Relaxed6,"",Acts_AidlPercMstpSnonWnonDnon_warmup_5_loop);
                    ANIMACTION(Relaxed7,"",Acts_AidlPercMstpSnonWnonDnon_warmup_6_loop);
                    ANIMACTION(Relaxed8,"",Acts_AidlPercMstpSnonWnonDnon_warmup_7_loop);
                    ANIMACTION(Relaxed9,"",Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop);

                    ANIMACTION(Relaxed10,"",Acts_AidlPercMstpSloWWrflDnon_warmup_5_loop);

                    ANIMACTION(Relaxed10,"",Acts_Hilltop_Calibration_Loop);
                };

                class GVAR(gestures) {
                    displayName = "Gestures";
                    icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\g_ca.paa";

                    ANIMACTION(Crouch,"",Acts_JetsCrewaidFCrouch_in);
                    ANIMACTION(CrouchThumbUp,"",Acts_JetsCrewaidFCrouchThumbup_in);
                    ANIMACTION(EnginesOn,"",Acts_JetsMarshallingEnginesOn_in);
                    ANIMACTION(ComeIn,"",Acts_NavigatingChopper_Loop);
                    ANIMACTION(ShieldFromSun,"",Acts_ShieldFromSun_loop);
                };

                class GVAR(dance) {
                    displayName = "Dance";
                    icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\d_ca.paa";

                    ANIMACTION(Dance1,"",Acts_Dance_01);
                    ANIMACTION(Dance2,"",Acts_Dance_02);
                };

                class GVAR(actions) {
                    displayName = "Dance";
                    icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\a_ca.paa";

                    ANIMACTION(Kata,"",AmovPercMstpSnonWnonDnon_exerciseKata);
                    ANIMACTION(PushUp,"",AmovPercMstpSnonWnonDnon_exercisePushUp);
                };

                class GVAR(mimic) {
                    displayName = "Dance";
					icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\a_ca.paa";

                    // TODO
                };

                class GVAR(cancel) {
                    displayName = CSTRING(Cancel);
                    statement = "[_player, ''] remoteExec ['switchMove', 0]"
                };
            };
        };
    };
};
