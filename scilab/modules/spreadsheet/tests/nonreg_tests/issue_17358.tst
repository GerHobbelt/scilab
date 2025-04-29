// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2025 - Dassault Systèmes S.E. - Adeline CARNIS
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
//
// <-- Non-regression test for issue 17358 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/17358
//
// <-- Short Description -->
// when lines function is set to [0,0], the whole table is displayed

NameContinent = ["Africa"; "North America"; "Oceania"; "Antarctica"; "Asia"; "Europe"; "South America"];
Area = [30065000; 24256000; 7687000; 13209000; 44579000; 9938000; 17819000]; // in km2

bigNames = strcat(NameContinent(:, ones(100, 1)), " ", "c");

t = table(NameContinent, Area, bigNames);

lines(0, 0);
disp(t)

t = table(rand(60,20));
disp(t)