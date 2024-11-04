## Respawn

Respawn template with live customization available through CBA settings.

### Enabling in a mission

Following config needs to be added to a mission config to allow this system to work properly:

```cpp
respawn = 3;
respawnDelay = 1e10;
respawnOnStart = -1;
respawnTemplates[] = {"afm_respawn_default", "Counter"};
```

## Respawn delay change

You can change respawn delay at any time during the mission. If someone was already waiting for respawn, his timer will get adjusted to account for already spent time waiting.

## Disabling respawn

Respawn can be freely enabled/disabled. When it gets disabled and there were players waiting, their time spent waiting is saved and in case respawn gets reenabled, timer restarts where it stopped (supports respawn delay change in meantime).

## Forcing respawn

You can always force respawn using `"afm_respawn_force"` server/local event (depending on who you want to respawn, all or only some players).

### Authors

- [3Mydlo3](http://github.com/3Mydlo3)
