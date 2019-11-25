class CfgDifficultyPresets {

    defaultPreset = QGVAR(Difficulty);

    class Custom;
    class GVAR(Difficulty): Custom {
        displayName = CSTRING(DifficultyName);

        description = CSTRING(DifficultyDescription);
        optionDescription = CSTRING(DifficultyDescription);

        levelAI = QGVAR(LevelAI);

        class Options {
            groupIndicators = 0;
            friendlyTags = 0;
            enemyTags = 0;
            detectedMines = 0;
            commands = 0;
            waypoints = 0;
            weaponInfo = 2;
            stanceIndicator = 2;
            reducedDamage = 0;
            staminaBar = 1;
            weaponCrosshair = 0;
            visionAid = 0;
            thirdPersonView = 0;
            cameraShake = 1;
            scoreTable = 0;
            deathMessages = 0;
            vonID = 1;
            mapContentFriendly = 0;
            mapContentEnemy = 0;
            mapContentMines = 0;
            autoReport = 0;
            multipleSaves = 1;
            tacticalPing = 0;
        };
    };
};
