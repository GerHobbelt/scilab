//
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - INRIA - Pierre MARECHAL
// Copyright (C) 2012 - DIGITEO - Vincent COUVERT
// Copyright (C) 2014 - Scilab Enterprises - Anais AUBERT
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.
//

function demo_gui()

    global demolist; // Demos list is defined in scilab.start
    global demolistlock;
    if isempty(demolist) then
        if isempty(demolistlock) then
            demolistlock = %t;
            // we load scilab demos only when it is required
            modules = getmodules();
            for i=1:size(modules,"*")
                if isfile("SCI/modules/"+modules(i)+"/demos/" + modules(i) + ".dem.gateway.sce") then
                    exec("SCI/modules/"+modules(i)+"/demos/" + modules(i) + ".dem.gateway.sce",-1);
                end
            end
            clear demolistlock;
            clearglobal demolistlock;
        end
    end

    // define a local demolist variable
    tmp = demolist;
    clear demolist   // The global one must stay in en_US
    demolist = gettext(tmp);

    if get("scilab_demo_fig") <> [] then
        set("scilab_demo_fig", "visible", "on");
        return;
    end


    // Figure creation
    // =========================================================================
    // We get the user Preferences for the GUI: dockable / not dockable
    File = SCIHOME + "/XConfiguration.xml";
    r = xmlGetValues("//general/documentation/body/demos","demoGUIisDockable", File);

    // We tune accordingly the predefined demo GUI
    File = SCI + "/modules/demo_tools/gui/demo_gui.xml";
    File2 = TMPDIR + "/demo_gui_dockable.xml";
    if r=="checked" then
        if ~isfile(File2) then
            mputl(mgetl(File), File2); // copyfile() sometimes keeps the no-writable status
            doc = xmlRead(File2);
            xmlSetValues("/scilabgui/figure", ..
                         ["dockable" "on"
                          "infobar_visible" "on"
                          "menubar" "figure"
                          "menubar_visible" "on"]', doc);
            xmlWrite(doc);
            xmlDelete(doc);
        end
        File = File2;
    end

    // We load the preset GUI
    demo_fig = loadGui(File);
    demo_fig.figure_name = _("Demonstrations");
    demo_fig.icon = "x-office-presentation";

    // Parameters
    // =========================================================================
    demo_fig.userdata = struct();
    demo_fig.userdata.frame_number = 1;      // Frame number
    demo_fig.userdata.subdemolist = [];

    lst_vars_locals = ["%h_delete";
    "demo_fig";
    "subdemolist";
    "demolistlock";
    "resize_demo_gui";
    "demo_gui_update";
    "demo_gui"];

    clear_vars_str = strcat("clear " + lst_vars_locals, ";") + ";";

    callback_close_str = "delete(get(""scilab_demo_fig""));";
    callback_close_str = callback_close_str + clear_vars_str + "clearglobal demolistlock;";

    b = get("frame_1", "border");
    b.title = _("Demonstrations");
    set("frame_1", "border", b);
    set("listbox_1", "string", "<html>"+demolist(:, 1)+" &#x2023; </html>");
    set("listbox_1", "userdata", demolist);

    demo_fig.closerequestfcn = callback_close_str;

    demo_fig.visible = "on"; // Display now

endfunction

