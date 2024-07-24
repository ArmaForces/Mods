
class CfgMainMenuSpotlight {

    class GVAR(server1) {
        text = CSTRING(SpotlightJoin);
        textIsQuote = 0;
        picture = QUOTE(\z\afm\addons\main\ui\logo_sm_ca.paa);
        action = QUOTE(_this call (uiNamespace getVariable QQFUNC(join)));
        actionText = CSTRING(SpotlightHeader);
        condition = QUOTE(true);
    };

    delete ApexProtocol;
    delete BootCamp;
    delete EastWind;

    delete Orange_CampaignGerman;
    delete Orange_Showcase_IDAP;
    delete Orange_Showcase_LoW;
    delete Orange_Campaign;

    delete Showcase_TankDestroyers;

    delete Tacops_Campaign_03;
    delete Tacops_Campaign_02;
    delete Tacops_Campaign_01;

    delete Tanks_Campaign_01;

    delete OldMan;

    delete Contact_Campaign;

    delete gm_campaign_01;

    delete SP_FD14;

    delete AoW_Showcase_AoW;
    delete AoW_Showcase_Future;

    delete Extraction_lxWS;
    delete Showcase_Alchemist_lxWS;
    delete Showcase_VR_lxWS;

    delete vn_showcase_macv;
    delete vn_showcase_macv_13;
    delete vn_showcase_pavn;
    delete vn_showcase_pavn_13;
    delete vn_sogba;

    delete SPE_Arsenal;
    delete SPE_Campagin_OperationCobra_04;
    delete SPE_Coop_DerZahnarzt;
    delete SPE_Faction_Showcase_GER;
    delete SPE_Faction_Showcase_US;

    delete Scenario_TrainingDay_RF;
    delete Scenario_FireSeason_RF;
    delete Scenario_AirControl_RF;
};
