class CfgRespawnTemplates
{
    // Class used in respawnTemplates entry
    class GVAR(default)
    {
        displayName = CSTRING(DisplayName);
        onPlayerKilled = QFUNC(onPlayerKilled);
        onPlayerRespawn = QFUNC(onPlayerRespawn);
        respawnDelay = 10;
        respawnOnStart = -1;
        respawnButton = 1;
        respawnDialog = 0;
        respawnTypes[] = {3};
    };
};
