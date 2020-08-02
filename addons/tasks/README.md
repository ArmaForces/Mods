## Tasks

Tasks framework. Automatic tasks creation from mission config. All scripts, conditions and events are run on server only.

## How to use

Just create `CfgTasks` in your mission's `description.ext` and fill it with tasks! Yes, and that's it, no more linking modules and triggers into spaghetti, works out of the box.

If you don't want to use some property it is best to remove it at all, don't leave it empty, it can break things sometimes.

## Example config

```hpp
class CfgTasks {
    class Soapy_Mission_XD {
        title = "Soapy Mission XD - Horse Knocked"; // Regular task title
        description = "Great mission of beating horse."; // Regular description. Cannot use linebreaks (enters), if needed use stringtable.
        /* Task icon location on the map
        First checks for marker with given name, and if doesn't exists, checks for object in mission namespace.
        Alternatively {x, y, z} can be used for supplying position coordinates.
        If all of them are empty then task won't be shown on the map. */
        position[] = {}; // Use for position
        object = ""; // Use for objects
        marker = ""; // Use for marker names only
        icon = "unknown"; // Icon classname from https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Appendix
        owners[] = { "true" }; // Default value, use "All"/"true" for all playable units
        initialState = "CREATED"; // Default value
        priority = -1; // Default value
        createdShowNotification = "false"; // Default value
        visibleIn3D = "false"; // Default value

        parentTask = ""; // Config entry name of parent task

        // Showing/creating task
        conditionCodeShow = "true";
        conditionEventsShow[] = {}; // Default value for all conditionEvents*[] is equal to [] which is {} in config
        conditionEventsShowRequired = 1; // How many events must fire for events condition to be met

        // Conditions codes which must return true to finish task
        conditionCodeSuccess = "";
        conditionCodeFailed = "";
        conditionCodeCanceled = "";
        // CBA event names which must be triggered to achieve the same as above
        conditionEventsSuccess[] = {};
        conditionEventsFailed[] = {};
        conditionEventsCanceled[] = {};
        // And number required as in show but for all others
        conditionEventsSuccessRequired = 1;
        conditionEventsFailedRequired = 1;
        conditionEventsCanceledRequired = 1;

        // Server CBA events called. If you want custom code just add appropriate CBA EH on server.
        onShowEvents[] = {};
        onSuccessEvents[] = {};
        onFailedEvents[] = {};
        onCanceledEvents[] = {};
    };
    class FindHorse {
        title = "Find Horse";
        icon = "search";
        parentTask = "Soapy_Mission_XD";
        conditionCodeShow = "true";
        conditionCodeSuccess = "unit1 distance horse < 50";
        onSuccessEvents[] = { "horseFound" };
    };
    class KnockHorse {
        title = "Knock Horse";
        icon = "attack";
        object = "horse";
        parentTask = "FindHorse";

        conditionEventsShow[] = { "horseFound" };
        conditionCodeSuccess = "!(alive horse)";
        conditionCodeFailed = "!(alive unit1)";

        onSuccessEvents[] = { "horseKnocked" };
        onFailedEvents[] = { "playerDied" };
    };
};
```

## Example custom event handling

```SQF
// initServer.sqf

// Event handler for onSuccessEvent
["horseKnocked", {
    titleText ["You beat the horse!", "PLAIN DOWN", 0.5];
    [{
        "EveryoneWon" call BIS_fnc_endMission;
    }, [], 3] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

// Event handler for onFailedEvent
["playerDied", {
    titleText ["You died!", "PLAIN DOWN", 0.5];
    [{
        "EveryoneLost" call BIS_fnc_endMission;
    }, [], 3] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
```

## Framework events

```
Event "afm_tasks_taskCreated"
  Params
  - 0: Task config name <STRING>
Event "afm_tasks_taskStateChanged"
  Params
  - 0: Task config name <STRING>
  - 1: New task state <STRING>
```

### Authors

- [3Mydlo3](http://github.com/3Mydlo3)
