// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2007 - INRIA - Allan CORNET
// Copyright (C) 2010 - DIGITEO - Allan CORNET
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
// Copyright (C) 2025 - Dassault Systèmes S.E. - Cédric DELAMARRE
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

// start a command PowerShell
function [resultat, status] = powershell(command)
    arguments
        command { mustBeA(command, "string"), mustBeScalar }
    end

    Chainecmd = "";
    Chainecmdbegin = "powershell.exe -nologo -inputformat text -outputformat text -Noninteractive ";
    resultat = [gettext("Error(s) : see help powershell");gettext("Please verify your powershell command without Scilab.")];
    status = %f;

    try
        winqueryreg("HKEY_LOCAL_MACHINE", "SOFTWARE\Microsoft\PowerShell\1", "Install");
    catch
        resultat = [gettext("Powershell 1.0 not found.")];
        return;
    end

    Chainecmd = Chainecmdbegin + "-command """ + command + """";
    [status, resultat] = host(Chainecmd);
endfunction
