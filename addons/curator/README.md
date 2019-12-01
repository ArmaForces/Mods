## Curator

Our adjustments and upgrades for Zeus.

### Automatic Zeus assignment

Some missions involve more than one Zeus. It is hard to get it working correctly and without problems when one Zeus disconnects. Not anymore. All units with editor attribute `ArmaForces Attributes -> Zeus` checked will have curator module assigned on startup (works for JIP). During game you can use `afm_curator_fnc_assignZeus` to assign Zeus for given unit. This way created curator module will be tracked and used again if possible (in case unit disconnects/dies), minimizing new modules creation (which freezes game every time).

## Authors

- [3Mydlo3](https://github.com/3Mydlo3)
- [veteran29](https://github.com/veteran29)
