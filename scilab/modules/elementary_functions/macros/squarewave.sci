// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// Copyright (C) DIGITEO - 2011 - Allan CORNET
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function s = squarewave(t, percentPositive)
    //squarewave(t) generates a square wave with period 2*Pi
    //squarewave(t) is like sin(t), only it creates a square wave
    //with peaks of +1 to -1 instead of a sine wave.

    //squarewave(t,%) generates an unsymmetric  square wave: %, is the
    //percent of the period in which the signal is positive.
    arguments
        t
        percentPositive = 50
    end

    s = 2*bool2s(pmodulo(t,2*%pi) < 2*%pi*percentPositive/100)-1;
endfunction
