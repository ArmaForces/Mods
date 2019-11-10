<p align="center">
    <img src="https://avatars2.githubusercontent.com/u/50863181">
</p>
<p align="center">
    <a href="https://github.com/ArmaForces/Mods/issues">
        <img src="https://img.shields.io/github/issues-raw/ArmaForces/Mods.svg?label=Issues" alt="ArmaForces Mods Issues">
    </a>
    <a href="https://github.com/ArmaForces/Mods/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/License-GPLv2-red.svg" alt="ArmaForces Mods License">
    </a>
    <a href="https://github.com/ArmaForces/Mods/actions">
        <img src="https://github.com/ArmaForces/Mods/workflows/Arma/badge.svg">
    </a>
</p>
<p align="center"><sup><strong>Requires the latest version of <a href="https://github.com/CBATeam/CBA_A3/releases/latest">CBA</a>.</strong></sup></p>

**Friendly Tracker** is our approach to BFT system. Built with modularity and high customization in mind, it serves it's purpose very well. It's clientside only, so no unnecessary network traffic.

## Features

### Friendly units tracking

Each player will have his very own small dot, changing it's color depending on various factors. Player will have his own dot colored yellow, and his teammates will be green, others will be blue. In case unconscious showing is enabled, anybody unconscious will be marked orange to indicate that he needs help. 

### Friendly vehicles tracking

If vehicle showing is enabled and players enter vehicle their dots disappear and now they all share vehicle's marker. The same coloring rules aplly as before, with exception of orange of course as vehicle cannot be unconscious. When players leave the vehicle, it's marker disappears. It is possible to avoid this behaviour by adding specific vehicles for permament tracking, then they will be marked gray if empty and black if destroyed. Special tracked vehicles will also have their own khaki color (instead of blue) to indicate their importance.

### Groups tracking

Commanders might find useful to see whole group markers more than blob of blue dots. If enabled by server, they can turn on such markers, which will have apropriate NATO symbol and group's name. It will make it easier to get sense of who those campfire guys are.

### Tracking device

If enabled, unit must have tracking device in equipment (GPS/UAV terminal for now) to be able to see BFT markers on the map and to be marked on the map for other units. In the future, when tracking device will be implemented, there will be a possibility that unit will have a tracker but won't have a map, great concept for CSAR ops.

### Highly customizable

- Option to mark unconscious players as orange dots
- Option to show only player's group
- Clientside setting for whole group markers, useful for commanders.
- Ability to show player crewed vehicles and special vehicles
- Change markers refresh rate
- Require GPS for tracking (units without GPS will not be marked nor see any markers)
- Can be started or stopped any time
