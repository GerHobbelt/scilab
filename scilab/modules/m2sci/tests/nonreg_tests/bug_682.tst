// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) ????-2008 - INRIA - Vincent COUVERT <vincent.couvert@inria.fr>
// Copyright (C) 2005-2008 - INRIA - Pierre MARECHAL <pierre.marechal@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->
// <-- ENGLISH IMPOSED -->
// <-- NO CHECK REF -->

// <-- Non-regression test for bug 682 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/682
//
// <-- Short Description -->
//    probleme with the logical or in tests.

MFILECONTENTS=["b=1;";"if b==0 | b(2)>0";"  a = 1;";"  else a = 0;";"end"];

MFILE=TMPDIR+"/bug682.m";
SCIFILE=TMPDIR+"/bug682.sci";

mputl(MFILECONTENTS,MFILE);
mfile2sci(MFILE,TMPDIR,,%T);
SCIFILECONTENTS=mgetl(SCIFILE);

SCIFILECONTENTSREF=[""
        "b = 1;"
        "if b==0 | b(2)>0 then"
        "  a = 1;"
        "else"
        "  a = 0;"
        "end"];

assert_checkequal(SCIFILECONTENTSREF, SCIFILECONTENTS);
