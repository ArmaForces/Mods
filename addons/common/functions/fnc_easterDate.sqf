#include "script_component.hpp"
/*
 * Author: veteran29
 * Calculate easter date for given year. Based on http://c-for-dummies.com/blog/?p=2446
 *
 * Arguments:
 * 0: Year <NUMBER>
 *
 * Return Value:
 * 0: Easter year <NUMBER>
 * 1: Easter month <NUMBER>
 * 2: Easter day <NUMBER>
 *
 * Example:
 * [2021] call afm_common_fnc_easterDate
 *
 * Public: No
 */

params [
    ["_year", systemTime select 0, [0]]
];

// https://en.wikipedia.org/wiki/Computus#Anonymous_Gregorian_algorithm
private _a = _year mod 19;
private _b = floor (_year / 100);
private _c = _year mod 100;
private _d = floor (_b / 4);
private _e = _b mod 4;
private _f = floor ((_b + 8) / 25);
private _g = floor ((_b - _f + 1) / 3);
private _h = (19 * _a + _b - _d - _g + 15) mod 30;
private _i = floor (_c / 4);
private _k = _c mod 4;
private _l = (32 + 2 * _e + 2 * _i - _h - _k) mod 7;
private _m = floor ((_a + 11 * _h + 22 * _l) / 451);

private _month = floor ((_h + _l - 7 * _m + 114) / 31);
private _day = ((_h + _l- 7 * _m + 114) mod 31) + 1;

[_year, _month, _day] // return
