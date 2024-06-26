// =============================================================================
// Scilab ( https://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Vincent COUVERT
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 1304 -->
//
// <-- GitLab URL -->
// https://gitlab.com/scilab/scilab/-/issues/1304
//
// <-- Short Description -->
// macr2tree(expression) doesn't work

//
// TESTS WITH A 'SIMPLE' FUNCTION
//

// <-- CLI SHELL MODE -->

function bug_1304()
    disp("bug_1304")
endfunction

// Reference tree generated using sci2exp
reftree = tlist(["program","name","outputs","inputs","statements","nblines"],"bug_1304",list(),..
list(),..
list(list("EOL"),..
tlist(["equal","expression","lhs","endsymbol"],..
tlist(["funcall","rhs","name","lhsnb"],list(tlist(["cste","value"],"bug_1304")),"disp",1),..
list(tlist(["variable","name"],"ans")),""),list("EOL"),..
tlist(["funcall","rhs","name","lhsnb"],[],"return",0),list("EOL")),3);

if ~and(macr2tree(bug_1304)==reftree) then pause;end
if ~and(macr2tree(evstr("bug_1304"))==reftree) then pause;end

clear bug_1304

//
// TESTS WITH A FUNCTION DEFINING AN OTHER FUNCTION
//

function f = bug_1304()
    function internal_bug_1304()
        disp("internal_bug_1304()")
    endfunction
    f = internal_bug_1304
endfunction

// Reference tree generated using sci2exp
reftree = tlist(["program","name","outputs","inputs","statements","nblines"],"bug_1304",..
list(tlist(["variable","name"],"f")),list(),..
list(list("EOL"),..
tlist(["inline","prototype","definition"],"internal_bug_1304()",..
["disp(""internal_bug_1304()"")"]),list("EOL"),..
tlist(["equal","expression","lhs","endsymbol"],..
tlist(["variable","name"],"internal_bug_1304"),list(tlist(["variable","name"],"f")),""),..
list("EOL"),tlist(["funcall","rhs","name","lhsnb"],[],"return",0),list("EOL")),..
6);

if ~and(macr2tree(bug_1304)==reftree) then pause;end
if ~and(macr2tree(evstr("bug_1304"))==reftree) then pause;end

// Reference tree generated using sci2exp
reftree = tlist(["program","name","outputs","inputs","statements","nblines"],"internal_bug_1304",..
list(),list(),..
list(list("EOL"),..
tlist(["equal","expression","lhs","endsymbol"],..
tlist(["funcall","rhs","name","lhsnb"],list(tlist(["cste","value"],"internal_bug_1304()")),..
"disp",1),list(tlist(["variable","name"],"ans")),""),list("EOL"),..
tlist(["funcall","rhs","name","lhsnb"],[],"return",0),list("EOL")),3);

if ~and(macr2tree(bug_1304())==reftree) then pause;end
