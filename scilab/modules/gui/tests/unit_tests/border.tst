// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2014 - Scilab Enterprises - Antoine ELIAS
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->
// <-- NO CHECK REF -->

l = list();
//border
//none
//l($+1) = createBorder("none");
//empty
l($+1) = createBorder("empty");
l($+1) = createBorder("empty", 10, 20, 30, 40);
//line
l($+1) = createBorder("line", "blue");
l($+1) = createBorder("line", "red", 2);
//bevel
l($+1) = createBorder("bevel", "raised");
l($+1) = createBorder("bevel", "lowered", "blue", "red");
l($+1) = createBorder("bevel", "lowered", "blue", "red", "magenta", "orange");
// softbevel
l($+1) = createBorder("softbevel", "raised");
l($+1) = createBorder("softbevel", "lowered", "blue", "red");
l($+1) = createBorder("softbevel", "lowered", "blue", "red", "magenta", "orange");
//etched
l($+1) = createBorder("etched");
l($+1) = createBorder("etched", "raised");
l($+1) = createBorder("etched", "blue", "red");
l($+1) = createBorder("etched", "lowered", "blue", "red");
//titled
font1 = createBorderFont("Serif", 12, "bold");
font2 = createBorderFont("Serif", 12, "normal", "italic");
l($+1) = createBorder("titled", "title");
l($+1) = createBorder("titled", createBorder("empty"));
l($+1) = createBorder("titled", createBorder("line", "blue"), "title");
l($+1) = createBorder("titled", createBorder("bevel", "raised"), "title", "center", "top");
l($+1) = createBorder("titled", createBorder("matte", 1, 2, 3, 4, "pink"), "title", "center", "top", font1);
l($+1) = createBorder("titled", createBorder("etched"), "title", "left", "top", font2, "blue");
//compound
l($+1) = createBorder("compound");
l($+1) = createBorder("compound", createBorder("empty"), createBorder("etched"));
//matte
l($+1) = createBorder("matte", 4, 3, 2, 1, "yellow");

//create a window with all type of frame border.

f = figure( ...
    "dockable", "off", ...
    "menubar_visible", "off", ...
    "infobar_visible", "off", ...
    "toolbar_visible", "off", ...
    "layout", "grid", ...
    "layout_options", createLayoutOptions("grid", [4,0], [1 1]));
for i = 1:size(l)
    u = uicontrol(f, "style", "frame", "border", l(i));
    assert_checkequal(u.border, l(i));
end

//generate colors from parula color map
colors = sprintf("#%02X%02X%02X\n", (parula(64) .* 255));

f = figure( ...
    "dockable", "off", ...
    "menubar_visible", "off", ...
    "infobar_visible", "off", ...
    "toolbar_visible", "off", ...
    "visible", "off", ...
    "layout", "grid", ...
    "layout_options", createLayoutOptions("grid", [8,0], [1 1]));

for i = 1:size(colors, "*")
    b = createBorder("line", colors(i));
    u = uicontrol(f, "style", "frame", "border", b);
    assert_checkequal(u.border, b);
end

f.visible = "on";
