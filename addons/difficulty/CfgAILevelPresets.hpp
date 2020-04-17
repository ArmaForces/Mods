class CfgAILevelPresets {
    class Custom;
    class GVAR(LevelAI): Custom {
        displayName = CSTRING(DifficultyName);

        skillAI = 0.9;
        precisionAI = 0.3;
    };
};
