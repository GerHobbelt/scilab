// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2007-2008 - INRIA - Pierre MARECHAL <pierre.marechal@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->
// <-- ENGLISH IMPOSED -->

// <-- Non-regression test for bug 2270 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/2270
//
// <-- Short Description -->
//    datenum(Y,M,D) issues an incorrect error message when the third 
//    parameter is invalid. The error should say 'The third argument must be 
//    between 1 and 31', depending on the actual number of days in that 
//    specific month.

// Test updated after https://gitlab.com/scilab/scilab/-/merge_requests/705/
// Values outside (1:12) for monthes and outside (1:31) for days are now managed.

d = datenum(2006,12,32);
assert_checkequal(d, 733043);