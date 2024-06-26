// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2015 - Scilab Enterprises - Adeline CARNIS
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->
// <-- NO CHECK REF -->

// <-- Non-regression test for bug 14030 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/14030
//
// <-- Short Description -->
//    Linear Algebra demo crashed due to calling of schur and fft functions.
// =============================================================================

H=[1.    1.    1.    0.;
2.   -1.    0.    1;
1.    0.    1.    1.;
0.    1.    2.   -1];

ww=spec(H);

function [flg]=sel(x,y)
    flg=%f
    if abs(x/y-ww(3))<0.0001|abs(x/y-ww(4))<0.00001 then flg=%t,end
endfunction

[X,d]=schur(H,eye(H),sel);
assert_checkfalse(norm(X*X'-eye(X), 1)> 200*%eps);
assert_checkequal(d, 2);

// check error
clear sel
function [flg]=sel(x,y)
endfunction
assert_checkfalse(execstr("[X,d]=schur(H,eye(H),sel)"   ,"errcatch") == 0);
refMsg = msprintf(_("Undefined variable ''%s'' in function ''%s''.\n"), "flg", "sel");
assert_checkerror("[X,d]=schur(H,eye(H),sel)", refMsg);

e = [0 1 0 0]';
ksi = fft(e, -1);
assert_checkequal(ksi, [1; -%i; -1; %i]);
