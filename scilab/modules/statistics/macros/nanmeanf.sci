
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 1999 - INRIA - Carlos Klimann
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


function [m] = nanmeanf(val, fre, orient)
    //
    //This function returns in scalar m the mean of the values (ignoring the
    //NANs) of  a  vector  or  matrix  val, each counted  with   a frequency
    //signaled by the  corresponding values of the  integer vector or matrix
    //fre with the same type of val.
    //
    //For     a   vector   or      matrix   val,   m=nanmeanf(val,fre)    or
    //m=nanmeanf(val,fre,'*')    returns in scalar  m  the   mean of all the
    //entries (ignoring   the NANs) of   val, each  value  counted  with the
    //multiplicity indicated by the corresponding value of fre.
    //
    //m=nanmeanf(val,fre,'r')(or,     equivalently,   m=nanmeanf(val,fre,1))
    //returns in each entry of the row vector m  of type 1xsize(val,'c') the
    //mean of each column  of  val (ignoring  the NANs), each  value counted
    //with the multiplicity indicated by the corresponding value of fre.
    //
    //m=nanmeanf(val,fre,'c')(or,   equivalently,     m=nanmeanf(val,fre,2))
    //returns in each  entry of the column  vector m of type size(val,'c')x1
    //the mean of  each row of val  (ignoring the NANs),  each value counted
    //with the multiplicity indicated by the corresponding value of fre.
    //
    //
    arguments
        val
        fre
        orient (1, 1) {mustBeA(orient, ["double", "string"]), mustBeMember(orient, {1, 2, "r", "c", "*"})} = "*"
    end

    if val == [] | fre == 0 then m = [], return,end
    isn=isnan(val)
    fre(isn)=0
    val(isn)=0
    m = sum(val .* fre, orient) ./ sum(fre, orient)
endfunction
