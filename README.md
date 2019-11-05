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

**ArmaForces Mods** is a collaborative effort by the members of <a href="https//armaforces.com/">ArmaForces</a>, polish Arma 3 community.

Main purpose of this addon is to bend and adjust Arma 3 game features to the Group gameplay needs and style.

The mod is on the same foundation as the ACE3 mod, using its framework, systems, tools and standards. It is entirely **open-source** and licensed under the GNU General Public License ([GPLv2](https://github.com/ArmaForces/Mods/blob/master/LICENSE)).

Huge appreciation and thanks to [ACE3 Team](http://ace3mod.com/team.html) for their open-source nature and permission to use their systems.


## Setup

### Requirements

- Arma 3
- Arma 3 Tools (available on Steam)
- Run Arma 3 and Arma 3 Tools directly from Steam once to install registry entries (and again after every update)
- [HEMTT](https://github.com/synixebrett/HEMTT) binary placed in project root or globally installed
  - `hemtt` (Linux) or `hemtt.exe` (Windows) or `setup.exe` (Windows global install)

### Procedure

_Replace `hemtt` with `hemtt.exe` on Windows._

- Open terminal (Linux) or command line (Windows)
- Run `$ hemtt build` to create a development build (add `-f` to overwrite already built addons)
- Run `$ hemtt build --release` to create a release build (add `-f` to overwrite already built release)
- Run `$ hemtt clean` to clean build files

**Windows Helpers:**
- Double-click `build.bat` to create a development build

### Recommended tools

It's recommended to use [Visual Studio Code](https://) editor with following plugins to ensure equal development environment for all contributors:
- [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [SQFLint](https://marketplace.visualstudio.com/items?itemName=skacekachna.sqflint)
- [SQF Langauge](https://marketplace.visualstudio.com/items?itemName=Armitxes.sqf)
- [psioniq File Header](https://marketplace.visualstudio.com/items?itemName=psioniq.psi-header)
