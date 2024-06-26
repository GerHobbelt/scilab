// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2006-2008 - INRIA - Serge STEER <serge.steer@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 1619 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/1619
//
// <-- Short Description -->
//    macr2tree doesn't like functions compiled for profiling. It hates them
//    so much,
//    that causes spectacular crashes of scilab.
//
// <-- CLI SHELL MODE -->
//
deff("x=foo(n)",["if n==0 then"
"  x=[]"
"else"
"  x=0"
"  for k=1:n"
"    s=svd(rand(n+10,n+10))"
"    x=x+s(1)"
"  end"
"end"])
if execstr("T=macr2tree(foo)","errcatch") <> 0 then pause,end
clear foo;

function y=foo(),y=sin(33)+1;endfunction
foo(); //execution creates a deleted op in the pseudo code of foo
if execstr("macr2tree(foo)","errcatch") <> 0 then pause,end
